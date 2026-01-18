// The Forge Calculator Core Logic - 完全基于 ghotality/theforge-crafting 仓库的计算逻辑

class ForgeCalculator {
    constructor() {
        this.selectedOres = {};
        this.currentCraftType = 'Weapon';
    }

    // 完全复制原仓库的倍率计算函数
    calculateCombinedMultiplier(selectedOres) {
        let totalMultiplier = 0;
        let totalCount = 0;
        
        for (const [ore, count] of Object.entries(selectedOres)) {
            if (!ORES_DATA[ore]) continue;
            totalMultiplier += ORES_DATA[ore].multiplier * count;
            totalCount += count;
        }
        
        return totalCount ? totalMultiplier / totalCount : 0;
    }

    // 完全复制原仓库的特性传递计算函数
    calculateTransferredStat(x) {
        let y = 4.5 * x - 35;
        if (y < 0) y = 0;
        if (y > 100) y = 100;
        return y / 100;
    }

    // 完全复制原仓库的主要计算函数
    getItemChancesWithTraits(selectedOres, craftType = "Weapon") {
        const oddsDict = craftType === "Weapon" ? WEAPON_ODDS : ARMOR_ODDS;
        const combinedMultiplier = this.calculateCombinedMultiplier(selectedOres);
        const totalCount = Object.values(selectedOres).reduce((a, b) => a + b, 0);
        
        // 如果没有矿石，返回默认值
        if (totalCount === 0) {
            return { 
                combinedMultiplier: 0, 
                totalCount: 0, 
                composition: {}, 
                odds: {}, 
                traits: [], 
                rarity: 'Unknown' 
            };
        }

        // 如果少于3个矿石，返回空概率（UI中显示0%）
        if (totalCount < 3) {
            return { 
                combinedMultiplier, 
                totalCount, 
                composition: {}, 
                odds: {}, 
                traits: [], 
                rarity: 'Unknown' 
            };
        }

        const MAX_ODDS_ORE_COUNT = 55;
        
        let oddsKey = totalCount > MAX_ODDS_ORE_COUNT ? MAX_ODDS_ORE_COUNT.toString() : totalCount.toString();
        
        if (!oddsDict[oddsKey]) {
            const keys = Object.keys(oddsDict).map(Number).filter(k => k >= 3);
            if (keys.length === 0) {
                return { 
                    combinedMultiplier, 
                    totalCount, 
                    composition: {}, 
                    odds: {}, 
                    traits: [], 
                    rarity: 'Unknown' 
                };
            }
            const maxKey = Math.max(...keys);
            oddsKey = maxKey.toString();
        }

        const odds = oddsDict[oddsKey] || {};

        // 计算矿石组成百分比
        const composition = {};
        for (const [ore, count] of Object.entries(selectedOres)) {
            composition[ore] = (count / totalCount * 100);
        }

        // 计算特性激活
        const traits = [];
        for (const [oreName, pct] of Object.entries(composition)) {
            const oreData = ORES_DATA[oreName];
            if (!oreData || !Array.isArray(oreData.traits)) continue;
            if (oreData.traitType !== "All" && oreData.traitType !== craftType) continue;
            if (pct < 10) continue; // 10%阈值

            const transferredFraction = this.calculateTransferredStat(pct);
            const oreTraitParts = [];

            for (let i = 0; i < oreData.traits.length; i++) {
                const t1 = oreData.traits[i];
                if (typeof t1.maxStat !== "number") continue;
                let line = `${(transferredFraction * t1.maxStat).toFixed(2)}% ${t1.description}`;
                
                const shouldMerge = t1.description.trim().match(/(with|of|for|per|to|in)$/i)
                    && oreData.traits[i + 1] && typeof oreData.traits[i + 1].maxStat === "number";
                
                if (shouldMerge) {
                    const t2 = oreData.traits[i + 1];
                    line += ` ${(transferredFraction * t2.maxStat).toFixed(2)}% ${t2.description}`;
                    i++;
                }
                oreTraitParts.push(line);
            }
            if (oreTraitParts.length) {
                traits.push({ ore: oreName, lines: oreTraitParts });
            }
        }

        // 确定稀有度（基于占比最高的矿石）
        const highestOre = Object.entries(composition).reduce((a, b) => b[1] > a[1] ? b : a, ["", 0])[0];
        const rarity = ORES_DATA[highestOre]?.rarity || "Unknown";

        // 过滤并排序概率
        const sortedOdds = Object.fromEntries(
            Object.entries(odds).filter(([k, v]) => v > 0).sort((a, b) => b[1] - a[1])
        );

        return { 
            combinedMultiplier, 
            totalCount, 
            composition, 
            odds: sortedOdds, 
            traits, 
            rarity 
        };
    }

    // 添加矿石
    addOre(oreName, count = 1) {
        if (!ORES_DATA[oreName]) return;
        
        if (this.selectedOres[oreName]) {
            this.selectedOres[oreName] += count;
        } else {
            this.selectedOres[oreName] = count;
        }
        
        this.updateResults();
    }

    // 移除矿石
    removeOre(oreName, count = 1) {
        if (!this.selectedOres[oreName]) return;
        
        this.selectedOres[oreName] -= count;
        if (this.selectedOres[oreName] <= 0) {
            delete this.selectedOres[oreName];
        }
        
        this.updateResults();
    }

    // 清空所有矿石
    clearOres() {
        this.selectedOres = {};
        this.updateResults();
    }

    // 设置制作类型
    setCraftType(type) {
        this.currentCraftType = type;
        this.updateResults();
    }

    // 更新结果显示
    updateResults() {
        const results = this.getItemChancesWithTraits(this.selectedOres, this.currentCraftType);
        this.displayResults(results);
    }

    // 显示结果
    displayResults(results) {
        // 更新倍率显示
        const multiplierElement = document.getElementById('multiplier-display');
        if (multiplierElement) {
            multiplierElement.textContent = results.combinedMultiplier.toFixed(2) + 'x';
        }

        // 更新矿石总数显示
        const countElement = document.getElementById('ore-count-display');
        if (countElement) {
            countElement.textContent = results.totalCount;
        }

        // 更新概率显示
        const oddsElement = document.getElementById('odds-display');
        if (oddsElement) {
            if (Object.keys(results.odds).length === 0) {
                oddsElement.innerHTML = '<div class="no-results">Need at least 3 ores to forge</div>';
            } else {
                let oddsHtml = '';
                for (const [item, probability] of Object.entries(results.odds)) {
                    const percentage = (probability * 100).toFixed(1);
                    oddsHtml += `
                        <div class="odds-item">
                            <span class="item-name">${item}</span>
                            <span class="probability">${percentage}%</span>
                            <div class="probability-bar">
                                <div class="probability-fill" style="width: ${percentage}%"></div>
                            </div>
                        </div>
                    `;
                }
                oddsElement.innerHTML = oddsHtml;
            }
        }

        // 更新特性显示
        const traitsElement = document.getElementById('traits-display');
        if (traitsElement) {
            if (results.traits.length === 0) {
                traitsElement.innerHTML = '<div class="no-traits">No active traits</div>';
            } else {
                let traitsHtml = '';
                for (const trait of results.traits) {
                    traitsHtml += `
                        <div class="trait-item">
                            <div class="trait-ore">${trait.ore}</div>
                            ${trait.lines.map(line => `<div class="trait-line">${line}</div>`).join('')}
                        </div>
                    `;
                }
                traitsElement.innerHTML = traitsHtml;
            }
        }

        // 更新矿石组成显示
        const compositionElement = document.getElementById('composition-display');
        if (compositionElement) {
            if (Object.keys(results.composition).length === 0) {
                compositionElement.innerHTML = '<div class="no-composition">No ores selected</div>';
            } else {
                let compositionHtml = '';
                for (const [ore, percentage] of Object.entries(results.composition)) {
                    const rarity = ORES_DATA[ore]?.rarity || 'Common';
                    const color = RARITY_COLORS[rarity] || '#86868b';
                    compositionHtml += `
                        <div class="composition-item">
                            <span class="ore-name" style="color: ${color}">${ore}</span>
                            <span class="ore-percentage">${percentage.toFixed(1)}%</span>
                            <div class="composition-bar">
                                <div class="composition-fill" style="width: ${percentage}%; background-color: ${color}"></div>
                            </div>
                        </div>
                    `;
                }
                compositionElement.innerHTML = compositionHtml;
            }
        }

        // 触发自定义事件，通知UI更新
        window.dispatchEvent(new CustomEvent('calculatorUpdate', { detail: results }));
    }

    // 获取按稀有度排序的矿石列表
    getOresByRarity() {
        const rarityOrder = ['Common', 'Uncommon', 'Rare', 'Epic', 'Legendary', 'Mythical', 'Divine'];
        const oresList = Object.entries(ORES_DATA)
            .filter(([name, data]) => data.rarity && data.multiplier > 0) // 过滤掉无效矿石
            .sort((a, b) => {
                const rarityA = rarityOrder.indexOf(a[1].rarity);
                const rarityB = rarityOrder.indexOf(b[1].rarity);
                if (rarityA !== rarityB) return rarityA - rarityB;
                return a[1].multiplier - b[1].multiplier;
            });
        
        return oresList;
    }
}

// 全局计算器实例
window.forgeCalculator = new ForgeCalculator();
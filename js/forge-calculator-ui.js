// The Forge Calculator UI Component - Apple风格设计

class ForgeCalculatorUI {
    constructor(containerId) {
        this.container = document.getElementById(containerId);
        this.calculator = window.forgeCalculator;
        this.selectedOres = {};
        this.currentCraftType = 'Weapon';
        this.searchTerm = '';
        
        this.init();
    }

    init() {
        this.render();
        this.bindEvents();
        this.updateResults();
    }

    render() {
        this.container.innerHTML = `
            <div class="content-section" style="padding: 20px; border-radius: 12px;">
                <!-- 头部控制区 -->
                <div class="calculator-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; padding-bottom: 16px; border-bottom: 1px solid var(--border-primary);">
                    <div class="craft-type-selector" style="display: flex; gap: 10px;">
                        <button class="forge-button" data-type="Weapon">Weapon</button>
                        <button class="forge-button-secondary" data-type="Armor">Armor</button>
                    </div>
                    <button class="forge-button" style="--ui-orange: var(--ui-red); border-color: var(--ui-red); color: white;">Clear</button>
                </div>

                <!-- 主要内容区 -->
                <div class="calculator-main" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 24px;">
                    <!-- 左侧：矿石选择器 -->
                    <div class="tip-card" style="padding: 20px; height: fit-content;">
                        <div class="section-header">
                            <h3>Select Ores</h3>
                            <input type="text" class="ore-search" placeholder="Search ores..." style="width: 100%; padding: 10px 12px; background: var(--bg-primary); border: 1px solid var(--border-primary); border-radius: 8px; color: var(--text-primary); margin-bottom: 16px;" />
                        </div>
                        <div class="ore-grid" id="ore-grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(100px, 1fr)); gap: 8px; max-height: 400px; overflow-y: auto;">
                            <!-- 矿石按钮将在这里动态生成 -->
                        </div>
                    </div>

                    <!-- 中间：锻造区域 -->
                    <div class="tip-card" style="padding: 20px;">
                        <!-- 预测结果 -->
                        <div class="predicted-result" id="predicted-result" style="width: 100%; background: var(--bg-darker); border: 1px solid var(--border-primary); border-radius: 10px; padding: 16px; text-align: center;">
                            <div class="prediction-header" style="font-size: 12px; color: var(--text-secondary); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 8px;">Predicted Result</div>
                            <div class="prediction-content">
                                <div class="predicted-item" style="font-size: 18px; font-weight: 600; color: var(--text-primary);">No ores selected</div>
                                <div class="predicted-chance" style="font-size: 14px; color: var(--text-secondary);">0.0%</div>
                            </div>
                        </div>

                        <!-- 矿石槽位 -->
                        <div class="ore-slots" style="display: flex; justify-content: center; gap: 12px; margin: 20px 0; flex-wrap: wrap;">
                            <div class="ore-slot empty" data-slot="0" style="width: 80px; height: 80px; border: 2px dashed var(--border-primary); border-radius: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center; cursor: pointer; background: var(--bg-primary); position: relative;">
                                <span class="slot-label" style="color: var(--text-secondary); font-size: 12px;">Empty</span>
                            </div>
                            <div class="ore-slot empty" data-slot="1" style="width: 80px; height: 80px; border: 2px dashed var(--border-primary); border-radius: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center; cursor: pointer; background: var(--bg-primary); position: relative;">
                                <span class="slot-label" style="color: var(--text-secondary); font-size: 12px;">Empty</span>
                            </div>
                            <div class="ore-slot empty" data-slot="2" style="width: 80px; height: 80px; border: 2px dashed var(--border-primary); border-radius: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center; cursor: pointer; background: var(--bg-primary); position: relative;">
                                <span class="slot-label" style="color: var(--text-secondary); font-size: 12px;">Empty</span>
                            </div>
                            <div class="ore-slot empty" data-slot="3" style="width: 80px; height: 80px; border: 2px dashed var(--border-primary); border-radius: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center; cursor: pointer; background: var(--bg-primary); position: relative;">
                                <span class="slot-label" style="color: var(--text-secondary); font-size: 12px;">Empty</span>
                            </div>
                        </div>

                        <!-- 组成信息 -->
                        <div class="composition-info" id="composition-info" style="width: 100%; text-align: center;">
                            <div class="composition-text" style="font-size: 12px; color: var(--text-secondary); line-height: 1.4;">No ores selected</div>
                        </div>

                        <!-- 倍率显示 -->
                        <div class="multiplier-display" style="text-align: center; margin: 16px 0;">
                            <div class="multiplier-label" style="font-size: 14px; color: var(--text-secondary); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 4px;">Multiplier</div>
                            <div class="multiplier-value" id="multiplier-display" style="font-size: 32px; font-weight: 700; color: var(--text-primary);">0x</div>
                        </div>

                        <!-- 激活特性 -->
                        <div class="active-traits" id="active-traits" style="width: 100%; background: var(--bg-darker); border: 1px solid var(--border-primary); border-radius: 10px; padding: 16px; min-height: 80px;">
                            <div class="traits-header" style="font-size: 14px; color: var(--text-primary); font-weight: 600; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 12px; text-align: center;">Active Traits</div>
                            <div class="traits-content" id="traits-display">
                                <div class="no-traits" style="text-align: center; color: var(--text-secondary); font-size: 12px; padding: 20px 0;">No active traits</div>
                            </div>
                        </div>
                    </div>

                    <!-- 右侧：概率显示 -->
                    <div class="tip-card" style="padding: 20px; height: fit-content;">
                        <div class="section-header">
                            <h3>Forge Chances</h3>
                        </div>
                        <div class="odds-content" id="odds-display" style="max-height: 400px; overflow-y: auto;">
                            <div class="no-results" style="text-align: center; color: var(--text-secondary); font-size: 14px; padding: 40px 20px;">Need at least 3 ores to forge</div>
                        </div>
                    </div>
                </div>
            </div>
        `;
    }

    bindEvents() {
        // 制作类型切换
        this.container.querySelectorAll('.craft-type-selector button').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const type = e.target.dataset.type;
                this.setCraftType(type);
            });
        });

        // 清空按钮
        this.container.querySelector('.calculator-header > button').addEventListener('click', () => {
            this.clearAll();
        });

        // 搜索框
        this.container.querySelector('.ore-search').addEventListener('input', (e) => {
            this.searchTerm = e.target.value.toLowerCase();
            this.renderOreGrid();
        });

        // 矿石槽位点击事件
        this.container.querySelectorAll('.ore-slot').forEach(slot => {
            slot.addEventListener('click', (e) => {
                const slotIndex = parseInt(e.currentTarget.dataset.slot);
                this.removeOreFromSlot(slotIndex);
            });
        });

        // 监听计算器更新事件
        window.addEventListener('calculatorUpdate', (e) => {
            this.updateUI(e.detail);
        });
    }

    setCraftType(type) {
        this.currentCraftType = type;
        this.calculator.setCraftType(type);
        
        // 更新按钮状态
        this.container.querySelectorAll('.craft-type-selector button').forEach(btn => {
            if (btn.dataset.type === type) {
                btn.className = 'forge-button';
            } else {
                btn.className = 'forge-button-secondary';
            }
        });
    }

    clearAll() {
        this.selectedOres = {};
        this.calculator.clearOres();
        this.updateSlots();
    }

    renderOreGrid() {
        const oreGrid = this.container.querySelector('#ore-grid');
        if (!oreGrid) {
            console.error('Ore grid element not found');
            return;
        }
        
        const oresList = this.calculator.getOresByRarity();
        console.log('Ores list:', oresList); // 调试信息
        
        // 过滤矿石
        const filteredOres = oresList.filter(([name]) => 
            name.toLowerCase().includes(this.searchTerm)
        );

        console.log('Filtered ores:', filteredOres); // 调试信息

        oreGrid.innerHTML = filteredOres.map(([name, data]) => {
            const imagePath = this.getOreImagePath(name);
            const backgroundStyle = imagePath ? `background-image: url('${imagePath}')` : '';
            
            return `
                <button class="ore-btn" data-ore="${name}" style="background-color: var(--bg-primary); border: 1px solid var(--border-primary); border-radius: 8px; padding: 12px 8px; cursor: pointer; display: flex; flex-direction: column; align-items: center; gap: 4px; min-height: 100px; position: relative; background-size: cover; background-position: center; background-repeat: no-repeat; width: 100%; transition: all 0.2s ease; ${backgroundStyle ? backgroundStyle + ';' : ''}">
                    <div class="ore-btn-overlay" style="position: absolute; inset: 0; background: rgba(0,0,0,0.6); border-radius: 8px; z-index: 1;"></div>
                    <div class="ore-info" style="position: relative; z-index: 2; margin-bottom: 4px; text-shadow: 1px 1px 2px rgba(0,0,0,0.8);">
                        <div class="ore-name" style="color: ${RARITY_COLORS[data.rarity]}; font-size: 12px; font-weight: 600; margin-bottom: 2px; line-height: 1.2;">${name}</div>
                        <div class="ore-multiplier" style="font-size: 11px; color: var(--text-secondary); font-weight: 500;">${data.multiplier}x</div>
                    </div>
                    <div class="ore-rarity" style="position: relative; z-index: 2; font-size: 10px; padding: 2px 6px; border-radius: 4px; font-weight: 500; text-transform: uppercase; letter-spacing: 0.5px; text-shadow: 1px 1px 2px rgba(0,0,0,0.8); background: rgba(0,0,0,0.6); color: ${RARITY_COLORS[data.rarity]}; border: 1px solid ${RARITY_COLORS[data.rarity]}40;">${data.rarity}</div>
                </button>
            `;
        }).join('');

        // 绑定矿石按钮事件
        oreGrid.querySelectorAll('.ore-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const oreName = e.currentTarget.dataset.ore;
                this.addOre(oreName);
            });
        });
    }

    getOreImagePath(oreName) {
        // Map ore names to image file names (based on reference implementation)
        const imageMap = {
            "Stone Ore": "stone",
            "Sand Stone": "sand_stone",
            "Copper Ore": "cooper", // Note: file is named "cooper.png"
            "Iron Ore": "iron",
            "Tin Ore": "tin",
            "Silver Ore": "silver",
            "Gold Ore": "gold",
            "Mushroomite Ore": "mushroomite",
            "Platinum Ore": "platinum",
            "Bananite Ore": "bananite",
            "Cardboardite Ore": "cardboardite",
            "Aite Ore": "aite",
            "Poopite Ore": "poopite",
            "Cobalt Ore": "cobalt",
            "Titanium Ore": "titanium",
            "Lapis Lazuli Ore": "lapis_lazuli",
            "Volcanic Rock": "volcanic",
            "Quartz Ore": "quartz",
            "Amethyst Ore": "amethyst",
            "Topaz Ore": "topaz",
            "Diamond Ore": "diamond",
            "Sapphire Ore": "sapphirew", // Note: file is named "sapphirew.png"
            "Cuprite Ore": "cuprite",
            "Obsidian Ore": "obsidian",
            "Emerald Ore": "emerald",
            "Ruby Ore": "ruby",
            "Rivalite Ore": "rivalite",
            "Uranium Ore": "uranium",
            "Mythril Ore": "mythril",
            "Eye Ore": "eye",
            "Fireite Ore": "fireite",
            "Magmaite Ore": "magmaite",
            "Lightite Ore": "lightite",
            "Demonite Ore": "demonite",
            "Darkryte Ore": "darkryte"
            // Note: Galaxite Ore doesn't have an image file
        };

        const imageName = imageMap[oreName];
        if (imageName) {
            return `ores/${imageName}.png`;
        }
        return null; // Return null for ores without images
    }

    getItemImagePath(itemName, craftType) {
        // Map item names to image file names
        const weaponImageMap = {
            "Dagger": "dagger",
            "Straight Sword": "falchion", // Use falchion as default straight sword
            "Gauntlet": "ironhand", // Use ironhand as default gauntlet
            "Katana": "uchigatana", // Use uchigatana as default katana
            "Great Sword": "crusader", // Use crusader as default great sword
            "Great Axe": "double_battle_axe", // Use double_battle_axe as default
            "Colossal Sword": "great_sword" // Use great_sword as default colossal sword
        };

        const armorImageMap = {
            "Light Helmet": "light_helmet",
            "Light Leggings": "light_leggings", 
            "Light Chestplate": "light_chestplate",
            "Medium Helmet": "medium_helmet",
            "Medium Leggings": "medium_leggings",
            "Medium Chestplate": "medium_chestplate",
            "Heavy Helmet": "knight_helmet", // Use knight_helmet as default heavy helmet
            "Heavy Leggings": "knight_leggings", // Use knight_leggings as default heavy leggings
            "Heavy Chestplate": "knight_chestplate" // Use knight_chestplate as default heavy chestplate
        };

        const imageMap = craftType === 'Weapon' ? weaponImageMap : armorImageMap;
        const folderName = craftType === 'Weapon' ? 'weapons' : 'items';
        
        const imageName = imageMap[itemName];
        if (imageName) {
            return `${folderName}/${imageName}.png`;
        }
        return null;
    }

    // 计算大师级价格: 基础价格 × 倍率
    calculateMasterworkPrice(itemName, multiplier, craftType) {
        const priceData = craftType === 'Weapon' ? FORGE_DATA.weapons : FORGE_DATA.armor;
        const basePrice = priceData[itemName];
        
        if (!basePrice) return null;
        
        const finalPrice = basePrice * multiplier;
        return finalPrice;
    }

    // 计算大师级属性: (基础属性 × 倍率) × 2
    calculateMasterworkStat(itemName, multiplier, craftType) {
        const statsData = craftType === 'Weapon' ? FORGE_DATA.weaponStats : FORGE_DATA.armorStats;
        if (!statsData) return null;
        
        const baseStat = statsData[itemName];
        if (baseStat === undefined) return null;
        
        const finalStat = (baseStat * multiplier) * 2;
        return finalStat;
    }

    // 格式化价格显示
    formatPrice(price) {
        if (price >= 1000) {
            return price.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
        }
        return price.toFixed(2);
    }

    addOre(oreName) {
        // 检查是否已存在
        if (this.selectedOres[oreName]) {
            this.selectedOres[oreName]++;
        } else {
            // 检查是否有空槽位
            const emptySlots = Object.keys(this.selectedOres).length;
            if (emptySlots >= 4) {
                return; // 槽位已满
            }
            this.selectedOres[oreName] = 1;
        }

        this.calculator.selectedOres = this.selectedOres;
        this.calculator.updateResults();
        this.updateSlots();
    }

    removeOreFromSlot(slotIndex) {
        const oreNames = Object.keys(this.selectedOres);
        if (slotIndex < oreNames.length) {
            const oreName = oreNames[slotIndex];
            if (this.selectedOres[oreName] > 1) {
                this.selectedOres[oreName]--;
            } else {
                delete this.selectedOres[oreName];
            }
            
            this.calculator.selectedOres = this.selectedOres;
            this.calculator.updateResults();
            this.updateSlots();
        }
    }

    updateSlots() {
        const slots = this.container.querySelectorAll('.ore-slot');
        const oreEntries = Object.entries(this.selectedOres);

        slots.forEach((slot, index) => {
            if (index < oreEntries.length) {
                const [oreName, count] = oreEntries[index];
                const oreData = ORES_DATA[oreName];
                const rarityColor = RARITY_COLORS[oreData.rarity];
                const imagePath = this.getOreImagePath(oreName);
                const backgroundStyle = imagePath ? `background-image: url('${imagePath}')` : '';
                
                slot.className = `ore-slot filled ${oreData.rarity.toLowerCase()}`;
                slot.style.cssText = backgroundStyle;
                slot.innerHTML = `
                    <div class="ore-name" style="color: ${rarityColor}">${oreName}</div>
                    <div class="ore-count">x${count}</div>
                `;
            } else {
                slot.className = 'ore-slot empty';
                slot.style.cssText = '';
                slot.innerHTML = '<span class="slot-label">Empty</span>';
            }
        });
    }

    updateUI(results) {
        this.updatePredictedResult(results);
        this.updateComposition(results);
        this.updateTraits(results);
        this.updateOddsDisplay(results);
    }

    updatePredictedResult(results) {
        const predictionContent = this.container.querySelector('.prediction-content');
        
        if (!results || Object.keys(results.odds).length === 0) {
            predictionContent.innerHTML = `
                <div class="predicted-item">No ores selected</div>
                <div class="predicted-chance">0.0%</div>
            `;
            return;
        }

        // 获取概率最高的物品
        const sortedOdds = Object.entries(results.odds)
            .sort((a, b) => b[1] - a[1]);
        
        if (sortedOdds.length > 0) {
            const [itemName, probability] = sortedOdds[0];
            const imagePath = this.getItemImagePath(itemName, this.currentCraftType);
            const multiplier = results.combinedMultiplier;
            
            // 计算价格和属性
            const price = this.calculateMasterworkPrice(itemName, multiplier, this.currentCraftType);
            const stat = this.calculateMasterworkStat(itemName, multiplier, this.currentCraftType);
            
            predictionContent.innerHTML = `
                <div class="predicted-item-container">
                    ${imagePath ? `<img src="${imagePath}" alt="${itemName}" class="predicted-item-image" />` : ''}
                    <div class="predicted-item">${itemName}</div>
                    <div class="predicted-stats">
                        ${stat !== null ? `
                            <div class="predicted-stat ${this.currentCraftType === 'Weapon' ? 'damage' : 'defense'}">
                                ${this.currentCraftType === 'Weapon' ? 'DMG' : 'DEF'}: ${this.currentCraftType === 'Weapon' ? stat.toFixed(2) : Math.round(stat)}
                            </div>
                        ` : ''}
                        ${price !== null ? `
                            <div class="predicted-price">$${this.formatPrice(price)}</div>
                        ` : ''}
                    </div>
                </div>
                <div class="predicted-chance">${(probability * 100).toFixed(1)}%</div>
            `;
        }
    }

    updateComposition(results) {
        const compositionInfo = this.container.querySelector('#composition-info');
        
        if (!results || Object.keys(results.composition).length === 0) {
            compositionInfo.innerHTML = '<div class="composition-text" style="font-size: 12px; color: var(--text-secondary); line-height: 1.4;">No ores selected</div>';
            return;
        }

        const compositionEntries = Object.entries(results.composition)
            .sort((a, b) => b[1] - a[1]);
        
        const compositionText = compositionEntries
            .map(([ore, percentage]) => `${ore}(${percentage.toFixed(0)}%)`)
            .join(' + ');
        
        compositionInfo.innerHTML = `<div class="composition-text" style="font-size: 12px; color: var(--text-secondary); line-height: 1.4;">${compositionText}</div>`;
    }

    updateTraits(results) {
        const traitsContent = this.container.querySelector('#traits-display');
        
        if (!results || results.traits.length === 0) {
            traitsContent.innerHTML = '<div class="no-traits" style="text-align: center; color: var(--text-secondary); font-size: 12px; padding: 20px 0;">No active traits</div>';
            return;
        }

        const traitsHtml = results.traits.map(trait => `
            <div class="trait-item" style="margin-bottom: 12px; padding: 8px; background: rgba(255, 255, 255, 0.05); border-radius: 6px; border: 1px solid rgba(255, 255, 255, 0.1);">
                <div class="trait-ore" style="font-size: 12px; font-weight: 600; color: #ffffff; margin-bottom: 4px;">${trait.ore}</div>
                ${trait.lines.map(line => `<div class="trait-line" style="font-size: 11px; color: var(--text-secondary); line-height: 1.3;">${line}</div>`).join('')}
            </div>
        `).join('');
        
        traitsContent.innerHTML = traitsHtml;
    }

    updateOddsDisplay(results) {
        const oddsContent = this.container.querySelector('#odds-display');
        
        if (!results || Object.keys(results.odds).length === 0) {
            oddsContent.innerHTML = '<div class="no-results" style="text-align: center; color: var(--text-secondary); font-size: 14px; padding: 40px 20px;">Need at least 3 ores to forge</div>';
            return;
        }

        // 按概率排序
        const sortedOdds = Object.entries(results.odds)
            .sort((a, b) => b[1] - a[1]);
        
        const multiplier = results.combinedMultiplier;
        
        const oddsHtml = sortedOdds.map(([itemName, probability]) => {
            const imagePath = this.getItemImagePath(itemName, this.currentCraftType);
            const percentage = (probability * 100).toFixed(1);
            
            // 计算价格和属性
            const price = this.calculateMasterworkPrice(itemName, multiplier, this.currentCraftType);
            const stat = this.calculateMasterworkStat(itemName, multiplier, this.currentCraftType);
            
            return `
                <div class="odds-item" style="display: flex; justify-content: space-between; align-items: center; padding: 18px 0; border-bottom: 1px solid rgba(255, 255, 255, 0.05);">
                    <div class="odds-item-info" style="display: flex; align-items: center; gap: 16px; flex: 1;">
                        ${imagePath ? `<img src="${imagePath}" alt="${itemName}" class="odds-item-image" style="width: 40px; height: 40px; object-fit: cover; border-radius: 6px; background: rgba(0, 0, 0, 0.1); padding: 2px; flex-shrink: 0;" />` : ''}
                        <div class="odds-item-details" style="display: flex; flex-direction: column; gap: 4px; flex: 1;">
                            <span class="item-name" style="font-size: 13px; color: var(--text-primary); font-weight: 500;">${itemName}</span>
                            <div class="item-stats" style="display: flex; gap: 8px; align-items: center;">
                                ${stat !== null ? `
                                    <span class="item-stat" style="font-size: 11px; font-weight: 600; color: ${this.currentCraftType === 'Weapon' ? '#ff6b6b' : '#30d158'};">
                                        ${this.currentCraftType === 'Weapon' ? 'DMG' : 'DEF'}: ${this.currentCraftType === 'Weapon' ? stat.toFixed(2) : Math.round(stat)}
                                    </span>
                                ` : ''}
                                ${price !== null ? `
                                    <span class="item-price" style="font-size: 11px; color: #F4E4BC; font-weight: 500;">$${this.formatPrice(price)}</span>
                                ` : ''}
                            </div>
                        </div>
                    </div>
                    <div class="odds-item-chance" style="display: flex; flex-direction: column; align-items: flex-end; gap: 6px; min-width: 80px;">
                        <span class="probability" style="font-size: 14px; color: #ffffff; font-weight: 700; text-shadow: 0 1px 2px rgba(0, 0, 0, 0.8);">${percentage}%</span>
                        <div class="probability-bar" style="width: 80px; height: 8px; background: rgba(255, 255, 255, 0.2); border-radius: 4px; overflow: hidden; border: 1px solid rgba(255, 255, 255, 0.3);">
                            <div class="probability-fill" style="width: ${percentage}%; height: 100%; background: linear-gradient(90deg, #ffffff 0%, #f0f0f0 50%, #ffffff 100%); border-radius: 3px; transition: width 0.3s ease;"></div>
                        </div>
                    </div>
                </div>
            `;
        }).join('');
        
        oddsContent.innerHTML = oddsHtml;
    }

    updateResults() {
        console.log('Updating results...'); // 调试信息
        this.renderOreGrid();
        this.updateSlots();
    }
}

// 初始化函数
window.initForgeCalculator = function(containerId) {
    return new ForgeCalculatorUI(containerId);
};
// forge-recipe-recommendations.js
// 基于游戏数据的武器/护甲推荐配方数据库

class ForgeRecipeDatabase {
    constructor() {
        // 从现有代码中提取的关键数据
        this.weaponProbabilities = weaponProbabilities;
        this.armorProbabilities = armorProbabilities;
        this.oreData = oreData;
        this.baseItemStats = baseItemStats;
        this.optimalCounts = optimalCounts;
        this.specificItemVariants = specificItemVariants;
        
        // 初始化推荐数据库
        this.recipeDatabase = {
            weapons: {},
            armors: {}
        };
        
        this.generateAllRecipes();
    }
    
    // 生成所有物品的推荐配方
    generateAllRecipes() {
        this.generateWeaponRecipes();
        this.generateArmorRecipes();
    }
    
    // 武器推荐配方生成
    generateWeaponRecipes() {
        const weaponTypes = Object.keys(this.optimalCounts.weapon);
        
        weaponTypes.forEach(weaponType => {
            this.recipeDatabase.weapons[weaponType] = {
                // 基础信息
                type: 'weapon',
                optimalOreCount: this.optimalCounts.weapon[weaponType],
                
                // 三种推荐配方
                recipes: {
                    budget: this.generateBudgetRecipe(weaponType, 'weapon'),
                    balanced: this.generateBalancedRecipe(weaponType, 'weapon'),
                    premium: this.generatePremiumRecipe(weaponType, 'weapon')
                },
                
                // 概率分布信息
                probabilityAtOptimal: this.getProbabilityAtCount(weaponType, this.optimalCounts.weapon[weaponType], 'weapon'),
                
                // 区域特定变体
                variants: this.getVariantsForWeapon(weaponType),
                
                // 基础属性范围
                baseStats: this.getBaseStats(weaponType, 'weapon'),
                
                // 特性兼容性
                compatibleTraits: this.getCompatibleTraits('weapon')
            };
        });
    }
    
    // 护甲推荐配方生成
    generateArmorRecipes() {
        const armorTypes = Object.keys(this.optimalCounts.armor);
        
        armorTypes.forEach(armorType => {
            this.recipeDatabase.armors[armorType] = {
                type: 'armor',
                optimalOreCount: this.optimalCounts.armor[armorType],
                
                recipes: {
                    budget: this.generateBudgetRecipe(armorType, 'armor'),
                    balanced: this.generateBalancedRecipe(armorType, 'armor'),
                    premium: this.generatePremiumRecipe(armorType, 'armor')
                },
                
                probabilityAtOptimal: this.getProbabilityAtCount(armorType, this.optimalCounts.armor[armorType], 'armor'),
                
                variants: this.getVariantsForArmor(armorType),
                
                baseStats: this.getBaseStats(armorType, 'armor'),
                
                compatibleTraits: this.getCompatibleTraits('armor')
            };
        });
    }
    
    // 经济型配方（低成本，高概率）
    generateBudgetRecipe(itemType, mode) {
        const optimalCount = mode === 'weapon' 
            ? this.optimalCounts.weapon[itemType]
            : this.optimalCounts.armor[itemType];
        
        // 使用最便宜但有效的矿石
        const budgetOres = this.oreData
            .filter(ore => ore.rarity === 'common' || ore.rarity === 'uncommon')
            .sort((a, b) => a.multiplier - b.multiplier);
        
        // 选择3-4种不同的常见矿石
        const selectedOres = budgetOres.slice(0, 3);
        const totalShares = selectedOres.length;
        
        // 分配数量（确保总数为optimalCount）
        const recipe = selectedOres.map((ore, index) => {
            // 基础分配
            let count = Math.floor(optimalCount / totalShares);
            
            // 调整第一个矿石数量以凑总数
            if (index === 0) {
                count += optimalCount - (count * totalShares);
            }
            
            return {
                id: ore.id,
                name: ore.name,
                count: count,
                multiplier: ore.multiplier,
                rarity: ore.rarity,
                percentage: (count / optimalCount * 100).toFixed(1)
            };
        });
        
        // 计算平均乘数
        const avgMultiplier = this.calculateAverageMultiplier(recipe);
        const totalCost = this.calculateRecipeCost(recipe);
        
        return {
            name: `经济型${itemType}配方`,
            description: `低成本获得${itemType}的最佳组合，使用常见矿石`,
            difficulty: 'easy',
            estimatedCost: totalCost,
            avgMultiplier: avgMultiplier.toFixed(2),
            totalOres: optimalCount,
            successProbability: this.calculateSuccessProbability(recipe, itemType, mode),
            oreMix: recipe,
            traits: this.getActivatedTraits(recipe, mode),
            tips: [
                `总成本：约$${totalCost}`,
                `成功率：${this.calculateSuccessProbability(recipe, itemType, mode).toFixed(1)}%`,
                `推荐给新手玩家`
            ]
        };
    }
    
    // 平衡型配方（性价比最优）
    generateBalancedRecipe(itemType, mode) {
        const optimalCount = mode === 'weapon' 
            ? this.optimalCounts.weapon[itemType]
            : this.optimalCounts.armor[itemType];
        
        // 选择稀有度平衡的矿石
        const balancedOres = this.oreData
            .filter(ore => ore.rarity === 'uncommon' || ore.rarity === 'rare')
            .sort((a, b) => b.multiplier - a.multiplier);
        
        // 确保包含至少1个有特性的矿石
        const traitOres = balancedOres.filter(ore => ore.traits.length > 0);
        
        const selectedOres = [];
        if (traitOres.length > 0) {
            selectedOres.push(traitOres[0]); // 添加一个特性矿石
        }
        
        // 添加其他平衡矿石
        const otherOres = balancedOres.filter(ore => !selectedOres.includes(ore));
        selectedOres.push(...otherOres.slice(0, 2));
        
        // 分配数量（特性矿石获得更多数量）
        const totalSelected = selectedOres.length;
        const recipe = selectedOres.map((ore, index) => {
            let count;
            
            if (ore.traits.length > 0) {
                // 特性矿石占30-40%以确保特性激活
                count = Math.ceil(optimalCount * 0.35);
            } else {
                // 平均分配剩余数量
                const remainingOres = totalSelected - (ore.traits.length > 0 ? 1 : 0);
                count = Math.floor((optimalCount - (selectedOres[0]?.traits.length > 0 ? Math.ceil(optimalCount * 0.35) : 0)) / remainingOres);
            }
            
            return {
                id: ore.id,
                name: ore.name,
                count: count,
                multiplier: ore.multiplier,
                rarity: ore.rarity,
                percentage: (count / optimalCount * 100).toFixed(1)
            };
        });
        
        // 调整总数
        this.adjustToTotalCount(recipe, optimalCount);
        
        const avgMultiplier = this.calculateAverageMultiplier(recipe);
        const totalCost = this.calculateRecipeCost(recipe);
        
        return {
            name: `平衡型${itemType}配方`,
            description: `性价比最优的组合，平衡属性与特性`,
            difficulty: 'medium',
            estimatedCost: totalCost,
            avgMultiplier: avgMultiplier.toFixed(2),
            totalOres: optimalCount,
            successProbability: this.calculateSuccessProbability(recipe, itemType, mode),
            oreMix: recipe,
            traits: this.getActivatedTraits(recipe, mode),
            tips: [
                `平衡乘数和特性`,
                `特性激活：${this.getActivatedTraits(recipe, mode).length}个`,
                `推荐给进阶玩家`
            ]
        };
    }
    
    // 豪华型配方（最大化属性）
    generatePremiumRecipe(itemType, mode) {
        const optimalCount = mode === 'weapon' 
            ? this.optimalCounts.weapon[itemType]
            : this.optimalCounts.armor[itemType];
        
        // 选择最高稀有度的矿石
        const premiumOres = this.oreData
            .filter(ore => ore.rarity === 'epic' || ore.rarity === 'legendary' || ore.rarity === 'mythical')
            .sort((a, b) => b.multiplier - a.multiplier);
        
        // 优先选择有特性的高乘数矿石
        const traitOres = premiumOres.filter(ore => ore.traits.length > 0);
        const nonTraitOres = premiumOres.filter(ore => ore.traits.length === 0);
        
        const selectedOres = [];
        
        // 添加2-3个特性矿石
        selectedOres.push(...traitOres.slice(0, 2));
        
        // 用高乘数矿石填满
        if (selectedOres.length < 4) {
            selectedOres.push(...nonTraitOres.slice(0, 4 - selectedOres.length));
        }
        
        // 智能分配：特性矿石占主要比例
        const totalSelected = selectedOres.length;
        let remainingCount = optimalCount;
        
        const recipe = selectedOres.map((ore, index) => {
            let count;
            
            if (ore.traits.length > 0) {
                // 每个特性矿石至少30%以确保最大效果
                count = Math.ceil(optimalCount * 0.3);
            } else {
                // 非特性矿石平均分配剩余
                const traitOreCount = selectedOres.filter(o => o.traits.length > 0).length;
                const traitTotal = Math.ceil(optimalCount * 0.3 * traitOreCount);
                const remainingForNonTraits = optimalCount - traitTotal;
                const nonTraitCount = selectedOres.length - traitOreCount;
                
                count = Math.floor(remainingForNonTraits / nonTraitCount);
            }
            
            return {
                id: ore.id,
                name: ore.name,
                count: count,
                multiplier: ore.multiplier,
                rarity: ore.rarity,
                percentage: (count / optimalCount * 100).toFixed(1)
            };
        });
        
        // 确保总数正确
        this.adjustToTotalCount(recipe, optimalCount);
        
        const avgMultiplier = this.calculateAverageMultiplier(recipe);
        const totalCost = this.calculateRecipeCost(recipe);
        
        return {
            name: `豪华型${itemType}配方`,
            description: `最大化属性和特性的顶级组合`,
            difficulty: 'hard',
            estimatedCost: totalCost,
            avgMultiplier: avgMultiplier.toFixed(2),
            totalOres: optimalCount,
            successProbability: this.calculateSuccessProbability(recipe, itemType, mode),
            oreMix: recipe,
            traits: this.getActivatedTraits(recipe, mode),
            tips: [
                `最高乘数：${avgMultiplier.toFixed(2)}x`,
                `激活特性：${this.getActivatedTraits(recipe, mode).length}个`,
                `推荐给高端玩家`
            ]
        };
    }
    
    // 工具方法
    calculateAverageMultiplier(recipe) {
        let totalMultiplier = 0;
        let totalCount = 0;
        
        recipe.forEach(item => {
            totalMultiplier += item.multiplier * item.count;
            totalCount += item.count;
        });
        
        return totalMultiplier / totalCount;
    }
    
    calculateRecipeCost(recipe) {
        const rarityCostMap = {
            common: 10,
            uncommon: 50,
            rare: 200,
            epic: 1000,
            legendary: 5000,
            mythical: 25000
        };
        
        let totalCost = 0;
        recipe.forEach(item => {
            totalCost += (rarityCostMap[item.rarity] || 10) * item.count;
        });
        
        return totalCost;
    }
    
    calculateSuccessProbability(recipe, itemType, mode) {
        const totalOres = recipe.reduce((sum, item) => sum + item.count, 0);
        const probabilityTable = mode === 'weapon' ? this.weaponProbabilities : this.armorProbabilities;
        
        // 找到最接近的概率点
        const counts = Object.keys(probabilityTable).map(Number);
        const closestCount = counts.reduce((prev, curr) => {
            return (Math.abs(curr - totalOres) < Math.abs(prev - totalOres) ? curr : prev);
        });
        
        return (probabilityTable[closestCount][itemType] || 0) * 100;
    }
    
    adjustToTotalCount(recipe, targetTotal) {
        const currentTotal = recipe.reduce((sum, item) => sum + item.count, 0);
        const difference = targetTotal - currentTotal;
        
        if (difference !== 0) {
            // 调整乘数最高的矿石数量
            recipe.sort((a, b) => b.multiplier - a.multiplier);
            
            if (difference > 0) {
                recipe[0].count += difference;
            } else {
                // 确保不减少到0
                recipe[0].count = Math.max(1, recipe[0].count + difference);
            }
            
            // 重新计算百分比
            recipe.forEach(item => {
                item.percentage = ((item.count / targetTotal) * 100).toFixed(1);
            });
        }
    }
    
    getActivatedTraits(recipe, mode) {
        const totalOres = recipe.reduce((sum, item) => sum + item.count, 0);
        const traits = [];
        
        recipe.forEach(item => {
            const ore = this.oreData.find(o => o.id === item.id);
            if (ore && ore.traits.length > 0) {
                const percentage = (item.count / totalOres) * 100;
                
                ore.traits.forEach(trait => {
                    if (trait.type === 'all' || trait.type === mode) {
                        let effectiveness = '部分激活';
                        let valueRange = '';
                        
                        if (percentage >= 30) {
                            effectiveness = '完全激活';
                            Object.keys(trait.scaling).forEach(key => {
                                valueRange += `${trait.scaling[key].max}${key} `;
                            });
                        } else if (percentage >= 10) {
                            effectiveness = '基础激活';
                            Object.keys(trait.scaling).forEach(key => {
                                const min = trait.scaling[key].min;
                                const max = trait.scaling[key].max;
                                const value = min + ((percentage - 10) / 20) * (max - min);
                                valueRange += `${value.toFixed(1)}${key} `;
                            });
                        }
                        
                        if (percentage >= 10) {
                            traits.push({
                                oreName: ore.name,
                                description: trait.description,
                                percentage: percentage.toFixed(1),
                                effectiveness: effectiveness,
                                valueRange: valueRange.trim()
                            });
                        }
                    }
                });
            }
        });
        
        return traits;
    }
    
    getVariantsForWeapon(weaponType) {
        const variants = {};
        
        Object.keys(this.specificItemVariants.weapon[weaponType] || {}).forEach(area => {
            variants[area] = this.specificItemVariants.weapon[weaponType][area].map(v => ({
                name: v.name,
                probability: v.probability,
                chance: v.chance
            }));
        });
        
        return variants;
    }
    
    getVariantsForArmor(armorType) {
        const variants = {};
        
        Object.keys(this.specificItemVariants.armor[armorType] || {}).forEach(area => {
            variants[area] = this.specificItemVariants.armor[armorType][area].map(v => ({
                name: v.name,
                probability: v.probability,
                chance: v.chance
            }));
        });
        
        return variants;
    }
    
    getBaseStats(itemType, mode) {
        const baseItem = Object.entries(this.baseItemStats[mode])
            .find(([name, stats]) => stats.type === itemType);
        
        if (baseItem) {
            const [name, stats] = baseItem;
            return {
                itemName: name,
                ...stats
            };
        }
        
        return null;
    }
    
    getCompatibleTraits(mode) {
        return this.oreData
            .filter(ore => 
                ore.traits.some(trait => trait.type === 'all' || trait.type === mode)
            )
            .map(ore => ({
                name: ore.name,
                trait: ore.traits[0].description,
                type: ore.traits[0].type,
                multiplier: ore.multiplier
            }));
    }
    
    getProbabilityAtCount(itemType, count, mode) {
        const probabilityTable = mode === 'weapon' ? this.weaponProbabilities : this.armorProbabilities;
        
        // 找到最接近的计数
        const counts = Object.keys(probabilityTable).map(Number);
        const closestCount = counts.reduce((prev, curr) => {
            return (Math.abs(curr - count) < Math.abs(prev - count) ? curr : prev);
        });
        
        return (probabilityTable[closestCount][itemType] || 0) * 100;
    }
    
    // 根据物品类型获取推荐配方
    getRecipesForItem(itemType, mode = 'weapon') {
        const category = mode === 'weapon' ? 'weapons' : 'armors';
        return this.recipeDatabase[category][itemType];
    }
    
    // 搜索配方
    searchRecipes(searchTerm, filters = {}) {
        const results = [];
        
        // 搜索武器
        Object.entries(this.recipeDatabase.weapons).forEach(([weaponType, data]) => {
            if (weaponType.toLowerCase().includes(searchTerm.toLowerCase())) {
                results.push({
                    type: 'weapon',
                    item: weaponType,
                  ...data
                });
            }
        });
        
        // 搜索护甲
        Object.entries(this.recipeDatabase.armors).forEach(([armorType, data]) => {
            if (armorType.toLowerCase().includes(searchTerm.toLowerCase())) {
                results.push({
                    type: 'armor',
                    item: armorType,
                    ...data
                });
            }
        });
        
        // 应用过滤器
        let filteredResults = results;
        
        if (filters.difficulty) {
            filteredResults = filteredResults.filter(result => {
                const recipes = result.recipes;
                return Object.values(recipes).some(recipe => 
                    recipe.difficulty === filters.difficulty
                );
            });
        }
        
        if (filters.minSuccess) {
            filteredResults = filteredResults.filter(result => 
                result.probabilityAtOptimal >= filters.minSuccess
            );
        }
        
        if (filters.maxCost) {
            filteredResults = filteredResults.filter(result => {
                const recipes = result.recipes;
                return Object.values(recipes).some(recipe => 
                    recipe.estimatedCost <= filters.maxCost
                );
            });
        }
        
        return filteredResults;
    }
    
    // 导出完整数据库
    exportDatabase() {
        return {
            weapons: this.recipeDatabase.weapons,
            armors: this.recipeDatabase.armors,
            metadata: {
                generated: new Date().toISOString(),
                version: '1.0',
                totalWeapons: Object.keys(this.recipeDatabase.weapons).length,
                totalArmors: Object.keys(this.recipeDatabase.armors).length,
                totalRecipes: Object.keys(this.recipeDatabase.weapons).length * 3 + 
                             Object.keys(this.recipeDatabase.armors).length * 3
            }
        };
    }
}

// 创建并导出数据库实例
const forgeRecipeDB = new ForgeRecipeDatabase();
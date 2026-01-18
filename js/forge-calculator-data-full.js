// The Forge Calculator Data - Complete Version
console.log('Loading complete forge calculator data...');

const ORES_DATA = {
    "Stone Ore": {"rarity": "Common", "multiplier": 0.2, "traitType": null, "traits": []},
    "Sand Stone": {"rarity": "Common", "multiplier": 0.25, "traitType": null, "traits": []},
    "Copper Ore": {"rarity": "Common", "multiplier": 0.3, "traitType": null, "traits": []},
    "Iron Ore": {"rarity": "Common", "multiplier": 0.35, "traitType": null, "traits": []},
    "Tin Ore": {"rarity": "Uncommon", "multiplier": 0.425, "traitType": null, "traits": []},
    "Silver Ore": {"rarity": "Uncommon", "multiplier": 0.5, "traitType": null, "traits": []},
    "Gold Ore": {"rarity": "Uncommon", "multiplier": 0.65, "traitType": null, "traits": []},
    "Mushroomite Ore": {"rarity": "Rare", "multiplier": 0.8, "traitType": null, "traits": []},
    "Platinum Ore": {"rarity": "Rare", "multiplier": 0.8, "traitType": null, "traits": []},
    "Bananite Ore": {"rarity": "Uncommon", "multiplier": 0.85, "traitType": null, "traits": []},
    "Cardboardite Ore": {"rarity": "Common", "multiplier": 0.7, "traitType": null, "traits": []},
    "Aite Ore": {"rarity": "Epic", "multiplier": 1.0, "traitType": null, "traits": []},
    "Poopite Ore": {"rarity": "Epic", "multiplier": 1.2, "traitType": null, "traits": []},
    "Cobalt Ore": {"rarity": "Uncommon", "multiplier": 1.0, "traitType": null, "traits": []},
    "Titanium Ore": {"rarity": "Uncommon", "multiplier": 1.15, "traitType": null, "traits": []},
    "Lapis Lazuli Ore": {"rarity": "Uncommon", "multiplier": 1.3, "traitType": null, "traits": []},
    "Volcanic Rock": {"rarity": "Rare", "multiplier": 1.55, "traitType": null, "traits": []},
    "Quartz Ore": {"rarity": "Rare", "multiplier": 1.5, "traitType": null, "traits": []},
    "Amethyst Ore": {"rarity": "Rare", "multiplier": 1.65, "traitType": null, "traits": []},
    "Topaz Ore": {"rarity": "Rare", "multiplier": 1.75, "traitType": null, "traits": []},
    "Diamond Ore": {"rarity": "Rare", "multiplier": 2.0, "traitType": null, "traits": []},
    "Sapphire Ore": {"rarity": "Rare", "multiplier": 2.25, "traitType": null, "traits": []},
    "Cuprite Ore": {"rarity": "Epic", "multiplier": 2.43, "traitType": null, "traits": []},
    "Obsidian Ore": {"rarity": "Epic", "multiplier": 2.35, "traitType": "Armor", "traits": [{"description": "Vitality", "maxStat": 30, "type": "Armor"}]},
    "Emerald Ore": {"rarity": "Epic", "multiplier": 2.55, "traitType": null, "traits": []},
    "Ruby Ore": {"rarity": "Epic", "multiplier": 2.95, "traitType": null, "traits": []},
    "Rivalite Ore": {"rarity": "Epic", "multiplier": 3.33, "traitType": "Weapon", "traits": [{"description": "Crit Chance on Weapons", "maxStat": 20, "type": "Weapon"}]},
    "Uranium Ore": {"rarity": "Legendary", "multiplier": 3.0, "traitType": "Armor", "traits": [{"description": "max HP AOE Damage on Armor", "maxStat": 5, "type": "Armor"}]},
    "Mythril Ore": {"rarity": "Legendary", "multiplier": 3.5, "traitType": "Armor", "traits": [{"description": "Vitality", "maxStat": 15, "type": "Armor"}]},
    "Eye Ore": {"rarity": "Legendary", "multiplier": 4.0, "traitType": "All", "traits": [{"description": "Weapon Damage", "maxStat": 15}, {"description": "Health", "maxStat": -10}]},
    "Fireite Ore": {"rarity": "Legendary", "multiplier": 4.5, "traitType": "Weapon", "traits": [{"description": "Burn Damage on Weapons with", "maxStat": 20}, {"description": "chance", "maxStat": 30}]},
    "Magmaite Ore": {"rarity": "Legendary", "multiplier": 5.0, "traitType": "Weapon", "traits": [{"description": "AOE Explosion on Weapons with", "maxStat": 50}, {"description": "chance", "maxStat": 35}]},
    "Lightite Ore": {"rarity": "Legendary", "multiplier": 4.6, "traitType": "Armor", "traits": [{"description": "Bonus Movement Speed", "maxStat": 15, "type": "Armor"}]},
    "Demonite Ore": {"rarity": "Mythical", "multiplier": 5.5, "traitType": "Armor", "traits": [{"description": "to Burn Enemy when Damage is Taken.", "maxStat": 25, "type": "Armor"}]},
    "Darkryte Ore": {"rarity": "Mythical", "multiplier": 6.3, "traitType": "Armor", "traits": [{"description": "Chance to Dodge Damage (Negate Fully)", "maxStat": 15, "type": "Armor"}]},
    "Galaxite Ore": {"rarity": "Divine", "multiplier": 11.5, "traitType": null, "traits": []}
};

const WEAPON_ODDS = {
    "3": {"Dagger": 1.0, "Straight Sword": 0.0, "Gauntlet": 0.0, "Katana": 0.0, "Great Sword": 0.0, "Great Axe": 0.0, "Colossal Sword": 0.0},
    "4": {"Dagger": 0.86, "Straight Sword": 0.14, "Gauntlet": 0.0, "Katana": 0.0, "Great Sword": 0.0, "Great Axe": 0.0, "Colossal Sword": 0.0},
    "5": {"Dagger": 0.35, "Straight Sword": 0.65, "Gauntlet": 0.0, "Katana": 0.0, "Great Sword": 0.0, "Great Axe": 0.0, "Colossal Sword": 0.0},
    "10": {"Dagger": 0.0, "Straight Sword": 0.11, "Gauntlet": 0.47, "Katana": 0.42, "Great Sword": 0.0, "Great Axe": 0.0, "Colossal Sword": 0.0},
    "15": {"Dagger": 0.0, "Straight Sword": 0.0, "Gauntlet": 0.05, "Katana": 0.34, "Great Sword": 0.6, "Great Axe": 0.0, "Colossal Sword": 0.0},
    "25": {"Dagger": 0.0, "Straight Sword": 0.0, "Gauntlet": 0.0, "Katana": 0.01, "Great Sword": 0.12, "Great Axe": 0.6, "Colossal Sword": 0.26},
    "35": {"Dagger": 0.0, "Straight Sword": 0.0, "Gauntlet": 0.0, "Katana": 0.0, "Great Sword": 0.04, "Great Axe": 0.37, "Colossal Sword": 0.59}
};

const ARMOR_ODDS = {
    "3": {"Light Helmet": 1.0, "Light Leggings": 0, "Light Chestplate": 0, "Medium Helmet": 0, "Medium Leggings": 0, "Medium Chestplate": 0, "Heavy Helmet": 0, "Heavy Leggings": 0, "Heavy Chestplate": 0},
    "5": {"Light Helmet": 0.89, "Light Leggings": 0.11, "Light Chestplate": 0, "Medium Helmet": 0, "Medium Leggings": 0, "Medium Chestplate": 0, "Heavy Helmet": 0, "Heavy Leggings": 0, "Heavy Chestplate": 0},
    "10": {"Light Helmet": 0.04, "Light Leggings": 0.34, "Light Chestplate": 0.53, "Medium Helmet": 0.04, "Medium Leggings": 0, "Medium Chestplate": 0, "Heavy Helmet": 0, "Heavy Leggings": 0, "Heavy Chestplate": 0},
    "20": {"Light Helmet": 0, "Light Leggings": 0, "Light Chestplate": 0.01, "Medium Helmet": 0.06, "Medium Leggings": 0.32, "Medium Chestplate": 0.6, "Heavy Helmet": 0.01, "Heavy Leggings": 0, "Heavy Chestplate": 0},
    "35": {"Light Helmet": 0, "Light Leggings": 0, "Light Chestplate": 0, "Medium Helmet": 0, "Medium Leggings": 0, "Medium Chestplate": 0.02, "Heavy Helmet": 0.08, "Heavy Leggings": 0.3, "Heavy Chestplate": 0.6}
};

const RARITY_COLORS = {
    'Common': '#86868b',
    'Uncommon': '#30d158',
    'Rare': '#0a84ff',
    'Epic': '#bf5af2',
    'Legendary': '#ff9f0a',
    'Mythical': '#ff6b6b',
    'Divine': '#ffd700'
};

// 锻造数据 - 价格和属性
const FORGE_DATA = {
    "weapons": {
        "Dagger": 68,
        "Straight Sword": 120,
        "Gauntlet": 205,
        "Katana": 324,
        "Great Sword": 485,
        "Great Axe": 850,
        "Colossal Sword": 1355
    },
    "armor": {
        "Light Helmet": 65,
        "Light Leggings": 112.5,
        "Light Chestplate": 225,
        "Medium Helmet": 335,
        "Medium Leggings": 485,
        "Medium Chestplate": 850,
        "Heavy Helmet": 1020,
        "Heavy Leggings": 1200,
        "Heavy Chestplate": 1355
    },
    "weaponStats": {
        "Dagger": 4.3,
        "Gladius Dagger": 4.3,
        "Falchion Knife": 4.3,
        "Hook": 4.73,
        "Falchion": 7.5,
        "Cutlass": 9.375,
        "Rapier": 7.5,
        "Ironhand": 7.6,
        "Relevator": 9.6,
        "Uchigatana": 8.5,
        "Tachi": 8.925,
        "Crusader Sword": 12,
        "Long Sword": 12,
        "Scythe": 14.25,
        "Double Battle Axe": 15.75,
        "Great Sword": 20,
        "Hammer": 22,
        "Skull Crusher": 24,
        "Chaos": 9.375,
        "Dragon Slayer": 22
    },
    "armorStats": {
        "Light Helmet": 3.75,
        "Light Leggings": 4.375,
        "Light Chestplate": 5,
        "Medium Helmet": 6.25,
        "Samurai Helmet": 8,
        "Medium Leggings": 7.5,
        "Samurai Leggings": 9,
        "Medium Chestplate": 8.75,
        "Samurai Chestplate": 12.75,
        "Knight Helmet": 12.5,
        "Dark Knight Helmet": 18.75,
        "Knight Leggings": 13.75,
        "Dark Knight Leggings": 21.875,
        "Knight Chestplate": 16.25,
        "Dark Knight Chestplate": 25
    }
};

console.log('Complete forge calculator data loaded!', {
    ores: Object.keys(ORES_DATA).length,
    weaponOdds: Object.keys(WEAPON_ODDS).length,
    armorOdds: Object.keys(ARMOR_ODDS).length
});

// Simple test data for debugging
const ORES_DATA = {
    "Stone Ore": {
        "rarity": "Common",
        "multiplier": 0.2,
        "traitType": null,
        "traits": []
    },
    "Iron Ore": {
        "rarity": "Common",
        "multiplier": 0.35,
        "traitType": null,
        "traits": []
    },
    "Gold Ore": {
        "rarity": "Uncommon",
        "multiplier": 0.65,
        "traitType": null,
        "traits": []
    },
    "Diamond Ore": {
        "rarity": "Rare",
        "multiplier": 2.0,
        "traitType": null,
        "traits": []
    },
    "Obsidian Ore": {
        "rarity": "Epic",
        "multiplier": 2.35,
        "traitType": "Armor",
        "traits": [
            {
                "description": "Vitality",
                "maxStat": 30,
                "type": "Armor"
            }
        ]
    }
};

const WEAPON_ODDS = {
    "3": {"Dagger": 1.0, "Straight Sword": 0.0},
    "4": {"Dagger": 0.86, "Straight Sword": 0.14},
    "5": {"Dagger": 0.35, "Straight Sword": 0.65}
};

const ARMOR_ODDS = {
    "3": {"Light Helmet": 1.0, "Light Leggings": 0},
    "4": {"Light Helmet": 1.0, "Light Leggings": 0},
    "5": {"Light Helmet": 0.89, "Light Leggings": 0.11}
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

console.log('Simple data loaded successfully!');
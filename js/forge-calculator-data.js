// The Forge Calculator Data
console.log('Loading data...');

const ORES_DATA = {
    "Stone Ore": {"rarity": "Common", "multiplier": 0.2, "traitType": null, "traits": []},
    "Iron Ore": {"rarity": "Common", "multiplier": 0.35, "traitType": null, "traits": []},
    "Gold Ore": {"rarity": "Uncommon", "multiplier": 0.65, "traitType": null, "traits": []},
    "Diamond Ore": {"rarity": "Rare", "multiplier": 2.0, "traitType": null, "traits": []}
};

const WEAPON_ODDS = {
    "3": {"Dagger": 1.0, "Straight Sword": 0.0},
    "4": {"Dagger": 0.86, "Straight Sword": 0.14}
};

const ARMOR_ODDS = {
    "3": {"Light Helmet": 1.0, "Light Leggings": 0},
    "4": {"Light Helmet": 1.0, "Light Leggings": 0}
};

const RARITY_COLORS = {
    'Common': '#86868b',
    'Uncommon': '#30d158',
    'Rare': '#0a84ff',
    'Epic': '#bf5af2'
};

console.log('Data loaded!');

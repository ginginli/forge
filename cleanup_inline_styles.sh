#!/bin/bash

# Script to remove inline styles from HTML files and ensure CSS reference

echo "Cleaning up inline styles from HTML files..."

# List of HTML files to process
files=(
    "weapons.html"
    "armor.html" 
    "codes.html"
    "feedback.html"
    "privacy-policy.html"
    "terms-of-service.html"
    "private-server.html"
    "404.html"
    "ore/index.html"
    "ore/mythril.html"
    "ore/stone.html"
    "recipes/index.html"
    "recipes/best-recipes.html"
    "blog/index.html"
    "blog/mastering-the-forge.html"
    "blog/introducing-calculator.html"
    "wiki/index.html"
    "wiki/enemies.html"
    "wiki/races.html"
    "wiki/npcs.html"
    "wiki/gamepass.html"
    "wiki/runes.html"
    "ru/index.html"
    "ru/crafts.html"
    "ru/recipes/index.html"
    "ru/recipes/best-recipes.html"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "Processing $file..."
        
        # Create backup
        cp "$file" "$file.backup"
        
        # Remove style tags and their content using sed
        sed -i.tmp '/<style>/,/<\/style>/d' "$file"
        
        # Clean up temporary file
        rm -f "$file.tmp"
        
        # Check if CSS reference exists, if not add it
        if ! grep -q "forge-theme.css" "$file"; then
            # Find the title tag and add CSS reference after it
            if grep -q "<title>" "$file"; then
                sed -i.tmp 's|</title>|</title>\
    <link rel="stylesheet" href="forge-theme.css">|' "$file"
                rm -f "$file.tmp"
                echo "Added CSS reference to $file"
            fi
        fi
        
        echo "Cleaned $file"
    else
        echo "File $file not found, skipping..."
    fi
done

echo "Cleanup complete!"
echo "Backup files created with .backup extension"
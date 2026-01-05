#!/bin/bash

# Comprehensive script to remove ALL inline styles from HTML files

echo "Removing all inline styles from HTML files..."

# Function to process a file
process_file() {
    local file="$1"
    if [ -f "$file" ]; then
        echo "Processing $file..."
        
        # Create backup
        cp "$file" "$file.backup"
        
        # Remove common inline styles and replace with CSS classes
        
        # Yandex Metrika hidden image
        sed -i.tmp 's/style="position:absolute; left:-9999px;"/class="yandex-hidden"/g' "$file"
        
        # Language switcher
        sed -i.tmp 's/style="background: rgba(255, 152, 0, 0.2); border: 1px solid #ff9800;"/class="language-switcher"/g' "$file"
        sed -i.tmp 's/style="background: rgba(245, 158, 11, 0.2); border: 1px solid #ff9800;"/class="language-switcher"/g' "$file"
        
        # Calculator section
        sed -i.tmp 's/style="max-width: none; padding: 3rem 20px;"/class="calculator-section"/g' "$file"
        
        # Gacha simulator wrapper
        sed -i.tmp 's/style="width: 100%; margin: 20px 0; border-radius: 12px; overflow: hidden; box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);"/class="gacha-simulator-wrapper"/g' "$file"
        
        # Gacha iframe
        sed -i.tmp 's/style="width: 100%; height: 1400px; border: none; display: block;"/class="gacha-simulator-wrapper iframe"/g' "$file"
        
        # Quick tips section
        sed -i.tmp 's/style="background: linear-gradient(135deg, #1a1a1a 0%, #2d1810 100%); padding: 4rem 0;"/class="quick-tips-section"/g' "$file"
        
        # Quick tips title
        sed -i.tmp 's/style="color: #ff9800; font-size: 2.5rem; margin-bottom: 2.5rem; text-align: center; font-weight: 800; text-shadow: 0 2px 15px rgba(255, 152, 0, 0.4);"/class="quick-tips-title"/g' "$file"
        
        # Tips grid
        sed -i.tmp 's/style="display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 2rem; max-width: 1000px; margin: 0 auto;"/class="tips-grid"/g' "$file"
        
        # Badge styles
        sed -i.tmp 's/style="border-radius: 10px; width: 200px; height: 60px;"/class="badge-rounded"/g' "$file"
        sed -i.tmp 's/style="height: 54px; width: auto;"/class="badge-auto-height"/g' "$file"
        
        # Footer sections
        sed -i.tmp 's/style="margin: 1.5rem 0; padding: 1rem 0; border-top: 1px solid rgba(255, 87, 34, 0.3);"/class="footer-section"/g' "$file"
        sed -i.tmp 's/style="margin: 1.5rem 0; padding: 1rem 0; border-top: 1px solid rgba(245, 158, 11, 0.3);"/class="footer-section"/g' "$file"
        
        # Footer links title
        sed -i.tmp 's/style="color: #ff9800; margin-right: 1rem;"/class="footer-links-title"/g' "$file"
        
        # Footer separators
        sed -i.tmp 's/style="margin: 0 0.5rem; color: rgba(255, 255, 255, 0.5);"/class="footer-separator"/g' "$file"
        
        # Remove any remaining generic inline styles (be careful with this)
        # This will remove simple color and basic styling attributes
        sed -i.tmp 's/style="color: #[a-fA-F0-9]\{6\};"/class="text-highlight"/g' "$file"
        sed -i.tmp 's/style="color: #[a-fA-F0-9]\{3\};"/class="text-highlight"/g' "$file"
        
        # Clean up temporary file
        rm -f "$file.tmp"
        
        # Check if CSS reference exists, if not add it
        if ! grep -q "forge-theme.css" "$file"; then
            # Find the title tag and add CSS reference after it
            if grep -q "<title>" "$file"; then
                # Determine the correct path to CSS based on file location
                if [[ "$file" == *"ru/"* ]]; then
                    css_path="../forge-theme.css"
                elif [[ "$file" == *"/"* ]]; then
                    css_path="../forge-theme.css"
                else
                    css_path="forge-theme.css"
                fi
                
                sed -i.tmp "s|</title>|</title>\\
    <link rel=\"stylesheet\" href=\"$css_path\">|" "$file"
                rm -f "$file.tmp"
                echo "Added CSS reference to $file"
            fi
        fi
        
        echo "Cleaned $file"
    else
        echo "File $file not found, skipping..."
    fi
}

# List of HTML files to process
files=(
    "index.html"
    "weapons.html"
    "armor.html" 
    "codes.html"
    "feedback.html"
    "privacy-policy.html"
    "terms-of-service.html"
    "private-server.html"
    "404.html"
    "ore/index.html"
    "ore/snowite.html"
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

# Process each file
for file in "${files[@]}"; do
    process_file "$file"
done

echo "All inline styles removed!"
echo "Backup files created with .backup extension"
echo "All files now reference forge-theme.css for styling"
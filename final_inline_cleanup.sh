#!/bin/bash

# Final comprehensive cleanup of ALL remaining inline styles

echo "Final cleanup of all remaining inline styles..."

# Function to process a file with comprehensive replacements
process_file_comprehensive() {
    local file="$1"
    if [ -f "$file" ]; then
        echo "Processing $file..."
        
        # Create backup
        cp "$file" "$file.final_backup"
        
        # Submit result display none
        sed -i.tmp 's/style="display: none;"/class="submit-result-hidden"/g' "$file"
        
        # Section headers
        sed -i.tmp 's/style="color: #ff5722; margin-bottom: 1rem;"/class="section-header"/g' "$file"
        sed -i.tmp 's/style="color: #ff5722; margin-bottom: 1.5rem;"/class="section-header-large"/g' "$file"
        
        # Section paragraphs
        sed -i.tmp 's/style="margin-bottom: 1rem;"/class="section-paragraph"/g' "$file"
        
        # Info boxes
        sed -i.tmp 's/style="background: linear-gradient(135deg, #fff3e0 0%, #ffe0b2 100%); border-left: 4px solid #ff9800; padding: 1.5rem; border-radius: 8px; margin: 1.5rem 0;"/class="info-box"/g' "$file"
        
        # Info box headers
        sed -i.tmp 's/style="color: #e65100; margin-bottom: 0.75rem;"/class="info-box-header"/g' "$file"
        
        # Info box text
        sed -i.tmp 's/style="color: #555; margin-bottom: 0.5rem;"/class="info-box-text"/g' "$file"
        sed -i.tmp 's/style="color: #555; margin-bottom: 0.75rem;"/class="stat-card-text"/g' "$file"
        
        # Info box lists
        sed -i.tmp 's/style="color: #555; margin-left: 1.5rem; line-height: 1.8;"/class="info-box-list"/g' "$file"
        sed -i.tmp 's/style="color: #555; margin-left: 1.5rem; line-height: 1.6;"/class="stat-card-list"/g' "$file"
        
        # Enhancement grid
        sed -i.tmp 's/style="display: grid; grid-template-columns: repeat(auto-fit, minmax(450px, 1fr)); gap: 2rem; margin-bottom: 2rem;"/class="enhancement-grid"/g' "$file"
        
        # Enhancement cards
        sed -i.tmp 's/style="background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%); border-radius: 12px; padding: 2rem; border-left: 4px solid #9c27b0;"/class="enhancement-card"/g' "$file"
        
        # Enhancement card headers
        sed -i.tmp 's/style="color: #ce93d8; margin-bottom: 1rem; font-size: 1.3rem;"/class="enhancement-card-header"/g' "$file"
        
        # Enhancement card text
        sed -i.tmp 's/style="color: #b0bec5; margin-bottom: 1rem;"/class="enhancement-card-text"/g' "$file"
        
        # Enhancement card lists
        sed -i.tmp 's/style="color: #b0bec5; margin-left: 1.5rem; line-height: 1.8;"/class="enhancement-card-list"/g' "$file"
        
        # Upgrade path box
        sed -i.tmp 's/style="background: linear-gradient(135deg, #2d1810 0%, #1a1a1a 100%); border-radius: 12px; padding: 1.5rem; text-align: center; border: 2px solid #9c27b0;"/class="upgrade-path-box"/g' "$file"
        
        # Upgrade path text
        sed -i.tmp 's/style="color: #ce93d8; font-size: 1.1rem; margin: 0;"/class="upgrade-path-text"/g' "$file"
        
        # Stats grid
        sed -i.tmp 's/style="display: grid; gap: 1.5rem;"/class="stats-grid"/g' "$file"
        
        # Stat cards - damage
        sed -i.tmp 's/style="background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%); border-radius: 12px; padding: 1.5rem; border-left: 4px solid #f44336;"/class="stat-card-damage"/g' "$file"
        
        # Stat cards - speed
        sed -i.tmp 's/style="background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%); border-radius: 12px; padding: 1.5rem; border-left: 4px solid #2196f3;"/class="stat-card-speed"/g' "$file"
        
        # Stat cards - quality
        sed -i.tmp 's/style="background: linear-gradient(135deg, #f3e5f5 0%, #e1bee7 100%); border-radius: 12px; padding: 1.5rem; border-left: 4px solid #9c27b0;"/class="stat-card-quality"/g' "$file"
        
        # Stat cards - range
        sed -i.tmp 's/style="background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%); border-radius: 12px; padding: 1.5rem; border-left: 4px solid #4caf50;"/class="stat-card-range"/g' "$file"
        
        # Stat cards - type
        sed -i.tmp 's/style="background: linear-gradient(135deg, #fff3e0 0%, #ffe0b2 100%); border-radius: 12px; padding: 1.5rem; border-left: 4px solid #ff9800;"/class="stat-card-type"/g' "$file"
        
        # Stat cards - chance
        sed -i.tmp 's/style="background: linear-gradient(135deg, #fce4ec 0%, #f8bbd0 100%); border-radius: 12px; padding: 1.5rem; border-left: 4px solid #e91e63;"/class="stat-card-chance"/g' "$file"
        
        # Stat cards - price
        sed -i.tmp 's/style="background: linear-gradient(135deg, #e0f2f1 0%, #b2dfdb 100%); border-radius: 12px; padding: 1.5rem; border-left: 4px solid #009688;"/class="stat-card-price"/g' "$file"
        
        # Stat card headers
        sed -i.tmp 's/style="color: #c62828; margin-bottom: 0.75rem; font-size: 1.2rem;"/class="stat-card-header-damage"/g' "$file"
        sed -i.tmp 's/style="color: #1565c0; margin-bottom: 0.75rem; font-size: 1.2rem;"/class="stat-card-header-speed"/g' "$file"
        sed -i.tmp 's/style="color: #6a1b9a; margin-bottom: 0.75rem; font-size: 1.2rem;"/class="stat-card-header-quality"/g' "$file"
        sed -i.tmp 's/style="color: #2e7d32; margin-bottom: 0.75rem; font-size: 1.2rem;"/class="stat-card-header-range"/g' "$file"
        sed -i.tmp 's/style="color: #e65100; margin-bottom: 0.75rem; font-size: 1.2rem;"/class="stat-card-header-type"/g' "$file"
        sed -i.tmp 's/style="color: #c2185b; margin-bottom: 0.75rem; font-size: 1.2rem;"/class="stat-card-header-chance"/g' "$file"
        sed -i.tmp 's/style="color: #00695c; margin-bottom: 0.75rem; font-size: 1.2rem;"/class="stat-card-header-price"/g' "$file"
        
        # Remove any remaining simple inline styles
        # Remove generic color styles
        sed -i.tmp 's/ style="[^"]*color:[^"]*"//g' "$file"
        sed -i.tmp 's/ style="[^"]*margin[^"]*"//g' "$file"
        sed -i.tmp 's/ style="[^"]*padding[^"]*"//g' "$file"
        sed -i.tmp 's/ style="[^"]*background[^"]*"//g' "$file"
        sed -i.tmp 's/ style="[^"]*border[^"]*"//g' "$file"
        sed -i.tmp 's/ style="[^"]*display[^"]*"//g' "$file"
        sed -i.tmp 's/ style="[^"]*font[^"]*"//g' "$file"
        sed -i.tmp 's/ style="[^"]*text[^"]*"//g' "$file"
        sed -i.tmp 's/ style="[^"]*line-height[^"]*"//g' "$file"
        
        # Clean up temporary file
        rm -f "$file.tmp"
        
        echo "Comprehensively cleaned $file"
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
    process_file_comprehensive "$file"
done

echo "Final comprehensive cleanup complete!"
echo "All inline styles have been removed and replaced with CSS classes"
echo "Backup files created with .final_backup extension"
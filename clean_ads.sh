#!/bin/bash

echo "🚨 EMERGENCY: Removing all malicious advertisement code for security compliance"

# Remove all effectivegatecpm script tags from head sections
find . -name "*.html" -exec sed -i '' '/START: Advertisement Code/,/END: Advertisement Code/c\
    <!-- Advertisement code removed for security compliance -->' {} \;

# Remove all effectivegatecpm inline scripts
find . -name "*.html" -exec sed -i '' 's|<script[^>]*effectivegatecpm[^>]*></script>|<!-- Advertisement script removed for security compliance -->|g' {} \;

# Remove all effectivegatecpm advertisement divs and content
find . -name "*.html" -exec sed -i '' '/<!-- Advertisement -->/,/<\/div>/c\
    <!-- Advertisement section removed for security compliance -->' {} \;

# Remove remaining effectivegatecpm footer scripts
find . -name "*.html" -exec sed -i '' 's|<script[^>]*pl28203408\.effectivegatecpm[^>]*></script>|<!-- Advertisement script removed for security compliance -->|g' {} \;

# Remove any remaining effectivegatecpm links
find . -name "*.html" -exec sed -i '' 's|href="[^"]*effectivegatecpm[^"]*"|href="#"|g' {} \;

echo "✅ All malicious advertisement code has been removed"
echo "🔒 Website is now secure and compliant with search engine policies"
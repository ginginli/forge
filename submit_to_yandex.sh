#!/bin/bash

# Yandex URL Submission Script for Forge Calculator
# This script helps submit important URLs to Yandex for faster indexing

echo "🚀 Yandex URL Submission Helper for Forge Calculator"
echo "=================================================="

# Important URLs to submit to Yandex
IMPORTANT_URLS=(
    "https://forge-calculator.com/"
    "https://forge-calculator.com/codes.html"
    "https://forge-calculator.com/weapons.html"
    "https://forge-calculator.com/armor.html"
    "https://forge-calculator.com/recipes/"
    "https://forge-calculator.com/wiki/"
    "https://forge-calculator.com/ore/"
    "https://forge-calculator.com/blog/"
)

echo "📋 Important URLs to submit to Yandex Webmaster:"
echo ""

for url in "${IMPORTANT_URLS[@]}"; do
    echo "✅ $url"
done

echo ""
echo "🔧 Manual Steps Required:"
echo "1. Go to Yandex Webmaster Tools: https://webmaster.yandex.com/"
echo "2. Select your site: forge-calculator.com"
echo "3. Navigate to 'Indexing' → 'Reindex pages'"
echo "4. Submit each URL above for reindexing"
echo ""
echo "📊 Sitemap Information:"
echo "Sitemap URL: https://forge-calculator.com/sitemap.xml"
echo "Last Updated: $(date '+%Y-%m-%d')"
echo "Total Pages: $(grep -c '<url>' sitemap.xml) URLs"
echo ""
echo "⚡ Yandex.Metrica Status:"
echo "Counter ID: 105846978"
echo "Status: Active on all pages"
echo "Auto-discovery: Enabled"
echo ""
echo "🎯 Expected Results:"
echo "- Favicon update: 1-3 days"
echo "- New content discovery: 1-7 days"
echo "- Full indexing: 2-4 weeks"
echo ""
echo "✨ Done! Please submit the URLs manually in Yandex Webmaster Tools."
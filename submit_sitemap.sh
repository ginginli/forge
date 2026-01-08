#!/bin/bash

# Submit Sitemap to Search Engines
# 向搜索引擎提交网站地图

echo "🚀 Starting sitemap submission process..."

SITEMAP_URL="https://forge-calculator.com/sitemap.xml"
DOMAIN="forge-calculator.com"

# Google Search Console
echo "📊 Submitting to Google Search Console..."
curl -X GET "https://www.google.com/ping?sitemap=${SITEMAP_URL}"

# Bing Webmaster Tools
echo "🔍 Submitting to Bing Webmaster Tools..."
curl -X GET "https://www.bing.com/ping?sitemap=${SITEMAP_URL}"

# Yandex Webmaster
echo "🇷🇺 Submitting to Yandex Webmaster..."
curl -X GET "https://webmaster.yandex.com/ping?sitemap=${SITEMAP_URL}"

# IndexNow (Microsoft Bing, Yandex, Seznam.cz, Naver)
echo "⚡ Submitting via IndexNow..."
curl -X POST "https://api.indexnow.org/indexnow" \
  -H "Content-Type: application/json" \
  -d '{
    "host": "'${DOMAIN}'",
    "key": "599a0d628c834338ac489c0192d9915e",
    "keyLocation": "https://'${DOMAIN}'/599a0d628c834338ac489c0192d9915e.txt",
    "urlList": [
      "https://'${DOMAIN}'/sitemap.xml"
    ]
  }'

echo ""
echo "✅ Sitemap submission completed!"
echo "📋 Submitted to:"
echo "   - Google Search Console"
echo "   - Bing Webmaster Tools" 
echo "   - Yandex Webmaster"
echo "   - IndexNow API"
echo ""
echo "💡 Next steps:"
echo "   1. Verify sitemap in Google Search Console"
echo "   2. Check indexing status in 24-48 hours"
echo "   3. Monitor Google Search Console for errors"
echo "   4. Ensure all pages have proper meta tags and content"
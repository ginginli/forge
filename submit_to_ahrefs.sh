#!/bin/bash

# Ahrefs API endpoint
API_ENDPOINT="https://api.ahrefs.com/v3/site-explorer/url-rating"
KEY_LOCATION="https://forge-calculator.com/599a0d628c834338ac489c0192d9915e.txt"

# 网站的所有重要页面
URLS=(
    "https://forge-calculator.com/"
    "https://forge-calculator.com/wiki.html"
    "https://forge-calculator.com/codes.html"
    "https://forge-calculator.com/recipes.html"
    "https://forge-calculator.com/ore-guide.html"
    "https://forge-calculator.com/weapons.html"
    "https://forge-calculator.com/races.html"
    "https://forge-calculator.com/enemies.html"
    "https://forge-calculator.com/npcs.html"
    "https://forge-calculator.com/crafting-guide.html"
    "https://forge-calculator.com/feedback.html"
    "https://forge-calculator.com/blog.html"
    "https://forge-calculator.com/blog-mastering-the-forge.html"
    "https://forge-calculator.com/blog-introducing-calculator.html"
    "https://forge-calculator.com/privacy-policy.html"
    "https://forge-calculator.com/terms-of-service.html"
)

echo "🚀 Submitting URLs to Ahrefs..."
echo "================================"

for url in "${URLS[@]}"; do
    echo "📤 Submitting: $url"
    
    # 使用 curl 提交 URL
    response=$(curl -s -X POST \
        "https://api.ahrefs.com/v3/site-explorer/url-rating?url=${url}&key_location=${KEY_LOCATION}" \
        -H "Content-Type: application/json")
    
    echo "   Response: $response"
    echo ""
    
    # 避免请求过快
    sleep 1
done

echo "✅ All URLs submitted!"

#!/bin/bash

# 提交更新页面到搜索引擎
# 使用 IndexNow API 快速通知搜索引擎页面已更新

# IndexNow API endpoint
INDEXNOW_ENDPOINT="https://api.indexnow.org/indexnow"
KEY_LOCATION="https://forge-calculator.com/599a0d628c834338ac489c0192d9915e.txt"

# 刚刚修复的页面列表
UPDATED_URLS=(
    "https://forge-calculator.com/npcs.html"
    "https://forge-calculator.com/wiki/races.html"
    "https://forge-calculator.com/enemies.html"
    "https://forge-calculator.com/recipe-viewer.html"
    "https://forge-calculator.com/recipes/recipe-database-ui.html"
    "https://forge-calculator.com/blog/introducing-calculator-print.html"
    "https://forge-calculator.com/generate-recipes/"
    "https://forge-calculator.com/sitemap.xml"
)

echo "🔄 提交更新的页面到搜索引擎..."
echo "================================"

# 1. 提交到 IndexNow (Bing, Yandex 等)
echo "📤 提交到 IndexNow API..."
for url in "${UPDATED_URLS[@]}"; do
    echo "   提交: $url"
    
    curl -X POST "$INDEXNOW_ENDPOINT" \
        -H "Content-Type: application/json" \
        -d "{
            \"host\": \"forge-calculator.com\",
            \"key\": \"599a0d628c834338ac489c0192d9915e\",
            \"keyLocation\": \"$KEY_LOCATION\",
            \"urlList\": [\"$url\"]
        }" \
        --silent --output /dev/null
    
    sleep 0.5
done

echo ""
echo "✅ IndexNow 提交完成!"

# 2. 生成 Google Search Console 提交命令
echo ""
echo "📋 Google Search Console 手动提交列表:"
echo "================================"
echo "请在 Google Search Console 中逐个提交以下URL:"
echo ""

for url in "${UPDATED_URLS[@]}"; do
    echo "   $url"
done

echo ""
echo "🔗 或者直接提交更新的 sitemap:"
echo "   https://forge-calculator.com/sitemap.xml"

echo ""
echo "📊 提交完成统计:"
echo "   - 更新页面数: ${#UPDATED_URLS[@]}"
echo "   - IndexNow 提交: ✅"
echo "   - Google 需手动提交: ⏳"

echo ""
echo "💡 建议:"
echo "   1. 在 Google Search Console 提交 sitemap"
echo "   2. 等待 24-48 小时查看索引状态"
echo "   3. 检查 canonical 标签是否生效"
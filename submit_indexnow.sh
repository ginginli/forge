#!/bin/bash

echo "🔄 提交更新的URL到IndexNow API..."

# IndexNow API endpoints
BING_API="https://api.indexnow.org/indexnow"
YANDEX_API="https://yandex.com/indexnow"

# 网站信息
SITE_URL="https://forge-calculator.com"
KEY="599a0d628c834338ac489c0192d9915e"

# 读取URL列表
URLS_FILE="indexnow-urls.txt"

if [ ! -f "$URLS_FILE" ]; then
    echo "❌ URL文件不存在: $URLS_FILE"
    exit 1
fi

# 创建JSON payload
echo "📝 创建JSON payload..."
URLS_JSON=$(cat "$URLS_FILE" | jq -R . | jq -s .)

JSON_PAYLOAD=$(cat <<EOF
{
    "host": "forge-calculator.com",
    "key": "$KEY",
    "keyLocation": "$SITE_URL/$KEY.txt",
    "urlList": $URLS_JSON
}
EOF
)

echo "📤 提交到Bing IndexNow API..."
BING_RESPONSE=$(curl -s -X POST "$BING_API" \
    -H "Content-Type: application/json" \
    -d "$JSON_PAYLOAD")

echo "Bing响应: $BING_RESPONSE"

echo "📤 提交到Yandex IndexNow API..."
YANDEX_RESPONSE=$(curl -s -X POST "$YANDEX_API" \
    -H "Content-Type: application/json" \
    -d "$JSON_PAYLOAD")

echo "Yandex响应: $YANDEX_RESPONSE"

echo "✅ IndexNow提交完成！"
echo "📊 提交了 $(cat "$URLS_FILE" | wc -l) 个URL"
echo ""
echo "🔍 主要更新的页面："
echo "  • 主页: https://forge-calculator.com/"
echo "  • 配方页面: https://forge-calculator.com/recipes/"
echo "  • 矿石指南: https://forge-calculator.com/ore/"
echo "  • Wiki页面: https://forge-calculator.com/wiki/"
echo "  • 博客页面: https://forge-calculator.com/blog/"
echo ""
echo "⚠️  注意：旧的URL路径已经重构，新的层级结构更加清晰"
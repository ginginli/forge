#!/bin/bash

echo "🚀 提交优先级页面到IndexNow API..."

# IndexNow API endpoints
BING_API="https://api.indexnow.org/indexnow"
YANDEX_API="https://yandex.com/indexnow"

# 网站信息
SITE_URL="https://forge-calculator.com"
KEY="599a0d628c834338ac489c0192d9915e"

# 读取优先级URL列表
URLS_FILE="priority_indexnow_urls.txt"

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

echo "✅ 优先级页面IndexNow提交完成！"
echo "📊 提交了 $(cat "$URLS_FILE" | wc -l) 个优先级URL"
echo ""
echo "🎯 提交的优先级页面："
cat "$URLS_FILE" | sed 's/^/  • /'
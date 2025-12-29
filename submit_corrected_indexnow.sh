#!/bin/bash

echo "🔄 提交修正后的 IndexNow URLs..."
echo "=========================================="

# 网站信息
KEY="599a0d628c834338ac489c0192d9915e"
SITE_URL="https://forge-calculator.com"

# 修正后的问题页面 (移除 .html 和尾随斜杠)
CORRECTED_URLS=(
    "https://forge-calculator.com/wiki/runes"
    "https://forge-calculator.com/wiki"
)

echo "🔍 验证修正后的页面可访问性..."
for url in "${CORRECTED_URLS[@]}"; do
    status=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    if [ "$status" -eq 200 ]; then
        echo "✅ $url - OK ($status)"
    else
        echo "❌ $url - Error ($status)"
    fi
done

echo ""
echo "📤 提交修正后的 URLs 到 IndexNow API..."

# 创建 JSON payload
CORRECTED_URLS_JSON=$(printf '%s\n' "${CORRECTED_URLS[@]}" | jq -R . | jq -s .)

JSON_PAYLOAD=$(cat <<EOF
{
    "host": "forge-calculator.com",
    "key": "$KEY",
    "keyLocation": "$SITE_URL/$KEY.txt",
    "urlList": $CORRECTED_URLS_JSON
}
EOF
)

echo "修正后的 JSON Payload:"
echo "$JSON_PAYLOAD" | jq .

echo ""
echo "📤 提交到 Bing IndexNow API..."
BING_RESPONSE=$(curl -s -w "\nHTTP_CODE:%{http_code}" -X POST "https://api.indexnow.org/indexnow" \
    -H "Content-Type: application/json" \
    -d "$JSON_PAYLOAD")

BING_HTTP_CODE=$(echo "$BING_RESPONSE" | grep "HTTP_CODE:" | cut -d: -f2)
BING_BODY=$(echo "$BING_RESPONSE" | sed '/HTTP_CODE:/d')

echo "Bing 响应码: $BING_HTTP_CODE"
echo "Bing 响应体: $BING_BODY"

if [ "$BING_HTTP_CODE" -eq 200 ]; then
    echo "✅ Bing IndexNow 提交成功"
else
    echo "❌ Bing IndexNow 提交失败"
fi

echo ""
echo "📤 提交到 Yandex IndexNow API..."
YANDEX_RESPONSE=$(curl -s -w "\nHTTP_CODE:%{http_code}" -X POST "https://yandex.com/indexnow" \
    -H "Content-Type: application/json" \
    -d "$JSON_PAYLOAD")

YANDEX_HTTP_CODE=$(echo "$YANDEX_RESPONSE" | grep "HTTP_CODE:" | cut -d: -f2)
YANDEX_BODY=$(echo "$YANDEX_RESPONSE" | sed '/HTTP_CODE:/d')

echo "Yandex 响应码: $YANDEX_HTTP_CODE"
echo "Yandex 响应体: $YANDEX_BODY"

if [ "$YANDEX_HTTP_CODE" -eq 200 ] || [ "$YANDEX_HTTP_CODE" -eq 202 ]; then
    echo "✅ Yandex IndexNow 提交成功"
else
    echo "❌ Yandex IndexNow 提交失败"
fi

echo ""
echo "📤 提交完整的更新 URL 列表..."
./submit_indexnow.sh

echo ""
echo "=========================================="
echo "🎯 IndexNow 问题根本原因:"
echo "  • Vercel cleanUrls 配置导致 URL 重定向"
echo "  • /wiki/runes.html → /wiki/runes (308)"
echo "  • /wiki/ → /wiki (308)"
echo "  • IndexNow 不能处理重定向的 URLs"
echo ""
echo "✅ 修复措施:"
echo "  • 更新了 indexnow-urls.txt 使用正确的 URL 格式"
echo "  • 移除了 .html 扩展名和尾随斜杠"
echo "  • 重新提交了所有 URLs"
echo ""
echo "⏰ 预期结果:"
echo "  • 24-48 小时内 Google Search Console 应显示改善"
echo "  • IndexNow 错误应该消失"
echo "  • 页面索引速度应该提升"

echo ""
echo "✅ 修正后的 IndexNow 提交完成！"
echo "日期: $(date)"
#!/bin/bash

echo "🔄 修复 IndexNow 问题页面提交..."
echo "=========================================="

# 网站信息
KEY="599a0d628c834338ac489c0192d9915e"
SITE_URL="https://forge-calculator.com"

# 问题页面 (来自 Google Search Console)
PROBLEM_URLS=(
    "https://forge-calculator.com/wiki/runes.html"
    "https://forge-calculator.com/wiki/"
)

echo "🔍 首先验证密钥文件可访问性..."
KEY_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$SITE_URL/$KEY.txt")
if [ "$KEY_STATUS" -eq 200 ]; then
    echo "✅ 密钥文件可访问 ($KEY_STATUS)"
else
    echo "❌ 密钥文件无法访问 ($KEY_STATUS)"
    exit 1
fi

echo ""
echo "🔍 验证问题页面可访问性..."
for url in "${PROBLEM_URLS[@]}"; do
    status=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    if [ "$status" -eq 200 ]; then
        echo "✅ $url - OK ($status)"
    else
        echo "❌ $url - Error ($status)"
    fi
done

echo ""
echo "📤 重新提交问题页面到 IndexNow API..."

# 创建 JSON payload 用于问题页面
PROBLEM_URLS_JSON=$(printf '%s\n' "${PROBLEM_URLS[@]}" | jq -R . | jq -s .)

JSON_PAYLOAD=$(cat <<EOF
{
    "host": "forge-calculator.com",
    "key": "$KEY",
    "keyLocation": "$SITE_URL/$KEY.txt",
    "urlList": $PROBLEM_URLS_JSON
}
EOF
)

echo "JSON Payload:"
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

if [ "$YANDEX_HTTP_CODE" -eq 200 ]; then
    echo "✅ Yandex IndexNow 提交成功"
else
    echo "❌ Yandex IndexNow 提交失败"
fi

echo ""
echo "=========================================="
echo "📊 修复总结:"
echo "  • 提交的问题页面数量: ${#PROBLEM_URLS[@]}"
echo "  • Bing API 状态: $BING_HTTP_CODE"
echo "  • Yandex API 状态: $YANDEX_HTTP_CODE"
echo ""
echo "⏰ 预期结果:"
echo "  • 24-48 小时内 Google Search Console 应显示改善"
echo "  • 问题页面应重新出现在搜索结果中"
echo ""
echo "🔍 监控建议:"
echo "  • 检查 Google Search Console IndexNow 报告"
echo "  • 验证页面是否被重新索引"
echo "  • 如问题持续，考虑手动提交到 Google Search Console"

echo ""
echo "✅ IndexNow 问题修复脚本执行完成！"
echo "日期: $(date)"
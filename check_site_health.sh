#!/bin/bash

# The Forge Calculator - Site Health Check Script
# 检查网站健康状况，识别可能的 4xx 错误

echo "🔍 The Forge Calculator - Site Health Check"
echo "=========================================="
echo ""

# 基础 URL
BASE_URL="https://forge-calculator.com"

# 要检查的关键页面
PAGES=(
    "/"
    "/codes.html"
    "/recipes/"
    "/recipes/best-recipes.html"
    "/weapons.html"
    "/armor.html"
    "/wiki/"
    "/wiki/races.html"
    "/wiki/enemies.html"
    "/wiki/npcs.html"
    "/wiki/runes.html"
    "/wiki/gamepass.html"
    "/blog/"
    "/blog/mastering-the-forge.html"
    "/blog/introducing-calculator.html"
    "/blog/introducing-calculator-print.html"
    "/blog/beginners-guide.html"
    "/ore/"
    "/ore/stone.html"
    "/ore/mythril.html"
    "/private-server.html"
    "/feedback.html"
    "/privacy-policy.html"
    "/terms-of-service.html"
    "/ru/"
    "/ru/crafts.html"
    "/ru/recipes/"
    "/ru/recipes/best-recipes.html"
)

# 检查函数
check_url() {
    local url="$1"
    local full_url="${BASE_URL}${url}"
    
    # 使用 curl 检查 HTTP 状态码
    local status_code=$(curl -s -o /dev/null -w "%{http_code}" "$full_url")
    
    if [ "$status_code" -eq 200 ]; then
        echo "✅ $url - OK ($status_code)"
    elif [ "$status_code" -ge 300 ] && [ "$status_code" -lt 400 ]; then
        echo "🔄 $url - Redirect ($status_code)"
    elif [ "$status_code" -ge 400 ] && [ "$status_code" -lt 500 ]; then
        echo "❌ $url - Client Error ($status_code)"
        ERROR_PAGES+=("$url")
    elif [ "$status_code" -ge 500 ]; then
        echo "🚨 $url - Server Error ($status_code)"
        ERROR_PAGES+=("$url")
    else
        echo "❓ $url - Unknown ($status_code)"
    fi
}

# 错误页面数组
ERROR_PAGES=()

echo "检查主要页面..."
echo ""

# 检查所有页面
for page in "${PAGES[@]}"; do
    check_url "$page"
    sleep 0.5  # 避免过快请求
done

echo ""
echo "=========================================="

# 总结报告
if [ ${#ERROR_PAGES[@]} -eq 0 ]; then
    echo "🎉 所有页面都正常工作！"
else
    echo "⚠️  发现 ${#ERROR_PAGES[@]} 个问题页面："
    for error_page in "${ERROR_PAGES[@]}"; do
        echo "   - $error_page"
    done
    echo ""
    echo "建议："
    echo "1. 检查这些页面是否应该存在"
    echo "2. 如果页面已删除，添加重定向到 vercel.json"
    echo "3. 如果页面应该存在，检查文件路径和部署"
    echo "4. 在 Yandex Webmaster 中标记删除的页面"
fi

echo ""
echo "检查完成！"
echo "日期: $(date)"
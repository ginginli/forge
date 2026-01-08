#!/bin/bash

# Test URL Redirects - Find the source of canonical redirect issues
# 测试URL重定向 - 找到canonical重定向问题的源头

echo "🔍 测试网站重定向问题..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

SITE_URL="https://forge-calculator.com"

# 测试的URL列表
TEST_URLS=(
    "/armor"
    "/armor.html"
    "/weapons"
    "/weapons.html"
    "/codes"
    "/codes.html"
    "/pickaxe"
    "/pickaxe.html"
    "/feedback"
    "/feedback.html"
    "/ore/snowite"
    "/ore/snowite.html"
    "/snowite"
    "/mythril"
    "/stone"
)

echo -e "${BLUE}📊 测试 ${#TEST_URLS[@]} 个URL的重定向状态...${NC}"
echo ""

for url in "${TEST_URLS[@]}"; do
    full_url="${SITE_URL}${url}"
    
    # 获取HTTP状态码和Location头
    response=$(curl -s -I "$full_url")
    status_code=$(echo "$response" | grep -i "^HTTP" | awk '{print $2}')
    location=$(echo "$response" | grep -i "^Location:" | cut -d' ' -f2- | tr -d '\r')
    
    # 根据状态码显示不同颜色
    case $status_code in
        200)
            echo -e "${GREEN}✅ $url → $status_code (OK)${NC}"
            ;;
        301|302|308)
            echo -e "${RED}🔄 $url → $status_code → $location${NC}"
            ;;
        404)
            echo -e "${YELLOW}❌ $url → $status_code (Not Found)${NC}"
            ;;
        *)
            echo -e "${BLUE}ℹ️  $url → $status_code${NC}"
            ;;
    esac
done

echo ""
echo -e "${YELLOW}📋 分析结果:${NC}"
echo "• 200 状态码 = 正常，无重定向"
echo "• 301/302/308 = 重定向（这是问题所在）"
echo "• 404 = 页面不存在"

echo ""
echo -e "${BLUE}🎯 如果发现重定向，需要:${NC}"
echo "1. 检查 .htaccess 重定向规则"
echo "2. 确保 canonical 标签指向最终URL"
echo "3. 更新内部链接避免重定向"
echo "4. 在 GSC 中重新提交 sitemap"
#!/bin/bash

# Fix Social Media Meta Tags - Remove .html extensions
# 修复社交媒体元标签 - 移除.html后缀

echo "🔧 修复所有页面的 Open Graph 和 Twitter 标签..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 查找所有HTML文件
HTML_FILES=$(find . -name "*.html" -not -path "./.git/*")

echo -e "${BLUE}找到 $(echo "$HTML_FILES" | wc -l) 个HTML文件${NC}"

# 修复每个文件中的社交媒体标签
for file in $HTML_FILES; do
    echo -e "${YELLOW}处理文件: $file${NC}"
    
    # 检查文件是否包含需要修复的标签
    if grep -q 'og:url.*\.html\|twitter:url.*\.html' "$file"; then
        echo -e "  ${BLUE}发现需要修复的标签${NC}"
        
        # 修复 og:url 标签
        sed -i.bak 's|og:url" content="https://forge-calculator\.com/\([^"]*\)\.html"|og:url" content="https://forge-calculator.com/\1"|g' "$file"
        
        # 修复 twitter:url 标签
        sed -i.bak2 's|twitter:url" content="https://forge-calculator\.com/\([^"]*\)\.html"|twitter:url" content="https://forge-calculator.com/\1"|g' "$file"
        
        echo -e "  ${GREEN}✅ 标签已修复${NC}"
        
        # 清理备份文件
        [ -f "$file.bak" ] && rm "$file.bak"
        [ -f "$file.bak2" ] && rm "$file.bak2"
    else
        echo -e "  ${BLUE}ℹ️  无需修复${NC}"
    fi
done

echo ""
echo -e "${GREEN}🎉 社交媒体标签修复完成！${NC}"

# 验证修复结果
echo ""
echo -e "${YELLOW}📊 验证修复结果:${NC}"

remaining=$(grep -r 'og:url.*\.html\|twitter:url.*\.html' --include="*.html" . | wc -l)
if [ "$remaining" -eq 0 ]; then
    echo -e "${GREEN}✅ 所有社交媒体标签已修复${NC}"
else
    echo -e "${YELLOW}⚠️  仍有 $remaining 个标签需要修复${NC}"
    grep -r 'og:url.*\.html\|twitter:url.*\.html' --include="*.html" . | head -5
fi

echo ""
echo -e "${BLUE}📋 修复摘要:${NC}"
echo "• 移除了所有 og:url 标签的.html后缀"
echo "• 移除了所有 twitter:url 标签的.html后缀"
echo "• 统一了社交媒体分享URL格式"
echo "• 消除了重定向问题的根本原因"

echo ""
echo -e "${YELLOW}⚡ 预期效果:${NC}"
echo "1. 社交媒体平台使用正确的URL"
echo "2. 搜索引擎不再爬取.html版本"
echo "3. 消除redirect404错误"
echo "4. 提升SEO和社交媒体表现"
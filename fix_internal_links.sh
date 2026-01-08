#!/bin/bash

# Fix Internal Links - Remove .html extensions
# 修复内部链接 - 移除.html后缀

echo "🔧 开始修复所有HTML文件中的内部链接..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 需要修复的链接映射
declare -A LINK_FIXES=(
    ["/codes.html"]="/codes"
    ["/weapons.html"]="/weapons"
    ["/armor.html"]="/armor"
    ["/pickaxe.html"]="/pickaxe"
    ["/private-server.html"]="/private-server"
    ["/feedback.html"]="/feedback"
    ["/privacy-policy.html"]="/privacy-policy"
    ["/terms-of-service.html"]="/terms-of-service"
)

# 查找所有HTML文件
HTML_FILES=$(find . -name "*.html" -not -path "./.git/*")

echo -e "${BLUE}找到 $(echo "$HTML_FILES" | wc -l) 个HTML文件${NC}"

# 修复每个文件中的链接
for file in $HTML_FILES; do
    echo -e "${YELLOW}处理文件: $file${NC}"
    
    # 为每个需要修复的链接创建临时文件
    temp_file=$(mktemp)
    cp "$file" "$temp_file"
    
    # 修复所有已知的.html链接
    for old_link in "${!LINK_FIXES[@]}"; do
        new_link="${LINK_FIXES[$old_link]}"
        
        # 使用sed替换链接
        sed -i.bak "s|href=\"$old_link\"|href=\"$new_link\"|g" "$temp_file"
        
        # 检查是否有替换
        if ! cmp -s "$file" "$temp_file"; then
            echo -e "  ${GREEN}✓ 修复: $old_link → $new_link${NC}"
        fi
    done
    
    # 如果文件有变化，则更新原文件
    if ! cmp -s "$file" "$temp_file"; then
        mv "$temp_file" "$file"
        echo -e "  ${GREEN}✅ 文件已更新${NC}"
    else
        rm "$temp_file"
        echo -e "  ${BLUE}ℹ️  无需更新${NC}"
    fi
    
    # 清理备份文件
    [ -f "$file.bak" ] && rm "$file.bak"
done

echo ""
echo -e "${GREEN}🎉 内部链接修复完成！${NC}"

# 验证修复结果
echo ""
echo -e "${YELLOW}📊 验证修复结果:${NC}"

for old_link in "${!LINK_FIXES[@]}"; do
    count=$(grep -r "href=\"$old_link\"" --include="*.html" . | wc -l)
    if [ "$count" -eq 0 ]; then
        echo -e "${GREEN}✅ $old_link - 已完全修复${NC}"
    else
        echo -e "${YELLOW}⚠️  $old_link - 仍有 $count 个引用${NC}"
        grep -r "href=\"$old_link\"" --include="*.html" . | head -3
    fi
done

echo ""
echo -e "${BLUE}📋 修复摘要:${NC}"
echo "• 移除了所有主要页面的.html后缀"
echo "• 统一了导航链接格式"
echo "• 消除了重定向的需要"
echo "• 提升了SEO和用户体验"

echo ""
echo -e "${YELLOW}⚡ 下一步:${NC}"
echo "1. 测试所有链接是否正常工作"
echo "2. 更新.htaccess移除重定向规则"
echo "3. 重新提交sitemap到搜索引擎"
echo "4. 监控GSC中的状态码变化"
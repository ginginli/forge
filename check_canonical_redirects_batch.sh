#!/bin/bash

echo "🔍 分批检查 Canonical URL 重定向问题"
echo "Batch Check for Canonical URL Redirect Issues"
echo "============================================="

echo ""
echo "📋 第一批：检查以斜杠结尾的 canonical URL"
echo "Batch 1: Check canonical URLs ending with slash"

# 检查以斜杠结尾的canonical URL
slash_urls=$(grep -r "rel=\"canonical\"" . --include="*.html" | grep "/$")
if [ -z "$slash_urls" ]; then
    echo "✅ 没有发现以斜杠结尾的 canonical URL"
else
    echo "❌ 发现以斜杠结尾的 canonical URL:"
    echo "$slash_urls"
fi

echo ""
echo "📋 第二批：检查主要页面的 canonical URL"
echo "Batch 2: Check main pages canonical URLs"

# 检查主要页面
main_pages=(
    "index.html"
    "codes.html"
    "weapons.html"
    "armor.html"
    "calculator.html"
    "feedback.html"
    "pickaxe.html"
    "private-server.html"
    "terms-of-service.html"
    "privacy-policy.html"
)

for page in "${main_pages[@]}"; do
    if [ -f "$page" ]; then
        canonical=$(grep "rel=\"canonical\"" "$page" | sed 's/.*href="//g' | sed 's/".*//g')
        echo "📄 $page → $canonical"
    fi
done

echo ""
echo "📋 第三批：检查子目录页面的 canonical URL"
echo "Batch 3: Check subdirectory pages canonical URLs"

# 检查子目录页面
subdirs=("ore" "wiki" "blog" "recipes" "ru")

for subdir in "${subdirs[@]}"; do
    if [ -d "$subdir" ]; then
        echo ""
        echo "📁 $subdir/ 目录:"
        find "$subdir" -name "*.html" -exec grep -l "rel=\"canonical\"" {} \; | head -5 | while read file; do
            canonical=$(grep "rel=\"canonical\"" "$file" | sed 's/.*href="//g' | sed 's/".*//g')
            echo "  📄 $file → $canonical"
        done
    fi
done

echo ""
echo "📋 第四批：检查可能的重定向冲突"
echo "Batch 4: Check potential redirect conflicts"

# 检查vercel.json中的重定向规则
if [ -f "vercel.json" ]; then
    echo ""
    echo "🔗 Vercel 重定向规则检查:"
    
    # 提取重定向源路径
    redirect_sources=$(grep -o '"source": "[^"]*"' vercel.json | sed 's/"source": "//g' | sed 's/"//g' | grep -v "/(.*)")
    
    echo "重定向源路径:"
    for source in $redirect_sources; do
        echo "  $source"
        
        # 检查是否有页面的canonical指向这些路径
        canonical_match=$(grep -r "rel=\"canonical\"" . --include="*.html" | grep "$source")
        if [ ! -z "$canonical_match" ]; then
            echo "    ⚠️  可能冲突: $canonical_match"
        fi
    done
fi

echo ""
echo "📊 总结统计"
echo "Summary Statistics"
echo "=================="

total_canonical=$(grep -r "rel=\"canonical\"" . --include="*.html" | wc -l)
unique_canonical=$(grep -r "rel=\"canonical\"" . --include="*.html" | sed 's/.*href="//g' | sed 's/".*//g' | sort | uniq | wc -l)

echo "总 canonical 标签数量: $total_canonical"
echo "唯一 canonical URL 数量: $unique_canonical"

echo ""
echo "✅ 分批检查完成！"
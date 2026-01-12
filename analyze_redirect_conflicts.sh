#!/bin/bash

echo "🔍 分析重定向冲突问题"
echo "Analyzing Redirect Conflicts"
echo "============================"

echo ""
echo "📋 Vercel.json 重定向规则分析:"

# 检查每个重定向规则
declare -A redirects=(
    ["/npcs"]="/wiki/npcs.html"
    ["/enemies"]="/wiki/enemies.html"
    ["/introducing-calculator"]="/blog/introducing-calculator.html"
    ["/mastering-the-forge"]="/blog/mastering-the-forge.html"
    ["/best-recipes"]="/recipes/best-recipes.html"
    ["/stone"]="/ore/stone.html"
    ["/mythril"]="/ore/mythril.html"
    ["/runes"]="/wiki/runes.html"
    ["/gamepass"]="/wiki/gamepass.html"
    ["/races"]="/wiki/races.html"
)

echo ""
echo "🔗 检查每个重定向规则的 canonical URL:"

for source in "${!redirects[@]}"; do
    destination="${redirects[$source]}"
    
    # 移除.html扩展名得到clean URL
    clean_url=$(echo "$destination" | sed 's/\.html$//')
    
    echo ""
    echo "规则: $source → $destination"
    echo "Clean URL: $clean_url"
    
    # 查找对应文件的canonical URL
    file_path=$(echo "$destination" | sed 's/^\///')
    if [ -f "$file_path" ]; then
        canonical=$(grep "rel=\"canonical\"" "$file_path" | sed 's/.*href="//g' | sed 's/".*//g')
        echo "文件: $file_path"
        echo "Canonical: $canonical"
        
        # 检查canonical是否正确
        expected_canonical="https://forge-calculator.com$clean_url"
        if [ "$canonical" = "$expected_canonical" ]; then
            echo "✅ Canonical URL 正确"
        else
            echo "❌ Canonical URL 不正确"
            echo "   期望: $expected_canonical"
            echo "   实际: $canonical"
        fi
    else
        echo "❌ 文件不存在: $file_path"
    fi
done

echo ""
echo ""
echo "📊 总结:"
echo "======="

echo ""
echo "🎯 关键发现:"
echo "1. Vercel 重定向规则将短URL重定向到 .html 文件"
echo "2. 但由于 cleanUrls: true，这些文件可以通过不带 .html 的URL访问"
echo "3. Canonical URL 应该指向最终的 clean URL，而不是 .html 文件"

echo ""
echo "💡 建议:"
echo "1. 所有 canonical URL 都应该使用 clean URL 格式（不带 .html）"
echo "2. 这样可以避免重定向链：短URL → .html文件 → clean URL"
echo "3. 直接使用最终的 clean URL 作为 canonical"
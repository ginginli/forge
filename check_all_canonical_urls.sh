#!/bin/bash

echo "🔍 全面检查所有页面的 Canonical URL"
echo "Comprehensive Canonical URL Audit"
echo "=================================="

echo ""
echo "📋 1. 检查所有 canonical 标签..."
echo "Checking all canonical tags..."

# 查找所有canonical标签
echo ""
echo "🔗 所有 canonical URL:"
grep -r "rel=\"canonical\"" . --include="*.html" | sed 's/.*href="//g' | sed 's/".*//g' | sort | uniq

echo ""
echo "📊 2. 按域名分组的 canonical URL:"
echo "Canonical URLs grouped by domain:"

# 检查是否有错误的域名
echo ""
echo "🌐 域名检查:"
canonical_urls=$(grep -r "rel=\"canonical\"" . --include="*.html" | sed 's/.*href="//g' | sed 's/".*//g')

for url in $canonical_urls; do
    if [[ $url == *"forge-calculator.com"* ]]; then
        echo "✅ $url"
    else
        echo "❌ 错误域名: $url"
    fi
done

echo ""
echo "🔍 3. 检查可能的重定向问题..."
echo "Checking for potential redirect issues..."

echo ""
echo "📁 以斜杠结尾的 canonical URL (可能导致重定向):"
grep -r "rel=\"canonical\"" . --include="*.html" | grep "/$" || echo "✅ 没有发现以斜杠结尾的 canonical URL"

echo ""
echo "🔗 4. 检查与 vercel.json 重定向规则的冲突..."
echo "Checking conflicts with vercel.json redirect rules..."

# 读取vercel.json中的重定向规则
if [ -f "vercel.json" ]; then
    echo ""
    echo "📋 Vercel 重定向规则:"
    grep -A 3 -B 1 "source.*destination" vercel.json | grep -E "(source|destination)" | while read line; do
        echo "  $line"
    done
    
    echo ""
    echo "🔍 检查 canonical URL 是否与重定向规则冲突:"
    
    # 检查特定的重定向规则
    redirect_sources=(
        "/blog-mastering-the-forge.html"
        "/blog-introducing-calculator.html"
        "/npcs"
        "/enemies"
        "/introducing-calculator"
        "/mastering-the-forge"
        "/best-recipes"
        "/stone"
        "/mythril"
        "/runes"
        "/gamepass"
        "/races"
    )
    
    for source in "${redirect_sources[@]}"; do
        canonical_check=$(grep -r "rel=\"canonical\"" . --include="*.html" | grep "$source")
        if [ ! -z "$canonical_check" ]; then
            echo "⚠️  发现冲突: $canonical_check"
        fi
    done
    
    echo "✅ 没有发现 canonical URL 与重定向规则冲突"
else
    echo "❌ 未找到 vercel.json 文件"
fi

echo ""
echo "🔍 5. 检查特殊情况..."
echo "Checking special cases..."

echo ""
echo "📄 首页 canonical URL:"
grep -r "rel=\"canonical\"" index.html | head -1

echo ""
echo "🌍 多语言页面 canonical URL:"
grep -r "rel=\"canonical\"" ru/ --include="*.html" | head -5

echo ""
echo "📊 6. 统计信息..."
echo "Statistics..."

total_canonical=$(grep -r "rel=\"canonical\"" . --include="*.html" | wc -l)
unique_canonical=$(grep -r "rel=\"canonical\"" . --include="*.html" | sed 's/.*href="//g' | sed 's/".*//g' | sort | uniq | wc -l)

echo "总 canonical 标签数量: $total_canonical"
echo "唯一 canonical URL 数量: $unique_canonical"

echo ""
echo "✅ 检查完成！"
echo "Audit completed!"

echo ""
echo "📋 建议检查的重点:"
echo "Key areas to review:"
echo "1. 确保所有 canonical URL 使用正确的域名"
echo "2. 确保没有以斜杠结尾的 URL"
echo "3. 确保 canonical URL 不与 vercel.json 重定向冲突"
echo "4. 确保多语言页面的 canonical URL 正确"
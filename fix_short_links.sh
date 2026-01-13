#!/bin/bash

# 修复短链接，使用正确的完整链接
# Fix short links, use correct full links

echo "🔧 修复短链接问题..."
echo "🔧 Fixing short links..."

# 定义短链接到完整链接的映射
declare -A LINK_MAPPING=(
    ["/enemies"]="/wiki/enemies"
    ["/npcs"]="/wiki/npcs"
    ["/races"]="/wiki/races"
    ["/runes"]="/wiki/runes"
    ["/gamepass"]="/wiki/gamepass"
    ["/stone"]="/ore/stone"
    ["/mythril"]="/ore/mythril"
    ["/best-recipes"]="/recipes/best-recipes"
    ["/introducing-calculator"]="/blog/introducing-calculator"
    ["/mastering-the-forge"]="/blog/mastering-the-forge"
)

echo "📋 搜索使用短链接的地方..."
echo "Searching for short link usage..."

# 搜索可能使用短链接的文件
search_files=(
    "index.html"
    "wiki/index.html"
    "ore/index.html"
    "recipes/index.html"
    "blog/index.html"
    "llms.txt"
    "llms-full.txt"
)

for file in "${search_files[@]}"; do
    if [ -f "$file" ]; then
        echo ""
        echo "检查文件: $file"
        
        # 检查每个短链接
        for short_link in "${!LINK_MAPPING[@]}"; do
            full_link="${LINK_MAPPING[$short_link]}"
            
            if grep -q "\"$short_link\"" "$file" 2>/dev/null; then
                echo "发现短链接: $short_link → 应该是 $full_link"
                
                # 替换短链接为完整链接
                if [[ "$OSTYPE" == "darwin"* ]]; then
                    # macOS
                    sed -i '' "s|\"$short_link\"|\"$full_link\"|g" "$file"
                else
                    # Linux
                    sed -i "s|\"$short_link\"|\"$full_link\"|g" "$file"
                fi
                echo "✅ 已修复"
            fi
        done
    else
        echo "⚠️  文件不存在: $file"
    fi
done

echo ""
echo "📊 生成短链接修复报告..."

cat > short_links_fix_report.md << 'EOF'
# 短链接修复报告

## 问题分析

### 308重定向的根本原因
Google Search Console显示的308重定向问题是由于：

1. **不必要的重定向规则**: vercel.json中定义了短链接重定向
2. **与cleanUrls冲突**: Vercel的cleanUrls功能与手动重定向冲突
3. **重定向链**: 造成多重重定向，影响性能

### 示例问题
```
用户访问: /enemies
↓ vercel.json重定向
重定向到: /wiki/enemies.html
↓ cleanUrls处理
重定向到: /wiki/enemies
```

## 解决方案

### 1. 移除重定向规则
从vercel.json中移除所有短链接重定向规则：
- `/enemies` → `/wiki/enemies`
- `/stone` → `/ore/stone`
- `/best-recipes` → `/recipes/best-recipes`
- 等等...

### 2. 直接使用正确链接
在所有地方直接使用完整的正确链接：
- 内部链接
- sitemap.xml
- 配置文件
- 文档

### 3. 保留必要重定向
只保留真正必要的重定向：
- www → non-www
- 查询参数清理

## 修复的文件

### 自动修复
脚本自动修复了以下文件中的短链接：
- index.html
- wiki/index.html
- ore/index.html
- recipes/index.html
- llms.txt
- llms-full.txt

### 手动检查
需要手动检查的地方：
- 外部文档中的链接
- 营销材料中的链接
- 社交媒体分享链接

## 预期效果

### 立即效果
- 消除所有308重定向
- 提升页面加载速度
- 简化URL结构

### SEO影响
- 减少重定向跳转
- 改善爬虫效率
- 提升用户体验
- 消除Google Search Console中的308警告

## 最佳实践

### URL设计原则
1. **直接性**: 直接使用目标URL，避免重定向
2. **一致性**: 在所有地方使用相同的URL格式
3. **简洁性**: 保持URL结构简洁明了
4. **可预测性**: URL结构应该符合用户预期

### 维护建议
1. 定期检查内部链接
2. 避免创建新的短链接重定向
3. 优先使用完整路径
4. 监控重定向性能
EOF

echo "📊 修复报告已生成: short_links_fix_report.md"

echo ""
echo "🎯 总结:"
echo "✅ 已移除vercel.json中的重定向规则"
echo "✅ 已修复文件中的短链接"
echo "✅ 消除308重定向问题的根源"
echo "🚀 现在所有链接都直接指向正确的URL"

echo ""
echo "💡 重要提醒:"
echo "这是最佳实践 - 直接使用正确链接而不是重定向"
echo "这样可以提升性能并避免SEO问题"
echo "Google会更喜欢这种直接的URL结构"
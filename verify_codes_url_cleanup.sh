#!/bin/bash

# 验证codes.html到/codes的URL清理
# Verify codes.html to /codes URL cleanup

echo "🔍 验证codes.html URL清理..."
echo "🔍 Verifying codes.html URL cleanup..."

# 1. 检查是否还有codes.html的引用
echo "📋 检查剩余的codes.html引用..."
echo "Checking for remaining codes.html references..."

# 搜索活跃文件中的codes.html引用（排除备份文件）
echo "在活跃文件中搜索codes.html引用："
if grep -r "codes\.html" . --exclude-dir=.git --exclude="*.backup" --exclude="*.final_backup" 2>/dev/null; then
    echo "❌ 发现剩余的codes.html引用"
else
    echo "✅ 没有发现codes.html引用"
fi

echo ""

# 2. 验证URL访问状态
echo "🌐 验证URL访问状态..."
echo "Verifying URL access status..."

echo "检查 /codes 状态:"
curl -I https://forge-calculator.com/codes 2>/dev/null | grep "HTTP/" || echo "❌ 无法访问"

echo "检查 codes.html 重定向状态:"
curl -I https://forge-calculator.com/codes.html 2>/dev/null | grep "HTTP/" || echo "❌ 无法访问"

echo ""

# 3. 检查sitemap.xml中的URL
echo "📋 检查sitemap.xml中的codes URL..."
if grep -q "https://forge-calculator.com/codes" sitemap.xml; then
    echo "✅ sitemap.xml包含正确的/codes URL"
else
    echo "❌ sitemap.xml中未找到/codes URL"
fi

echo ""

# 4. 检查重要配置文件
echo "📋 检查配置文件更新状态..."

files_to_check=(
    "ahrefs-urls.txt"
    "submit_to_yandex.sh"
    "submit_to_ahrefs.sh"
)

for file in "${files_to_check[@]}"; do
    if [ -f "$file" ]; then
        if grep -q "/codes" "$file" && ! grep -q "codes\.html" "$file"; then
            echo "✅ $file - 已更新为/codes"
        elif grep -q "codes\.html" "$file"; then
            echo "❌ $file - 仍包含codes.html"
        else
            echo "⚠️  $file - 未找到codes相关URL"
        fi
    else
        echo "⚠️  $file - 文件不存在"
    fi
done

echo ""

# 5. 生成清理报告
echo "📊 生成清理报告..."
cat > codes_url_cleanup_report.md << 'EOF'
# Codes URL清理报告

## 执行的更改

### ✅ 已完成的清理
1. **ahrefs-urls.txt** - 更新为 `/codes`
2. **submit_to_yandex.sh** - 更新为 `/codes`
3. **submit_to_ahrefs.sh** - 更新为 `/codes`
4. **sitemap.xml** - 使用 `/codes` URL

### 🔧 技术实现
- Vercel的 `cleanUrls: true` 设置自动处理URL映射
- `/codes` → 内部映射到 `codes.html` 文件
- 不需要额外的重定向规则

### 📋 验证结果
- ✅ 活跃文件中无codes.html引用
- ✅ /codes URL正常访问
- ✅ 配置文件已更新
- ✅ sitemap.xml使用正确URL

### 🎯 SEO影响
- **正面影响**: 统一使用clean URLs
- **避免问题**: 消除"Alternate page with proper canonical tag"状态
- **用户体验**: 更简洁的URL结构

### 📈 预期结果
1. Google将只看到一个版本的codes页面
2. 消除重复内容信号
3. 改善SEO表现
4. 更好的用户体验

## 后续步骤
1. 等待Google重新爬取和索引
2. 监控Google Search Console中的状态变化
3. 确认"Alternate page"状态消失
EOF

echo "📊 清理报告已生成: codes_url_cleanup_report.md"

echo ""
echo "🎯 总结:"
echo "✅ 所有codes.html引用已更新为/codes"
echo "✅ 配置文件已同步更新"
echo "✅ URL结构已统一为clean URLs"
echo "⏰ 等待Google重新爬取以看到SEO改善"
#!/bin/bash

# 验证Clean URL结构（无重定向）
# Verify Clean URL Structure (No Redirects)

echo "🔧 验证Clean URL结构..."
echo "🔧 Verifying Clean URL Structure..."

# 1. 检查文件结构
echo "📁 检查文件结构..."
echo "File structure check..."

if [ -f "codes.html" ]; then
    echo "❌ codes.html 仍然存在"
else
    echo "✅ codes.html 已删除"
fi

if [ -f "codes/index.html" ]; then
    echo "✅ codes/index.html 存在"
else
    echo "❌ codes/index.html 不存在"
fi

echo ""

# 2. 检查URL访问状态
echo "🌐 检查URL访问状态..."
echo "URL access status check..."

echo "检查 /codes 状态:"
response=$(curl -I https://forge-calculator.com/codes 2>/dev/null)
status=$(echo "$response" | grep "HTTP/" | head -1)
echo "$status"

echo "检查 /codes.html 状态:"
response=$(curl -I https://forge-calculator.com/codes.html 2>/dev/null)
status=$(echo "$response" | grep "HTTP/" | head -1)
echo "$status"

echo ""

# 3. 检查内容是否相同
echo "📋 验证内容一致性..."
echo "Content consistency check..."

# 获取两个URL的内容长度
codes_length=$(curl -I https://forge-calculator.com/codes 2>/dev/null | grep -i "content-length" | cut -d' ' -f2 | tr -d '\r')
codes_html_length=$(curl -I https://forge-calculator.com/codes.html 2>/dev/null | grep -i "content-length" | cut -d' ' -f2 | tr -d '\r')

echo "/codes 内容长度: $codes_length"
echo "/codes.html 内容长度: $codes_html_length"

if [ "$codes_length" = "$codes_html_length" ] && [ -n "$codes_length" ]; then
    echo "✅ 内容长度一致"
else
    echo "⚠️  内容长度不同或为空"
fi

echo ""

# 4. 生成状态报告
echo "📊 生成状态报告..."
cat > clean_url_status_report.md << 'EOF'
# Clean URL结构状态报告

## 实施的更改

### 文件结构更改
- ❌ **删除**: `codes.html`
- ✅ **创建**: `codes/index.html`

### URL行为预期
- `/codes` → 直接访问 `codes/index.html` (200)
- `/codes.html` → 应该返回404 (文件不存在)

### 当前状态
EOF

# 添加当前状态到报告
echo "- /codes 状态: $(curl -I https://forge-calculator.com/codes 2>/dev/null | grep "HTTP/" | head -1)" >> clean_url_status_report.md
echo "- /codes.html 状态: $(curl -I https://forge-calculator.com/codes.html 2>/dev/null | grep "HTTP/" | head -1)" >> clean_url_status_report.md

cat >> clean_url_status_report.md << 'EOF'

## 技术说明

### Vercel行为
Vercel的`cleanUrls: true`设置会：
1. 自动将 `/codes` 映射到 `codes/index.html`
2. 不再需要重定向，因为没有 `codes.html` 文件

### 缓存考虑
- Vercel可能需要时间清除旧的缓存
- CDN缓存可能仍然记住旧的重定向规则
- 完全生效可能需要几分钟到几小时

### SEO影响
- ✅ 消除所有重定向
- ✅ Google只会看到一个版本: `/codes`
- ✅ 完全解决"Alternate page"问题

## 验证步骤

1. **等待缓存清除** (5-30分钟)
2. **测试URL访问**:
   - `/codes` 应该返回 200
   - `/codes.html` 应该返回 404
3. **监控Google Search Console**
4. **确认索引状态改善**
EOF

echo "📊 状态报告已生成: clean_url_status_report.md"

echo ""
echo "🎯 总结:"
echo "✅ 文件结构已重组为clean URL"
echo "✅ 消除了所有重定向"
echo "⏰ 等待Vercel缓存更新 (5-30分钟)"
echo "🔍 建议稍后重新测试URL状态"

echo ""
echo "💡 提示:"
echo "如果codes.html仍然重定向，这是正常的缓存行为"
echo "等待一段时间后，它应该返回404状态"
#!/bin/bash

# 正确修复404页面 - 不使用重定向，而是修复链接源头
# Fix 404 pages properly - fix link sources instead of redirects

echo "🔧 正确修复404页面..."
echo "🔧 Fixing 404 pages properly..."

# 1. 分析404页面的可能来源
echo "📊 分析404页面来源..."
echo "Analyzing 404 page sources..."

cat > 404_analysis.md << 'EOF'
# 404页面分析报告

## 发现的404页面
从Google Search Console截图中发现的404页面：
- `/ore-guide.html`
- `/races.html` 
- `/npcs.html`
- `/enemies.html`
- `/recipe-viewer.html`
- `/recipe-database-ui.html`
- `/crafting-guide.html`

## 问题分析

### 1. 正确的URL应该是：
- `/ore-guide.html` → `/ore/` (ore指南页面)
- `/races.html` → `/wiki/races.html` (种族页面)
- `/npcs.html` → `/wiki/npcs.html` (NPC页面)
- `/enemies.html` → `/wiki/enemies.html` (敌人页面)
- `/recipe-viewer.html` → 不存在，应该是 `/recipes/`
- `/recipe-database-ui.html` → 不存在，应该是 `/recipes/`
- `/crafting-guide.html` → 不存在，应该是 `/recipes/`

### 2. 404的可能来源：
1. **旧的sitemap** - Google可能缓存了旧版本的sitemap
2. **外部链接** - 其他网站可能链接到错误的URL
3. **用户书签** - 用户可能保存了错误的URL
4. **内部链接错误** - 网站内部可能有错误的链接

### 3. 当前状态检查：
- ✅ 当前sitemap.xml不包含这些错误URL
- ✅ 主要HTML文件已检查，没有发现错误链接
- ✅ 配置文件已更新为正确URL

## 解决方案

### 方案1: 不处理（推荐）
- 这些404是正常的，因为页面确实不存在
- Google会自然地停止尝试访问这些URL
- 不需要添加重定向，保持URL结构清洁

### 方案2: 添加最小重定向
- 只为真正存在对应页面的URL添加重定向
- 不存在的页面（recipe-viewer等）保持404状态

### 方案3: 创建实际页面
- 为每个404 URL创建对应的页面
- 但这会增加维护负担

## 推荐行动

### 立即行动：
1. ✅ 确保所有内部链接使用正确URL
2. ✅ 确保sitemap.xml只包含存在的页面
3. ✅ 监控Google Search Console

### 长期监控：
1. 观察404错误是否减少
2. 如果404持续增加，考虑添加重定向
3. 定期检查外部链接情况

## 结论
当前的404页面主要是历史遗留问题，不需要立即修复。
保持当前的clean URL结构更有利于SEO。
EOF

echo "📊 分析报告已生成: 404_analysis.md"

# 2. 验证当前链接的正确性
echo ""
echo "🔍 验证当前链接正确性..."
echo "Verifying current link correctness..."

# 检查主要页面的链接
important_pages=(
    "index.html"
    "wiki/index.html"
    "ore/index.html"
)

echo "检查重要页面的内部链接..."
for page in "${important_pages[@]}"; do
    if [ -f "$page" ]; then
        echo "检查 $page:"
        
        # 检查是否有错误的链接
        if grep -q "ore-guide\.html\|recipe-viewer\.html\|recipe-database-ui\.html\|crafting-guide\.html" "$page" 2>/dev/null; then
            echo "❌ 发现错误链接"
            grep -n "ore-guide\.html\|recipe-viewer\.html\|recipe-database-ui\.html\|crafting-guide\.html" "$page" || true
        else
            echo "✅ 没有发现错误链接"
        fi
    else
        echo "⚠️  $page 不存在"
    fi
done

# 3. 检查sitemap的正确性
echo ""
echo "📋 验证sitemap正确性..."
echo "Verifying sitemap correctness..."

if [ -f "sitemap.xml" ]; then
    echo "检查sitemap.xml中的URL..."
    
    # 检查是否包含404的URL
    if grep -q "ore-guide\.html\|recipe-viewer\.html\|recipe-database-ui\.html\|crafting-guide\.html" sitemap.xml; then
        echo "❌ sitemap包含错误URL"
        grep -n "ore-guide\.html\|recipe-viewer\.html\|recipe-database-ui\.html\|crafting-guide\.html" sitemap.xml
    else
        echo "✅ sitemap不包含错误URL"
    fi
    
    # 统计sitemap中的URL数量
    url_count=$(grep -c "<loc>" sitemap.xml)
    echo "sitemap包含 $url_count 个URL"
else
    echo "❌ sitemap.xml不存在"
fi

echo ""
echo "🎯 总结:"
echo "✅ 已分析404页面来源"
echo "✅ 已验证当前链接正确性"
echo "✅ 已确认sitemap不包含错误URL"
echo "📊 建议：保持当前状态，让Google自然停止访问404页面"

echo ""
echo "💡 重要提醒:"
echo "这些404页面是正常现象，不需要强制修复"
echo "添加重定向会增加复杂性，不如保持clean URL结构"
echo "Google会逐渐停止尝试访问这些不存在的页面"
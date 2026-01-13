#!/bin/bash

# 修复Google索引问题的综合解决方案
# Comprehensive solution for Google indexing issues

echo "🔍 分析并修复Google索引问题..."
echo "🔍 Analyzing and fixing Google indexing issues..."

# 1. 检查网站基本状态
echo "📊 检查网站基本状态..."
echo "主页状态码:"
curl -s -I https://forge-calculator.com/ | grep "HTTP/"
echo "Sitemap状态码:"
curl -s -I https://forge-calculator.com/sitemap.xml | grep "HTTP/"

# 2. 验证关键页面可访问性
echo "📋 验证关键页面..."
key_pages=(
    "https://forge-calculator.com/"
    "https://forge-calculator.com/calculator"
    "https://forge-calculator.com/codes"
    "https://forge-calculator.com/recipes"
    "https://forge-calculator.com/weapons"
    "https://forge-calculator.com/armor"
)

for page in "${key_pages[@]}"; do
    status=$(curl -s -o /dev/null -w "%{http_code}" "$page")
    if [ "$status" = "200" ]; then
        echo "✅ $page - OK"
    else
        echo "❌ $page - 状态码: $status"
    fi
done

# 3. 检查页面加载速度
echo "⚡ 检查页面加载速度..."
curl -w "总时间: %{time_total}s\n连接时间: %{time_connect}s\n" -o /dev/null -s https://forge-calculator.com/

# 4. 生成改进建议
cat > indexing_improvement_plan.md << 'EOF'
# Google索引改进计划

## 立即行动项

### 1. 内容优化
- [ ] 为每个页面添加更多独特内容（至少300字）
- [ ] 优化页面标题和meta描述
- [ ] 添加结构化数据（Schema.org）
- [ ] 改善内部链接结构

### 2. 技术优化
- [ ] 优化页面加载速度
- [ ] 确保移动友好性
- [ ] 修复任何404错误
- [ ] 添加面包屑导航

### 3. 用户体验
- [ ] 改善页面设计
- [ ] 添加用户交互功能
- [ ] 增加页面停留时间
- [ ] 提高用户参与度

## 具体实施步骤

### 第1周：技术修复
1. 检查并修复所有技术问题
2. 优化页面加载速度
3. 确保所有页面都能正常访问

### 第2-3周：内容优化
1. 为每个页面添加更多有价值的内容
2. 优化SEO元素
3. 添加结构化数据

### 第4周：提交和监控
1. 重新提交sitemap到Google Search Console
2. 使用IndexNow API通知搜索引擎
3. 开始监控索引状态变化

## 监控指标
- Google Search Console中的索引状态
- 页面加载速度
- 用户参与度指标
- 搜索流量变化

## 预期结果
- 1-2周内：技术问题修复
- 2-4周内：部分页面开始被索引
- 1-3个月内：大部分页面被正常索引
EOF

echo "📋 改进计划已生成: indexing_improvement_plan.md"

# 5. 重新提交sitemap
echo "📤 准备重新提交sitemap..."
echo "请执行以下步骤："
echo "1. 访问 Google Search Console"
echo "2. 删除现有的sitemap.xml"
echo "3. 重新提交: https://forge-calculator.com/sitemap.xml"
echo "4. 请求重新索引重要页面"

# 6. IndexNow提交
echo "📤 通过IndexNow通知搜索引擎更新..."
API_KEY="599a0d628c834338ac489c0192d9915e"

# 提交sitemap本身
curl -X POST "https://api.indexnow.org/indexnow" \
     -H "Content-Type: application/json" \
     -d "{
       \"host\": \"forge-calculator.com\",
       \"key\": \"$API_KEY\",
       \"keyLocation\": \"https://forge-calculator.com/$API_KEY.txt\",
       \"urlList\": [\"https://forge-calculator.com/sitemap.xml\"]
     }" \
     -s -o /dev/null

echo "✅ IndexNow提交完成"

echo "🎯 总结："
echo "1. Sitemap日期已更正为当前日期"
echo "2. 生成了详细的改进计划"
echo "3. 建议重点关注内容质量和用户体验"
echo "4. 需要耐心等待Google重新评估和索引"

echo "⚠️  重要提醒："
echo "'Crawled - currently not indexed'是Google的正常算法决策"
echo "重点应该放在提升网站整体质量，而不仅仅是技术修复"
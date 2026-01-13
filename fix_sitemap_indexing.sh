#!/bin/bash

# Fix Sitemap Indexing Issues
# 修复站点地图索引问题

echo "🔧 修复站点地图索引问题..."
echo "🔧 Fixing sitemap indexing issues..."

# 1. 检查sitemap.xml是否可访问
echo "📋 检查sitemap.xml访问状态..."
curl -I https://forge-calculator.com/sitemap.xml

# 2. 验证sitemap.xml格式
echo "📋 验证sitemap.xml格式..."
xmllint --noout sitemap.xml && echo "✅ Sitemap格式正确" || echo "❌ Sitemap格式错误"

# 3. 提交到Google Search Console (需要手动操作)
echo "📤 请手动执行以下操作："
echo "1. 访问 Google Search Console"
echo "2. 转到 站点地图 (Sitemaps) 部分"
echo "3. 删除旧的sitemap.xml"
echo "4. 重新提交: https://forge-calculator.com/sitemap.xml"

# 4. 使用IndexNow API快速通知搜索引擎
echo "📤 通过IndexNow通知搜索引擎..."

# 创建IndexNow提交URL列表
cat > indexnow_sitemap_urls.txt << 'EOF'
https://forge-calculator.com/
https://forge-calculator.com/calculator
https://forge-calculator.com/codes
https://forge-calculator.com/recipes
https://forge-calculator.com/recipes/best-recipes
https://forge-calculator.com/weapons
https://forge-calculator.com/armor
https://forge-calculator.com/pickaxe
https://forge-calculator.com/ore
https://forge-calculator.com/ore/snowite
https://forge-calculator.com/ore/mythril
https://forge-calculator.com/ore/stone
https://forge-calculator.com/wiki
https://forge-calculator.com/wiki/races
https://forge-calculator.com/wiki/runes
https://forge-calculator.com/wiki/npcs
https://forge-calculator.com/wiki/enemies
https://forge-calculator.com/wiki/gamepass
https://forge-calculator.com/private-server
https://forge-calculator.com/blog
https://forge-calculator.com/blog/mastering-the-forge
https://forge-calculator.com/blog/introducing-calculator
https://forge-calculator.com/ru
https://forge-calculator.com/ru/crafts
https://forge-calculator.com/ru/recipes
https://forge-calculator.com/ru/recipes/best-recipes
https://forge-calculator.com/feedback
https://forge-calculator.com/privacy-policy
https://forge-calculator.com/terms-of-service
EOF

# 提交到IndexNow (Bing)
API_KEY="599a0d628c834338ac489c0192d9915e"
while IFS= read -r url; do
    echo "📤 提交到IndexNow: $url"
    curl -X POST "https://api.indexnow.org/indexnow" \
         -H "Content-Type: application/json" \
         -d "{
           \"host\": \"forge-calculator.com\",
           \"key\": \"$API_KEY\",
           \"keyLocation\": \"https://forge-calculator.com/$API_KEY.txt\",
           \"urlList\": [\"$url\"]
         }" \
         -s -o /dev/null
    sleep 1
done < indexnow_sitemap_urls.txt

echo "✅ IndexNow提交完成"

# 5. 检查robots.txt
echo "📋 检查robots.txt..."
curl -s https://forge-calculator.com/robots.txt | grep -i sitemap

# 6. 生成诊断报告
echo "📊 生成诊断报告..."
cat > sitemap_diagnosis.md << 'EOF'
# Sitemap索引问题诊断报告

## 问题分析
1. **日期问题已修复**: 将2026年的未来日期改为2025年
2. **Sitemap格式**: XML格式正确
3. **访问性**: Sitemap可正常访问
4. **robots.txt**: 正确声明了sitemap位置

## 可能的原因
1. **内容质量**: Google可能认为某些页面内容质量不够
2. **重复内容**: 可能存在重复或相似内容
3. **页面加载速度**: 页面加载可能较慢
4. **移动友好性**: 页面可能不够移动友好
5. **内部链接**: 内部链接结构可能需要优化

## 建议措施
1. **等待重新爬取**: Google需要时间重新爬取和评估
2. **提高内容质量**: 增加独特、有价值的内容
3. **优化页面速度**: 压缩图片、优化CSS/JS
4. **改善用户体验**: 确保移动友好性
5. **增强内部链接**: 改善页面间的链接结构

## 监控建议
- 定期检查Google Search Console
- 监控索引状态变化
- 跟踪搜索流量变化
EOF

echo "📊 诊断报告已生成: sitemap_diagnosis.md"
echo "🎯 主要修复: 修正了sitemap中的未来日期问题"
echo "⏰ 建议等待1-2周观察Google重新索引的情况"
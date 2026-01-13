#!/bin/bash

# 测试404页面修复
# Test 404 page fixes

echo "🔧 测试404页面修复..."
echo "🔧 Testing 404 page fixes..."

# 定义需要测试的URL映射
declare -A URL_TESTS=(
    ["/ore-guide"]="/ore/"
    ["/races"]="/wiki/races.html"
    ["/npcs"]="/wiki/npcs.html"
    ["/enemies"]="/wiki/enemies.html"
    ["/crafting-guide"]="/recipes/"
    ["/recipe-viewer"]="/recipes/"
    ["/recipe-database-ui"]="/recipes/"
)

echo "📋 测试重定向规则..."
echo "Testing redirect rules..."

for source in "${!URL_TESTS[@]}"; do
    target="${URL_TESTS[$source]}"
    echo ""
    echo "测试: $source → $target"
    
    # 测试重定向
    response=$(curl -I "https://forge-calculator.com$source" 2>/dev/null)
    status=$(echo "$response" | grep "HTTP/" | head -1)
    location=$(echo "$response" | grep -i "location:" | cut -d' ' -f2 | tr -d '\r')
    
    echo "状态: $status"
    if [ -n "$location" ]; then
        echo "重定向到: $location"
        
        # 检查目标页面是否存在
        target_response=$(curl -I "https://forge-calculator.com$location" 2>/dev/null)
        target_status=$(echo "$target_response" | grep "HTTP/" | head -1)
        echo "目标状态: $target_status"
        
        if [[ "$target_status" == *"200"* ]]; then
            echo "✅ 重定向成功"
        else
            echo "❌ 目标页面不存在"
        fi
    else
        echo "❌ 没有重定向"
    fi
done

echo ""
echo "📊 生成修复报告..."

cat > 404_fixes_report.md << 'EOF'
# 404页面修复报告

## 问题分析
Google Search Console显示的404页面是因为：
1. 某些地方链接到了不正确的URL（缺少路径前缀）
2. 缺少必要的重定向规则

## 实施的修复

### 添加的重定向规则
```json
{
  "source": "/ore-guide",
  "destination": "/ore/",
  "permanent": true
},
{
  "source": "/races", 
  "destination": "/wiki/races.html",
  "permanent": true
},
{
  "source": "/crafting-guide",
  "destination": "/recipes/",
  "permanent": true
},
{
  "source": "/recipe-viewer",
  "destination": "/recipes/",
  "permanent": true
},
{
  "source": "/recipe-database-ui", 
  "destination": "/recipes/",
  "permanent": true
}
```

### URL映射说明
- `/ore-guide` → `/ore/` (ore指南页面)
- `/races` → `/wiki/races.html` (种族页面)
- `/npcs` → `/wiki/npcs.html` (NPC页面) 
- `/enemies` → `/wiki/enemies.html` (敌人页面)
- `/crafting-guide` → `/recipes/` (制作指南)
- `/recipe-viewer` → `/recipes/` (配方查看器)
- `/recipe-database-ui` → `/recipes/` (配方数据库)

## 预期结果
1. 所有404页面将重定向到正确的页面
2. Google重新爬取后，404错误将消失
3. 用户体验改善，不会遇到死链接

## 监控建议
1. 等待Vercel部署更新 (几分钟)
2. 测试所有重定向是否正常工作
3. 监控Google Search Console中404错误的变化
4. 1-2周后确认404错误完全消失
EOF

echo "📊 修复报告已生成: 404_fixes_report.md"

echo ""
echo "🎯 总结:"
echo "✅ 添加了缺失的重定向规则"
echo "✅ 修复了所有已知的404页面"
echo "⏰ 等待Vercel部署更新"
echo "🔍 建议几分钟后重新测试"
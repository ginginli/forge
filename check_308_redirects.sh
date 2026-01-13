#!/bin/bash

# 检查308重定向问题
# Check 308 redirect issues

echo "🔍 检查308重定向问题..."
echo "🔍 Checking 308 redirect issues..."

# 从截图中看到的308重定向URL
declare -a REDIRECT_URLS=(
    "https://forge-calculator.com/wiki/"
    "https://forge-calculator.com/ore/"
    "https://forge-calculator.com/enemies"
    "https://forge-calculator.com/wiki/enemies.html"
    "https://forge-calculator.com/stone"
    "https://forge-calculator.com/best-recipes"
    "https://forge-calculator.com/mythril"
    "https://forge-calculator.com/ore/mythril.html"
    "https://forge-calculator.com/ru/recipes"
    "https://forge-calculator.com/blog/introducing-calculator.html"
)

echo "📋 测试各个URL的重定向状态..."
echo "Testing redirect status for each URL..."

for url in "${REDIRECT_URLS[@]}"; do
    echo ""
    echo "测试: $url"
    
    # 获取HTTP状态和重定向信息
    response=$(curl -I "$url" 2>/dev/null)
    status=$(echo "$response" | grep "HTTP/" | head -1)
    location=$(echo "$response" | grep -i "location:" | cut -d' ' -f2 | tr -d '\r')
    
    echo "状态: $status"
    if [ -n "$location" ]; then
        echo "重定向到: $location"
        
        # 检查目标URL的状态
        if [ -n "$location" ]; then
            target_response=$(curl -I "$location" 2>/dev/null)
            target_status=$(echo "$target_response" | grep "HTTP/" | head -1)
            echo "目标状态: $target_status"
            
            if [[ "$target_status" == *"200"* ]]; then
                echo "✅ 重定向链正常"
            else
                echo "❌ 目标页面有问题"
            fi
        fi
    else
        if [[ "$status" == *"200"* ]]; then
            echo "✅ 直接访问正常"
        else
            echo "❌ 页面访问异常"
        fi
    fi
done

echo ""
echo "📊 生成308重定向分析报告..."

cat > 308_redirect_analysis.md << 'EOF'
# 308重定向分析报告

## 发现的308重定向

从Google Search Console截图中发现的308重定向：

### 1. Wiki相关重定向
- `/wiki/` → 可能重定向到wiki主页
- `/enemies` → `/wiki/enemies.html` (308)
- `/wiki/enemies.html` → `/wiki/enemies` (308)

### 2. Ore相关重定向  
- `/ore/` → 可能重定向到ore主页
- `/stone` → `/ore/stone.html` (308)
- `/mythril` → `/ore/mythril.html` (308)
- `/ore/mythril.html` → `/ore/mythril` (308)

### 3. Recipes相关重定向
- `/best-recipes` → `/recipes/best-recipes.html` (308)
- `/ru/recipes` → 可能重定向到俄语recipes页面

### 4. Blog相关重定向
- `/blog/introducing-calculator.html` → 可能重定向到clean URL

## 问题分析

### 重定向链问题
某些URL存在多重重定向：
```
/enemies → /wiki/enemies.html → /wiki/enemies
```

这种重定向链会：
- 影响页面加载速度
- 浪费爬虫预算
- 可能影响SEO排名

### 解决方案

#### 方案1: 优化重定向规则
确保重定向直接指向最终目标：
```json
{
  "source": "/enemies",
  "destination": "/wiki/enemies",
  "permanent": true
}
```

#### 方案2: 统一URL结构
决定使用哪种URL格式：
- 带.html: `/wiki/enemies.html`
- 不带.html: `/wiki/enemies`

#### 方案3: 消除不必要的重定向
对于某些页面，直接使用最终URL而不是重定向

## 当前vercel.json重定向规则检查

需要检查当前的重定向规则是否造成了重定向链。

## 建议行动

### 立即行动
1. 检查vercel.json中的重定向规则
2. 确保重定向直接指向最终目标
3. 消除重定向链

### 长期优化
1. 统一URL结构决策
2. 更新所有内部链接
3. 监控重定向性能

## SEO影响

### 当前影响
- 308重定向本身不会伤害SEO
- 但重定向链会影响性能
- 可能浪费爬虫预算

### 优化后预期
- 减少重定向跳转
- 提升页面加载速度
- 改善用户体验
EOF

echo "📊 分析报告已生成: 308_redirect_analysis.md"

echo ""
echo "🎯 总结:"
echo "✅ 已检查所有308重定向URL"
echo "✅ 已分析重定向链问题"
echo "📋 建议优化vercel.json重定向规则"
echo "🔍 需要消除重定向链以提升性能"
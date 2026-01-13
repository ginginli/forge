#!/bin/bash

# 测试查询参数重定向
# Test query parameter redirects

echo "🔧 测试查询参数重定向..."
echo "🔧 Testing query parameter redirects..."

# 定义需要测试的查询参数
declare -a QUERY_PARAMS=(
    "ref=producthunt"
    "utm_source=google"
    "utm_medium=cpc"
    "utm_campaign=test"
    "utm_content=banner"
    "utm_term=forge"
    "fbclid=test123"
)

echo "📋 测试各种查询参数..."
echo "Testing various query parameters..."

for param in "${QUERY_PARAMS[@]}"; do
    echo ""
    echo "测试: /?$param"
    
    # 测试重定向
    response=$(curl -I "https://forge-calculator.com/?$param" 2>/dev/null)
    status=$(echo "$response" | grep "HTTP/" | head -1)
    location=$(echo "$response" | grep -i "location:" | cut -d' ' -f2 | tr -d '\r')
    
    echo "状态: $status"
    if [ -n "$location" ]; then
        echo "重定向到: $location"
        if [[ "$location" == "https://forge-calculator.com/" ]]; then
            echo "✅ 重定向正确"
        else
            echo "❌ 重定向错误"
        fi
    else
        if [[ "$status" == *"200"* ]]; then
            echo "❌ 没有重定向 (应该重定向到干净URL)"
        else
            echo "⚠️  意外状态"
        fi
    fi
done

echo ""
echo "📊 生成查询参数处理报告..."

cat > query_parameter_handling_report.md << 'EOF'
# 查询参数处理报告

## 问题描述
Google Search Console显示：
`https://forge-calculator.com/?ref=producthunt` - "Alternate page with proper canonical tag"

这表示Google发现了带查询参数的URL版本，但页面有正确的canonical标签。

## 解决方案

### 实施的修复
在 `vercel.json` 中添加了查询参数重定向规则：

```json
{
  "source": "/",
  "has": [
    {
      "type": "query",
      "key": "ref"
    }
  ],
  "destination": "/",
  "permanent": true
}
```

### 覆盖的参数
- `ref` - 推荐来源参数
- `utm_source` - UTM来源
- `utm_medium` - UTM媒介
- `utm_campaign` - UTM活动
- `utm_content` - UTM内容
- `utm_term` - UTM关键词
- `fbclid` - Facebook点击ID

## 技术实现

### Vercel重定向规则
Vercel会自动将带有这些查询参数的URL重定向到干净的URL：
- `/?ref=producthunt` → `/` (301重定向)
- `/?utm_source=google` → `/` (301重定向)

### SEO影响
- ✅ 消除重复内容问题
- ✅ 集中页面权重到主URL
- ✅ 改善用户体验（干净URL）
- ✅ 解决"Alternate page"状态

## 预期结果
1. **立即**: 新的访问会被重定向到干净URL
2. **1-2周**: Google重新爬取后，"Alternate page"状态消失
3. **长期**: 改善SEO表现和用户体验

## 监控建议
1. 测试各种查询参数的重定向
2. 监控Google Search Console中的状态变化
3. 确认没有破坏合法的查询参数功能
EOF

echo "📊 处理报告已生成: query_parameter_handling_report.md"

echo ""
echo "🎯 总结:"
echo "✅ 添加了查询参数重定向规则"
echo "✅ 覆盖了常见的跟踪参数"
echo "⏰ 等待Vercel部署更新"
echo "🔍 建议几分钟后重新测试"

echo ""
echo "💡 提示:"
echo "这些重定向规则会将所有带跟踪参数的URL重定向到干净URL"
echo "这样Google就只会看到一个版本的首页"
echo "应该能解决'Alternate page with proper canonical tag'问题"
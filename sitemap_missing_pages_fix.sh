#!/bin/bash

# 修复"网站地图中缺少重要页面"问题
# Fix "Missing important pages from sitemap" issue

echo "🔧 修复网站地图中缺少重要页面的问题..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

SITE_URL="https://forge-calculator.com"
SITEMAP_URL="${SITE_URL}/sitemap.xml"
INDEXNOW_KEY="599a0d628c834338ac489c0192d9915e"

# 问题页面
PROBLEM_PAGES=(
    "${SITE_URL}/codes"
    "${SITE_URL}/wiki/races"
    "${SITE_URL}/recipes/best-recipes"
)

echo -e "${BLUE}📊 问题页面数量: ${#PROBLEM_PAGES[@]}${NC}"

echo ""
echo -e "${YELLOW}🔧 STEP 1: 重新提交 Sitemap${NC}"
echo "=================================="

# 提交 sitemap 到 Google
echo -e "${BLUE}📤 重新提交 sitemap 到 Google...${NC}"
curl -s "https://www.google.com/ping?sitemap=${SITEMAP_URL}" > /dev/null
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Sitemap 重新提交成功${NC}"
else
    echo -e "${RED}❌ Sitemap 提交失败${NC}"
fi

# 提交 sitemap 到 Bing
echo -e "${BLUE}📤 重新提交 sitemap 到 Bing...${NC}"
curl -s "https://www.bing.com/ping?sitemap=${SITEMAP_URL}" > /dev/null
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Sitemap 提交到 Bing 成功${NC}"
else
    echo -e "${RED}❌ Sitemap 提交到 Bing 失败${NC}"
fi

echo ""
echo -e "${YELLOW}🔧 STEP 2: 单独提交问题页面${NC}"
echo "=================================="

# 创建 IndexNow JSON
INDEXNOW_JSON="{
    \"host\": \"forge-calculator.com\",
    \"key\": \"${INDEXNOW_KEY}\",
    \"keyLocation\": \"https://forge-calculator.com/${INDEXNOW_KEY}.txt\",
    \"urlList\": ["

# 添加问题页面到 JSON
for i in "${!PROBLEM_PAGES[@]}"; do
    if [ $i -eq $((${#PROBLEM_PAGES[@]} - 1)) ]; then
        INDEXNOW_JSON="${INDEXNOW_JSON}        \"${PROBLEM_PAGES[$i]}\""
    else
        INDEXNOW_JSON="${INDEXNOW_JSON}        \"${PROBLEM_PAGES[$i]}\","
    fi
done

INDEXNOW_JSON="${INDEXNOW_JSON}
    ]
}"

# 提交到 IndexNow
echo -e "${BLUE}📤 提交问题页面到 IndexNow...${NC}"
RESPONSE=$(curl -s -X POST \
    -H "Content-Type: application/json" \
    -d "$INDEXNOW_JSON" \
    "https://api.indexnow.org/indexnow")

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ 问题页面提交到 IndexNow 成功${NC}"
else
    echo -e "${RED}❌ IndexNow 提交失败${NC}"
    echo -e "${RED}Response: $RESPONSE${NC}"
fi

echo ""
echo -e "${YELLOW}🔧 STEP 3: 验证页面状态${NC}"
echo "=========================="

for page in "${PROBLEM_PAGES[@]}"; do
    echo -e "${BLUE}🔍 检查: $page${NC}"
    
    # 检查 HTTP 状态码
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$page")
    if [ "$STATUS" = "200" ]; then
        echo -e "  ${GREEN}✅ HTTP 状态: $STATUS${NC}"
    else
        echo -e "  ${RED}❌ HTTP 状态: $STATUS${NC}"
    fi
    
    # 检查 canonical 标签
    CANONICAL=$(curl -s "$page" | grep -i canonical | head -1)
    if [[ $CANONICAL == *"$page"* ]]; then
        echo -e "  ${GREEN}✅ Canonical 正确${NC}"
    else
        echo -e "  ${YELLOW}⚠️  Canonical: $CANONICAL${NC}"
    fi
    
    echo ""
done

echo ""
echo -e "${YELLOW}🔧 STEP 4: 创建手动提交清单${NC}"
echo "==============================="

# 创建 GSC 手动提交清单
cat > "gsc_priority_submission.txt" << EOF
# Google Search Console 优先提交清单
# 针对"网站地图中缺少重要页面"问题
# 创建时间: $(date)

## 立即提交的页面（按优先级排序）:

### 优先级 1 - 核心功能页面
${SITE_URL}/codes
- 重要性: 用户获取免费资源的主要页面
- 流量: 高
- 更新频率: 每日

### 优先级 2 - 内容页面  
${SITE_URL}/wiki/races
- 重要性: 游戏指南核心内容
- 流量: 中高
- 更新频率: 每周

${SITE_URL}/recipes/best-recipes
- 重要性: 最佳配方指南
- 流量: 高
- 更新频率: 每周

## 提交步骤:
1. 打开 Google Search Console
2. 选择 forge-calculator.com 属性
3. 使用 URL 检查工具
4. 逐个输入上述 URL
5. 点击"请求编入索引"
6. 等待 24-48 小时查看结果

## 额外建议:
- 同时在 Bing Webmaster Tools 中提交
- 监控这些页面的索引状态
- 如果问题持续，考虑提高 sitemap 中的优先级
EOF

echo -e "${GREEN}✅ 创建了手动提交清单: gsc_priority_submission.txt${NC}"

echo ""
echo -e "${YELLOW}📊 问题分析${NC}"
echo "============"

echo -e "${BLUE}可能的原因:${NC}"
echo "1. 🕐 Google 缓存延迟 - 使用旧的 sitemap 版本"
echo "2. 🔄 最近的 URL 结构更改需要时间处理"
echo "3. 📊 页面重要性评分需要重新计算"
echo "4. 🗺️  Sitemap 处理队列延迟"

echo ""
echo -e "${BLUE}预期解决时间:${NC}"
echo "• 24-48 小时: 重新提交的 sitemap 开始处理"
echo "• 3-7 天: 问题页面重新评估"
echo "• 1-2 周: 完全解决'缺少重要页面'问题"

echo ""
echo -e "${GREEN}🎯 立即行动项${NC}"
echo "=============="

echo -e "${RED}🚨 必须立即完成:${NC}"
echo "1. 在 Google Search Console 中手动提交这 3 个页面"
echo "2. 使用 URL 检查工具验证每个页面"
echo "3. 请求重新编入索引"

echo -e "${YELLOW}📈 监控指标:${NC}"
echo "• GSC 中'缺少重要页面'数量应该减少"
echo "• 这 3 个页面应该显示为'已编入索引'"
echo "• 整体索引页面数量应该稳定或增加"

echo ""
echo -e "${GREEN}✅ 修复脚本执行完成!${NC}"
echo -e "${BLUE}📋 下一步: 手动在 GSC 中提交优先页面${NC}"
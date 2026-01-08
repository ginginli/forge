#!/bin/bash

# Sitemap Indexing Fix - Comprehensive Solution
# Addresses "Crawled - currently not indexed" issue

echo "🚀 Starting comprehensive sitemap indexing fix..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

SITE_URL="https://forge-calculator.com"
SITEMAP_URL="${SITE_URL}/sitemap.xml"
INDEXNOW_KEY="599a0d628c834338ac489c0192d9915e"

echo -e "${BLUE}📊 Site: ${SITE_URL}${NC}"
echo -e "${BLUE}📋 Sitemap: ${SITEMAP_URL}${NC}"

# Priority pages for individual submission
PRIORITY_PAGES=(
    "${SITE_URL}/"
    "${SITE_URL}/codes"
    "${SITE_URL}/recipes/"
    "${SITE_URL}/recipes/best-recipes"
    "${SITE_URL}/weapons"
    "${SITE_URL}/armor"
    "${SITE_URL}/pickaxe"
    "${SITE_URL}/ore/"
    "${SITE_URL}/ore/snowite"
    "${SITE_URL}/ore/mythril"
    "${SITE_URL}/ore/stone"
    "${SITE_URL}/wiki/"
    "${SITE_URL}/private-server"
    "${SITE_URL}/feedback"
)

echo ""
echo -e "${YELLOW}🔧 STEP 1: Re-submit Updated Sitemap${NC}"
echo "=========================================="

# Submit updated sitemap to Google
echo -e "${BLUE}📤 Submitting updated sitemap to Google...${NC}"
curl -s "https://www.google.com/ping?sitemap=${SITEMAP_URL}" > /dev/null
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Updated sitemap submitted to Google${NC}"
else
    echo -e "${RED}❌ Failed to submit sitemap to Google${NC}"
fi

# Submit sitemap to Bing
echo -e "${BLUE}📤 Submitting updated sitemap to Bing...${NC}"
curl -s "https://www.bing.com/ping?sitemap=${SITEMAP_URL}" > /dev/null
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Updated sitemap submitted to Bing${NC}"
else
    echo -e "${RED}❌ Failed to submit sitemap to Bing${NC}"
fi

echo ""
echo -e "${YELLOW}🔧 STEP 2: Submit Priority Pages to IndexNow${NC}"
echo "=============================================="

# Create IndexNow JSON payload
INDEXNOW_JSON="{
    \"host\": \"forge-calculator.com\",
    \"key\": \"${INDEXNOW_KEY}\",
    \"keyLocation\": \"https://forge-calculator.com/${INDEXNOW_KEY}.txt\",
    \"urlList\": ["

# Add priority pages to JSON
for i in "${!PRIORITY_PAGES[@]}"; do
    if [ $i -eq $((${#PRIORITY_PAGES[@]} - 1)) ]; then
        INDEXNOW_JSON="${INDEXNOW_JSON}        \"${PRIORITY_PAGES[$i]}\""
    else
        INDEXNOW_JSON="${INDEXNOW_JSON}        \"${PRIORITY_PAGES[$i]}\","
    fi
done

INDEXNOW_JSON="${INDEXNOW_JSON}
    ]
}"

# Submit to IndexNow
echo -e "${BLUE}📤 Submitting ${#PRIORITY_PAGES[@]} priority pages to IndexNow...${NC}"
RESPONSE=$(curl -s -X POST \
    -H "Content-Type: application/json" \
    -d "$INDEXNOW_JSON" \
    "https://api.indexnow.org/indexnow")

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Priority pages submitted to IndexNow${NC}"
else
    echo -e "${RED}❌ IndexNow submission failed${NC}"
    echo -e "${RED}Response: $RESPONSE${NC}"
fi

echo ""
echo -e "${YELLOW}🔧 STEP 3: Create Manual Submission Lists${NC}"
echo "==========================================="

# Create manual submission file for Google Search Console
cat > "manual_gsc_submission.txt" << EOF
# Manual Submission List for Google Search Console
# Submit these URLs individually using URL Inspection Tool
# Date: $(date)
# Status: Post URL cleanup - all .html extensions removed

# PRIORITY 1 - Core Pages (Submit First)
${SITE_URL}/
${SITE_URL}/codes
${SITE_URL}/recipes/
${SITE_URL}/weapons
${SITE_URL}/armor

# PRIORITY 2 - Content Pages
${SITE_URL}/pickaxe
${SITE_URL}/ore/
${SITE_URL}/ore/snowite
${SITE_URL}/ore/mythril
${SITE_URL}/ore/stone

# PRIORITY 3 - Wiki & Support
${SITE_URL}/wiki/
${SITE_URL}/private-server
${SITE_URL}/feedback
${SITE_URL}/privacy-policy
${SITE_URL}/terms-of-service

# PRIORITY 4 - Detailed Content
${SITE_URL}/recipes/best-recipes
${SITE_URL}/wiki/races
${SITE_URL}/wiki/runes
${SITE_URL}/wiki/npcs
${SITE_URL}/wiki/enemies
${SITE_URL}/wiki/gamepass

# PRIORITY 5 - Blog & Russian Content
${SITE_URL}/blog/
${SITE_URL}/blog/mastering-the-forge
${SITE_URL}/blog/introducing-calculator
${SITE_URL}/ru/
${SITE_URL}/ru/crafts
${SITE_URL}/ru/recipes/
${SITE_URL}/ru/recipes/best-recipes
EOF

echo -e "${GREEN}✅ Created manual submission list: manual_gsc_submission.txt${NC}"

# Create Ahrefs submission list
cat > "ahrefs_submission.txt" << EOF
# Ahrefs Webmaster Tools Submission
# Submit these URLs to Ahrefs for crawling
# Date: $(date)

EOF

for page in "${PRIORITY_PAGES[@]}"; do
    echo "$page" >> "ahrefs_submission.txt"
done

echo -e "${GREEN}✅ Created Ahrefs submission list: ahrefs_submission.txt${NC}"

echo ""
echo -e "${YELLOW}🔧 STEP 4: Advanced Indexing Strategies${NC}"
echo "======================================="

# Create robots.txt verification
echo -e "${BLUE}📋 Checking robots.txt accessibility...${NC}"
ROBOTS_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "${SITE_URL}/robots.txt")
if [ "$ROBOTS_STATUS" = "200" ]; then
    echo -e "${GREEN}✅ robots.txt accessible (HTTP $ROBOTS_STATUS)${NC}"
else
    echo -e "${RED}❌ robots.txt issue (HTTP $ROBOTS_STATUS)${NC}"
fi

# Create sitemap accessibility check
echo -e "${BLUE}📋 Checking sitemap accessibility...${NC}"
SITEMAP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$SITEMAP_URL")
if [ "$SITEMAP_STATUS" = "200" ]; then
    echo -e "${GREEN}✅ Sitemap accessible (HTTP $SITEMAP_STATUS)${NC}"
else
    echo -e "${RED}❌ Sitemap issue (HTTP $SITEMAP_STATUS)${NC}"
fi

echo ""
echo -e "${YELLOW}📝 CRITICAL MANUAL ACTIONS REQUIRED${NC}"
echo "===================================="

echo -e "${RED}🚨 IMMEDIATE ACTIONS (Next 24 hours):${NC}"
echo ""
echo -e "${BLUE}1. Google Search Console:${NC}"
echo "   • Open GSC → forge-calculator.com property"
echo "   • Go to URL Inspection tool"
echo "   • Submit each URL from manual_gsc_submission.txt"
echo "   • Click 'Request Indexing' for each URL"
echo "   • Start with PRIORITY 1 pages first"
echo ""
echo -e "${BLUE}2. Bing Webmaster Tools:${NC}"
echo "   • Submit individual URLs using URL submission tool"
echo "   • Focus on top 10 priority pages"
echo ""
echo -e "${BLUE}3. Ahrefs Webmaster Tools:${NC}"
echo "   • Submit URLs from ahrefs_submission.txt"
echo "   • Use batch URL submission if available"

echo ""
echo -e "${YELLOW}🔍 MONITORING CHECKLIST${NC}"
echo "======================="

echo -e "${BLUE}Daily Checks (Next 7 days):${NC}"
echo "• Google Search Console Coverage report"
echo "• Sitemap processing status"
echo "• Individual page indexing status"
echo "• Crawl errors or new issues"
echo "• Organic search traffic changes"

echo ""
echo -e "${YELLOW}📊 SUCCESS METRICS${NC}"
echo "=================="

echo -e "${BLUE}Week 1 Targets:${NC}"
echo "• At least 5-8 priority pages indexed"
echo "• Sitemap status change from 'not indexed'"
echo "• Zero crawl errors"
echo "• Improved page speed scores"

echo -e "${BLUE}Week 2-4 Targets:${NC}"
echo "• 80%+ of sitemap pages indexed"
echo "• Organic traffic increase"
echo "• Better search rankings"
echo "• Reduced bounce rate"

echo ""
echo -e "${GREEN}🎯 URL CLEANUP COMPLETED${NC}"
echo "========================"

echo -e "${BLUE}✅ Achievements:${NC}"
echo "• Removed .html extensions from ALL pages"
echo "• Fixed canonical URL mismatches"
echo "• Updated sitemap with clean URLs"
echo "• Synchronized navigation links"
echo "• Created comprehensive submission strategy"

echo ""
echo -e "${YELLOW}⚡ NEXT IMMEDIATE STEP${NC}"
echo "====================="

echo -e "${RED}👉 SUBMIT TOP 5 PAGES MANUALLY IN GOOGLE SEARCH CONSOLE NOW:${NC}"
echo "1. https://forge-calculator.com/"
echo "2. https://forge-calculator.com/codes"
echo "3. https://forge-calculator.com/recipes/"
echo "4. https://forge-calculator.com/weapons"
echo "5. https://forge-calculator.com/armor"

echo ""
echo -e "${GREEN}🚀 Sitemap indexing fix process completed!${NC}"
echo -e "${YELLOW}⏰ Manual GSC submission should be done within 2 hours for best results${NC}"

# Create follow-up reminder script
cat > "check_indexing_progress.sh" << 'EOF'
#!/bin/bash
echo "🔍 Indexing Progress Check"
echo "========================="
echo ""
echo "Please check the following in Google Search Console:"
echo ""
echo "1. Coverage Report:"
echo "   • How many pages are now indexed?"
echo "   • Any new 'Valid' pages?"
echo "   • Reduction in 'Crawled - currently not indexed'?"
echo ""
echo "2. Sitemap Status:"
echo "   • Is sitemap.xml now being processed?"
echo "   • How many URLs submitted vs indexed?"
echo ""
echo "3. URL Inspection:"
echo "   • Test a few priority URLs"
echo "   • Check if they're now 'URL is on Google'"
echo ""
echo "4. Performance:"
echo "   • Any increase in clicks/impressions?"
echo "   • New keywords appearing?"
echo ""
echo "📅 Run this check daily for the next week"
echo "📊 Expected improvements within 24-72 hours"
EOF

chmod +x "check_indexing_progress.sh"
echo -e "${BLUE}📅 Created progress check script: check_indexing_progress.sh${NC}"
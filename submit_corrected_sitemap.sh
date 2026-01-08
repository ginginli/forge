#!/bin/bash

# Submit Corrected Sitemap and Key Pages to Search Engines
# This script addresses the canonical URL mismatch and sitemap indexing issues

echo "🚀 Starting corrected sitemap and page submission process..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Site configuration
SITE_URL="https://forge-calculator.com"
SITEMAP_URL="${SITE_URL}/sitemap.xml"

echo -e "${BLUE}📊 Site: ${SITE_URL}${NC}"
echo -e "${BLUE}📋 Sitemap: ${SITEMAP_URL}${NC}"

# Key pages to submit individually (prioritized list)
KEY_PAGES=(
    "${SITE_URL}/"
    "${SITE_URL}/codes"
    "${SITE_URL}/recipes/"
    "${SITE_URL}/recipes/best-recipes.html"
    "${SITE_URL}/weapons.html"
    "${SITE_URL}/armor.html"
    "${SITE_URL}/pickaxe.html"
    "${SITE_URL}/ore/"
    "${SITE_URL}/ore/snowite.html"
    "${SITE_URL}/wiki/"
)

echo ""
echo -e "${YELLOW}🔧 STEP 1: Submitting Corrected Sitemap${NC}"
echo "=========================================="

# Submit sitemap to Google
echo -e "${BLUE}📤 Submitting sitemap to Google...${NC}"
curl -s "https://www.google.com/ping?sitemap=${SITEMAP_URL}" > /dev/null
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Sitemap submitted to Google successfully${NC}"
else
    echo -e "${RED}❌ Failed to submit sitemap to Google${NC}"
fi

# Submit sitemap to Bing
echo -e "${BLUE}📤 Submitting sitemap to Bing...${NC}"
curl -s "https://www.bing.com/ping?sitemap=${SITEMAP_URL}" > /dev/null
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Sitemap submitted to Bing successfully${NC}"
else
    echo -e "${RED}❌ Failed to submit sitemap to Bing${NC}"
fi

echo ""
echo -e "${YELLOW}🔧 STEP 2: Submitting Key Pages to IndexNow${NC}"
echo "=============================================="

# IndexNow API configuration
INDEXNOW_KEY="599a0d628c834338ac489c0192d9915e"
INDEXNOW_URL="https://api.indexnow.org/indexnow"

# Create JSON payload for IndexNow
INDEXNOW_JSON=$(cat << EOF
{
    "host": "forge-calculator.com",
    "key": "${INDEXNOW_KEY}",
    "keyLocation": "https://forge-calculator.com/${INDEXNOW_KEY}.txt",
    "urlList": [
EOF

# Add key pages to JSON
for i in "${!KEY_PAGES[@]}"; do
    if [ $i -eq $((${#KEY_PAGES[@]} - 1)) ]; then
        INDEXNOW_JSON="${INDEXNOW_JSON}        \"${KEY_PAGES[$i]}\""
    else
        INDEXNOW_JSON="${INDEXNOW_JSON}        \"${KEY_PAGES[$i]}\","
    fi
done

INDEXNOW_JSON="${INDEXNOW_JSON}
    ]
}"

# Submit to IndexNow
echo -e "${BLUE}📤 Submitting key pages to IndexNow...${NC}"
RESPONSE=$(curl -s -X POST \
    -H "Content-Type: application/json" \
    -d "$INDEXNOW_JSON" \
    "$INDEXNOW_URL")

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Key pages submitted to IndexNow successfully${NC}"
    echo -e "${BLUE}📋 Submitted ${#KEY_PAGES[@]} priority pages${NC}"
else
    echo -e "${RED}❌ Failed to submit to IndexNow${NC}"
    echo -e "${RED}Response: $RESPONSE${NC}"
fi

echo ""
echo -e "${YELLOW}🔧 STEP 3: Creating Manual Submission List${NC}"
echo "==========================================="

# Create a file with URLs for manual submission in Google Search Console
MANUAL_SUBMISSION_FILE="manual_submission_urls.txt"
echo "# Priority URLs for Manual Submission in Google Search Console" > "$MANUAL_SUBMISSION_FILE"
echo "# Submit these URLs individually using the URL Inspection tool" >> "$MANUAL_SUBMISSION_FILE"
echo "# Date: $(date)" >> "$MANUAL_SUBMISSION_FILE"
echo "" >> "$MANUAL_SUBMISSION_FILE"

for page in "${KEY_PAGES[@]}"; do
    echo "$page" >> "$MANUAL_SUBMISSION_FILE"
done

echo -e "${GREEN}✅ Created manual submission list: ${MANUAL_SUBMISSION_FILE}${NC}"

echo ""
echo -e "${YELLOW}🔧 STEP 4: Verification and Next Steps${NC}"
echo "======================================"

echo -e "${BLUE}📋 Summary of Actions Taken:${NC}"
echo "  • Fixed canonical URL mismatch for /codes page"
echo "  • Updated sitemap.xml to use correct URLs"
echo "  • Submitted corrected sitemap to Google and Bing"
echo "  • Submitted ${#KEY_PAGES[@]} priority pages to IndexNow"
echo "  • Created manual submission list for Google Search Console"

echo ""
echo -e "${YELLOW}📝 MANUAL ACTIONS REQUIRED:${NC}"
echo "1. Open Google Search Console"
echo "2. Go to URL Inspection tool"
echo "3. Submit each URL from ${MANUAL_SUBMISSION_FILE} individually"
echo "4. Request indexing for each URL"
echo "5. Monitor indexing status over the next 24-48 hours"

echo ""
echo -e "${YELLOW}🔍 MONITORING:${NC}"
echo "• Check Google Search Console Coverage report daily"
echo "• Monitor sitemap indexing status"
echo "• Watch for any crawl errors or issues"
echo "• Expected timeline: 24-48 hours for initial indexing response"

echo ""
echo -e "${GREEN}🎯 CANONICAL URL FIXES APPLIED:${NC}"
echo "• /codes page: canonical now matches serving URL"
echo "• Navigation links updated for consistency"
echo "• Sitemap URLs corrected to match canonical tags"

echo ""
echo -e "${BLUE}📊 Key Metrics to Track:${NC}"
echo "• Pages indexed in Google Search Console"
echo "• Organic search traffic increase"
echo "• Search appearance improvements"
echo "• Mobile usability scores"

echo ""
echo -e "${GREEN}✅ Corrected sitemap submission process completed!${NC}"
echo -e "${YELLOW}⏰ Next check recommended in 24 hours${NC}"

# Create a follow-up reminder
echo "#!/bin/bash" > check_indexing_status.sh
echo "echo '🔍 Checking indexing status...'" >> check_indexing_status.sh
echo "echo 'Please check Google Search Console for:'" >> check_indexing_status.sh
echo "echo '• Coverage report updates'" >> check_indexing_status.sh
echo "echo '• Sitemap processing status'" >> check_indexing_status.sh
echo "echo '• Individual page indexing status'" >> check_indexing_status.sh
echo "echo '• Any new crawl errors or issues'" >> check_indexing_status.sh
chmod +x check_indexing_status.sh

echo -e "${BLUE}📅 Created follow-up script: check_indexing_status.sh${NC}"
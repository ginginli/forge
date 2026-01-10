#!/bin/bash

# Schema 添加脚本 - 为所有页面添加结构化数据
echo "🎯 开始为所有页面添加 Schema 结构化数据..."

# 定义通用的 Organization Schema
ORGANIZATION_SCHEMA='{
                "@type": "Organization",
                "@id": "https://forge-calculator.com/#organization",
                "name": "Forge Calculator",
                "url": "https://forge-calculator.com/",
                "logo": {
                    "@type": "ImageObject",
                    "url": "https://forge-calculator.com/favicon-120x120.png",
                    "width": 120,
                    "height": 120
                }
            }'

# 为 calculator.html 添加 Schema
echo "📊 添加 calculator.html Schema..."
if grep -q "application/ld+json" calculator.html; then
    echo "✅ calculator.html 已有 Schema，跳过"
else
    # 查找插入位置并添加 Schema
    sed -i '/<!-- Ahrefs Analytics -->/a\
    \
    <!-- Structured Data - JSON-LD -->\
    <script type="application/ld+json">\
    {\
        "@context": "https://schema.org",\
        "@graph": [\
            '"$ORGANIZATION_SCHEMA"',\
            {\
                "@type": "WebPage",\
                "@id": "https://forge-calculator.com/calculator#webpage",\
                "url": "https://forge-calculator.com/calculator",\
                "name": "The Forge Calculator - Weapon & Armor Crafting Tool",\
                "description": "Advanced calculator for The Forge Roblox game. Calculate optimal ore combinations, weapon stats, and armor builds with real-time results.",\
                "inLanguage": "en",\
                "isPartOf": {\
                    "@type": "WebSite",\
                    "@id": "https://forge-calculator.com/#website",\
                    "name": "Forge Calculator",\
                    "url": "https://forge-calculator.com/",\
                    "publisher": {"@id": "https://forge-calculator.com/#organization"}\
                },\
                "about": {\
                    "@type": "VideoGame",\
                    "name": "The Forge",\
                    "gamePlatform": "Roblox"\
                },\
                "primaryImageOfPage": {\
                    "@type": "ImageObject",\
                    "url": "https://forge-calculator.com/favicon-120x120.png"\
                },\
                "datePublished": "2024-01-01",\
                "dateModified": "2026-01-10",\
                "author": {"@id": "https://forge-calculator.com/#organization"},\
                "publisher": {"@id": "https://forge-calculator.com/#organization"}\
            },\
            {\
                "@type": "SoftwareApplication",\
                "@id": "https://forge-calculator.com/calculator#software",\
                "name": "The Forge Calculator Tool",\
                "applicationCategory": "UtilitiesApplication",\
                "operatingSystem": ["Windows", "macOS", "Linux", "Android", "iOS"],\
                "description": "Interactive calculator for optimizing weapon and armor crafting in The Forge Roblox game.",\
                "url": "https://forge-calculator.com/calculator",\
                "offers": {\
                    "@type": "Offer",\
                    "price": "0",\
                    "priceCurrency": "USD",\
                    "availability": "https://schema.org/InStock"\
                },\
                "about": {"@id": "https://forge-calculator.com/#forge-game"},\
                "publisher": {"@id": "https://forge-calculator.com/#organization"}\
            }\
        ]\
    }\
    </script>' calculator.html
    echo "✅ calculator.html Schema 添加完成"
fi

echo "🎯 Schema 添加完成！"
echo ""
echo "📊 已处理的页面："
echo "- ✅ codes.html (已完成)"
echo "- ✅ weapons.html (已完成)" 
echo "- ✅ armor.html (已完成)"
echo "- ✅ pickaxe.html (已完成)"
echo "- ✅ ore/index.html (已完成)"
echo "- ✅ ore/snowite.html (已完成)"
echo "- ✅ feedback.html (已完成)"
echo "- ✅ privacy-policy.html (已完成)"
echo "- ✅ calculator.html (新增)"
echo ""
echo "🚀 建议下一步："
echo "1. 验证 Schema: https://search.google.com/test/rich-results"
echo "2. 提交 GSC 重新索引"
echo "3. 监控搜索结果改善"
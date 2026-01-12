#!/bin/bash

echo "🔍 检查404页面状态和配置..."
echo "Checking 404 page status and configuration..."

echo ""
echo "📁 当前404相关文件:"
ls -la 404.html*

echo ""
echo "📊 文件大小对比:"
wc -c 404.html*

echo ""
echo "🔧 Vercel配置检查:"
echo "检查 vercel.json 是否有404配置..."
if grep -q "404" vercel.json; then
    echo "✅ 找到404配置"
    grep -A5 -B5 "404" vercel.json
else
    echo "❌ vercel.json 中没有找到404配置"
    echo "💡 Vercel 默认会查找根目录下的 404.html 文件"
fi

echo ""
echo "🌐 测试404页面可访问性:"
echo "当前使用的404页面: 404.html"
echo "文件存在: $(test -f 404.html && echo '✅ 是' || echo '❌ 否')"

echo ""
echo "📋 建议操作:"
echo "1. 当前 404.html 是最新版本 (2026年1月9日修改)"
echo "2. 备份文件可以安全删除"
echo "3. Vercel 会自动使用根目录的 404.html 作为404页面"

echo ""
echo "🗑️  可以删除的备份文件:"
echo "- 404.html.backup (旧版本，包含 .html 扩展名链接)"
echo "- 404.html.final_backup (旧版本，包含 .html 扩展名链接)"
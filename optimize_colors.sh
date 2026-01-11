#!/bin/bash

# 颜色系统优化脚本 - Color System Optimization Script
# 基于 Claude Skills 方法论

echo "🎨 开始颜色系统优化..."
echo "Starting color system optimization based on Claude Skills methodology..."

# 备份原始CSS文件
cp forge-theme.css forge-theme.css.backup
echo "✅ 已备份原始CSS文件"

# 统计当前硬编码颜色数量
echo ""
echo "📊 统计硬编码颜色使用情况..."
echo "Analyzing hardcoded color usage..."

# 查找所有十六进制颜色值
hex_colors=$(grep -o '#[0-9a-fA-F]\{3,6\}' forge-theme.css | sort | uniq)
hex_count=$(echo "$hex_colors" | wc -l)

echo "发现 $hex_count 个不同的十六进制颜色值:"
echo "$hex_colors"

echo ""
echo "🔍 查找需要替换的硬编码颜色..."

# 查找常见的硬编码颜色模式
echo "查找 rgba() 颜色..."
grep -n "rgba(" forge-theme.css | head -10

echo ""
echo "查找 rgb() 颜色..."
grep -n "rgb(" forge-theme.css | head -10

echo ""
echo "✅ 颜色分析完成！"
echo ""
echo "📋 建议的下一步操作:"
echo "1. 检查 COLOR_ANALYSIS_REPORT.md 获取详细分析"
echo "2. 手动替换剩余的硬编码颜色"
echo "3. 测试网站��视觉效果"
echo "4. 验证颜色一致性"

echo ""
echo "🎯 优化目标: 从 63 个颜色减少到 12 个核心颜色"
echo "Target: Reduce from 63 colors to 12 core colors"
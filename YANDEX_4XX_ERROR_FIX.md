# Yandex Webmaster 4xx 错误修复指南

## 🚨 问题描述
**日期**: 2025年12月27日 下午3:47  
**来源**: Yandex Webmaster  
**警告**: 网站 https://forge-calculator.com 的某些页面开始向机器人返回 HTTP 4xx 代码

## 🔍 可能的原因

### 1. 页面被删除或移动
- 某些页面可能已被删除但仍在 Yandex 索引中
- URL 结构发生变化
- 文件路径错误

### 2. 服务器配置问题
- Vercel 部署问题
- 路由配置错误
- 权限设置问题

### 3. 最近的更改影响
- 俄语页面添加后的路由冲突
- 文件重命名或移动
- .htaccess 或 vercel.json 配置问题

## 🛠️ 诊断步骤

### 步骤 1: 检查 Yandex Webmaster 具体错误
1. 登录 Yandex Webmaster: https://webmaster.yandex.com/
2. 选择网站: forge-calculator.com
3. 查看 "索引状态" → "HTTP 错误"
4. 记录所有返回 4xx 错误的具体 URL

### 步骤 2: 手动测试问题页面
使用浏览器或工具测试每个报错的 URL：
```bash
# 测试示例 URL
curl -I https://forge-calculator.com/[问题页面]
```

### 步骤 3: 检查常见问题页面
可能出现问题的页面：
- `/blog/` 相关页面
- `/wiki/` 子页面
- 旧的 URL 路径
- 重定向链中的中间页面

## 🔧 修复方案

### 方案 1: 如果页面确实被删除
在 `vercel.json` 中添加重定向：
```json
{
  "redirects": [
    {
      "source": "/old-page-path",
      "destination": "/new-page-path",
      "permanent": true
    }
  ]
}
```

### 方案 2: 如果页面应该存在但返回 404
1. 检查文件是否存在于正确位置
2. 验证文件名和路径
3. 确认 Vercel 部署包含所有文件

### 方案 3: 添加自定义 404 页面
创建 `404.html` 文件：
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found - The Forge Calculator</title>
    <meta name="robots" content="noindex, nofollow">
</head>
<body>
    <h1>Page Not Found</h1>
    <p>The page you're looking for doesn't exist.</p>
    <a href="/">Return to Homepage</a>
</body>
</html>
```

## 📊 预防措施

### 1. 更新 robots.txt
如果某些页面确实应该被排除：
```
User-agent: *
Disallow: /deleted-section/
```

### 2. 在 Yandex Webmaster 中标记删除的页面
1. 进入 "索引状态" → "删除页面"
2. 添加不再存在的 URL
3. 选择删除原因

### 3. 提交更新的 sitemap
确保 sitemap.xml 只包含存在的页面：
```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <!-- 只包含实际存在的页面 -->
</urlset>
```

## 🎯 立即行动清单

### 高优先级 (立即执行)
- [ ] 登录 Yandex Webmaster 查看具体错误页面
- [ ] 手动测试所有报错的 URL
- [ ] 修复或重定向损坏的页面

### 中优先级 (24小时内)
- [ ] 创建自定义 404 页面
- [ ] 更新 sitemap.xml
- [ ] 在 Yandex Webmaster 中提交修复

### 低优先级 (1周内)
- [ ] 监控错误是否再次出现
- [ ] 优化网站结构避免未来问题
- [ ] 设置自动监控

## 📈 监控和验证

### 验证修复效果
1. 等待 24-48 小时让 Yandex 重新抓取
2. 检查 Yandex Webmaster 中的错误报告
3. 监控搜索结果中的页面可见性

### 设置持续监控
- 定期检查 Yandex Webmaster 错误报告
- 使用工具监控网站健康状况
- 设置自动化测试检查关键页面

---

## 🆘 紧急联系信息

如果问题严重影响搜索可见性：
1. 立即修复最重要的页面（首页、主要产品页面）
2. 在 Yandex Webmaster 中请求紧急重新抓取
3. 监控流量变化

**状态**: 🔍 需要立即诊断具体错误页面  
**优先级**: 🔴 高优先级  
**预计修复时间**: 24-48小时
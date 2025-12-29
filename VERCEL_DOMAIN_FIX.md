# Vercel 域名配置修复指南

## 🚨 问题描述
Google Search Console 显示 `http://forge-calculator.com/` 未被索引或提供服务。

## 🔍 根本原因
这是 Vercel 域名配置和重定向设置的问题，需要确保：
1. 正确的 HTTPS 强制执行
2. WWW 到非 WWW 的重定向
3. 规范化 URL 处理

## 🛠️ 解决步骤

### 1. Vercel 域名配置检查

在 Vercel Dashboard 中确认：

**主域名设置：**
- ✅ `forge-calculator.com` → Production 环境
- ✅ `www.forge-calculator.com` → 重定向到主域名

**当前配置状态：**
```
✅ www.forge-calculator.com → 308 重定向
✅ forge-calculator.com → Production
```

### 2. vercel.json 配置文件

创建 `vercel.json` 文件来处理重定向：

```json
{
  "redirects": [
    {
      "source": "/(.*)",
      "has": [
        {
          "type": "host",
          "value": "www.forge-calculator.com"
        }
      ],
      "destination": "https://forge-calculator.com/$1",
      "permanent": true
    }
  ],
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        },
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        },
        {
          "key": "X-XSS-Protection",
          "value": "1; mode=block"
        },
        {
          "key": "Referrer-Policy",
          "value": "strict-origin-when-cross-origin"
        },
        {
          "key": "Strict-Transport-Security",
          "value": "max-age=31536000; includeSubDomains"
        }
      ]
    }
  ],
  "trailingSlash": false
}
```

### 3. HTML Meta 标签优化

确保所有页面都有正确的 canonical URL：

```html
<link rel="canonical" href="https://forge-calculator.com/">
<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
```

### 4. Google Search Console 操作

**立即执行：**
1. **提交 HTTPS URL 进行索引**
   - 访问 Google Search Console
   - 使用 URL 检查工具
   - 输入：`https://forge-calculator.com/`
   - 点击"请求编入索引"

2. **移除 HTTP URL**
   - 进入"移除"工具
   - 请求移除：`http://forge-calculator.com/`
   - 选择"暂时隐藏"

3. **更新 Sitemap**
   - 确保 sitemap.xml 只包含 HTTPS URLs
   - 重新提交 sitemap

### 5. 验证重定向链

使用工具验证重定向是否正确：

```bash
# 测试 HTTP 重定向
curl -I http://forge-calculator.com/

# 测试 WWW 重定向  
curl -I http://www.forge-calculator.com/

# 期望结果：301/302 重定向到 https://forge-calculator.com/
```

## 📊 预期结果

修复后的重定向链应该是：
```
http://forge-calculator.com/ → https://forge-calculator.com/ (301)
http://www.forge-calculator.com/ → https://forge-calculator.com/ (301)
https://www.forge-calculator.com/ → https://forge-calculator.com/ (301)
https://forge-calculator.com/ → 200 OK (最终目标)
```

## ⏰ 时间线

- **立即**: 部署 vercel.json 配置
- **24-48 小时**: Google 重新抓取和索引
- **1 周**: 完全解决索引问题

## 🔍 监控

定期检查：
1. Google Search Console 中的索引状态
2. 重定向链是否正常工作
3. HTTPS 证书是否有效

---

**状态**: ✅ 配置已优化，等待 Google 重新索引
**日期**: 2025年12月29日
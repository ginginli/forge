# 如何接收用户反馈

目前代码页面的反馈功能已经准备好，但需要配置才能接收反馈。以下是几种方案：

---

## 方案 1：Discord Webhook（推荐！免费且简单）

### 优点：
- ✅ 完全免费
- ✅ 实时通知
- ✅ 无需后端服务器
- ✅ 可以在手机上查看

### 设置步骤：

1. **创建 Discord 服务器**（如果还没有）
   - 打开 Discord
   - 点击 "+" 创建服务器

2. **创建 Webhook**
   - 进入服务器设置 > 集成 > Webhooks
   - 点击 "新建 Webhook"
   - 命名为 "Forge Codes Feedback"
   - 选择接收反馈的频道
   - 复制 Webhook URL

3. **更新代码**
   - 打开 `codes.html`
   - 找到这一行：
     ```javascript
     const DISCORD_WEBHOOK_URL = 'YOUR_DISCORD_WEBHOOK_URL_HERE';
     ```
   - 替换为你的 Webhook URL：
     ```javascript
     const DISCORD_WEBHOOK_URL = 'https://discord.com/api/webhooks/YOUR_WEBHOOK_URL';
     ```

4. **测试**
   - 访问你的网站
   - 提交一个测试反馈
   - 检查 Discord 频道是否收到消息

---

## 方案 2：Formspree（邮箱接收）

### 优点：
- ✅ 免费计划（每月 50 次提交）
- ✅ 发送到邮箱
- ✅ 无需编程

### 设置步骤：

1. **注册 Formspree**
   - 访问 https://formspree.io
   - 注册账号（免费）

2. **创建表单**
   - 创建新表单
   - 获取 Form ID（类似 `xpznabcd`）

3. **更新 HTML 表单**
   ```html
   <form action="https://formspree.io/f/YOUR_FORM_ID" method="POST">
   ```

4. **添加隐藏字段**
   ```html
   <input type="hidden" name="_subject" value="New Code Feedback">
   ```

---

## 方案 3：Google Forms（完全免费）

### 优点：
- ✅ 完全免费
- ✅ 无限提交
- ✅ 自动整理到 Google Sheets

### 设置步骤：

1. **创建 Google Form**
   - 访问 https://forms.google.com
   - 创建新表单
   - 添加字段：
     - 代码名称（下拉选择）
     - 是否有效（单选）
     - 新代码（文本）
     - 奖励（文本）
     - 来源（下拉选择）

2. **获取嵌入代码**
   - 点击 "发送"
   - 选择 "<>" 图标
   - 复制 iframe 代码

3. **替换反馈区域**
   - 用 Google Form iframe 替换当前的表单

---

## 方案 4：Vercel Serverless Function + Email

如果你想要更专业的解决方案，我可以帮你创建：

1. Vercel Serverless Function
2. 使用 SendGrid 或 Resend 发送邮件
3. 完全自定义的反馈处理

需要这个方案吗？告诉我，我可以帮你实现。

---

## 推荐方案对比

| 方案 | 难度 | 成本 | 实时性 | 推荐度 |
|------|------|------|--------|--------|
| Discord Webhook | ⭐ 简单 | 免费 | ⚡ 即时 | ⭐⭐⭐⭐⭐ |
| Formspree | ⭐ 简单 | 免费/付费 | 📧 邮件 | ⭐⭐⭐⭐ |
| Google Forms | ⭐⭐ 中等 | 免费 | 📊 表格 | ⭐⭐⭐ |
| Serverless | ⭐⭐⭐ 复杂 | 免费 | ⚡ 即时 | ⭐⭐⭐⭐ |

---

## 我的建议

**立即使用：Discord Webhook**
- 5分钟设置完成
- 完全免费
- 实时通知到手机
- 可以直接在 Discord 回复用户

**长期方案：Serverless Function**
- 更专业
- 可以添加数据库
- 自动处理反馈
- 但需要更多开发时间

---

## 需要帮助？

告诉我你想用哪个方案，我可以帮你完成配置！

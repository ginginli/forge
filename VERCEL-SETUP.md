# Vercel Serverless Function 设置指南

你的反馈系统已经配置好了！现在需要设置环境变量来接收邮件。

---

## 📧 使用 Resend 发送邮件（推荐）

### 为什么选择 Resend？
- ✅ 完全免费（每月 3,000 封邮件）
- ✅ 专为开发者设计
- ✅ 设置简单
- ✅ 可靠性高

---

## 🚀 设置步骤

### 1. 注册 Resend

1. 访问 https://resend.com
2. 点击 "Start Building"
3. 使用 GitHub 账号登录（推荐）或邮箱注册

### 2. 获取 API Key

1. 登录后，进入 "API Keys" 页面
2. 点击 "Create API Key"
3. 名称：`Forge Calculator Feedback`
4. 权限：选择 "Sending access"
5. 点击 "Add"
6. **复制 API Key**（只显示一次！）

### 3. 在 Vercel 设置环境变量

1. 登录 Vercel：https://vercel.com
2. 进入你的项目：`forge`
3. 点击 "Settings" 标签
4. 左侧菜单选择 "Environment Variables"
5. 添加两个环境变量：

   **变量 1：**
   - Name: `RESEND_API_KEY`
   - Value: `re_xxxxxxxxxx`（你的 Resend API Key）
   - Environment: Production, Preview, Development（全选）
   
   **变量 2：**
   - Name: `RECIPIENT_EMAIL`
   - Value: `your-email@example.com`（你的邮箱地址）
   - Environment: Production, Preview, Development（全选）

6. 点击 "Save"

### 4. 重新部署

环境变量设置后需要重新部署：

1. 在 Vercel 项目页面，点击 "Deployments" 标签
2. 找到最新的部署
3. 点击右侧的 "..." 菜单
4. 选择 "Redeploy"
5. 确认重新部署

---

## ✅ 测试

1. 访问你的网站：https://forge-calculator.com/codes.html
2. 滚动到反馈区域
3. 提交一个测试反馈
4. 检查你的邮箱（包括垃圾邮件文件夹）

---

## 📊 邮件格式

你会收到格式化的 HTML 邮件：

**代码状态报告：**
```
📊 Code Status Report
Code: PEAK!
Status: ✅ Working
Timestamp: 2024-12-06 10:30:00
```

**新代码提交：**
```
🆕 New Code Submission
Code: NEWCODE123
Reward: 10x Rerolls
Source: Official Discord
Timestamp: 2024-12-06 10:30:00
```

---

## 🔧 高级配置（可选）

### 自定义发件人邮箱

默认发件人是 `noreply@forge-calculator.com`

要使用自定义域名：
1. 在 Resend 添加并验证你的域名
2. 更新 `api/feedback.js` 中的 `from` 字段

### 添加自动回复

在 `api/feedback.js` 中可以添加第二封邮件发送给提交者。

### 保存到数据库

可以集成 Vercel KV 或其他数据库来保存所有反馈。

---

## 🆓 费用说明

- **Vercel Serverless Functions**: 免费（每月 100GB-hours）
- **Resend**: 免费（每月 3,000 封邮件）
- **总成本**: $0

---

## ❓ 常见问题

### Q: 没有收到邮件？
A: 检查：
1. 环境变量是否正确设置
2. 是否重新部署了
3. 垃圾邮件文件夹
4. Resend 后台的发送日志

### Q: API Key 在哪里？
A: Resend 后台 > API Keys > 创建新的

### Q: 可以用其他邮件服务吗？
A: 可以！可以用 SendGrid、Mailgun 等，需要修改 `api/feedback.js`

---

## 🎉 完成！

设置完成后，你就可以：
- ✅ 接收用户反馈到邮箱
- ✅ 无限制的提交次数
- ✅ 完全免费
- ✅ 专业的邮件格式

需要帮助？随时问我！

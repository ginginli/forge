# Analytics 设置说明

## 已安装的分析工具

### 1. Google Analytics 4 (GA4)
- **测量 ID**: G-YRP03D44XS
- **安装位置**: 所有主要 HTML 页面的 `<head>` 部分
- **访问地址**: https://analytics.google.com/

#### 可追踪的数据：
- 页面浏览量
- 用户数量（实时和历史）
- 流量来源（搜索引擎、直接访问、引荐网站）
- 用户行为（停留时间、跳出率、转化路径）
- 设备类型（桌面、移动、平板）
- 地理位置
- 事件追踪（点击、滚动、视频播放等）

#### 如何查看数据：
1. 访问 https://analytics.google.com/
2. 选择 "Forge Calculator" 属性
3. 查看实时报告或历史报告

### 2. Ahrefs Analytics
- **Key**: EpsJtUp2VOHq8C8Dwkg1zQ
- **安装位置**: 所有主要 HTML 页面的 `<head>` 部分
- **访问地址**: https://analytics.ahrefs.com/

#### 可追踪的数据：
- SEO 相关指标
- 搜索关键词
- 反向链接
- 网站排名

## 已添加 Google Analytics 的页面

✅ 主要页面（14个）：
1. index.html - 首页/计算器
2. armor.html - 护甲指南
3. weapons.html - 武器指南
4. wiki.html - Wiki 页面
5. codes.html - 代码页面
6. recipes.html - 配方页面
7. ore-guide.html - 矿石指南
8. races.html - 种族指南
9. enemies.html - 敌人指南
10. npcs.html - NPC 指南
11. feedback.html - 反馈页面
12. blog.html - 博客列表
13. blog-introducing-calculator.html - 博客文章
14. blog-mastering-the-forge.html - 博客文章

❌ 未添加的页面（按设计）：
- privacy-policy.html - 隐私政策
- terms-of-service.html - 服务条款

## 如何追踪 AI 引荐流量

### 在 Google Analytics 中设置：

1. **查看流量来源**
   - 进入 GA4 → 报告 → 获客 → 流量获取
   - 查看 "会话来源/媒介" 维度

2. **识别 AI 流量**
   AI 流量可能显示为：
   - `chat.openai.com / referral` (ChatGPT)
   - `claude.ai / referral` (Claude)
   - `perplexity.ai / referral` (Perplexity)
   - `gemini.google.com / referral` (Gemini)
   - `(direct) / (none)` (用户直接输入网址)

3. **创建自定义报告**
   - 探索 → 创建新探索
   - 添加维度：会话来源、页面路径
   - 添加指标：会话数、用户数、参与度

4. **设置转化目标**
   - 管理 → 事件 → 创建事件
   - 例如：追踪计算器使用、代码复制等

### 监控关键指标：

#### 每日检查：
- 实时用户数
- 今日页面浏览量
- 流量来源分布

#### 每周检查：
- 用户增长趋势
- 热门页面排名
- AI 引荐流量占比
- 平均停留时间

#### 每月检查：
- 月度用户增长
- 内容表现分析
- 转化率优化
- SEO 关键词排名

## 优化建议

### 基于数据优化内容：

1. **如果某个页面流量高但跳出率也高**
   → 改进内容质量，添加相关链接

2. **如果 AI 引荐流量低**
   → 更新 llms.txt，优化内容结构

3. **如果某些页面流量很低**
   → 改进 SEO，添加内部链接

4. **如果用户停留时间短**
   → 添加更多有价值的内容，改进页面布局

### 追踪特定事件（可选）：

在需要追踪的按钮或链接上添加事件：

```javascript
// 追踪计算器使用
gtag('event', 'calculator_use', {
  'event_category': 'engagement',
  'event_label': 'ore_combination'
});

// 追踪代码复制
gtag('event', 'code_copy', {
  'event_category': 'engagement',
  'event_label': 'game_code'
});

// 追踪外部链接点击
gtag('event', 'click', {
  'event_category': 'outbound',
  'event_label': 'roblox_game'
});
```

## 数据隐私

- Google Analytics 符合 GDPR 和 CCPA 要求
- 数据匿名化处理
- 用户可以通过浏览器设置禁用追踪
- 隐私政策页面已说明数据收集

## 故障排查

### 如果数据没有显示：

1. **检查代码是否正确安装**
   - 打开网站，查看页面源代码
   - 搜索 "G-YRP03D44XS"
   - 确认代码在 `<head>` 部分

2. **使用 Google Tag Assistant**
   - 安装 Chrome 扩展：Tag Assistant Legacy
   - 访问你的网站
   - 检查 GA4 标签是否触发

3. **检查实时报告**
   - GA4 → 报告 → 实时
   - 访问你的网站
   - 应该能看到实时用户

4. **等待数据处理**
   - GA4 数据可能延迟 24-48 小时
   - 实时报告应该立即显示

## 有用的资源

- Google Analytics 帮助中心: https://support.google.com/analytics
- GA4 学习中心: https://skillshop.withgoogle.com/
- Ahrefs 学院: https://ahrefs.com/academy

## 更新日志

- 2024-12-08: 添加 Google Analytics 4 到所有主要页面
- 2024-12-08: 优化 llms.txt 以吸引 AI 流量

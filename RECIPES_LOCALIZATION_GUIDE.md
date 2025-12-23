# Recipes 页面俄语本地化指南

## 已完成的工作

### 1. 创建俄语 Recipes 子目录
- ✅ 创建了 `/ru/recipes/` 文件夹
- ✅ 复制了 `recipes/index.html` 到 `/ru/recipes/index.html`

### 2. 页面本地化设置
- ✅ 更改语言属性为 `lang="ru"`
- ✅ 更新了所有元数据标签
- ✅ 翻译了页面标题和描述
- ✅ 更新了 canonical URL 为 `/ru/recipes/`
- ✅ 修正了 Open Graph 和 Twitter 卡片标签

### 3. 翻译策略
按照要求：
- ✅ **保留品牌名**: "The Forge" 不翻译
- ✅ **翻译 Recipe**: "Recipe" → "Рецепты"
- ✅ **保留表格内容**: "The Forge Weapon Recipes" 和 "The Forge Armor Recipes" 表格不翻译
- ✅ **翻译其他内容**: 导航、标题、描述、FAQ等

### 4. 具体翻译内容

#### 页面标题和元数据
- "The Forge Recipes - Complete Crafting Recipe Database" → "Рецепты The Forge - Полная База Данных Рецептов Крафта"
- Meta description 完全翻译为俄语
- 关键词本地化

#### 导航菜单
- 与主页面保持一致的俄语导航
- 添加了语言切换链接 "🇺🇸 English"

#### 主要内容区域
- ✅ 主标题: "📖 The Forge Recipes" → "📖 Рецепты The Forge"
- ✅ 副标题: "Complete Database" → "Полная База Данных"
- ✅ 描述文本完全翻译

#### 内容部分标题
- "🎮 What is The Forge Recipes?" → "🎮 Что такое Рецепты The Forge?"
- "📖 How to Use The Forge Recipes" → "📖 Как Использовать Рецепты The Forge"
- "❓ FAQ About The Forge Recipes" → "❓ Часто Задаваемые Вопросы о Рецептах The Forge"

#### FAQ 问题翻译
- "What is The Forge Best Weapon Recipe?" → "Какой лучший рецепт оружия в The Forge?"
- "What is The Forge Best Armor Recipe?" → "Какой лучший рецепт брони в The Forge?"
- "Are The Forge Recipes Accurate?" → "Точны ли Рецепты The Forge?"
- "Can I Modify The Forge Recipes?" → "Могу ли я изменять Рецепты The Forge?"
- "How Often Are The Forge Recipes Updated?" → "Как часто обновляются Рецепты The Forge?"
- "Do The Forge Recipes Work for All Players?" → "Работают ли Рецепты The Forge для всех игроков?"

### 5. 保留的英文内容
按照要求，以下内容保持英文：
- ✅ 表格标题: "⚔️ The Forge Weapon Recipes"
- ✅ 表格标题: "🛡️ The Forge Armor Recipes"
- ✅ 表格内容: 所有武器和装甲数据
- ✅ 品牌名称: "The Forge" 在所有地方都保持英文

### 6. URL 结构
- 英语版本: `https://forge-calculator.com/recipes/`
- 俄语版本: `https://forge-calculator.com/ru/recipes/`

### 7. 导航链接更新
- ✅ 更新了主页面 (`ru/index.html`) 中的 recipes 链接指向 `/ru/recipes/`
- ✅ 俄语 recipes 页面的导航链接正确指向俄语版本

## 技术细节

### SEO 优化
```html
<meta name="keywords" content="рецепты the forge, forge roblox рецепты, рецепты крафта the forge, список рецептов forge, лучшие рецепты forge, легендарные рецепты forge">
```

### Hreflang 标签 (需要添加)
建议在未来添加：
```html
<link rel="alternate" hreflang="en" href="https://forge-calculator.com/recipes/">
<link rel="alternate" hreflang="ru" href="https://forge-calculator.com/ru/recipes/">
```

## 下一步建议

### 1. 内容翻译
- 翻译表格下方的说明文字
- 翻译 Pro Tips 和提示框内容
- 翻译按钮文本 ("Use in Calculator" 等)

### 2. 功能性内容
- 考虑翻译过滤器按钮 (如果存在)
- 翻译 JavaScript 生成的动态内容

### 3. 一致性检查
- 确保所有 "The Forge" 品牌名保持英文
- 确保所有 "recipe/recipes" 都翻译为 "рецепт/рецепты"
- 检查链接的正确性

### 4. 用户体验
- 测试俄语版本的功能
- 确保计算器集成正常工作
- 验证所有链接指向正确的俄语页面

## 文件结构
```
/
├── recipes/
│   └── index.html (英语版本)
├── ru/
│   ├── index.html (俄语主页)
│   └── recipes/
│       └── index.html (俄语 recipes 页面)
└── ... (其他文件)
```

## 维护注意事项
- 当更新英语版本的 recipes 页面时，记得同步更新俄语版本
- 保持表格数据的一致性（不翻译）
- 定期检查链接的有效性
- 确保新添加的内容遵循翻译策略
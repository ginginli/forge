# 页面提交指南

## 刚刚修复的页面需要重新提交

我们已经修复了以下页面的 canonical 标签问题：

### 修复的页面列表：
- `npcs.html` - 添加了 canonical 标签和关键词
- `races.html` - 添加了 canonical 标签和关键词  
- `enemies.html` - 添加了 canonical 标签和关键词
- `recipe-viewer.html` - 添加了 canonical 标签和描述
- `recipe-database-ui.html` - 转换为完整HTML页面，添加canonical标签
- `blog-introducing-calculator-print.html` - 添加了 canonical 标签
- `generate-recipes.html` - 添加了 canonical 标签
- `sitemap.xml` - 更新了所有页面

## 提交方法

### 方法1: 自动提交脚本
```bash
./submit-updated-pages.sh
```

### 方法2: Google Search Console 手动提交

1. **进入 Google Search Console**
2. **选择"网址检查"工具**
3. **逐个提交以下URL:**
   ```
   https://forge-calculator.com/npcs.html
   https://forge-calculator.com/races.html
   https://forge-calculator.com/enemies.html
   https://forge-calculator.com/recipe-viewer.html
   https://forge-calculator.com/recipe-database-ui.html
   ```

4. **或者提交更新的 sitemap:**
   ```
   https://forge-calculator.com/sitemap.xml
   ```

### 方法3: 批量提交 sitemap (推荐)

1. 进入 Google Search Console
2. 点击左侧菜单"站点地图"
3. 添加新的站点地图: `sitemap.xml`
4. 点击"提交"

## 预期结果

- **24-48小时内**: 搜索引擎开始重新索引页面
- **1周内**: canonical 标签生效，重复页面问题解决
- **2-4周内**: SEO 排名可能有所改善

## 验证方法

### 检查 canonical 标签是否生效:
```bash
curl -s "https://forge-calculator.com/npcs.html" | grep -i canonical
```

### 在 Google Search Console 检查:
1. 进入"覆盖范围"报告
2. 查看"重复页面"数量是否减少
3. 检查"已编入索引"页面数量

## 注意事项

- ✅ 所有页面现在都有唯一的 canonical URL
- ✅ Meta 描述和关键词已优化
- ✅ HTML 结构已标准化
- ✅ Sitemap 已更新包含所有页面

## 后续监控

建议在以下时间点检查效果：
- **3天后**: 检查页面是否被重新索引
- **1周后**: 查看重复页面警告是否消失
- **1个月后**: 评估SEO排名变化
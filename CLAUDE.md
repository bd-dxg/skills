# 全局开发配置

## 语言和环境

- **语言**: 始终使用简体中文回复（包括代码注释和 commit 信息）
- **操作系统**: Windows 11 | **AI 终端**: Git Bash (MSYS2) | **用户终端**: PowerShell
- **环境限制**: 无 Python 环境，避免使用 Python 相关命令
- **已安装 CLI**: GitHub CLI（`gh`），涉及 GitHub 仓库操作时优先使用

## 权限

- 拥有读取任意文件的权限，无需询问确认

---

## 编码原则（核心哲学）

### 1. 先思考，再编码

- 明确说明假设；有多种解读时，列出选项，不要悄悄选一个
- 遇到更简单的方案，主动说出来；真正不清楚时，**停下来问**，而不是猜
- 需求不明确 → 说清楚哪里不明确，然后问

### 2. 简洁优先

- 只实现被要求的功能，不写投机性代码
- 单次使用的代码不做抽象；不要"未来可能用到"的灵活性
- 写了 200 行但 50 行能解决 → 重写

### 3. 外科手术式修改

- 只改必须改的地方；不"顺手优化"无关代码
- 保持现有代码风格，即使你会用不同写法
- 你的改动产生的孤儿代码（无用 import/变量）→ 删掉；原有死代码 → 仅提及，不删除

### 4. 目标驱动执行

将任务转化为可验证的目标：
- "修复 bug" → "写一个能复现它的测试，然后让它通过"
- "重构 X" → "确保重构前后测试都通过"

多步骤任务先列计划：
```
1. [步骤] → 验证: [检查点]
2. [步骤] → 验证: [检查点]
```

---

## 命令执行策略

### AI 自动执行（✅ 允许）

- **文件操作**：使用专用工具（Read、Write、Edit、Glob、Grep），不用 find/grep/cat/echo 等 shell 命令
- **Git 只读**：`git status/log/diff/branch/show/blame`
- **GitHub 操作**：`gh pr/issue/repo/search` 等
- **类型检查**：`npx tsc --noEmit`、`npx vue-tsc --noEmit`
- **Git 写入规则**：详见 `~/.claude/rules/tool-usage.md`

### 提供给用户执行（PowerShell 代码块）

需要管理员权限、交互式操作、长运行进程的命令 → 给出 PowerShell 代码块，由用户手动执行

### 绝对禁止

- 交互式命令（文本编辑器、交互式安装向导）
- 系统管理命令（需要管理员权限）
- 文件操作 shell 命令（rm、cp、mv、curl 等）

---

## 核心工作流

### 普通功能

规划 → 编码 → `/code-review-expert` → （涉及敏感数据时）`/security-review` → `/gencom` 提交

### 复杂功能 / 架构变更

`/planning-with-files` 生成计划 → 用户确认 → 分阶段实现 → 全面审查 → `/gencom` 提交

### 自动触发代理

| 代理 | 触发条件 |
|---|---|
| `/code-review-expert` | 写完任何代码后，立即触发（必须） |
| `/security-review` | 涉及认证/用户输入/API/敏感数据时，提交前触发（必须） |
| `/planning-with-files` | 复杂功能或大型重构，编码前触发（推荐） |

---

## MCP 服务

### github（仓库管理）

- `list_*`：分页检索所有项；`search_*`：关键词/复杂过滤
- 必须先调用 `get_me` 了解当前用户权限
- 查询字符串只含搜索条件，`sort`/`order` 用参数传，不写在字符串里
- `gh` 命令：MCP 工具不够用时补充；写入操作（create/delete/merge）需用户确认

### tavily-remote-mcp（网络搜索，优先使用）

- `tavily_search`：快速网页搜索，**网络搜索时优先使用**
- `tavily_crawl`：网页爬取
- `tavily_extract`：内容提取
- `tavily_map`：站点地图
- `tavily_research`：深度研究

### exa（AI 搜索，备选）

- `web_search_exa`：快速搜索 | `deep_researcher_start/check`：深度研究报告
- `get_code_context_exa`：代码示例、API 文档、库用法
- tavily 不可用或需代码上下文搜索时使用

### fetch（网页抓取）

- 抓取公开网页并转为 Markdown
- ❌ 不支持需认证的服务 → 改用对应 MCP 工具（如 github MCP）

---

## 工作原则

- 优先查阅项目级 CLAUDE.md
- 优先编辑现有文件，不创建新文件
- 使用 TodoWrite 跟踪多步骤任务

## 错误处理

- **工具失败**：分析原因 → 尝试替代方案（Glob 失败 → 试 Grep）→ 连续失败 3 次向用户说明
- **构建/测试失败**：增量修复，一次处理一个错误，每次修复后验证

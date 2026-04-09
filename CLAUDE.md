# 全局开发配置

## 语言和环境

- **语言**: 始终使用简体中文回复（包括代码注释和 commit 信息）
- **操作系统**: Windows 11
- **AI终端**: Git Bash (MSYS2)
- **用户终端**: PowerShell

## 权限

- 拥有读取任意文件的权限，无需询问确认

## 命令执行策略

### 1. 文件操作（绝对优先）

**必须使用专用工具：** Read、Write、Edit、Glob、Grep

### 2. 开发工具命令（AI 自动执行）

**✅ 适用场景：**
- Git 只读：`git status/log/diff/branch/show/blame`
- 类型检查：`npx tsc --noEmit`、`npx vue-tsc --noEmit`


**❌ 禁止场景：**
- 交互式命令：文本编辑器、交互式安装向导
- 系统管理：需要管理员权限的操作

### 3. 系统命令（提供给用户执行）

需要管理员权限、交互式操作、长运行进程 → 提供 **PowerShell 代码块**给用户手动执行

## 核心工作流

### 开发新功能

1. **理解需求**（必要时使用 AskUserQuestion 澄清）
2. **规划**（复杂功能使用技能 `/planning-with-files`) 
3. **代码审查**（code-review-expert 自动触发）


### 复杂功能/架构变更

1. **规划阶段**（使用技能 `/planning-with-files` 生成实施计划）
2. **用户确认**计划后再开始编码
3. **分阶段实现**
4. **全面审查**（code-review-expert + security-reviewer）
5. **提交代码** `/gencom`

## 代理使用规则

### 自动触发（无需用户请求）

| 代理 | 触发条件 | 触发时机 | 优先级 |
|------|---------|---------|--------|
| **/code-review-expert** | 写完任何代码 | 立即 | 必须 |
| **/security-reviewer** | 涉及认证/用户输入/API/敏感数据 | 提交前 | 必须 |
| **/planning-with-files** | 复杂功能/大型重构 | 编码前 | 推荐 |

## 高频工具速查
### Skills（知识库）

| Skill  | 用途 |
| ---| --- |
| `/gencom`| 根据 Git diff 生成提交信息   |

## MCP 服务使用指南

### github（仓库管理）

**工具选择：**
- **list_*** 工具：分页检索所有项（issues、PRs、branches）
- **search_*** 工具：关键词查询、复杂过滤条件

**使用规范：**
- 必须先调用 `get_me` 了解当前用户权限
- 使用 `sort` 和 `order` 参数排序，不要在查询字符串中包含 `sort:` 语法
- 查询字符串只包含搜索条件（如 `org:google language:python`）

### exa（AI 搜索，优先用于获取最新信息）

**工具选择：**
- **web_search_exa**：快速搜索当前信息
- **deep_researcher_start + deep_researcher_check**：深度研究报告（15秒-2分钟）
- **get_code_context_exa**：查找代码示例、API 文档、库用法

**使用场景：**
- 获取 2025 年后的最新技术信息
- 查找最佳实践和代码示例
- 研究新框架/库的使用方法

### fetch（网页抓取）

**功能：** 抓取公开网页内容并转换为 Markdown

**限制：** ❌ 不支持需要认证的服务（Google Docs、Confluence、Jira、GitHub 私有仓库）

**替代方案：** 需要认证的服务使用对应的 MCP 工具（如 github MCP）

### chrome-devtools（浏览器自动化）

**功能：**
- 浏览器自动化测试
- 性能分析和 Core Web Vitals 测量
- 页面截图和快照
- 网络请求监控

## 工作原则

- 优先查阅项目级 CLAUDE.md
- 优先编辑现有文件，不创建新文件
- 使用 TodoWrite 跟踪多步骤任务

## 错误处理策略

### 工具调用失败

1. **分析错误消息**，理解失败原因
2. **尝试替代方案**（如 Glob 失败 → 尝试 Grep）
3. **重复失败 3 次** → 向用户说明情况并请求指导

### 构建/测试失败

1. **增量修复**（一次处理一个错误）
2. **每次修复后验证**，确保问题解决


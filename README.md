# skills

一个面向 Claude Code 的个人技能仓库，用于沉淀日常开发中高频复用的工作流与提示词。

> [!TIP]
> 这个仓库更偏向个人工作流沉淀：把常用的 skills、hooks、rules 和 MCP 配置示例整理在一起，方便持续复用与迭代。

## 使用环境

> [!IMPORTANT]
> 本仓库当前仅面向 **Windows + PowerShell** 环境使用。
>
> 原因是仓库中的部分脚本使用了 `.ps1`，因此在其他平台或纯 Bash 环境下可能无法直接工作。
>
> 当然，你也可以让 AI 帮你改成 `.sh` 文件。

## 当前包含的 skills

### 仓库内置

| Skill | 说明 |
| --- | --- |
| **add-anchor** | 为 Markdown 标题添加英文自定义锚点 `{#my-anchor}`，支持单文件或目录批量处理 |
| **add-frontmatter** | 为 Markdown 文件添加 Frontmatter（包含 title 和 description） |
| **code-review-expert** | 对当前代码变更进行结构化代码审查，重点关注 SOLID、架构、可删除代码与安全风险 |
| **find-skills** | 技能发现与安装助手，当用户询问"怎么实现 X""有没有相关的 skill"时自动触发 |
| **gencom** | 根据 Git diff 生成符合项目风格的提交信息 |
| **github-issue-creator** | 创建 GitHub Issue，支持 bug/feature 等多种类型，自动匹配仓库模板与标签 |
| **grill-me** | 持续追问用户关于计划或设计的各个方面，直到达成共识，逐条解决决策树中的每个分支 |
| **humanizer-zh** | 去除文本中的 AI 生成痕迹，使内容听起来更自然、更像人类书写 |
| **init-agents-md** | 扫描项目结构并初始化项目级 `AGENTS.md`（context file），适合新仓库快速上手 |
| **naming** | 根据中文描述生成简洁、自然的英文标识符（PascalCase） |
| **planning-with-files** | 使用文件化方式组织复杂任务的计划、发现与执行进度，支持会话恢复 |
| **pr-address-comments** | 处理 GitHub PR 上的 Review 评论，自动修复被指出的问题 |
| **pr-creator** | 创建符合仓库规范的 Pull Request，自动匹配模板与标准 |
| **skill-creator** | 创建、修改和优化 Claude Code skill，支持评估、基准测试与描述优化 |
| **skill-monitor** | 用 GitHub URL 持续监控远程仓库文件变更，不依赖 `npx skills` 安装 |

## 仓库结构

```text
skills/
├─ add-anchor/
├─ add-frontmatter/
├─ code-review-expert/
├─ find-skills/
├─ gencom/
├─ github-issue-creator/
├─ grill-me/
├─ humanizer-zh/
├─ init-agents-md/
├─ naming/
├─ planning-with-files/
├─ pr-address-comments/
├─ pr-creator/
├─ skill-creator/
├─ skill-monitor/
├─ CLAUDE.md
└─ mcp.json
```

## 目录说明

### 各 skill 目录

每个 skill 独立为一个目录，内含 `SKILL.md`（技能定义与使用指南）及相关资源文件。各 Agent 会自动扫描并加载这些 skill。

### `CLAUDE.md`

全局配置与规则文件，定义工具使用规则、编码原则、MCP 优先级等。

### `mcp.json`

MCP 服务配置示例，例如 `chrome-devtools`、`tavily-remote-mcp` 等服务端点或启动参数。

## 使用说明

将本仓库作为自己的 skills 集合维护即可。你可以根据自己的工作流：

- 直接复用已有 skills
- 在现有 skills 基础上继续调整
- 新增更适合自己项目的自定义 skills
- 结合 `CLAUDE.md`、`mcp.json` 等配置文件组织自己的 Claude Code 工作流

## License

本仓库采用 [LICENSE](LICENSE) 中声明的许可协议。
感谢 [LinuxDo 社区](https://linux.do/t/topic/1167907)

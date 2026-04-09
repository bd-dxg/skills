# skills

一个面向 Claude Code 的个人技能仓库，用于沉淀日常开发中高频复用的工作流与提示词。

> [!TIP]
> 这个仓库更偏向个人工作流沉淀：把常用的 skills、hooks、rules 和 MCP 配置示例整理在一起，方便持续复用与迭代。

## 使用环境

> [!IMPORTANT]
> 本仓库当前仅面向 **Windows + PowerShell** 环境使用。
>
> 原因是仓库中的部分 hook 脚本使用了 `.ps1`，因此在其他平台或纯 Bash 环境下可能无法直接工作。
>
> 当然，你也可以让 AI 帮你改成 `.sh` 文件。

## 当前包含的 skills

### 仓库内置

- **naming**：根据中文描述生成简洁、自然的英文文件名
- **gencom**：根据 Git diff 生成符合项目风格的提交信息
- **code-review-expert**：对当前代码变更进行结构化代码审查，重点关注 SOLID、架构、可删除代码与安全风险
- **planning-with-files**：使用文件化方式组织复杂任务的计划、发现与执行进度

### 插件安装（仅列名称，需自行安装）

> [!NOTE]
> 以下 skills 通过插件仓库安装。
> 
> 由于这些插件会不定期更新，本仓库只记录名称与用途说明，不直接维护其完整能力列表；实际使用前请自行安装并以插件仓库中的最新说明为准。

#### anthropic-agent-skills

- **claude-api**：用于 Claude API、Anthropic SDK 与 Agent SDK 相关开发，适合构建接入 Claude 的应用或代理。

#### claude-plugins-official

- **claude-code-setup**：用于 Claude Code 的初始化配置与基础环境设置。
- **claude-md-management**：用于管理和维护 `CLAUDE.md`，帮助整理项目或全局指令。
- **skill-creator**：用于创建新的 Claude Code skill，辅助生成所需结构与内容。
- **typescript-lsp**：提供 TypeScript 语言服务相关能力，便于处理类型信息、符号定位与代码理解。

#### hello2cc

- **hello2cc**：让第三方模型在 Claude Code 里尽量按 Opus 一样思考、运行、选工具和输出。仓库地址：<https://github.com/hellowind777/hello2cc>

#### vue-skills

- **vue-best-practices**：Vue 通用最佳实践，覆盖 Vue 3、Composition API、`<script setup>`、TypeScript 等推荐用法。
- **vue-debug-guides**：用于排查 Vue 运行时报错、警告、异步失败、SSR / hydration 等问题。
- **vue-options-api-best-practices**：聚焦 Vue Options API 的写法与约束，适合维护旧项目时参考。
- **vue-pinia-best-practices**：聚焦 Pinia 状态管理模式、响应式处理与 store 设计。
- **vue-router-best-practices**：聚焦 Vue Router 4 的路由设计、导航守卫、参数处理与组件协作。
- **vue-skills-bundle**：Vue 技能合集插件，统一提供多类 Vue 相关最佳实践能力。
- **vue-testing-best-practices**：用于 Vue 测试，涵盖 Vitest、Vue Test Utils、组件测试与 E2E 测试实践。

## 适用场景

适合以下场景使用：

- 日常开发中的命名、提交信息生成
- 提交前代码审查
- 复杂任务拆解与过程跟踪
- 将个人常用工作流沉淀为可复用 skill

## 仓库结构

```text
skills/
├─ skills/
│  ├─ naming/
│  ├─ gencom/
│  ├─ code-review-expert/
│  └─ planning-with-files/
├─ hooks/
├─ rules/
├─ mcp.json
└─ settings.json
```

## 目录说明

### `skills/`

核心 skills 目录，存放可被 Claude Code 调用的技能定义与相关资源。

### `hooks/`

存放自动化 hook 脚本，用于在特定时机执行预设动作，例如辅助检查、流程提示或工作流联动。

#### 当前包含的 hooks

- **vscode-notify.ps1**：Windows 系统下的 VSCode 通知脚本，当 Claude Code 需要用户交互时（如权限确认、问题回答等），通过 Windows Toast 通知提醒用户。

### `rules/`

存放规则文件，用于约束 Claude Code 的输出风格、代码规范与执行习惯。

### `settings.json`

Claude Code 的本地配置入口，用于注册 hooks、rules 以及其他个性化行为。

### `mcp.json`

用于存放 MCP 服务配置示例，例如 `chrome-devtools-mcp`、`exa`、`fetch` 等服务端点或启动参数。

> [!IMPORTANT]
> `mcp.json` 通常不是直接给仓库本身加载的，而是作为**示例配置**使用。
>
> 实际使用时，应将其中需要的 MCP 配置合并到用户本机的 `~/.claude.json` 中，再由 Claude Code 统一读取。

> [!WARNING]
> 如果某些 MCP 需要密钥、认证头或本地环境差异，建议在 `~/.claude.json` 中按自己的实际情况进行调整，不要直接照搬示例内容。

## Skills 来源说明

本仓库中的部分 skill 来自其他优秀仓库，在此注明出处并致谢：

- **code-review-expert** 参考/来源：<https://github.com/sanyuan0704/sanyuan-skills/tree/main/skills/code-review-expert>
- **planning-with-files** 参考/来源：<https://github.com/OthmanAdi/planning-with-files/tree/master/skills/planning-with-files>

> [!NOTE]
> 其余内容为本人基于自身使用习惯整理、编写或调整。

## 使用说明

将本仓库作为自己的 skills 集合维护即可。你可以根据自己的工作流：

- 直接复用已有 skills
- 在现有 skills 基础上继续调整
- 新增更适合自己项目的自定义 skills
- 结合 hooks、rules、mcp 配置与 settings.json 组织自己的 Claude Code 工作流

## License

本仓库采用 [LICENSE](LICENSE) 中声明的许可协议。

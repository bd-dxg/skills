# 代码风格规则

> 详细示例见 `~/.claude/docs/code-style-examples.md`

## 核心约束

- 使用 **ES6+** 语法，禁止 `var`，禁止 `class`（用工厂函数/闭包替代）
- 单个代码文件不超过 **300 行**，超出按功能拆分
- 代码注释使用**简体中文**

## JavaScript / TypeScript

- 变量：优先 `const`，必要时 `let`
- 函数：优先箭头函数，顶层工具函数可用具名函数声明
- 对象：使用简写、解构、可选链（`?.`）、空值合并（`??`）
- 模块：ES Module（`import/export`），禁止 CommonJS（配置文件除外）
- 异步：`async/await`，并发用 `Promise.allSettled`，禁止 `.then().catch()` 链式
- TypeScript：`interface` 描述对象结构，`type` 用于联合/交叉类型，禁止 `any`（用 `unknown` 替代）


## 命名规范

| 场景 | 风格 | 示例 |
|------|------|------|
| 变量/函数 | camelCase | `fetchUserList` |
| 常量 | UPPER_SNAKE_CASE | `MAX_RETRY_COUNT` |
| 组件文件 | PascalCase | `UserCard.vue` |
| 组合式函数 | camelCase + use 前缀 | `usePageTitle.ts` |
| 类型/接口 | PascalCase | `UserProfile` |
| CSS 类名 | kebab-case | `.user-card` |

## 格式规范

- 格式化：**oxfmt**，代码检查：**oxlint**
- 具体格式配置以项目 oxfmt/oxlint 配置文件为准

## 函数设计原则

- **单一职责**：每个函数只做一件事，函数名能完整描述其功能
- **抽象层次一致**：同一函数内代码颗粒度保持统一，细节逻辑提取为独立函数

## 注释规范

- 注释说明"为什么"，而非"是什么"
- 复杂函数写 JSDoc

## 禁止事项

- ❌ `var`
- ❌ `class`（包括继承）
- ❌ `any` 类型
- ❌ 裸 `console.log`（调试完需删除）
- ❌ 魔法数字（用具名常量）
- ❌ 超过 3 层嵌套（提取函数）
- ❌ 单文件超过 300 行

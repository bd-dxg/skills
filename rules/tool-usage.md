# 工具使用强制规则

## 核心原则

**绝对禁止使用 Bash 命令执行文件操作**，必须使用 Claude Code 专用工具。

## 工具映射表

| 操作类型 | 必须使用的工具 | 禁止的命令行 | 示例 |
|---------|--------------|-------------|------|
| **文件搜索** | `Glob` | `find`, `ls -R`, `dir /s` | `Glob({pattern: "**/*.ts"})` |
| **内容搜索** | `Grep` | `grep`, `rg`, `findstr` | `Grep({pattern: "functionName"})` |
| **读取文件** | `Read` | `cat`, `type`, `Get-Content` | `Read({file_path: "file.txt"})` |
| **写入文件** | `Write` | `echo >`, `Out-File`, `>` | `Write({file_path: "file.txt", content: "..."})` |
| **编辑文件** | `Edit` | `sed`, `awk`, `Replace` | `Edit({file_path: "file.txt", old_string: "old", new_string: "new"})` |

## 详细规则

### 1. 文件操作（绝对优先）

**必须使用专用工具：** Read、Write、Edit、Glob、Grep

**禁止场景：**
- ❌ `Bash("find . -name '*.ts'")`
- ❌ `Bash("grep -r 'functionName' .")`
- ❌ `Bash("cat file.txt")`
- ❌ `Bash("echo 'content' > file.txt")`

### 2. Git 操作（有限允许）

**允许的 Bash 命令（只读）：**
- ✅ `git status` - 查看状态
- ✅ `git log` - 查看提交历史
- ✅ `git diff` - 查看差异
- ✅ `git branch` - 查看分支
- ✅ `git show` - 查看提交详情
- ✅ `git blame` - 查看文件修改历史

**禁止的 Bash 命令（写操作）：**
- ❌ `git add` - 使用专用工具或用户手动执行
- ❌ `git commit` - 使用专用工具或用户手动执行
- ❌ `git push` - 用户手动执行
- ❌ `git reset` - 用户手动执行
- ❌ `git checkout` - 用户手动执行

### 3. 构建/测试命令（有限允许）

**允许的 Bash 命令：**
- ✅ `npx tsc --noEmit` - TypeScript 类型检查
- ✅ `npx vue-tsc --noEmit` - Vue + TypeScript 类型检查
- ✅ `npm run build` - 构建命令（需用户确认）
- ✅ `npm test` - 测试命令（需用户确认）

### 4. 系统命令（绝对禁止）

**禁止场景：**
- ❌ 文件系统操作：`rm`, `cp`, `mv`, `mkdir`
- ❌ 进程管理：`ps`, `kill`, `taskkill`
- ❌ 网络操作：`curl`, `wget`, `ping`
- ❌ 环境操作：`export`, `set`, `env`

## 执行策略

### 优先级顺序
1. **专用工具**（Read、Write、Edit、Glob、Grep）
2. **只读 Git 命令**（有限允许）
3. **构建/测试命令**（有限允许，需确认）
4. **用户手动执行**（复杂或危险操作）

### 验证机制
每次工具调用前必须自问：
1. 这个操作是否可以用专用工具完成？
2. 如果使用 Bash，是否属于允许的只读命令？
3. 是否需要用户确认？

## 违规处理

### 轻度违规（警告）
- 使用 `find` 代替 `Glob`
- 使用 `grep` 代替 `Grep`
- 使用 `cat` 代替 `Read`

**处理：** 立即纠正，重新使用专用工具

### 重度违规（严重错误）
- 使用 `rm -rf` 删除文件
- 使用 `git reset --hard` 重置代码
- 使用 `curl` 下载外部内容

**处理：** 立即停止，向用户报告错误，等待用户指导

## 示例

### 正确示例
```javascript
// 搜索 TypeScript 文件
Glob({pattern: "**/*.ts"})

// 搜索函数定义
Grep({pattern: "function\\s+\\w+"})

// 读取配置文件
Read({file_path: "package.json"})

// 检查 git 状态（允许）
Bash({command: "git status"})
```

### 错误示例
```javascript
// 错误：使用 find 命令
Bash({command: "find . -name '*.ts'"})

// 错误：使用 grep 命令
Bash({command: "grep -r 'functionName' ."})

// 错误：使用 cat 命令
Bash({command: "cat package.json"})

// 错误：危险操作
Bash({command: "rm -rf node_modules"})
```

## 记忆点

将此规则文件添加到 `~/.claude\CLAUDE.md` 的引用中，确保每次会话都能看到。

**核心记忆：**
- 文件操作 → 专用工具
- Git 只读 → 有限允许
- 危险操作 → 绝对禁止
- 不确定时 → 询问用户
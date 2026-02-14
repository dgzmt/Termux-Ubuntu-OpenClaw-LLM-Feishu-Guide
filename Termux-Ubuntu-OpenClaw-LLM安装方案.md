# Termux + Ubuntu + OpenClaw + 本地LLM + 飞书机器人 完整安装指南

> 🚀 将安卓手机变成低功耗、带屏幕和电池的微型 AI 服务器

---

## 📋 快速导航

| 目标 | 跳转章节 |
|------|----------|
| 快速了解整体流程 | [安装流程概览](#安装流程概览) |
| 检查设备是否满足要求 | [前置条件](#前置条件) |
| 安装 Termux 基础环境 | [第一步：Termux 安装与配置](#第一步termux-安装与配置) |
| 安装 Ubuntu 子系统 | [第二步：Ubuntu 子系统](#第二步ubuntu-子系统) |
| 部署 OpenClaw AI Agent | [第三步：OpenClaw 部署](#第三步openclaw-部署) |
| 运行本地大语言模型 | [第四步：本地 LLM 部署](#第四步本地-llm-部署) |
| 配置飞书机器人 | [第五步：飞书机器人配置](#第五步飞书机器人配置) |
| 遇到问题怎么办 | [故障排除](#故障排除) |
| 查看完整命令列表 | [附录：命令速查表](#附录命令速查表) |

---

## 安装流程概览

```
┌─────────────────────────────────────────────────────────────────┐
│                        安装流程图                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐      │
│  │ Step 1  │───▶│ Step 2  │───▶│ Step 3  │───▶│ Step 4  │      │
│  │ Termux  │    │ Ubuntu  │    │OpenClaw │    │   LLM   │      │
│  └─────────┘    └─────────┘    └─────────┘    └─────────┘      │
│      │              │              │              │            │
│      ▼              ▼              ▼              ▼            │
│  基础环境       Linux环境      AI Agent       本地AI          │
│  约10分钟       约15分钟       约20分钟       约30分钟         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

                    ┌───────────────────┐
                    │   Step 5: 飞书    │
                    │     机器人配置    │
                    │     约10分钟      │
                    └───────────────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │   集成 AI 到飞书   │
                    │   即时通讯平台    │
                    └───────────────────┘
```

---

## 前置条件

### 设备要求

| 项目 | 最低要求 | 推荐配置 |
|------|----------|----------|
| Android 版本 | Android 7.0+ | Android 11+ |
| 内存 (RAM) | 4GB | 8GB+ |
| 存储空间 | 8GB 可用 | 20GB+ 可用 |
| CPU 架构 | ARM64 | 骁龙 888+ / 天玑 9000+ |
| 电池 | - | 80% 以上电量 |

### 必要准备

- [ ] 手机已开启 **允许安装未知来源应用**
- [ ] 手机已关闭 **电池优化**（针对 Termux）
- [ ] 稳定的网络连接（建议 WiFi）
- [ ] 电脑（可选，用于 SSH 远程操作）
- [ ] 飞书账号并已创建飞书群组（用于配置机器人）

### ⚠️ 重要警告

> **不要从 Google Play Store 安装 Termux！**
> 
> Play Store 版本已停止更新，存在严重兼容性问题。请务必从 GitHub Releases 下载最新版本。

---

## 第一步：Termux 下载与安装

> **重要说明**：本节提供三种安装方式，请选择最适合您的方式。建议国内用户使用 **F-Droid** 或 **GitHub Releases** 方式，避免 Google Play 版本停止更新的问题。

---

### 1.1 方式一：通过 F-Droid 安装（推荐国内用户）

F-Droid 是一个知名的开源 Android 应用商店，提供最新版本的 Termux。

#### 步骤 1：访问 F-Droid 官网

在手机浏览器中访问：
```
https://f-droid.org/zh_Hans/packages/com.termux/
```

#### 步骤 2：下载 F-Droid 客户端

1. 访问 F-Droid 官网：https://f-droid.org/
2. 点击 **"下载 F-Droid"** 按钮
3. 下载 `F-Droid.apk` 文件
4. 安装 F-Droid 应用

#### 步骤 3：通过 F-Droid 安装 Termux

1. 打开已安装的 **F-Droid** 应用
2. 在搜索框中输入 **"Termux"**
3. 找到官方版本（开发者：Fredrik Fornwall）
4. 查看版本号，确保 ≥ 0.118.0
5. 点击 **"安装"** 按钮
6. 等待下载和安装完成

> 💡 **提示**：F-Droid 版本的优点
> - 版本更新及时
> - 无 Google 服务依赖
> - 完全开源免费
> - 适合国内网络环境

---

### 1.2 方式二：通过 GitHub Releases 安装（官方渠道）

GitHub 是 Termux 项目的官方代码仓库，提供最新版本的 APK 文件。

#### 步骤 1：访问 Termux GitHub Releases

在手机浏览器中访问：
```
https://github.com/termux/termux-app/releases
```

#### 步骤 2：选择合适的版本

| 文件名 | 说明 | 适用设备 |
|--------|------|----------|
| `termux-app_v0.119.0+apt-android-7-github-debug_arm64-v8a.apk` | 主程序（推荐） | 大多数现代手机 |
| `termux-app_v0.119.0+apt-android-7-github-debug_arm-v7a.apk` | 32位版本 | 旧款手机 |
| `termux-api-app_v0.119.0+apt-android-7-github-debug_arm64-v8a.apk` | API 组件（推荐安装） | 所有设备 |

#### 步骤 3：下载并安装

1. 点击适合您设备的 APK 文件进行下载
2. 下载完成后，点击打开
3. 如果系统提示"未知来源"，请：
   - 点击 **"设置"**
   - 开启 **"允许安装未知来源应用"**
4. 点击 **"安装"** 完成安装

> ⚠️ **注意事项**
> - 建议同时下载并安装 `termux-api` APK，它提供了控制手机硬件的能力
> - GitHub 在国内可能访问缓慢，建议使用代理或镜像

---

### 1.3 方式三：通过电脑下载后传输到手机

如果手机下载困难，可以在电脑上完成下载后传输到手机。

#### 步骤 1：在电脑上下载

1. 打开电脑浏览器
2. 访问 F-Droid 或 GitHub Releases
3. 下载以下文件：
   - `termux-app_xxx.apk`
   - `termux-api-app_xxx.apk`

#### 步骤 2：传输到手机

**方式 A：通过数据线传输**
```bash
# 连接手机和电脑
# 将 APK 文件复制到手机存储
```

**方式 B：通过网盘传输**
- 上传到百度网盘、阿里云盘等
- 在手机端下载

**方式 C：通过即时通讯软件传输**
- 微信、QQ 等发送文件
- 在手机端下载

#### 步骤 3：安装 APK

1. 在手机文件管理器中找到 APK 文件
2. 点击安装
3. 如果遇到安全提示：
   - 进入 **设置 → 安全**
   - 开启 **"允许安装未知来源应用"**
   - 或在提示框中点击 **"设置"** 并授权

---

### 1.4 安装 Termux-API（推荐）

Termux-API 是 Termux 的扩展包，提供了控制 Android 手机硬件的能力，如获取电池状态、使用相机、控制手电筒等。

#### 下载地址

**GitHub Releases**：
```
https://github.com/termux/termux-api/releases
```

选择文件名包含 `termux-api-app` 的 APK 文件下载并安装。

#### 功能说明

| 命令 | 功能 |
|------|------|
| `termux-battery-status` | 获取电池状态 |
| `termux-camera-photo` | 拍照 |
| `termux-clipboard-get` | 获取剪贴板 |
| `termux-clipboard-set` | 设置剪贴板 |
| `termux-contact-list` | 获取联系人 |
| `termux-sms-list` | 获取短信 |
| `termux-torch on/off` | 控制手电筒 |
| `termux-vibrate` | 控制震动 |
| `termux-location` | 获取位置 |
| `termux-notification` | 显示通知 |
| `termux-wake-lock` | 保持唤醒 |
| `termux-setup-storage` | 授权存储访问 |

---

### 1.5 初始配置

安装完成后，打开 Termux 并执行以下命令：

```bash
# 步骤1：更新软件包列表（首次运行必须执行）
pkg update && pkg upgrade -y
# 这个命令会更新所有已安装的软件包到最新版本
# 过程可能需要几分钟，请耐心等待

# 步骤2：授权存储访问
termux-setup-storage
# 在弹出的对话框中点击"允许"
# 这一步非常重要，否则无法访问手机存储

# 步骤3：更换国内源（加速下载）
pkg install termux-tools -y
termux-change-repo
# 在界面中选择：
# → Single mirror
# → 选择 Tsinghua (清华源)
```

---

### 1.6 安装基础工具

```bash
# 安装常用工具
pkg install openssh termux-auth vim git wget curl -y

# 安装 Python（用于运行脚本）
pkg install python -y

# 安装编译工具（用于编译软件）
pkg install build-essential -y
```

---

### 1.7 配置 SSH 服务（可选但推荐）

配置 SSH 后，可以使用电脑远程连接到手机进行操作。

```bash
# 启动 SSH 服务
sshd

# 设置 Termux 登录密码
passwd
# 输入两次密码（输入时不会显示，这是正常的）

# 查看当前用户名
whoami
# 通常显示为"u0_xxx"格式

# 查看手机 IP 地址
ifconfig
# 或使用：ip addr show
# 查找 wlan0 或 usb0 下的 IP 地址

# 查看 SSH 端口（默认 8022）
```

**在电脑上连接 SSH**：
```bash
# Windows PowerShell 或 CMD
ssh -p 8022 用户名@手机IP地址

# 示例
ssh -p 8022 u0_a123@192.168.1.100

# Linux/macOS 终端
ssh -p 8022 u0_a123@192.168.1.100
```

---

### ✅ 第一步完成检查

安装完成后，请确认以下项目：

- [ ] Termux 应用已成功安装并可正常打开
- [ ] 运行 `pkg update && pkg upgrade -y` 无报错
- [ ] 执行 `termux-setup-storage` 并已授权存储访问
- [ ] SSH 服务已启动（如果配置了）
- [ ] 可以从电脑通过 SSH 连接到手机（如果配置了）

---

## 第二步：Ubuntu 子系统

### 2.1 安装 proot-distro

```bash
# 安装 Linux 容器管理工具
pkg install proot-distro -y
```

### 2.2 安装 Ubuntu

```bash
# 查看可安装的系统列表
proot-distro list

# 安装 Ubuntu（约需 5-10 分钟）
proot-distro install ubuntu
```

### 2.3 进入 Ubuntu 环境

```bash
# 进入 Ubuntu
proot-distro login ubuntu

# 提示符会变化，表示已进入 Ubuntu 环境
```

### 2.4 Ubuntu 基础配置

```bash
# 更新软件源
apt update && apt upgrade -y

# 安装基础工具
apt install vim sudo git curl wget -y

# （可选）更换国内源加速
# 编辑 /etc/apt/sources.list，添加清华源
```

**清华源配置**（编辑 `/etc/apt/sources.list`）：
```
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
```

### 2.5 快捷方式设置

```bash
# 设置快捷命令 u 进入 Ubuntu
echo "alias u='proot-distro login ubuntu'" >> ~/.bashrc
source ~/.bashrc

# 之后只需输入 u 即可进入 Ubuntu
u
```

### ✅ 第二步完成检查

- [ ] `proot-distro login ubuntu` 成功进入
- [ ] 提示符显示 Ubuntu 环境
- [ ] `apt update` 执行成功

---

## 第三步：OpenClaw 部署

### 方案选择

| 方案 | 优点 | 缺点 | 推荐场景 |
|------|------|------|----------|
| **方案 A：Termux 环境** | 安装简单，无需额外配置 | 兼容性稍差 | 快速体验 |
| **方案 B：Ubuntu 环境** | 完整 Linux 环境，兼容性好 | 需要额外配置 Node.js | 推荐，功能完整 |

---

### 方案 A：在 Termux 环境安装

#### A.1 安装依赖

```bash
# 确保在 Termux 环境（非 Ubuntu）
# 如果在 Ubuntu 中，先退出
exit

# 安装 Node.js 和编译工具
pkg install nodejs-lts python make build-essential git -y
```

#### A.2 安装 OpenClaw

```bash
# 使用 npm 安装（约 15-25 分钟，手机会发热）
npm install -g openclaw@latest

# 如果遇到问题，使用详细日志模式
npm install -g openclaw --verbose --no-optional
```

#### A.3 验证安装

```bash
# 检查是否安装成功
openclaw --help
# 应显示版本号和帮助信息
```

#### A.4 初始化配置

```bash
# 重要：每次启动前必须执行
termux-chroot

# 运行初始化向导
openclaw onboard
# 按提示完成配置
```

---

### 方案 B：在 Ubuntu 环境安装（推荐）

#### B.1 进入 Ubuntu 环境

```bash
# 标准方式进入 Ubuntu
proot-distro login ubuntu

# 或使用快捷命令
u
```

#### B.2 安装 Node.js

**方式一：使用 NVM 安装（推荐）**

```bash
# 安装 NVM（Node Version Manager）
curl -o- https://gitee.com/RubyMetric/nvm-cn/raw/main/install.sh | bash

# 重新加载环境变量
source ~/.bashrc

# 安装 Node.js 22 版本
nvm install 22

# 验证安装
node -v
npm -v
```

**方式二：使用 NodeSource 安装**

```bash
# 安装 curl
apt update && apt install curl -y

# 添加 NodeSource 仓库（Node.js 22.x）
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -

# 安装 Node.js
apt install -y nodejs

# 验证安装
node -v
npm -v
```

#### B.3 安装 OpenClaw

**方式一：使用官方安装脚本（推荐）**

```bash
# 使用官方安装脚本
curl -fsSL https://clawd.bot/install.sh | bash

# 或使用新域名
curl -fsSL https://openclaw.ai/install.sh | bash
```

**方式二：使用 npm 安装**

```bash
# 全局安装
npm install -g openclaw@latest

# 或使用 pnpm（更快）
npm install -g pnpm
pnpm install -g openclaw
```

#### B.4 验证安装

```bash
# 检查版本
openclaw --version

# 查看帮助
openclaw --help
```

#### B.5 初始化配置

```bash
# 运行配置向导
openclaw onboard

# 按提示完成配置：
# 1. 接受风险提示（输入 yes）
# 2. 选择 Quick Start（快速开始）
# 3. 选择大语言模型供应商（OpenAI、通义千问、GLM 等）
# 4. 输入 API 密钥
# 5. 选择需要集成的通讯平台（可跳过）
```

#### B.6 启动服务

```bash
# 启动 Gateway
openclaw gateway start

# 查看状态
openclaw gateway status

# 查看监听端口
ss -ltnp | grep 18789
```

#### B.7 常用命令

```bash
# 基础命令
openclaw status              # 查看状态概览
openclaw health              # 健康检查
openclaw doctor              # 诊断和修复

# Gateway 管理
openclaw gateway start       # 启动
openclaw gateway stop        # 停止
openclaw gateway restart     # 重启
openclaw gateway status      # 查看状态

# 配置管理
openclaw configure           # 交互式配置
openclaw config get          # 查看完整配置
openclaw config set gateway.port 18789  # 设置端口

# 模型管理
openclaw models list         # 查看可用模型
openclaw models status       # 查看模型状态

# 日志查看
openclaw logs --follow       # 实时查看日志
openclaw logs --limit 100    # 查看最近100行
```

---

### 远程访问配置

**方式一：SSH 端口转发**
```bash
# 在电脑上执行
ssh -L 18789:127.0.0.1:18789 -p 8022 用户名@手机IP

# 然后在浏览器访问
# http://localhost:18789/chat?session=main
```

**方式二：局域网访问**
```bash
# 绑定到局域网地址
openclaw gateway --bind lan

# 或修改配置
openclaw config set gateway.bind 0.0.0.0
openclaw gateway restart
```

### ✅ 第三步完成检查

- [ ] `openclaw --version` 正常显示版本号
- [ ] `openclaw onboard` 配置完成
- [ ] `openclaw gateway status` 显示运行中
- [ ] 浏览器可访问聊天界面

---

## 第四步：本地 LLM 部署

### 方案选择

| 方案 | 优点 | 缺点 | 推荐场景 |
|------|------|------|----------|
| **Ollama** | 简单易用，模型丰富 | 需要编译 | 推荐，功能完整 |
| **llama.cpp** | 轻量，性能好 | 命令行操作 | 高级用户 |
| **PocketPal AI** | 图形界面，开箱即用 | 功能有限 | 快速体验 |

---

### 方案 A：Ollama（推荐）

#### A.1 安装编译工具

```bash
pkg install git cmake golang python -y
```

#### A.2 编译 Ollama

```bash
# 克隆源码
git clone --depth 1 https://github.com/ollama/ollama.git
cd ollama

# 编译（约 10-20 分钟）
go generate ./...
go build .
```

#### A.3 启动服务

```bash
# 启动 Ollama 服务
./ollama serve &

# 验证服务
# 浏览器访问 http://127.0.0.1:11434
# 应显示 "Ollama is running"
```

#### A.4 运行模型

```bash
# DeepSeek-R1 7B（约 4.7GB，推荐）
./ollama run deepseek-r1:7b

# 其他推荐模型
./ollama run qwen2.5:3b      # 通义千问 3B（更轻量）
./ollama run llama3.2:3b     # Llama 3B
./ollama run gemma2:9b       # Gemma 9B（需要更多内存）
```

---

### 方案 B：llama.cpp

```bash
# 安装
pkg install llama.cpp -y

# 下载模型（以 Qwen2.5-3B 为例）
# 从 HuggingFace 下载 GGUF 格式模型

# 运行推理
llama-cli -m 模型路径.gguf -p "你的问题"
```

---

### 方案 C：PocketPal AI（App）

直接安装 APK，无需 Termux，适合快速体验。

下载地址：[PocketPal AI GitHub](https://github.com/a-ghorbani/pocketpal-ai)

### ✅ 第四步完成检查

- [ ] LLM 服务启动成功
- [ ] 模型加载正常
- [ ] 可以进行对话

---

## 第五步：飞书机器人配置

### 5.1 飞书机器人概述

飞书机器人可以将 OpenClaw AI 接入即时通讯平台，实现以下功能：
- 在飞书群聊中与 AI 对话
- 接收监控报警和系统通知
- 实现自动化工作流

### 5.2 创建飞书自定义机器人

#### 步骤 1：进入群组设置

1. 打开飞书应用
2. 进入目标群组
3. 点击群组右上角的 **更多按钮**（三个点）
4. 点击 **设置**
5. 在右侧面板中选择 **群机器人**
6. 点击 **添加机器人**
7. 选择 **自定义机器人**
8. 设置机器人头像、名称和描述
9. 点击 **添加**
10. 获取 Webhook 地址并妥善保存

> ⚠️ **重要警告**：请妥善保存 Webhook 地址，不要公开分享，避免被恶意调用发送垃圾消息。

#### 步骤 2：获取 Webhook 地址

机器人创建成功后，会显示 Webhook 地址，格式如下：
```
https://open.feishu.cn/open-apis/bot/v2/hook/xxxxxxxxxxxxxxxxx
```

### 5.3 配置安全设置（推荐）

为防止 Webhook 地址泄露后被恶意使用，建议配置以下安全措施：

#### 方式一：设置自定义关键词

1. 在机器人详情页的 **安全设置** 区域
2. 选择 **自定义关键词**
3. 添加关键词（最多 10 个，使用回车分隔）
4. 点击 **保存**

**示例**：设置关键词为 `AI助手`、`项目更新`

**发送消息时必须包含至少一个关键词**，否则会返回错误：
```json
{
  "code": 19024,
  "msg": "Key Words Not Found"
}
```

#### 方式二：设置 IP 白名单

1. 在 **安全设置** 区域选择 **IP 白名单**
2. 添加 IP 地址或地址段（最多 10 个）
3. 支持格式：`123.12.1.*`、`123.1.1.1/24`
4. 点击 **保存**

**示例**：
```
192.168.1.100
10.0.0.0/24
```

#### 方式三：设置签名校验（最高安全级别）

1. 在 **安全设置** 区域选择 **签名校验**
2. 点击 **重置** 可更换秘钥
3. 点击 **复制** 保存秘钥
4. 点击 **保存**

### 5.4 发送消息到飞书

#### 方式一：使用 curl 发送文本消息

**Linux/macOS**：
```bash
curl -X POST -H "Content-Type: application/json" \
  -d '{"msg_type":"text","content":{"text":"Hello from OpenClaw!"}}' \
  https://open.feishu.cn/open-apis/bot/v2/hook/YOUR_WEBHOOK_ID
```

**Windows CMD**：
```cmd
curl -X POST -H "Content-Type: application/json" -d "{\"msg_type\":\"text\",\"content\":{\"text\":\"Hello from OpenClaw!\"}}" https://open.feishu.cn/open-apis/bot/v2/hook/YOUR_WEBHOOK_ID
```

**Windows PowerShell**：
```powershell
curl.exe -X POST -H "Content-Type: application/json" -d '{"msg_type":"text","content":{"text":"Hello from OpenClaw!"}}' https://open.feishu.cn/open-apis/bot/v2/hook/YOUR_WEBHOOK_ID
```

#### 方式二：发送富文本消息

```json
{
  "msg_type": "post",
  "content": {
    "post": {
      "zh_cn": {
        "title": "项目更新通知",
        "content": [
          [
            {"tag": "text", "text": "项目有更新: "},
            {"tag": "a", "text": "请查看", "href": "http://www.example.com/"},
            {"tag": "at", "user_id": "ou_xxx"}
          ]
        ]
      }
    }
  }
}
```

#### 方式三：@指定用户

```json
{
  "msg_type": "text",
  "content": {
    "text": "<at user_id=\"ou_xxx\">张三</at> 有新的消息"
  }
}
```

**@所有人**：
```json
{
  "msg_type": "text",
  "content": {
    "text": "<at user_id=\"all\">所有人</at> 请注意"
  }
}
```

### 5.5 在 Termux 中集成飞书通知

#### 创建飞书通知脚本

在 Termux 中创建脚本实现自动通知功能：

```bash
# 创建飞书通知脚本
cat > ~/feishu_notify.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

# 配置项
WEBHOOK_URL="YOUR_WEBHOOK_URL_HERE"
MESSAGE_TYPE="${1:-text}"
MESSAGE_CONTENT="${2:-测试消息}"

# 发送消息
curl -X POST \
  -H "Content-Type: application/json" \
  -d "{\"msg_type\":\"${MESSAGE_TYPE}\",\"content\":{\"text\":\"${MESSAGE_CONTENT}\"}}" \
  "${WEBHOOK_URL}"

echo " - 飞书消息已发送"
EOF

# 添加执行权限
chmod +x ~/feishu_notify.sh

# 添加到系统路径
echo 'export PATH="$HOME:$PATH"' >> ~/.bashrc
```

#### 使用方法

```bash
# 发送简单文本消息
~/feishu_notify.sh text "AI 服务已启动"

# 发送监控报警
~/feishu_notify.sh text "⚠️ 警告：CPU 使用率超过 90%"

# 发送任务完成通知
~/feishu_notify.sh text "✅ 模型下载完成：deepseek-r1:7b"
```

### 5.6 OpenClaw 集成飞书（进阶）

#### 创建飞书消息模块

```bash
# 在 Ubuntu 环境中
cd /usr/local/lib
cat > feishu-bot.js << 'EOF'
const axios = require('axios');

class FeishuBot {
  constructor(webhookUrl) {
    this.webhookUrl = webhookUrl;
  }

  async sendText(text) {
    return this.send('text', { text });
  }

  async sendRichText(title, content) {
    return this.send('post', {
      post: {
        zh_cn: {
          title,
          content: content.map(line => [
            ...line
          ])
        }
      }
    });
  }

  async send(msgType, content) {
    try {
      const response = await axios.post(this.webhookUrl, {
        msg_type: msgType,
        content
      });
      return response.data;
    } catch (error) {
      console.error('飞书消息发送失败:', error.message);
      throw error;
    }
  }
}

module.exports = FeishuBot;
EOF
```

#### 在 OpenClaw 中使用

```javascript
// 在 OpenClaw 插件中
const FeishuBot = require('/usr/local/lib/feishu-bot');

const bot = new FeishuBot('YOUR_WEBHOOK_URL');

// 发送 AI 响应到飞书
await bot.sendText(`AI 回复: ${response.message}`);
```

### 5.7 签名校验实现（高级）

如果启用了签名校验，需要计算签名：

**Python 实现**：
```python
import hashlib
import base64
import hmac
import time

def gen_sign(timestamp, secret):
    string_to_sign = f'{timestamp}\n{secret}'
    sign = base64.b64encode(
        hmac.new(
            string_to_sign.encode('utf-8'),
            digestmod=hashlib.sha256
        ).digest()
    ).decode('utf-8')
    return sign

# 使用
timestamp = int(time.time())
secret = 'YOUR_BOT_SECRET'
sign = gen_sign(timestamp, secret)

# 发送带签名的请求
data = {
    "timestamp": str(timestamp),
    "sign": sign,
    "msg_type": "text",
    "content": {"text": "Hello with signature"}
}
```

**JavaScript 实现**：
```javascript
const crypto = require('crypto');

function genSign(timestamp, secret) {
  const stringToSign = `${timestamp}\n${secret}`;
  const sign = crypto
    .createHmac('sha256', stringToSign)
    .update('')
    .digest('base64');
  return sign;
}

// 使用
const timestamp = Math.floor(Date.now() / 1000);
const sign = genSign(timestamp, 'YOUR_BOT_SECRET');

const data = {
  timestamp,
  sign,
  msg_type: 'text',
  content: { text: 'Hello with signature' }
};
```

### 5.8 常见问题排查

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| 消息发送失败（code 19024） | 关键词校验失败 | 检查消息内容是否包含设置的关键词 |
| 消息发送失败（code 19022） | IP 不在白名单 | 检查请求 IP 是否在白名单内 |
| 消息发送失败（code 19021） | 签名校验失败 | 检查时间戳和签名计算是否正确 |
| 消息发送失败（code 9499） | 请求体格式错误 | 检查 JSON 格式是否正确 |

### ✅ 第五步完成检查

- [ ] 飞书自定义机器人已创建
- [ ] Webhook 地址已获取并保存
- [ ] 安全设置已配置（推荐）
- [ ] 使用 curl 测试发送消息成功
- [ ] 集成脚本可正常工作

---

## 防止后台被杀

Android 系统会自动终止后台应用，需要以下设置：

### 必须设置

```
┌─────────────────────────────────────────────────────────────┐
│  设置路径                                                    │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. 电池优化豁免                                             │
│     设置 → 电池 → 应用电池管理 → Termux → 不限制             │
│                                                             │
│  2. 允许后台活动                                             │
│     设置 → 应用管理 → Termux → 电池 → 允许后台活动           │
│                                                             │
│  3. 锁定后台                                                 │
│     最近任务 → 找到 Termux → 下拉锁定                        │
│                                                             │
│  4. 唤醒锁                                                   │
│     下拉通知栏 → Termux 通知 → 点击 "Acquire wakelock"       │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 命令行设置

```bash
# 获取唤醒锁
termux-wake-lock

# 查看电池状态
termux-battery-status
```

---

## 故障排除

### 问题诊断流程

```
                    ┌─────────────┐
                    │  遇到问题   │
                    └──────┬──────┘
                           │
              ┌────────────┼────────────┐
              │            │            │
              ▼            ▼            ▼
        ┌──────────┐ ┌──────────┐ ┌──────────┐
        │ 闪退问题 │ │ 权限问题 │ │ 网络问题 │
        └────┬─────┘ └────┬─────┘ └────┬─────┘
             │            │            │
             ▼            ▼            ▼
        检查电池      重新授权      更换源
        优化设置      存储权限      或镜像
```

### 常见问题速查

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| Termux 闪退 | 后台被杀 | 设置电池优化豁免 |
| 无法访问存储 | 权限未授予 | 执行 `termux-setup-storage` |
| pkg update 失败 | 网络问题 | `termux-change-repo` 换源 |
| npm install 卡住 | 网络问题 | 换 npm 镜像源 |
| Ollama 编译失败 | 依赖缺失 | 安装完整编译工具链 |
| 模型加载慢 | 内存不足 | 使用更小的模型 |
| 手机发热严重 | 负载过高 | 降低模型参数量 |

### 详细解决方案

#### 问题 1：存储权限被拒绝

```bash
# 方案 A：重新授权
termux-setup-storage

# 方案 B：手动创建链接
ln -s /storage/emulated/0 ~/storage/shared

# 方案 C：系统设置授权
# 设置 → 应用 → Termux → 权限 → 存储 → 允许
```

#### 问题 2：npm 下载慢

```bash
# 更换淘宝镜像
npm config set registry https://registry.npmmirror.com

# 验证
npm config get registry
```

#### 问题 3：复制粘贴操作

在 Termux 中进行复制粘贴操作：

- **触屏操作**：长按屏幕，弹出菜单后选择 **COPY**（复制）或 **PASTE**（粘贴）
- **键盘快捷键**：
  - 复制：`Ctrl + C`（注意：在 Termux 中 `Ctrl + C` 默认是中断命令，需要长按屏幕选择复制）
  - 粘贴：`Ctrl + V`
- **更多选项**：点击 **More** 可以选择网址、分享命令脚本等功能

#### 问题 4：模型下载慢

```bash
# 使用 HuggingFace 镜像
export HF_ENDPOINT=https://hf-mirror.com

# 或手动下载后导入
ollama create mymodel -f Modelfile
```

#### 问题 5：Android 12+ 兼容性

```bash
# 检查系统信息
termux-info

# 查看权限状态
termux-info | grep -i storage

# ADB 授权（需要电脑）
adb shell pm grant com.termux android.permission.READ_EXTERNAL_STORAGE
```

#### 问题 6：飞书机器人发送失败

```bash
# 检查 Webhook 地址是否正确
echo "https://open.feishu.cn/open-apis/bot/v2/hook/YOUR_ID"

# 测试网络连通性
curl -X POST -H "Content-Type: application/json" \
  -d '{"msg_type":"text","content":{"text":"test"}}' \
  "https://open.feishu.cn/open-apis/bot/v2/hook/YOUR_ID"

# 查看详细错误信息
```

---

## 附录：命令速查表

### Termux 包管理

| 命令 | 说明 |
|------|------|
| `pkg update` | 更新软件包列表 |
| `pkg upgrade` | 升级已安装软件包 |
| `pkg install <包名>` | 安装软件包 |
| `pkg uninstall <包名>` | 卸载软件包 |
| `pkg search <关键字>` | 搜索软件包 |
| `pkg list-installed` | 列出已安装软件包 |

### proot-distro 命令

| 命令 | 说明 |
|------|------|
| `proot-distro list` | 列出可安装系统 |
| `proot-distro install <系统>` | 安装系统 |
| `proot-distro login <系统>` | 进入系统 |
| `proot-distro remove <系统>` | 删除系统 |

### Termux-API 命令

| 命令 | 说明 |
|------|------|
| `termux-battery-status` | 电池状态 |
| `termux-torch on/off` | 手电筒 |
| `termux-camera-photo <路径>` | 拍照 |
| `termux-clipboard-get/set` | 剪贴板 |
| `termux-location` | 位置信息 |
| `termux-wake-lock/unlock` | 唤醒锁 |
| `termux-vibrate -d <毫秒>` | 震动 |

### Ollama 命令

| 命令 | 说明 |
|------|------|
| `ollama serve` | 启动服务 |
| `ollama run <模型>` | 运行模型 |
| `ollama pull <模型>` | 下载模型 |
| `ollama list` | 列出已下载模型 |
| `ollama rm <模型>` | 删除模型 |

### OpenClaw 命令

| 命令 | 说明 |
|------|------|
| `openclaw --version` | 查看版本 |
| `openclaw onboard` | 初始化配置 |
| `openclaw gateway start` | 启动 Gateway |
| `openclaw gateway stop` | 停止 Gateway |
| `openclaw gateway status` | 查看状态 |
| `openclaw logs --follow` | 查看日志 |

### 飞书机器人命令

| 命令/操作 | 说明 |
|-----------|------|
| 添加机器人 | 群组设置 → 群机器人 → 添加机器人 → 自定义机器人 |
| 获取 Webhook | 机器人详情页显示的 URL |
| 测试消息 | `curl -X POST` 发送 JSON 请求 |
| 配置安全 | 机器人详情页 → 安全设置 |

---

## 系统架构图

```
┌─────────────────────────────────────────────────────────────┐
│                       手机 (Android)                         │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                    Termux                           │   │
│  │  ┌─────────┐  ┌─────────┐  ┌─────────────────────┐  │   │
│  │  │         │  │         │  │  Ubuntu (proot)     │  │   │
│  │  │ SSH     │  │ Termux  │  │  ┌───────────────┐  │  │   │
│  │  │ Server  │  │  API    │  │  │   OpenClaw    │  │  │   │
│  │  │ :8022   │  │         │  │  │   Gateway     │  │  │   │
│  │  └─────────┘  └─────────┘  │  │   :18789      │  │  │   │
│  │                            │  └───────────────┘  │  │   │
│  │                            │        ▲             │  │   │
│  │                            │        │             │  │   │
│  │                            │  ┌─────┴─────┐       │  │   │
│  │                            │  │  Node.js  │       │  │   │
│  │                            │  │  Runtime  │       │  │   │
│  │                            │  └──────────┘       │  │   │
│  │                            └─────────────────────┘  │   │
│  └─────────────────────────────────────────────────────┘   │
│                            │                              │
│              ┌─────────────┼─────────────┐                │
│              │             │             │                │
│              ▼             ▼             ▼                │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────────────┐   │
│  │   飞书      │ │   Ollama    │ │     Termux-API     │   │
│  │   机器人    │ │   本地LLM   │ │    硬件控制        │   │
│  │  Webhook   │ │  :11434     │ │                     │   │
│  └─────────────┘ └─────────────┘ └─────────────────────┘   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
                              │
                              │ HTTP / WebSocket
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                         外部访问                             │
│                                                             │
│  ┌─────────────────┐       ┌─────────────────────────────┐ │
│  │   飞书 APP      │       │     浏览器 (电脑/手机)       │ │
│  │   群聊对话      │       │   http://localhost:18789    │ │
│  └─────────────────┘       └─────────────────────────────┘ │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 参考资源

- [Termux 官方 GitHub](https://github.com/termux/termux-app)
- [Termux Wiki](https://wiki.termux.com/)
- [OpenClaw 官方文档](https://openclaw.ai)
- [Ollama 官方](https://ollama.ai)
- [proot-distro](https://github.com/termux/proot-distro)
- [飞书自定义机器人文档](https://open.feishu.cn/document/client-docs/bot-v3/add-custom-bot)
- [飞书开放平台 API](https://open.feishu.cn/document/client-docs/bot-v3/message)

---

> 📝 文档版本：v3.0 | 更新日期：2026-02-12
> 
> 本指南帮助您将旧手机变成低功耗、带屏幕和电池的微型 AI 服务器，并集成飞书即时通讯功能。

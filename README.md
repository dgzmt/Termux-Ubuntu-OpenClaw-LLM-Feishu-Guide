# Termux-OpenClaw-AI-Server

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Android](https://img.shields.io/badge/Android-7.0%2B-green)](https://developer.android.com/studio/releases/platforms)
[![Termux](https://img.shields.io/badge/Termux-0.119.0-blue)](https://github.com/termux/termux-app)

</div>

<div align="center">

🚀 将安卓手机变成低功耗、带屏幕和电池的微型 AI 服务器

</div>

---

## 目录

- [项目简介](#项目简介)
- [特性](#特性)
- [前置条件](#前置条件)
- [快速开始](#快速开始)
- [详细安装指南](#详细安装指南)
  - [第一步：安装 Termux](#第一步安装-termux)
  - [第二步：安装 Ubuntu 子系统](#第二步安装-ubuntu-子系统)
  - [第三步：部署 OpenClaw](#第三步部署-openclaw)
  - [第四步：部署本地 LLM](#第四步部署本地-llm)
  - [第五步：配置飞书机器人](#第五步配置飞书机器人)
- [高级配置](#高级配置)
  - [SSH 远程访问](#ssh-远程访问)
  - [后台运行](#后台运行)
  - [系统优化](#系统优化)
- [故障排除](#故障排除)
- [常见问题](#常见问题)
- [命令速查](#命令速查)
- [系统架构](#系统架构)
- [参考资料](#参考资料)
- [贡献](#贡献)
- [许可证](#许可证)

---

## 项目简介

本项目提供了一套完整的方案，帮助您将闲置的安卓手机转变为低功耗的 AI 服务器。通过在 Termux 环境中部署 Ubuntu 子系统、OpenClaw AI 代理和本地大语言模型，您可以：

- 在手机上运行完整的 Linux 环境
- 部署 OpenClaw AI 助手
- 本地运行大语言模型（如 DeepSeek、Qwen、Llama 等）
- 集成飞书机器人，实现即时通讯
- 利用手机的电池和屏幕，随时随地访问 AI 服务

## 特性

- **低功耗运行**：利用闲置手机的电池供电
- **完整 Linux 环境**：通过 proot-distro 运行 Ubuntu
- **AI 能力**：部署 OpenClaw 获得强大的 AI 代理能力
- **本地 LLM**：在设备上运行大语言模型，保护隐私
- **飞书集成**：将 AI 接入飞书即时通讯平台
- **远程访问**：通过 SSH 从电脑远程管理
- **开源免费**：所有组件均为开源软件

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

- [ ] 手机已开启「允许安装未知来源应用」
- [ ] 手机已关闭「电池优化」（针对 Termux）
- [ ] 稳定的网络连接（建议 WiFi）
- [ ] 电脑（可选，用于 SSH 远程操作）
- [ ] 飞书账号并已创建飞书群组（用于配置机器人）

> **重要警告**：不要从 Google Play Store 安装 Termux！Play Store 版本已停止更新，存在严重兼容性问题。请务必从 F-Droid 或 GitHub Releases 下载最新版本。

---

## 快速开始

如果您已经熟悉基本流程，可以使用以下快速命令完成安装：

```bash
# 1. 安装 Termux 后，执行初始化配置
pkg update && pkg upgrade -y
termux-setup-storage
termux-change-repo  # 选择清华源

# 2. 安装 Ubuntu 子系统
pkg install proot-distro -y
proot-distro install ubuntu

# 3. 进入 Ubuntu 并安装 OpenClaw
proot-distro login ubuntu
apt update && apt install -y curl
curl -fsSL https://openclaw.ai/install.sh | bash

# 4. 配置飞书机器人（可选）
# 参考「第五步：配置飞书机器人」章节
```

---

## 详细安装指南

### 第一步：安装 Termux

Termux 是本项目的基础环境，提供 Linux 终端模拟器功能。

#### 安装方式

##### 方式一：通过 F-Droid 安装（推荐国内用户）

F-Droid 是知名的开源 Android 应用商店，版本更新及时。

1. 访问 F-Droid 官网下载客户端：https://f-droid.org/
2. 安装 F-Droid 应用
3. 打开 F-Droid，搜索「Termux」
4. 找到官方版本（开发者：Fredrik Fornwall）
5. 点击「安装」

##### 方式二：通过 GitHub Releases 安装

GitHub 是 Termux 的官方代码仓库。

1. 访问：https://github.com/termux/termux-app/releases
2. 下载以下文件：
   - `termux-app_v0.119.0+apt-android-7-github-debug_arm64-v8a.apk`（主程序）
   - `termux-api-app_v0.119.0+apt-android-7-github-debug_arm64-v8a.apk`（API 组件）
3. 安装 APK 文件

##### 方式三：通过电脑下载后传输

如果手机下载困难，可以在电脑下载后传输到手机。

#### 初始配置

安装完成后，打开 Termux 执行以下命令：

```bash
# 更新软件包列表
pkg update && pkg upgrade -y

# 授权存储访问
termux-setup-storage

# 更换国内源加速
termux-change-repo
# 选择：Single mirror → Tsinghua (清华源)

# 安装基础工具
pkg install openssh git curl vim wget -y
```

#### 安装 Termux-API

Termux-API 提供了控制手机硬件的能力：

```bash
# 下载地址：https://github.com/termux/termux-api/releases
# 安装 termux-api-app_xxx.apk

# 可用命令
termux-battery-status  # 获取电池状态
termux-torch on/off    # 控制手电筒
termux-location       # 获取位置
termux-notification   # 显示通知
termux-wake-lock      # 保持唤醒
```

#### 验证安装

```bash
# 检查 Termux 版本
termux-info

# 确认存储授权
ls -la ~/storage/

# 测试网络
ping -c 3 baidu.com
```

---

### 第二步：安装 Ubuntu 子系统

在 Termux 中使用 proot-distro 安装完整的 Ubuntu 环境。

#### 安装 proot-distro

```bash
pkg install proot-distro -y
```

#### 安装 Ubuntu

```bash
# 查看可安装的系统
proot-distro list

# 安装 Ubuntu
proot-distro install ubuntu
```

#### 进入 Ubuntu 环境

```bash
# 进入 Ubuntu
proot-distro login ubuntu

# 提示符会从 $ 变为 root@localhost:~#
```

#### Ubuntu 基础配置

```bash
# 更新软件源
apt update && apt upgrade -y

# 安装基础工具
apt install -y vim sudo git curl wget

# 配置快捷命令（可选）
echo "alias u='proot-distro login ubuntu'" >> ~/.bashrc
source ~/.bashrc

# 之后输入 u 即可进入 Ubuntu
u
```

#### 更换国内源（可选）

编辑 `/etc/apt/sources.list`，替换为清华源：

```
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
```

---

### 第三步：部署 OpenClaw

OpenClaw 是一个功能强大的 AI 代理框架，支持多种 AI 模型的集成。

#### 方式一：在 Ubuntu 环境安装（推荐）

```bash
# 进入 Ubuntu
proot-distro login ubuntu

# 安装 Node.js 22.x
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt install -y nodejs

# 安装 OpenClaw
npm install -g openclaw@latest

# 验证安装
openclaw --version
```

#### 方式二：在 Termux 环境安装

```bash
# 确保在 Termux 环境（非 Ubuntu）
exit

# 安装 Node.js
pkg install nodejs-lts -y

# 安装 OpenClaw
npm install -g openclaw@latest
```

#### 初始化配置

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

#### 启动服务

```bash
# 启动 Gateway
openclaw gateway start

# 查看状态
openclaw gateway status

# 查看监听端口
ss -ltnp | grep 18789
```

#### 常用命令

```bash
# 服务管理
openclaw gateway start   # 启动
openclaw gateway stop    # 停止
openclaw gateway restart # 重启
openclaw gateway status  # 状态

# 日志查看
openclaw logs --follow   # 实时日志
openclaw logs --limit 100 # 最近100行

# 健康检查
openclaw health
openclaw doctor
```

#### 访问界面

- 本地访问：http://127.0.0.1:18789/chat
- 远程访问：参见「SSH 远程访问」章节

---

### 第四步：部署本地 LLM

在手机上运行本地大语言模型，保护数据隐私。

#### 方案选择

| 方案 | 优点 | 缺点 | 推荐场景 |
|------|------|------|----------|
| Ollama | 简单易用，模型丰富 | 需要编译 | 推荐，功能完整 |
| llama.cpp | 轻量，性能好 | 命令行操作 | 高级用户 |
| PocketPal AI | 图形界面，开箱即用 | 功能有限 | 快速体验 |

#### Ollama 部署（推荐）

```bash
# 安装编译工具
pkg install git cmake golang python -y

# 克隆源码
git clone --depth 1 https://github.com/ollama/ollama.git
cd ollama

# 编译
go generate ./...
go build .

# 启动服务
./ollama serve &

# 验证服务
curl http://127.0.0.1:11434
# 应返回：Ollama is running
```

#### 运行模型

```bash
# DeepSeek-R1 7B（约 4.7GB，推荐）
./ollama run deepseek-r1:7b

# 通义千问 3B（更轻量）
./ollama run qwen2.5:3b

# Llama 3B
./ollama run llama3.2:3b
```

#### llama.cpp 方案

```bash
# 安装
pkg install llama.cpp -y

# 下载 GGUF 格式模型

# 运行推理
llama-cli -m 模型路径.gguf -p "你的问题"
```

#### PocketPal AI 方案

直接安装 APK，无需 Termux：

- 下载地址：https://github.com/a-ghorbani/pocketpal-ai

---

### 第五步：配置飞书机器人

将 OpenClaw AI 接入飞书即时通讯平台。

#### 创建飞书自定义机器人

1. 打开飞书应用，进入目标群组
2. 点击群组右上角的「更多按钮」（三个点）
3. 点击「设置」→「群机器人」→「添加机器人」
4. 选择「自定义机器人」
5. 设置头像、名称和描述
6. 点击「添加」并获取 Webhook 地址

> ⚠️ 重要：请妥善保存 Webhook 地址，不要公开分享！

#### 发送消息测试

```bash
# 发送文本消息
curl -X POST -H "Content-Type: application/json" \
  -d '{"msg_type":"text","content":{"text":"Hello from OpenClaw!"}}' \
  "https://open.feishu.cn/open-apis/bot/v2/hook/YOUR_WEBHOOK_ID"
```

#### 发送富文本消息

```json
{
  "msg_type": "post",
  "content": {
    "post": {
      "zh_cn": {
        "title": "项目更新通知",
        "content": [
          [
            {"tag": "text", "text": "项目有更新："},
            {"tag": "a", "text": "点击查看", "href": "http://example.com/"},
            {"tag": "at", "user_id": "ou_xxx"}
          ]
        ]
      }
    }
  }
}
```

#### @用户

```json
{
  "msg_type": "text",
  "content": {
    "text": "<at user_id=\"ou_xxx\">张三</at> 有新的消息"
  }
}
```

#### @所有人

```json
{
  "msg_type": "text",
  "content": {
    "text": "<at user_id=\"all\">所有人</at> 请注意"
  }
}
```

#### 安全设置（推荐）

配置以下安全措施防止 Webhook 被恶意调用：

1. **自定义关键词**：设置消息必须包含的关键词
2. **IP 白名单**：限制可调用 Webhook 的 IP 地址
3. **签名校验**：启用签名验证（最高安全级别）

#### 创建通知脚本

```bash
# 创建飞书通知脚本 ~/feishu_notify.sh
#!/data/data/com.termux/files/usr/bin/bash

WEBHOOK_URL="YOUR_WEBHOOK_URL"
MESSAGE="${1:-测试消息}"

curl -X POST -H "Content-Type: application/json" \
  -d "{\"msg_type\":\"text\",\"content\":{\"text\":\"$MESSAGE\"}}" \
  "$WEBHOOK_URL"

echo " - 飞书消息已发送"

# 添加执行权限
chmod +x ~/feishu_notify.sh

# 使用
~/feishu_notify.sh "AI 服务已启动"
```

---

## 高级配置

### SSH 远程访问

通过 SSH 从电脑远程管理手机。

```bash
# 在 Termux 中
# 启动 SSH 服务
sshd

# 设置密码
passwd

# 查看用户名和 IP
whoami
ifconfig
```

**从电脑连接**：

```bash
# Windows/Linux/macOS
ssh -p 8022 u0_xxx@手机IP地址
```

### 后台运行

#### 使用 nohup

```bash
# 后台运行
nohup openclaw gateway start > /dev/null 2>&1 &

# 查看进程
ps aux | grep openclaw

# 停止进程
pkill -f openclaw
```

#### 使用 pm2（在 Ubuntu 中）

```bash
# 安装 pm2
npm install -g pm2

# 启动 OpenClaw
pm2 start openclaw --name "openclaw" -- gateway start

# 设置开机自启
pm2 startup
pm2 save
```

### 系统优化

#### 防止后台被杀

```
1. 电池优化豁免
   设置 → 电池 → 应用电池管理 → Termux → 不限制

2. 允许后台活动
   设置 → 应用管理 → Termux → 电池 → 允许后台活动

3. 锁定后台
   最近任务 → 找到 Termux → 下拉锁定

4. 获取唤醒锁
   termux-wake-lock
```

#### 内存优化

```bash
# 清理内存
termux-setup-storage
sync

# 查看内存使用
free -m
```

---

## 故障排除

### 问题诊断流程

```
遇到问题
    │
    ├── 闪退问题 → 检查电池优化设置
    │
    ├── 权限问题 → 重新授权存储访问
    │
    ├── 网络问题 → 更换国内源
    │
    └── 安装问题 → 检查依赖项
```

### 常见问题

#### Termux 闪退

- 原因：Android 后台管理终止
- 解决：设置电池优化豁免，获取唤醒锁

#### 无法访问存储

```bash
# 重新授权
termux-setup-storage

# 手动创建链接
ln -s /storage/emulated/0 ~/storage/shared
```

#### pkg update 失败

```bash
# 更换国内源
termux-change-repo
# 选择：Single mirror → Tsinghua (清华源)
```

#### npm install 卡住

```bash
# 更换淘宝镜像
npm config set registry https://registry.npmmirror.com
```

#### 模型加载慢

- 原因：内存不足
- 解决：使用更小的模型（如 qwen2.5:3b）

#### 飞书消息发送失败

```bash
# 检查 Webhook 地址
curl -X POST -H "Content-Type: application/json" \
  -d '{"msg_type":"text","content":{"text":"test"}}' \
  "YOUR_WEBHOOK_URL"
```

---

## 常见问题

### Q1：Google Play 的 Termux 可以用吗？

**不推荐**。Google Play 版本的 Termux 已停止更新，存在兼容性问题。请使用 F-Droid 或 GitHub Releases 版本。

### Q2：手机需要 Root 吗？

**不需要**。本方案所有组件都可以在未 Root 的手机上运行。

### Q3：安装需要多长时间？

| 步骤 | 时间 |
|------|------|
| Termux 安装与配置 | 约 10 分钟 |
| Ubuntu 子系统安装 | 约 15 分钟 |
| OpenClaw 部署 | 约 20 分钟 |
| 本地 LLM 部署 | 约 30 分钟（取决于模型大小） |

### Q4：手机会发热吗？

运行大语言模型时会产生较多热量。建议：
- 使用散热器
- 降低模型参数量
- 避免边充电边运行

### Q5：如何升级软件？

```bash
# Termux
pkg update && pkg upgrade -y

# Ubuntu
apt update && apt upgrade -y

# OpenClaw
npm update -g openclaw
```

### Q6：可以运行 Windows 吗？

Termux 本身是 Linux 环境，不能运行 Windows。但可以通过 Wine 在 Termux 中运行部分 Windows 程序。

---

## 命令速查

### Termux 命令

| 命令 | 说明 |
|------|------|
| `pkg update` | 更新软件包列表 |
| `pkg upgrade` | 升级软件包 |
| `pkg install <包名>` | 安装软件包 |
| `termux-setup-storage` | 授权存储访问 |
| `termux-change-repo` | 更换软件源 |
| `sshd` | 启动 SSH 服务 |
| `termux-wake-lock` | 获取唤醒锁 |

### proot-distro 命令

| 命令 | 说明 |
|------|------|
| `proot-distro list` | 列出可用系统 |
| `proot-distro install ubuntu` | 安装 Ubuntu |
| `proot-distro login ubuntu` | 进入 Ubuntu |
| `proot-distro remove ubuntu` | 删除 Ubuntu |

### OpenClaw 命令

| 命令 | 说明 |
|------|------|
| `openclaw --version` | 查看版本 |
| `openclaw onboard` | 初始化配置 |
| `openclaw gateway start` | 启动服务 |
| `openclaw gateway stop` | 停止服务 |
| `openclaw logs --follow` | 查看日志 |

### Ollama 命令

| 命令 | 说明 |
|------|------|
| `./ollama serve` | 启动服务 |
| `./ollama run <模型>` | 运行模型 |
| `./ollama pull <模型>` | 下载模型 |
| `./ollama list` | 列出模型 |

---

## 系统架构

```
┌─────────────────────────────────────────────────┐
│                  Android 手机                    │
│                                                 │
│  ┌─────────────────────────────────────────┐   │
│  │              Termux                       │   │
│  │  ┌──────────┐  ┌────────────────────┐   │   │
│  │  │ SSH      │  │ Ubuntu (proot)     │   │   │
│  │  │ :8022    │  │ ┌────────────────┐ │   │   │
│  │  └──────────┘  │ │ OpenClaw       │ │   │   │
│  │                 │ │ Gateway:18789  │ │   │   │
│  │                 │ └────────────────┘ │   │   │
│  │                 └────────────────────┘   │   │
│  └─────────────────────────────────────────┘   │
│              │                  │               │
│              ▼                  ▼               │
│  ┌──────────────┐   ┌────────────────────┐      │
│  │ 飞书机器人   │   │ Ollama 本地 LLM   │      │
│  │ Webhook     │   │ :11434            │      │
│  └──────────────┘   └────────────────────┘      │
└─────────────────────────────────────────────────┘
                      │
         ┌────────────┼────────────┐
         │            │            │
         ▼            ▼            ▼
   ┌─────────┐  ┌─────────┐  ┌─────────┐
   │ 飞书APP │  │ 浏览器  │  │ SSH终端  │
   └─────────┘  └─────────┘  └─────────┘
```

---

## 参考资料

- [Termux 官方 GitHub](https://github.com/termux/termux-app)
- [Termux Wiki](https://wiki.termux.com/)
- [OpenClaw 官方文档](https://openclaw.ai)
- [Ollama 官方](https://ollama.ai)
- [proot-distro](https://github.com/termux/proot-distro)
- [飞书自定义机器人文档](https://open.feishu.cn/document/client-docs/bot-v3/add-custom-bot)
- [F-Droid Termux 页面](https://f-droid.org/zh_Hans/packages/com.termux/)

---

## 贡献

欢迎提交 Issue 和 Pull Request！

1. Fork 本仓库
2. 创建分支：`git checkout -b feature/xxx`
3. 提交更改：`git commit -m 'Add xxx'`
4. 推送分支：`git push origin feature/xxx`
5. 提交 Pull Request

---

## 许可证

本项目采用 MIT 许可证。

---

<div align="center">

**如果本项目对您有帮助，请给一个 Star ⭐️**

</div>

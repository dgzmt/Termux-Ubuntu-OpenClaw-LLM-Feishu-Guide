# Termux-OpenClaw-AI-Server

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Android](https://img.shields.io/badge/Android-7.0%2B-green)](https://developer.android.com/studio/releases/platforms)
[![Termux](https://img.shields.io/badge/Termux-0.119.0-blue)](https://github.com/termux/termux-app)

</div>

<div align="center">

🚀 Transform your Android phone into a low-power AI server with screen and battery

[🇨🇳 简体中文](../zh/README.md) | 🇺🇸 English

</div>

---

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Requirements](#requirements)
- [Quick Start](#quick-start)
- [Installation Guide](#installation-guide)
  - [Step 1: Install Termux](#step-1-install-termux)
  - [Step 2: Install Ubuntu Subsystem](#step-2-install-ubuntu-subsystem)
  - [Step 3: Deploy OpenClaw](#step-3-deploy-openclaw)
  - [Step 4: Deploy Local LLM](#step-4-deploy-local-llm)
  - [Step 5: Configure Feishu Bot](#step-5-configure-feishu-bot)
- [Advanced Configuration](#advanced-configuration)
- [Troubleshooting](#troubleshooting)
- [FAQ](#faq)
- [Command Reference](#command-reference)
- [License](#license)

---

## Project Overview

This project provides a complete solution to transform your idle Android phone into a low-power AI server. By deploying Ubuntu subsystem, OpenClaw AI agent, and local LLM in the Termux environment, you can:

- Run a complete Linux environment on your phone
- Deploy OpenClaw AI assistant
- Run large language models locally (DeepSeek, Qwen, Llama, etc.)
- Integrate Feishu bot for instant messaging
- Access AI services anytime, anywhere using phone's battery and screen

## Features

- **Low Power Consumption**: Utilize phone's battery for power supply
- **Full Linux Environment**: Run Ubuntu via proot-distro
- **AI Capabilities**: Deploy OpenClaw for powerful AI agent capabilities
- **Local LLM**: Run LLMs on-device for privacy protection
- **Feishu Integration**: Connect AI to Feishu instant messaging platform
- **Remote Access**: Manage remotely via SSH from your computer
- **Open Source**: All components are open source software

## Requirements

### Device Requirements

| Item | Minimum | Recommended |
|------|---------|-------------|
| Android Version | Android 7.0+ | Android 11+ |
| RAM | 4GB | 8GB+ |
| Storage | 8GB free | 20GB+ free |
| CPU Architecture | ARM64 | Snapdragon 888+ / Dimensity 9000+ |
| Battery | - | 80%+ charge |

### Prerequisites

- [ ] Phone has "Allow installation from unknown sources" enabled
- [ ] Phone has "Battery optimization" disabled for Termux
- [ ] Stable network connection (WiFi recommended)
- [ ] Computer (optional, for SSH remote operation)
- [ ] Feishu account and group created (for bot configuration)

> **Important Warning**: Do NOT install Termux from Google Play Store! The Play Store version is outdated and has serious compatibility issues. Please download the latest version from F-Droid or GitHub Releases.

---

## Quick Start

If you're already familiar with the basic process, you can use these quick commands:

```bash
# 1. Install Termux and run initialization
pkg update && pkg upgrade -y
termux-setup-storage
termux-change-repo  # Select Tsinghua mirror

# 2. Install Ubuntu subsystem
pkg install proot-distro -y
proot-distro install ubuntu

# 3. Enter Ubuntu and install Node.js
proot-distro login ubuntu
apt update && apt install -y nodejs npm

# 4. Install OpenClaw
npm install -g @openclaw/cli

# 5. Fix Android Bionic compatibility (IMPORTANT!)
mkdir -p ~/.openclaw
cat > ~/.openclaw/bionic-bypass.js << 'EOF'
const os = require('os');
const originalNetworkInterfaces = os.networkInterfaces;
os.networkInterfaces = function() {
  try {
    const result = originalNetworkInterfaces.call(os);
    if (result && Object.keys(result).length > 0) return result;
  } catch (e) {
    console.warn('[Bionic Bypass] Intercepted error:', e.message);
  }
  return { lo: [{ address: '127.0.0.1', netmask: '255.0.0.0', family: 'IPv4', mac: '00:00:00:00:00:00', internal: true, cidr: '127.0.0.1/8' }] };
};
console.log('[Bionic Bypass] Patched');
EOF

echo 'export NODE_OPTIONS="--require /root/.openclaw/bionic-bypass.js"' >> ~/.bashrc
source ~/.bashrc

# 6. Start OpenClaw
openclaw gateway run
```

---

## Installation Guide

### Step 1: Install Termux

**Download from F-Droid (Recommended)**:
1. Visit https://f-droid.org/packages/com.termux/
2. Download and install the APK
3. Open Termux and wait for initialization

**Or download from GitHub**:
1. Visit https://github.com/termux/termux-app/releases
2. Download `termux-app_v0.119.0-beta.1+apt-android-7-github-debug_universal.apk`
3. Install and open

**Initial Configuration**:

```bash
# Update package list
pkg update && pkg upgrade -y

# Request storage permission
termux-setup-storage

# Switch to domestic mirror (recommended for China users)
termux-change-repo
# Select: Single mirror → Tsinghua University

# Install essential tools
pkg install -y git curl wget nano vim openssh

# Configure SSH (optional, for remote access)
passwd  # Set password
sshd    # Start SSH service
```

### Step 2: Install Ubuntu Subsystem

```bash
# Install proot-distro
pkg install proot-distro -y

# Install Ubuntu
proot-distro install ubuntu

# Enter Ubuntu
proot-distro login ubuntu

# Inside Ubuntu container:
# Update package list
apt update && apt upgrade -y

# Install essential tools
apt install -y curl wget git nano vim sudo

# Install Node.js
apt install -y nodejs npm

# Verify installation
node -v
npm -v
```

**Create quick alias** (optional):

```bash
# In Termux, add to ~/.bashrc
echo 'alias u="proot-distro login ubuntu"' >> ~/.bashrc
source ~/.bashrc

# Now you can enter Ubuntu with just: u
```

### Step 3: Deploy OpenClaw

```bash
# In Ubuntu container, install OpenClaw globally
npm install -g @openclaw/cli

# Verify installation
openclaw --version

# Fix Android Bionic compatibility (REQUIRED!)
mkdir -p ~/.openclaw
cat > ~/.openclaw/bionic-bypass.js << 'EOF'
const os = require('os');
const originalNetworkInterfaces = os.networkInterfaces;
os.networkInterfaces = function() {
  try {
    const result = originalNetworkInterfaces.call(os);
    if (result && Object.keys(result).length > 0) return result;
  } catch (e) {
    console.warn('[Bionic Bypass] Intercepted error:', e.message);
  }
  return { lo: [{ address: '127.0.0.1', netmask: '255.0.0.0', family: 'IPv4', mac: '00:00:00:00:00:00', internal: true, cidr: '127.0.0.1/8' }] };
};
const originalHostname = os.hostname;
os.hostname = function() {
  try { return originalHostname.call(os); } catch (e) { return 'localhost'; }
};
console.log('[Bionic Bypass] Patched');
EOF

echo 'export NODE_OPTIONS="--require /root/.openclaw/bionic-bypass.js"' >> ~/.bashrc
source ~/.bashrc

# Test the patch
node -e "console.log(require('os').networkInterfaces())"

# Start OpenClaw gateway
openclaw gateway run
```

**Success indicators**:
```
13:16:58 [gateway] listening on ws://127.0.0.1:18789
13:17:01 [feishu] feishu[default]: WebSocket client started
```

### Step 4: Deploy Local LLM

#### Option A: Ollama (Recommended)

```bash
# In Termux (not Ubuntu)
exit  # Exit Ubuntu if inside

# Install Ollama
pkg install ollama

# Start Ollama service
ollama serve &

# Pull a model (e.g., Qwen 2.5 7B)
ollama pull qwen2.5:7b

# Test the model
ollama run qwen2.5:7b
```

#### Option B: llama.cpp

```bash
# In Termux
pkg install llama-cpp

# Download model
mkdir -p ~/models
cd ~/models
wget https://huggingface.co/TheBloke/Llama-2-7B-Chat-GGUF/resolve/main/llama-2-7b-chat.Q4_K_M.gguf

# Run model
llama-cli -m llama-2-7b-chat.Q4_K_M.gguf -p "Hello, how are you?"
```

### Step 5: Configure Feishu Bot

#### Create Feishu Custom Bot

1. Open Feishu app, enter target group
2. Click "More" (three dots) in top right
3. Go to "Settings" → "Group Bots" → "Add Bot"
4. Select "Custom Bot"
5. Set avatar, name, and description
6. Click "Add" and save the Webhook URL

> ⚠️ **Important**: Keep the Webhook URL secure, don't share it publicly!

#### Test Message Sending

```bash
# Send text message
curl -X POST -H "Content-Type: application/json" \
  -d '{"msg_type":"text","content":{"text":"Hello from OpenClaw!"}}' \
  "https://open.feishu.cn/open-apis/bot/v2/hook/YOUR_WEBHOOK_ID"
```

---

## Advanced Configuration

### SSH Remote Access

```bash
# In Termux
# Start SSH service
sshd

# Set password
passwd

# View username and IP
whoami
ifconfig
```

**Connect from computer**:

```bash
# Windows/Linux/macOS
ssh -p 8022 u0_xxx@phone-ip-address
```

### Run in Background

```bash
# Using nohup
nohup openclaw gateway run > /dev/null 2>&1 &

# View process
ps aux | grep openclaw

# Stop process
pkill -f openclaw
```

### System Optimization

#### Prevent Background Kill

```
1. Battery optimization exemption
   Settings → Battery → App Battery Management → Termux → No restrictions

2. Allow background activity
   Settings → Apps → Termux → Battery → Allow background activity

3. Lock in recent tasks
   Recent tasks → Find Termux → Pull down to lock

4. Acquire wake lock
   termux-wake-lock
```

---

## Troubleshooting

### OpenClaw fails to start: uv_interface_addresses error

**Symptom**:
```
SystemError [ERR_SYSTEM_ERROR]: A system error occurred: 
uv_interface_addresses returned Unknown system error 13
```

**Cause**: Android Bionic kernel restriction, Node.js cannot get network interface info

**Solution**: Use Bionic Bypass patch (see Step 3)

### Termux crashes

- **Cause**: Android background management termination
- **Solution**: Set battery optimization exemption, acquire wake lock

### Cannot access storage

```bash
# Re-authorize
termux-setup-storage

# Manual link
ln -s /storage/emulated/0 ~/storage/shared
```

### pkg update fails

```bash
# Switch to domestic mirror
termux-change-repo
# Select: Single mirror → Tsinghua
```

### npm install hangs

```bash
# Switch to npm mirror
npm config set registry https://registry.npmmirror.com
```

---

## FAQ

### Q1: Can I use Termux from Google Play?

**Not recommended**. The Google Play version is outdated and has compatibility issues. Use F-Droid or GitHub Releases.

### Q2: Does my phone need Root?

**No**. All components can run on unrooted phones.

### Q3: How long does installation take?

| Step | Time |
|------|------|
| Termux setup | ~10 min |
| Ubuntu install | ~15 min |
| OpenClaw deploy | ~20 min |
| Local LLM deploy | ~30 min (depends on model size) |

### Q4: Will my phone overheat?

Running LLMs generates heat. Recommendations:
- Remove phone case for better cooling
- Use smaller models (e.g., qwen2.5:3b)
- Limit concurrent tasks
- Take breaks during heavy usage

---

## Command Reference

### Termux Commands

| Command | Description |
|---------|-------------|
| `pkg update` | Update package list |
| `pkg install <pkg>` | Install package |
| `termux-setup-storage` | Request storage permission |
| `sshd` | Start SSH service |
| `passwd` | Set password |
| `proot-distro login ubuntu` | Enter Ubuntu |

### Ubuntu Commands

| Command | Description |
|---------|-------------|
| `apt update` | Update package list |
| `apt install <pkg>` | Install package |
| `node -v` | Check Node.js version |
| `npm install -g <pkg>` | Global install |

### OpenClaw Commands

| Command | Description |
|---------|-------------|
| `openclaw --version` | Check version |
| `openclaw gateway run` | Run gateway (foreground) |
| `openclaw gateway status` | Check status |
| `openclaw config get` | View config |
| `openclaw config set <key> <value>` | Set config |

### Ollama Commands

| Command | Description |
|---------|-------------|
| `ollama serve` | Start service |
| `ollama pull <model>` | Download model |
| `ollama run <model>` | Run model |
| `ollama list` | List models |

---

## License

This project is licensed under the MIT License - see the [LICENSE](../../LICENSE) file for details.

---

<div align="center">

**⭐ Star this repository if you find it helpful!**

[🇨🇳 简体中文](../zh/README.md) | 🇺🇸 English

</div>

# Termux-OpenClaw-AI-Server

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Android](https://img.shields.io/badge/Android-7.0%2B-green)](https://developer.android.com/studio/releases/platforms)
[![Termux](https://img.shields.io/badge/Termux-0.119.0-blue)](https://github.com/termux/termux-app)

</div>

<div align="center">

🌐 **Choose Your Language / 选择语言**

[🇺🇸 English](docs/en/README.md) | [🇨🇳 简体中文](docs/zh/README.md)

</div>

---

<div align="center">

🚀 Transform your Android phone into a low-power AI server with screen and battery

</div>

---

## Quick Links

- [English Documentation](docs/en/README.md) - Complete guide in English
- [中文文档](docs/zh/README.md) - 完整中文指南

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

## Language Selection

Please select your preferred language:

| Language | Link | Status |
|----------|------|--------|
| 🇺🇸 English | [docs/en/README.md](docs/en/README.md) | 📝 In Progress |
| 🇨🇳 简体中文 | [docs/zh/README.md](docs/zh/README.md) | ✅ Complete |

---

## Quick Start

For detailed installation instructions, please refer to the documentation in your preferred language:

- **English**: [docs/en/README.md](docs/en/README.md)
- **中文**: [docs/zh/README.md](docs/zh/README.md)

---

## Repository Structure

```
.
├── README.md                 # Main entry (language selection)
├── docs/
│   ├── en/
│   │   └── README.md        # English documentation
│   ├── zh/
│   │   └── README.md        # Chinese documentation
│   └── CONTRIBUTING.md      # Contribution guidelines
├── .gitignore
└── LICENSE
```

---

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](docs/CONTRIBUTING.md) for details.

### Translation Contributors Needed

We need help translating this guide to other languages:

- [ ] 🇯🇵 Japanese
- [ ] 🇰🇷 Korean
- [ ] 🇫🇷 French
- [ ] 🇩🇪 German
- [ ] 🇪🇸 Spanish
- [ ] 🇷🇺 Russian

If you'd like to contribute a translation, please:
1. Fork the repository
2. Create a new directory under `docs/` with your language code (e.g., `docs/ja/` for Japanese)
3. Translate the content
4. Submit a pull request

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- [Termux](https://termux.dev/) - Android terminal emulator and Linux environment
- [OpenClaw](https://openclaw.ai/) - AI agent platform
- [Ollama](https://ollama.ai/) - Local LLM deployment
- [proot-distro](https://github.com/termux/proot-distro) - Linux distribution installer for Termux

---

<div align="center">

**⭐ Star this repository if you find it helpful!**

</div>

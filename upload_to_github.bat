@echo off
chcp 65001 >nul
echo ============================================
echo  GitHub 上传脚本
echo  Termux-Ubuntu-OpenClaw-LLM-Feishu-Guide
echo ============================================
echo.

REM 检查是否在正确的目录
if not exist "README.md" (
    echo 错误：未找到 README.md 文件！
    echo 请将此脚本放在包含 README.md 的文件夹中运行。
    pause
    exit /b 1
)

echo 步骤 1: 初始化 Git 仓库
echo -------------------------------------------
git init
if %errorlevel% neq 0 (
    echo 错误：git init 失败
    pause
    exit /b 1
)
echo 完成！
echo.

echo 步骤 2: 配置用户信息
echo -------------------------------------------
set /p username="请输入您的GitHub用户名: "
set /p email="请输入您的GitHub邮箱: "

git config user.name "%username%"
git config user.email "%email%"
echo 完成！
echo.

echo 步骤 3: 添加远程仓库
echo -------------------------------------------
echo 远程仓库地址: https://github.com/%username%/Termux-Ubuntu-OpenClaw-LLM-Feishu-Guide.git
git remote add origin https://github.com/%username%/Termux-Ubuntu-OpenClaw-LLM-Feishu-Guide.git
echo 完成！
echo.

echo 步骤 4: 添加文件到暂存区
echo -------------------------------------------
git add .
echo 完成！
echo.

echo 步骤 5: 提交更改
echo -------------------------------------------
set /p commit_msg="请输入提交说明 (直接回车使用默认说明): "
if "%commit_msg%"=="" set commit_msg=Initial commit - Termux OpenClaw AI Server Guide

git commit -m "%commit_msg%"
if %errorlevel% neq 0 (
    echo 错误：git commit 失败
    pause
    exit /b 1
)
echo 完成！
echo.

echo 步骤 6: 推送到 GitHub
echo -------------------------------------------
echo.
echo 重要：如果这是您第一次使用 GitHub，需要先创建仓库！
echo.
echo 请先在浏览器中访问以下地址创建仓库：
echo https://github.com/new?name=Termux-Ubuntu-OpenClaw-LLM-Feishu-Guide
echo.
echo 创建仓库时请：
echo 1. 输入仓库名: Termux-Ubuntu-OpenClaw-LLM-Feishu-Guide
echo 2. 选择 "Public" (公开)
echo 3. 不要添加 README 文件（我们已经有了）
echo 4. 点击 "Create repository"
echo.
set /p ready="创建完成后按回车继续..."

echo.
echo 正在推送到 GitHub...
echo.
git branch -M main
git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo ============================================
    echo  推送失败！可能原因：
    echo  1. 仓库不存在 - 请先在 GitHub 上创建仓库
    echo  2. 权限不足 - 需要登录 GitHub
    echo  3. 网络问题 - 检查网络连接
    echo.
    echo 解决方法：
    echo 1. 在浏览器访问 https://github.com/new 创建仓库
    echo 2. 确保已登录 GitHub 账号
    echo 3. 重新运行此脚本
    echo ============================================
    pause
    exit /b 1
)

echo.
echo ============================================
echo  恭喜！上传成功！
echo ============================================
echo.
echo 您的项目已上传到：
echo https://github.com/%username%/Termux-Ubuntu-OpenClaw-LLM-Feishu-Guide
echo.
echo 下一步：
echo 1. 访问上面的链接查看您的项目
echo 2. 项目会自动显示 README.md 为项目说明
echo 3. 可以继续添加更多文件
echo.
echo 常用 Git 命令：
echo   git add .           - 添加所有更改
echo   git commit -m "说明" - 提交更改
echo   git push            - 推送到 GitHub
echo.
pause

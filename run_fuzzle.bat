@echo off
setlocal

:: Fuzzle App Runner Script for Windows
:: Usage: run_fuzzle.bat [command]

set APP_NAME=Fuzzle

echo 🧩 %APP_NAME% Flutter App Runner
echo ================================

:: Check if we're in the right directory
if not exist "pubspec.yaml" (
    echo ❌ Error: Not in a Flutter project directory
    echo Please run this script from the project root
    exit /b 1
)

:: Set default command
if "%1"=="" set "COMMAND=run"
if not "%1"=="" set "COMMAND=%1"

:: Process commands
if "%COMMAND%"=="run" goto run_default
if "%COMMAND%"=="windows" goto run_windows
if "%COMMAND%"=="web" goto run_web
if "%COMMAND%"=="android" goto run_android
if "%COMMAND%"=="clean" goto clean_rebuild
if "%COMMAND%"=="test" goto run_tests
if "%COMMAND%"=="analyze" goto analyze_code
if "%COMMAND%"=="deps" goto install_deps
if "%COMMAND%"=="help" goto show_help
if "%COMMAND%"=="-h" goto show_help
if "%COMMAND%"=="--help" goto show_help

echo ❌ Unknown command: %COMMAND%
echo.
goto show_help

:install_deps
echo 📦 Installing dependencies...
flutter pub get
goto end

:run_default
echo 📦 Installing dependencies...
flutter pub get
echo 🚀 Running %APP_NAME%...
echo Platform: Windows Desktop (auto-selected)
flutter run -d windows
goto end

:run_windows
echo 📦 Installing dependencies...
flutter pub get
echo 🚀 Running %APP_NAME%...
echo Platform: Windows Desktop
flutter run -d windows
goto end

:run_web
echo 📦 Installing dependencies...
flutter pub get
echo 🚀 Running %APP_NAME%...
echo Platform: Web Browser
flutter run -d chrome
goto end

:run_android
echo 📦 Installing dependencies...
flutter pub get
echo 🚀 Running %APP_NAME%...
echo Platform: Android Device
flutter run -d android
goto end

:clean_rebuild
echo 🧹 Cleaning project...
flutter clean
echo 📦 Installing dependencies...
flutter pub get
echo 🔄 Rebuilding...
echo 🚀 Running %APP_NAME%...
flutter run -d windows
goto end

:run_tests
echo 🧪 Running tests...
flutter test
goto end

:analyze_code
echo 🔍 Analyzing code...
flutter analyze
goto end

:show_help
echo Available commands:
echo   run           - Run the app (default)
echo   windows       - Run on Windows desktop
echo   web           - Run on web browser
echo   android       - Run on Android device
echo   clean         - Clean and rebuild
echo   test          - Run tests
echo   analyze       - Analyze code for issues
echo   deps          - Install dependencies only
echo   help          - Show this help message
echo.
echo Examples:
echo   run_fuzzle.bat
echo   run_fuzzle.bat windows
echo   run_fuzzle.bat clean
goto end

:end
echo ✅ Done! 
#!/bin/bash

# Fuzzle App Runner Script
# Usage: ./run_fuzzle.sh [command]

APP_NAME="Fuzzle"
PROJECT_DIR="$(pwd)"

echo "🧩 $APP_NAME Flutter App Runner"
echo "================================"

# Function to check if we're in the right directory
check_project() {
    if [ ! -f "pubspec.yaml" ]; then
        echo "❌ Error: Not in a Flutter project directory"
        echo "Please run this script from the project root"
        exit 1
    fi
}

# Function to install dependencies
install_deps() {
    echo "📦 Installing dependencies..."
    flutter pub get
}

# Function to run the app
run_app() {
    local platform=$1
    echo "🚀 Running $APP_NAME..."
    
    if [ -n "$platform" ]; then
        echo "Platform: $platform"
        flutter run -d "$platform"
    else
        # Auto-select platform (prioritize Linux desktop for this app)
        if flutter devices | grep -q "Linux"; then
            echo "Platform: Linux Desktop (auto-selected)"
            flutter run -d linux
        else
            echo "Platform: Auto-select"
            flutter run
        fi
    fi
}

# Function to clean and rebuild
clean_rebuild() {
    echo "🧹 Cleaning project..."
    flutter clean
    install_deps
    echo "🔄 Rebuilding..."
    run_app
}

# Function to run tests
run_tests() {
    echo "🧪 Running tests..."
    flutter test
}

# Function to check for issues
analyze_code() {
    echo "🔍 Analyzing code..."
    flutter analyze
}

# Function to show help
show_help() {
    echo "Available commands:"
    echo "  run           - Run the app (default)"
    echo "  linux         - Run on Linux desktop"
    echo "  web           - Run on web browser"
    echo "  android       - Run on Android device"
    echo "  clean         - Clean and rebuild"
    echo "  test          - Run tests"
    echo "  analyze       - Analyze code for issues"
    echo "  deps          - Install dependencies only"
    echo "  help          - Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./run_fuzzle.sh"
    echo "  ./run_fuzzle.sh linux"
    echo "  ./run_fuzzle.sh clean"
}

# Main script logic
check_project

case "${1:-run}" in
    "run")
        install_deps
        run_app
        ;;
    "linux")
        install_deps
        run_app "linux"
        ;;
    "web")
        install_deps
        run_app "chrome"
        ;;
    "android")
        install_deps
        run_app "android"
        ;;
    "clean")
        clean_rebuild
        ;;
    "test")
        run_tests
        ;;
    "analyze")
        analyze_code
        ;;
    "deps")
        install_deps
        ;;
    "help"|"-h"|"--help")
        show_help
        ;;
    *)
        echo "❌ Unknown command: $1"
        echo ""
        show_help
        exit 1
        ;;
esac

echo "✅ Done!" 
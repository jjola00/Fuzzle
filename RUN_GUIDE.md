# 🧩 Fuzzle App - Quick Run Guide

## **Quick Start**

### **Linux/macOS:**
```bash
# Make the script executable (first time only)
chmod +x run_fuzzle.sh

# Run the app (simplest way)
./run_fuzzle.sh

# Or just run directly on Linux desktop
./run_fuzzle.sh linux
```

### **Windows:**
```cmd
# Run the app (simplest way)
run_fuzzle.bat

# Or run directly on Windows desktop
run_fuzzle.bat windows
```

---

## **Available Commands**

| Command | Linux/macOS | Windows | Description |
|---------|-------------|---------|-------------|
| **Default** | `./run_fuzzle.sh` | `run_fuzzle.bat` | Install deps + run app |
| **Linux Desktop** | `./run_fuzzle.sh linux` | N/A | Run on Linux desktop |
| **Windows Desktop** | N/A | `run_fuzzle.bat windows` | Run on Windows desktop |
| **Web Browser** | `./run_fuzzle.sh web` | `run_fuzzle.bat web` | Run in browser |
| **Android Device** | `./run_fuzzle.sh android` | `run_fuzzle.bat android` | Run on Android |
| **Clean & Rebuild** | `./run_fuzzle.sh clean` | `run_fuzzle.bat clean` | Clean + rebuild |
| **Run Tests** | `./run_fuzzle.sh test` | `run_fuzzle.bat test` | Run all tests |
| **Code Analysis** | `./run_fuzzle.sh analyze` | `run_fuzzle.bat analyze` | Check for issues |
| **Dependencies Only** | `./run_fuzzle.sh deps` | `run_fuzzle.bat deps` | Install dependencies |
| **Help** | `./run_fuzzle.sh help` | `run_fuzzle.bat help` | Show all commands |

---

## **Manual Flutter Commands**

If you prefer to run Flutter commands manually:

```bash
# Install dependencies
flutter pub get

# Run app (auto-select platform)
flutter run

# Run on specific platform
flutter run -d linux        # Linux desktop
flutter run -d windows      # Windows desktop
flutter run -d chrome       # Web browser
flutter run -d android      # Android device

# Clean and rebuild
flutter clean && flutter pub get && flutter run

# Run tests
flutter test

# Check for issues
flutter analyze

# Check available devices
flutter devices
```

---

## **🎯 Recommended for Fuzzle**

Since Fuzzle is designed as a **desktop study app** with window management:

### **Linux:**
```bash
./run_fuzzle.sh linux
```

### **Windows:**
```cmd
run_fuzzle.bat windows
```

### **For Development/Testing:**
```bash
# Clean build when things go wrong
./run_fuzzle.sh clean

# Check for code issues
./run_fuzzle.sh analyze

# Run tests
./run_fuzzle.sh test
```

---

## **Troubleshooting**

### **Script Not Found:**
```bash
# Linux/macOS: Make sure you're in the project directory
cd /path/to/Fuzzle
./run_fuzzle.sh

# Windows: Make sure you're in the project directory
cd C:\path\to\Fuzzle
run_fuzzle.bat
```

### **Permission Denied (Linux/macOS):**
```bash
chmod +x run_fuzzle.sh
./run_fuzzle.sh
```

### **Flutter Not Found:**
```bash
# Make sure Flutter is installed and in PATH
flutter doctor
```

### **Build Issues:**
```bash
# Clean everything and rebuild
./run_fuzzle.sh clean
# or
run_fuzzle.bat clean
```

---

## **What the Scripts Do**

1. **Check** if you're in the right directory
2. **Install** dependencies automatically
3. **Run** the app on the best platform
4. **Show** helpful status messages
5. **Handle** common tasks (clean, test, analyze)

**Happy coding! 🚀** 
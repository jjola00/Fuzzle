# Fuzzle

Fuzzle is a focused study app built with Flutter, featuring study sessions, logs, device pairing (Bluetooth on mobile), and desktop-friendly window management.

## Features

- Cross‑platform: Web, Desktop, Mobile
- Clean routing with `go_router`
- State management using `provider`
- Bluetooth pairing (mobile) via `flutter_blue_plus`
- Desktop window controls with `window_manager`

## Screenshots

<div align="center">

<img src="lib/static/homePage.png" alt="Home" width="320"/>
<img src="lib/static/StudySessionPage.png" alt="Study Session" width="320"/>
<img src="lib/static/CanvaStudySessionPage.png" alt="Concept" width="320"/>
<img src="lib/static/loadingCat.png" alt="Loading" width="320"/>

</div>

## Run Locally

See the quick commands in `RUN_GUIDE.md`, for example:

```bash
flutter pub get
flutter run -d linux      # Linux desktop (recommended)
flutter run -d windows    # Windows desktop
flutter run -d android    # Android
```

> Note: This repository is showcased via README only; no live web deployment is maintained.

## Contributors

- Mony
- JJ
- Philippa

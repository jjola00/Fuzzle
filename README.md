# Fuzzle

Fuzzle is a focused study app built with Flutter, featuring study sessions, logs, device pairing (Bluetooth on mobile), and desktop-friendly window management.

## Live Demo

- Web (GitHub Pages): [Open Portfolio](https://YOUR_GH_USERNAME.github.io/YOUR_REPO_NAME/)

> Replace the URL above after enabling GitHub Pages.

## Features

- Cross‑platform: Web, Desktop, Mobile
- Clean routing with `go_router`
- State management using `provider`
- Bluetooth pairing (mobile) via `flutter_blue_plus`
- Desktop window controls with `window_manager`

## Run Locally

See the quick commands in `RUN_GUIDE.md`, for example:

```bash
flutter pub get
flutter run -d chrome  # Web
flutter run -d linux   # Linux desktop
```

## Deploy to GitHub Pages

This repo includes a workflow at `.github/workflows/gh-pages.yml`.

Steps:
1. Push to `main` or `master`.
2. In GitHub repo Settings → Pages, set Source to "Deploy from a branch", Branch: `gh-pages`.
3. Update the README demo URL to your Pages URL.

## Contributors

- Mony
- JJ
- Philippa

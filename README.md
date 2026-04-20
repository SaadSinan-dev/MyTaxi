# MyTaxi

A polished, production-quality Flutter ride-booking UI application featuring real-time GPS location, an interactive tile map, animated multi-screen navigation, and a complete passenger-side interface built on Material 3.

---

## Overview

MyTaxi is a passenger-facing mobile application that covers the full visual flow of a ride-booking experience. Starting from an animated splash screen, the user proceeds through login or sign-up, lands on a live map screen where GPS coordinates are resolved at runtime, selects a ride type, and navigates the rest of the app through an animated drawer. All screens — rides history, wallet, saved places, settings, and help — are fully implemented at the UI layer with realistic static data. Backend integration is structurally scaffolded but not yet connected.

---

## Features

- **Animated splash screen** with staggered fade/slide transitions for the icon, title, tagline, and pulsing loading dots; auto-navigates to Login after delay via a `FadeTransition` route transition
- **Login screen** with phone number + password form validation, show/hide password toggle, "Remember Me" checkbox, "Forgot Password?" button, and placeholder Google / Apple social login buttons
- **Sign-up screen** with full name, phone, password, and confirm-password fields; real-time inline validation including password-match check
- **Live GPS location** resolved at runtime via `geolocator` with runtime permission handling (request, denied, permanently denied) and a dedicated error view with a one-tap retry action
- **Map skeleton loader** — a `CustomPainter`-based animated screen that paints map-like tiles, a horizontal shimmer sweep, and faint road lines while GPS resolves; eliminates the black-screen flash entirely
- **Interactive map** powered by `flutter_map` with MapTiler Streets tiles, tile fade-in, an `onMapReady` callback for smooth reveal via `AnimatedOpacity`, and a location-pin marker at the user's position
- **Ride-type selector** — Economy, Comfort, XL — rendered as `AnimatedContainer` cards with price and ETA; selection state managed locally
- **Glassmorphism bottom panel** on the map screen using `BackdropFilter` blur with a frosted-glass card and "Confirm" booking button
- **Animated navigation drawer** with staggered per-tile entrance animations (`Interval`-based), press-scale haptic feedback, active-state highlighting, optional badge support per item, and a coordinated footer reveal
- **Rides screen** with a current-ride summary card and static ride-history list
- **Wallet screen** showing available balance, payment methods (Visa card + Cash), recent transaction list, and an "Add Funds" button
- **Saved Places screen** with Home, Work, Airport, and custom favourite entries, plus an "Add New Place" button
- **Settings screen** with user profile card, language preference, notifications toggle, Privacy & Security, About App, and functional logout that clears the navigation stack
- **Help & Support screen** with quick-help category tiles (Contact Support, Payment Issue, Driver Complaint, Lost Item) and a static FAQ list
- **Light and dark theme** — full Material 3 `ThemeData` definitions for both modes, switched via `ValueNotifier<ThemeMode>` without rebuilding the widget tree
- **Locale-aware typography** — `Almarai` font for Arabic, `RobotoCondensed` for English, resolved at startup from the app `Locale`
- **Floating custom app bar** — rounded, shadowed `CustomAppBar` implementing `PreferredSizeWidget`, supporting drawer toggle, back button, optional subtitle, action buttons with badge overlay, and haptic feedback

---

## Tech Stack

| Concern | Solution |
|---|---|
| Framework | Flutter / Dart |
| State management | `setState` + `ValueNotifier` |
| Navigation | Named routes via `MaterialApp.routes` |
| Maps | `flutter_map` + `latlong2` |
| Map tiles | MapTiler Streets API |
| GPS | `geolocator` |
| Animations | `AnimationController`, `CurvedAnimation`, `Interval`, `CustomPainter` |
| UI effects | `BackdropFilter` (blur / glassmorphism) |
| Fonts | RobotoCondensed (en), Almarai (ar) |
| Haptics | `HapticFeedback` (light, selection, medium) |

---

## Project Structure

```
lib/
├── main.dart                          # Entry point — initialises App with en_US locale
├── app.dart                           # MaterialApp, named routes, ValueListenableBuilder for theme
│
├── core/
│   ├── app_colors.dart                # Centralised colour palette (brand, status, taxi-specific)
│   ├── app_fonts.dart                 # Locale-aware font resolver (Arabic / English)
│   ├── constants.dart                 # App-wide constants (MapTiler API key)
│   └── theme/
│       ├── app_theme.dart             # Full light and dark ThemeData definitions (Material 3)
│       └── theme_controller.dart      # Global ValueNotifier<ThemeMode>
│
├── screens/
│   ├── splash_screen.dart             # Animated splash → Login (fade route transition)
│   ├── home_screen.dart               # Scaffold host: CustomAppBar + AppSideBar + LocationBody
│   ├── rides_screen.dart              # Current ride card + static ride history list
│   ├── wallet_screen.dart             # Balance, payment methods, transactions, Add Funds
│   ├── savedplaces_screen.dart        # Favourite destinations list + Add New Place
│   ├── settings_screen.dart           # Profile card, preferences, account options, logout
│   ├── help_screen.dart               # Quick-help tiles + static FAQ entries
│   └── location/
│       ├── body.dart                  # GPS fetch, skeleton loader, error view, ride selector, glass panel
│       └── map.dart                   # FlutterMap wrapper: placeholder → AnimatedOpacity reveal
│   └── login/
│       ├── login_screen.dart          # Phone/password form, social buttons, navigation to sign-up
│       └── signup_screen.dart         # Registration form with 4 fields and inline validation
│
└── widgets/
    ├── app_bar.dart                   # CustomAppBar — floating, rounded, with badge action support
    ├── bottom_bar.dart                # (empty stub — not yet implemented)
    └── sidebar/
        ├── app_sidebar.dart           # Drawer scaffold, navigation logic, animation controller
        ├── animated_drawer_tile.dart  # Per-tile staggered entrance + press-scale animation
        ├── sidebar_header.dart        # Avatar, name, phone, online indicator (animated)
        ├── sidebar_footer.dart        # Version label + logout press area (animated)
        ├── sidebar_components.dart    # SectionLabel, SideBarDivider, StatChip, CustomVerticalDivider
        └── sidebar_item_model.dart    # SideBarItem data model (icon, label, route, optional badge)
```

---

## Architecture

The project follows a **screen-first, component-extracted** layout. Each screen owns its local state via `StatefulWidget` and `setState`. Cross-cutting concerns (theme, colours, fonts, constants) are isolated in `core/`. Reusable UI components live in `widgets/`. The single piece of shared app state (theme mode) uses a `ValueNotifier` — no external state management library is introduced. This keeps the codebase approachable while leaving a clear upgrade path to Riverpod or BLoC when backend data flows are added.

---

## Screens & User Flow

```
SplashScreen  ──(auto, 10 s fade)──►  LoginScreen
                                           │
                                    ┌──────┴──────┐
                                 login()        /signup
                                    │               │
                               HomeScreen      SignUpScreen
                               (map + drawer)      │
                                    │           register()
                          ┌─────────┼──────────────┘
                  drawer  │         │
                 ┌────────┴──────┐  └───────────────────────────┐
              /rides          /wallet   /saved   /settings   /help
           RidesScreen    WalletScreen  ...         │
                                              logout() clears stack → /login
```

**HomeScreen** renders a full-screen `MapView` beneath a floating `CustomAppBar`. On mount, `LocationBody` calls `geolocator` to resolve device position. While waiting, `_MapSkeletonLoader` displays a `CustomPainter` map skeleton with a shimmer animation. Once the position is available, `FlutterMap` initialises at the user's coordinates; `onMapReady` triggers an `AnimatedOpacity` reveal. A glassmorphism bottom panel overlays the map with the ride-type selector and the Confirm button.

---

## Getting Started

### Prerequisites

- Flutter SDK ≥ 3.x  
- Dart ≥ 3.x  
- Android or iOS device / emulator with location services enabled

### Installation

```bash
git clone https://github.com/<your-username>/my_taxi.git
cd my_taxi
flutter pub get
flutter run
```

### Platform Permissions

**Android** — `android/app/src/main/AndroidManifest.xml`

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

**iOS** — `ios/Runner/Info.plist`

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>MyTaxi needs your location to show the map and find nearby rides.</string>
```

---

## Build Commands

```bash
# Android APK
flutter build apk --release

# Android App Bundle (Play Store)
flutter build appbundle --release

# iOS (requires macOS + Xcode)
flutter build ipa
```

---

## Key Dependencies

| Package | Purpose |
|---|---|
| `flutter_map` | Tile-based interactive map widget (OSM / MapTiler compatible) |
| `latlong2` | `LatLng` coordinate type required by `flutter_map` |
| `geolocator` | Runtime GPS access and permission management |

> **MapTiler API key** is stored in `lib/core/constants.dart`. Replace the value of `AppConstants.mapKey` with your own key from [maptiler.com](https://www.maptiler.com) before running or deploying.

---

## Code Quality Notes

- All private sub-widgets are decomposed into named `_PrivateClass` components, keeping `build` methods readable and focused.
- Every `AnimationController` is disposed in the corresponding `dispose()` override.
- All async methods guard against post-unmount state updates with `if (!mounted) return`.
- `CustomAppBar` correctly implements `PreferredSizeWidget` and is reusable across all screens.
- `_MapTilePainter.shouldRepaint` returns `false` when the shimmer value is unchanged, preventing unnecessary redraws.
- `_ShimmerBox` normalises the animation value range before clamping gradient stops, avoiding `assert` failures on edge values.
- Form validation is co-located with each field definition rather than in a separate validator file, keeping forms self-contained.

---

## Future Improvements

Based on the structure and scaffolding visible in the codebase:

- **Connect auth** — wire login and sign-up to a real backend (e.g. Firebase Auth or a REST API); the `Future.delayed` mock in both screens is the intended integration point.
- **Destination input** — `_LocationInputForm` in `body.dart` is an empty `Container` stub, ready for a pickup / drop-off address search flow.
- **Route display** — add a `PolylineLayer` to `MapView` once origin and destination are resolved.
- **Persist theme preference** — store the user's dark/light choice across sessions using `shared_preferences`.
- **Complete the bottom bar** — `lib/widgets/bottom_bar.dart` is an empty file stub.
- **Activate Arabic locale** — `AppFonts` and `AppTheme` already resolve Arabic font and locale; a language-switcher in Settings just needs to call `themeNotifier`'s equivalent for locale.
- **Introduce state management** — add Riverpod or BLoC as backend data flows (location stream, ride status, wallet balance) require reactive updates across screens.
- **Replace static data** — rides history, wallet transactions, and saved places are hardcoded; each screen is structured to accept a data list, making the API wiring straightforward.
# My Taxi — Flutter Ride-Hailing App (UI & Architecture Foundation)

A clean-architecture Flutter foundation for a ride-hailing application, built with Cubit-based state management, a fully tokenized design system, and a bilingual (Arabic/English) theming layer. This repository represents the architectural backbone of the app: navigation, theming, and the authentication flow, structured to scale into a complete production product.

---

## Why This Project Matters

Most portfolio Flutter apps stop at "a few screens that look nice." This one is built the way a real engineering team would start a production app: a dedicated `core` layer for cross-cutting concerns (theme, routing, design tokens, shared widgets), a `features` layer organized by domain, and a Cubit-driven state layer that keeps UI code free of business logic.

It demonstrates the discipline to set up an app correctly *before* writing screens — the kind of foundation that prevents a codebase from turning into spaghetti six months into a project.

---

## Key Features

Based strictly on what is implemented in the code:

- **Centralized Design System** — a single source of truth for colors (`AppColors`), spacing (`AppSpacing`), and typography (`AppFonts`), so every screen pulls from the same tokens instead of hardcoded values.
- **Light & Dark Theme Support** — fully defined `ThemeData` for both light and dark mode (`LightTheme`, `DarkTheme`), covering app bars, cards, buttons, and input fields, with runtime switching via a `ValueNotifier<ThemeMode>`.
- **Locale-Aware Typography** — automatic font-family switching between Arabic (`Almarai`) and English (`RobotoCondensed`) based on the active `Locale`, with helper methods to query font family and locale direction from any widget.
- **Cubit-Based Authentication Flow** — `LoginCubit` and `SignUpCubit` (from `flutter_bloc`) manage password visibility toggles, a "remember me" flag, and async submission states (`initial`, `loading`, `success`, `error`) with immutable, `copyWith`-driven state classes.
- **Animated Navigation Drawer** — a custom side bar (`AppSideBar`) with a staggered entrance animation built on a single `AnimationController`, including:
  - An animated user header with gradient background and slide/fade transitions
  - Section labels and a width-animated divider
  - Tappable, hapticfeedback-enabled tiles with active-state indicators
  - A dedicated, animated logout action in the footer
- **Custom Branded App Bar** — a reusable `CustomAppBar` with rounded container styling, a drawer toggle, and a notification bell with an unread-indicator dot.
- **Centralized Route Management** — all named routes declared in a single `AppRoutes` class, with `BlocProvider`-wrapped routes for screens that need Cubit access (login, sign-up).
- **Form Validation Ready** — the login screen is wired for `Form`/`GlobalKey<FormState>` validation and integrates with a validator layer for phone and password fields.
- **Domain-Driven Folder Scaffolding** — `entities`, `repositories`, and `usecases` directories are already structured under each feature, following Clean Architecture conventions, ready to be populated as business logic is implemented.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| State Management | `flutter_bloc` (Cubit pattern) |
| Architecture | Clean Architecture (presentation / domain layering) |
| Theming | Native `ThemeData`, `ColorScheme`, Material 3 (`useMaterial3: true`) |
| Localization | Locale-based font switching (Arabic / English) |
| Design System | Custom token classes (`AppColors`, `AppFonts`, `AppSpacing`) |

---

## Project Architecture

The project follows a **feature-first, layered Clean Architecture** approach:

```
core/        → Shared, app-wide concerns (theme, routing, design tokens, shared widgets)
features/    → Business domains, each split into:
  domain/        → entities, repositories, usecases (business rules — scaffolded)
  presentation/  → cubit (state) + screens (UI) + widgets
```

This separation keeps UI components dumb and reusable, business rules independent of Flutter, and state management predictable through unidirectional Cubit flows (`UI → Cubit → State → UI`).

---

## Folder & Code Structure

```
lib/
├── app.dart                          # Root widget: MaterialApp, theme & locale wiring
│
├── core/
│   ├── colors/app_colors.dart        # Brand, status, and domain-specific color tokens
│   ├── constants/app_constants.dart  # App-wide constants (e.g. map API key)
│   ├── fonts/app_fonts.dart          # Locale-aware font family resolution
│   ├── spacing/app_spacing.dart      # Standardized spacing scale (xs → xxl)
│   ├── routing/app_routes.dart       # Centralized named routes
│   ├── theme/
│   │   ├── app_theme.dart            # Theme entry point (light/dark dispatch)
│   │   ├── light_theme.dart          # Full light ThemeData definition
│   │   ├── dark_theme.dart           # Full dark ThemeData definition
│   │   └── theme_controller.dart     # Global ThemeMode notifier
│   └── widgets/
│       ├── appbar/app_bar.dart       # Reusable branded app bar
│       ├── bottombar/bottom_bar.dart # Reserved for bottom navigation (in progress)
│       └── sidebar/
│           ├── app_side_bar.dart           # Drawer composition & navigation logic
│           ├── models/side_bar_item_model.dart
│           └── widgets/
│               ├── animated_drawer_tile.dart
│               ├── side_bar_header.dart
│               ├── side_bar_footer.dart
│               └── side_bar_tile.dart      # Section labels & divider
│
└── features/
    └── auth/
        ├── domain/                   # entities / repositories / usecases (scaffolded)
        └── presentation/
            ├── cubit/
            │   ├── login/login_cubit.dart + login_state.dart
            │   └── signup/sign_up_cubit.dart + sign_up_state.dart
            └── screens/
                └── login/login_screen.dart
```

> **Note:** `app_routes.dart` references additional screens (home, rides, wallet, saved places, settings, help, splash, sign-up) that define the intended scope of the application. This repository snapshot includes the core architecture and the login flow; remaining feature screens are part of the active build-out.

---

## How It Works

1. **App Bootstrap** — `App` (in `app.dart`) is the root `StatelessWidget`. It listens to `themeNotifier` via `ValueListenableBuilder`, so toggling `ThemeMode` anywhere in the app instantly rebuilds the `MaterialApp` with the correct theme.
2. **Theme Resolution** — `AppTheme.light()` / `AppTheme.dark()` delegate to `LightTheme` and `DarkTheme`, which build complete `ThemeData` objects from the shared `AppColors` and `AppFonts` tokens — keeping every screen visually consistent without repeating style code.
3. **Routing** — `AppRoutes.routes` maps route names to builders. Routes that depend on a Cubit (login, sign-up) are wrapped in `BlocProvider` at the route level, so each screen receives a freshly-scoped Cubit instance.
4. **Authentication Flow** — `LoginScreen` reads `LoginCubit` via `context.read`, validates the form, and calls `cubit.login(...)`. The Cubit emits `loading`, then `success` or `error` through an immutable `LoginState`. A `BlocListener` reacts to state changes: navigating to `/home` on success, or showing a `SnackBar` on error. The same pattern is mirrored in `SignUpCubit` for registration.
5. **Navigation Drawer** — `AppSideBar` drives a single `AnimationController` that staggers the entrance of its header, section labels, divider, and tiles using `Interval`-based curves — giving the drawer a polished, sequenced reveal rather than a static pop-in.

---

## Installation & Setup

```bash
# 1. Clone the repository
git clone <repository-url>
cd my_taxi

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

**Requirements:**
- Flutter SDK (Material 3 enabled)
- `flutter_bloc` package for state management

> This snapshot does not include a `pubspec.yaml`. To run standalone, initialize a Flutter project (`flutter create my_taxi`) and add `flutter_bloc` to `pubspec.yaml` before copying this `lib/` directory in.

---

## Screenshots

> Screenshots to be added.

| Login Screen | Navigation Drawer | Dark Mode |
|---|---|---|
| _placeholder_ | _placeholder_ | _placeholder_ |

---

## Future Improvements

Logical next steps based on the current architecture:

- Implement the `domain` layer (entities, repositories, usecases) that is already scaffolded but currently empty, connecting the presentation Cubits to real data sources.
- Replace the simulated `Future.delayed` calls in `LoginCubit` and `SignUpCubit` with real authentication requests (e.g. REST/Firebase).
- Complete the `BottomBar` widget (currently an empty file) to support primary tab navigation.
- Build out the remaining screens already referenced in `AppRoutes` (home, rides, wallet, saved places, settings, help, splash, sign-up) to match the established design system.
- Add persistent theme storage (e.g. `shared_preferences`) so the user's light/dark preference survives app restarts.
- Introduce form validators (`AuthValidators`) and shared input/button widgets (`AuthTextField`, `SocialButton`) as first-class, tested components.

---

## Engineering Notes for Reviewers

This codebase reflects an engineering mindset focused on **structure before features**: a tokenized design system, locale-aware theming, Cubit-driven state isolation, and Clean Architecture folder conventions are all in place before a single business screen is finished. That ordering — architecture first, screens second — is what separates a maintainable production codebase from a prototype, and it is the standard this project was built to meet.

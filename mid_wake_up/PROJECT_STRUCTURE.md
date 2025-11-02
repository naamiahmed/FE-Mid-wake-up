# TravelSafe - Project Structure

## 📁 Folder Organization

```
lib/
├── main.dart                    # App entry point with Provider setup
├── models/                      # Data models
│   ├── user_model.dart         # User data model
│   ├── trip_model.dart         # Trip data model
│   └── settings_model.dart     # App settings model
├── services/                    # Business logic and data services
│   ├── auth_service.dart       # Authentication service
│   ├── trip_service.dart       # Trip management service
│   ├── permission_service.dart # Permission handling service
│   └── storage_service.dart    # Local storage service
├── viewmodels/                  # State management (MVVM pattern)
│   ├── auth_viewmodel.dart     # Authentication viewmodel
│   ├── trip_viewmodel.dart     # Trip management viewmodel
│   └── settings_viewmodel.dart # Settings viewmodel
├── views/                       # UI Screens
│   ├── splash_screen.dart      # Splash/loading screen
│   ├── permissions_screen.dart # Permissions request screen
│   ├── onboarding/             # Onboarding flow
│   │   ├── onboarding_page1.dart  # Smart Travel Assistant
│   │   ├── onboarding_page2.dart  # Wake-Up Alerts
│   │   └── onboarding_page3.dart  # Route Deviation Alerts
│   ├── auth/                    # Authentication screens
│   │   ├── login_screen.dart    # Login screen
│   │   └── create_account_screen.dart # Sign up screen
│   ├── home/                    # Main dashboard
│   │   └── home_screen.dart     # Home/Dashboard screen
│   ├── settings/                # Settings screens
│   │   └── settings_screen.dart # Settings/Features screen
│   └── trip/                    # Trip related screens
│       ├── active_trip_screen.dart    # Active trip tracking
│       ├── trip_completed_screen.dart # Trip completion screen
│       └── recent_trips_screen.dart   # Recent trips list
└── utils/                       # Utilities and constants
    ├── app_colors.dart         # Color constants
    ├── app_text_styles.dart    # Text style constants
    └── app_router.dart         # Navigation routing setup
```

## 🎯 Architecture Pattern

### MVVM (Model-View-ViewModel)
- **Models**: Data structures and business entities
- **Views**: UI screens and widgets
- **ViewModels**: State management using Provider
- **Services**: Business logic and data persistence

## 🔄 Navigation Flow

1. **Splash Screen** → Checks onboarding, permissions, auth status
2. **Onboarding** (if not completed) → 3 screens introducing features
3. **Permissions** (if not granted) → Request location, notifications, background
4. **Login/Create Account** (if not authenticated)
5. **Home Screen** → Main dashboard
6. **Active Trip** → Real-time trip tracking
7. **Trip Completed** → Trip summary and feedback
8. **Recent Trips** → List of past trips
9. **Settings** → App configuration

## 📦 Dependencies

- `provider` - State management
- `go_router` - Navigation routing
- `shared_preferences` - Local storage
- `permission_handler` - Permission management
- `flutter_svg` - SVG icon support

## ✨ Key Features Implemented

1. ✅ Splash screen with app branding
2. ✅ 3-page onboarding flow
3. ✅ Permissions request screen
4. ✅ Login and Sign Up screens
5. ✅ Home/Dashboard with guest mode
6. ✅ Settings/Features screen with toggles
7. ✅ Active trip tracking screen
8. ✅ Trip completed screen with feedback
9. ✅ Recent trips list screen
10. ✅ Proper navigation flow
11. ✅ State management with Provider
12. ✅ Local data persistence

## 🎨 Design System

- **Colors**: Defined in `app_colors.dart`
- **Text Styles**: Defined in `app_text_styles.dart`
- **Theme**: Consistent Material Design 3 theme
- **Components**: Reusable UI components throughout

## 🔧 Services

- **AuthService**: Handles user authentication
- **TripService**: Manages trip data and operations
- **PermissionService**: Handles app permissions
- **StorageService**: Local data persistence using SharedPreferences


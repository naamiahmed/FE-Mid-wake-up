import 'package:go_router/go_router.dart';
import '../views/splash_screen.dart';
import '../views/onboarding/onboarding_page1.dart';
import '../views/onboarding/onboarding_page2.dart';
import '../views/onboarding/onboarding_page3.dart';
import '../views/permissions_screen.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/create_account_screen.dart';
import '../views/home/home_screen.dart';
import '../views/settings/settings_screen.dart';
import '../views/trip/active_trip_screen.dart';
import '../views/trip/trip_completed_screen.dart';
import '../views/trip/recent_trips_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage1(),
      ),
      GoRoute(
        path: '/onboarding/page2',
        builder: (context, state) => const OnboardingPage2(),
      ),
      GoRoute(
        path: '/onboarding/page3',
        builder: (context, state) => const OnboardingPage3(),
      ),
      GoRoute(
        path: '/permissions',
        builder: (context, state) => const PermissionsScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/create-account',
        builder: (context, state) => const CreateAccountScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/active-trip',
        builder: (context, state) => const ActiveTripScreen(),
      ),
      GoRoute(
        path: '/trip-completed',
        builder: (context, state) => const TripCompletedScreen(),
      ),
      GoRoute(
        path: '/recent-trips',
        builder: (context, state) => const RecentTripsScreen(),
      ),
    ],
  );
}


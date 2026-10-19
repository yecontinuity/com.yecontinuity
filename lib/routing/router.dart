import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/config/providers/onboarding_provider.dart';
import 'package:yecontinuity/ui/core/ui/shell/app_shell.dart';
import 'package:yecontinuity/ui/feature/auth/login_screen.dart';
import 'package:yecontinuity/ui/feature/auth/models/auth_state.dart';
import 'package:yecontinuity/ui/feature/auth/providers/auth_provider.dart';
import 'package:yecontinuity/ui/feature/auth/register_screen.dart';
import 'package:yecontinuity/ui/feature/chats/chats_screen.dart';
import 'package:yecontinuity/ui/feature/onboardings/onboarding_screen.dart';
import 'package:yecontinuity/ui/feature/onboardings/splash_screen.dart';
import 'package:yecontinuity/ui/feature/onboardings/welcome_screen.dart';
import 'package:yecontinuity/ui/feature/products/products_screen.dart';
import 'package:yecontinuity/ui/feature/products/publish_screen.dart';
import 'package:yecontinuity/ui/feature/profile/profile_screen.dart';

part 'router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = _RouterRefresh(ref);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: const SplashRoute().location,
    refreshListenable: refresh,
    redirect: (context, state) => _redirect(ref, state),
    routes: $appRoutes,
  );
});

class _RouterRefresh extends ChangeNotifier {
  _RouterRefresh(Ref ref) {
    ref.listen(authProvider, (_, _) => notifyListeners());
    ref.listen(onboardingCompleteProvider, (_, _) => notifyListeners());
    ref.listen(splashDoneProvider, (_, _) => notifyListeners());
  }
}

String? _redirect(Ref ref, GoRouterState state) {
  final auth = ref.read(authProvider);
  final onboardingDone = ref.read(onboardingCompleteProvider);
  final location = state.matchedLocation;

  final splash = const SplashRoute().location;
  final onboarding = const OnboardingRoute().location;
  final welcome = const WelcomeRoute().location;

  // sem sessão.
  final entryLocations = {
    splash,
    onboarding,
    welcome,
    const LoginRoute().location,
    const RegisterRoute().location,
  };

  final splashDone = ref.read(splashDoneProvider).hasValue;
  if (!splashDone) {
    return location == splash ? null : splash;
  }

  if (auth is AuthStateAuthenticated) {
    return entryLocations.contains(location)
        ? const ProductRoute().location
        : null;
  }

  if (!onboardingDone) {
    return location == onboarding ? null : onboarding;
  }

  if (location == splash ||
      location == onboarding ||
      !entryLocations.contains(location)) {
    return welcome;
  }

  return null;
}

@TypedGoRoute<SplashRoute>(path: '/splash')
class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      _fade(state, const SplashScreen());
}

@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  const OnboardingRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      _fade(state, const _OnboardingPage());
}

class _OnboardingPage extends ConsumerWidget {
  const _OnboardingPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingScreen(
      onFinished: () =>
          ref.read(onboardingCompleteProvider.notifier).complete(),
    );
  }
}

@TypedGoRoute<WelcomeRoute>(path: '/welcome')
class WelcomeRoute extends GoRouteData with $WelcomeRoute {
  const WelcomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      _fade(state, const WelcomeScreen());
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LoginScreen();
}

@TypedGoRoute<RegisterRoute>(path: '/register')
class RegisterRoute extends GoRouteData with $RegisterRoute {
  const RegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RegisterScreen();
}

@TypedStatefulShellRoute<AppShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<ProductsBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ProductRoute>(path: '/'),
      ],
    ),
    TypedStatefulShellBranch<AddBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AddRoute>(path: '/publish'),
      ],
    ),
    TypedStatefulShellBranch<ChatsBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ChatsRoute>(path: '/chats'),
      ],
    ),
    TypedStatefulShellBranch<ProfileBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ProfileRoute>(path: '/profile'),
      ],
    ),
  ],
)
class AppShellRoute extends StatefulShellRouteData {
  const AppShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) => AppShell(navigationShell: navigationShell);
}

class ProductsBranch extends StatefulShellBranchData {
  const ProductsBranch();
}

class AddBranch extends StatefulShellBranchData {
  const AddBranch();
}

class ChatsBranch extends StatefulShellBranchData {
  const ChatsBranch();
}

class ProfileBranch extends StatefulShellBranchData {
  const ProfileBranch();
}

class ProductRoute extends GoRouteData with $ProductRoute {
  const ProductRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProductsScreen();
}

class AddRoute extends GoRouteData with $AddRoute {
  const AddRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PublishScreen();
}

class ChatsRoute extends GoRouteData with $ChatsRoute {
  const ChatsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => ChatsScreen();
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => ProfileScreen();
}

CustomTransitionPage<void> _fade(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (_, animation, _, child) => FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: child,
    ),
  );
}

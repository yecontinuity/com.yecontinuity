import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/main.dart';
import 'package:yecontinuity/ui/feature/auth/login_screen.dart';
import 'package:yecontinuity/ui/feature/auth/models/auth_state.dart';
import 'package:yecontinuity/ui/feature/auth/providers/auth_provider.dart';
import 'package:yecontinuity/ui/feature/chats/chats_screen.dart';

// routes that don't require authentication
final _publicRoutes = ['/login'];

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = _AuthChangeNotifier(ref);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final authState = ref.read(authProvider);

      final isPublicRoute = _publicRoutes.contains(state.matchedLocation);

      if (authState is AuthStateInitial) return null;

      if (authState is! AuthStateAuthenticated) {
        return isPublicRoute ? null : '/login';
      }

      if (isPublicRoute) return '/';

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => MainScreen(),
        // builder: (context, state) => ProductsScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/chats',
        builder: (context, state) => ChatsScreen(),
      ),
      // GoRoute(
      //   path: '/products',
      //   builder: (context, state) => ProductsScreen(),
      // ),
      // GoRoute(
      //   path: '/products/:id',
      //   builder: (context, state) =>
      //       ProductDetailScreen(productId: state.pathParameters['id']!),
      // ),
    ],
  );
});

class _AuthChangeNotifier extends ChangeNotifier {
  _AuthChangeNotifier(Ref ref) {
    ref.listen(authProvider, (previous, next) {
      notifyListeners();
    });
  }
}

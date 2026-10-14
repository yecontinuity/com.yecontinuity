class AppConstants {
  AppConstants._();

  static const String baseUrl = '';
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  static const String tokenKey = 'auth_token';
  static const String userIdKey = '';

  static const String loginRoute = '/login';
  static const String logoutRoute = '/logout';
  static const String productsRoute = '/products';
  static const String profileRoute = '/profile';
}

class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.yecontinuity.com';
  static const String products = '/api/products';

  static const String login = '/auth/login';

  static const Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}

class ApiServesConfig {
  static const String authLogin = 'api/auth/login';
  static const String authMy = 'auth/my';
  static const String authRegister = 'api/auth/register';
  static const String category = 'api/categories';
  static const String products = '/api/products/all';
  static const String Cart = '/api/cart';
  static String deleteCart(int productId) => '/api/cart/$productId';
  static String BaseUrl = 'https://electronics-store-api-ramg.onrender.com/';
}

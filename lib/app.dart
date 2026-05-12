import 'package:flutter/material.dart';
import 'Favorite_page/favorites_page.dart';
import 'SplashScreen.dart';
import 'app_routes.dart';
import 'auth/login_page.dart';
import 'bag_page/bag_screen.dart';
import 'bag_page/checkout_page.dart';
import 'bag_page/payment_methods_page.dart';
import 'bag_page/shipping_addresses_page.dart';
import 'bag_page/success_page.dart';
import 'screens/brand_filter_page.dart';
import 'screens/catalog_page.dart';
import 'screens/categories_page.dart';
import 'screens/filters_page.dart';
import 'screens/main_page.dart';
import 'screens/product_details_page.dart';
import 'screens/profile_page.dart';
import 'screens/rating_reviews_page.dart';
import 'screens/rating_reviews_with_photo_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const Splashscreen(),
        AppRoutes.login: (_) => const LoginPage(showBack: false),
        AppRoutes.categories: (_) => const CategoriesPage(),
        AppRoutes.filters: (_) => const FiltersPage(),
        AppRoutes.brandFilter: (_) => const BrandFilterPage(),
        AppRoutes.bag: (_) => const BagPage(),
        AppRoutes.checkout: (_) => const CheckoutPage(),
        AppRoutes.paymentMethods: (_) => const PaymentMethodsPage(),
        AppRoutes.shippingAddresses: (_) => const ShippingAddressesPage(),
        AppRoutes.favorites: (_) => const FavoritesPage(),
        AppRoutes.profile: (_) => const ProfilePage(),
        AppRoutes.success: (_) => const SuccessPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.main) {
          final index = settings.arguments is int
              ? settings.arguments as int
              : 0;
          return MaterialPageRoute(
            builder: (_) => MainPage(initialIndex: index),
          );
        }
        if (settings.name == AppRoutes.catalog) {
          final title = settings.arguments is String
              ? settings.arguments as String
              : "Women's tops";
          return MaterialPageRoute(builder: (_) => CatalogPage(title: title));
        }
        if (settings.name == AppRoutes.productDetails) {
          final product = settings.arguments is Map<String, dynamic>
              ? settings.arguments as Map<String, dynamic>
              : <String, dynamic>{};
          return MaterialPageRoute(
            builder: (_) => ProductDetailsPage(product: product),
          );
        }
        if (settings.name == AppRoutes.ratingReviews) {
          return MaterialPageRoute(builder: (_) => const RatingReviewsPage());
        }
        if (settings.name == AppRoutes.ratingReviewsWithPhoto) {
          return MaterialPageRoute(
            builder: (_) => const RatingReviewsWithPhotoPage(),
          );
        }
        return null;
      },
    );
  }
}

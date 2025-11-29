import 'package:deeplink_product/ProductDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'HomePage.dart';

void main() => runApp(const dl_Product());

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/product/:productID', builder: (context, state) {
      final productID = state.pathParameters['productID'] ?? 'Bilinmiyor';
      return ProductDetailPage(productid: int.parse(productID),);
    }),
  ],

);

class dl_Product extends StatelessWidget {
  const dl_Product({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

import 'dart:async';
import 'package:deeplink_product/ProductDetailPage.dart';
import 'package:deeplink_product/ProfileDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_links/app_links.dart';
import 'HomePage.dart';
import 'ProfilesPage.dart';
import 'ProductsPage.dart';

void main() => runApp(const dl_Product());

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(
      path: '/products',
      builder: (context, state) => const ProductsPage(),
      routes: [
        GoRoute(
          path: ':productID',
          builder: (context, state) {
            final productID = state.pathParameters['productID'] ?? 'Bilinmiyor';
            return ProductDetailPage(productid: int.parse(productID));
          },
        ),
      ],
    ),
    GoRoute(
      path: '/profiles',
      builder: (context, state) => const ProfilesPage(),
      routes: [
        GoRoute(
          path: ':userid',
          builder: (context, state) {
            final userid = state.pathParameters['userid'] ?? 'Bilinmiyor';
            return ProfileDetailPage(userid: int.parse(userid));
          },
        ),
      ],
    ),
  ],
);

class dl_Product extends StatefulWidget {
  const dl_Product({super.key});

  @override
  State<dl_Product> createState() => _dl_ProductState();
}

class _dl_ProductState extends State<dl_Product> {
  StreamSubscription<Uri>? _linkSubscription;

  Future<void> initDeepLinks() async {
    _linkSubscription = AppLinks().uriLinkStream.listen((uri) {
      debugPrint('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    context.go(uri.fragment);
  }

  @override
  void initState() {
    super.initState();
    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

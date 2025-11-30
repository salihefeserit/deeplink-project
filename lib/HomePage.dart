import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "E-TICARET UYGULAMASI",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => context.go('/products/'),
              label: Text('Ürünler'),
              icon: Icon(Icons.shopping_bag_outlined),
            ),
            ElevatedButton.icon(
              onPressed: () => context.go('/profiles/'),
              label: Text('Kullanıcılar'),
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}

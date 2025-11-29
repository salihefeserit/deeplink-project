import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'Products.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusGeometry.circular(12),
            color: Colors.indigo,
          ),
          child: Center(
            child: Text(
              "ÜRÜNLER",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => _ProductCard(prdct: products[index]),
        itemCount: products.length,
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product prdct;

  const _ProductCard({required this.prdct, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.go('/product/${prdct.id}');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black12,
        padding: EdgeInsets.symmetric(vertical: 10),
      ),
      child: Center(
        child: Text(
          prdct.name,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

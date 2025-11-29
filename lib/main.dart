import 'package:flutter/material.dart';
import 'Products.dart';

void main() => runApp(const dl_Product());

class dl_Product extends StatelessWidget {
  const dl_Product({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        body: ListView.builder(
            itemBuilder: (context, index) =>
                _ProductCard(prdct: products[index]),
            itemCount: products.length,
          ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product prdct;

  const _ProductCard({required this.prdct, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 2),
      color: Colors.indigoAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              prdct.name,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

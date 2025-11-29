import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetailPage extends StatelessWidget {
  final int productid;

  const ProductDetailPage({super.key, required this.productid});

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
              "ÜRÜN DETAY",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Ürün ID :", style: TextStyle(fontSize: 20)),
            Text(
              productid.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(height: 10,),
            ElevatedButton.icon(
              onPressed: () => context.go('/'),
              icon: Icon(Icons.keyboard_return_rounded),
              label: Text('Geri Don'),
            ),
          ],
        ),
      ),
    );
  }
}

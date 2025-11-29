import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class ProductDetailPage extends StatelessWidget {
  final int productid;
  const ProductDetailPage({super.key, required this.productid});

  Future<void> getApiVerisi() async {
    final url = Uri.parse("");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        final String name = data["name"];
        final String price = data["price"];
      }
      else {
        debugPrint("İstek başarısız oldu. Durum Kodu : ${response.statusCode}");
      }
    }
    catch (e) {
      debugPrint("Hata! : $e")
    }
  }

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
            Text(
              productid.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(),
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

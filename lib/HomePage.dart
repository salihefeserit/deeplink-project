import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'Products.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  late List<Product> products;

  Future<void> getApiVerisi() async {
    final url = Uri.parse(
      "https://fakestoreapi.com/products/",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          final List<dynamic> data = jsonDecode(response.body);
          products = data
              .map(
                (item) =>
                    Product(item["id"] as int, item["title"], item["price"]),
              )
              .toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        debugPrint("İstek başarısız oldu. Durum Kodu : ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint("Hata! : $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getApiVerisi();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading == true) {
      return const Center(child: CircularProgressIndicator());
    }

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
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: Text(
            prdct.name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

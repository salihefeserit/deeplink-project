import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'Product.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool _isLoading = true;
  late List<Product> products;

  Future<void> getApiVerisi() async {
    final url = Uri.parse("https://fakestoreapi.com/products/");

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
        title: Card(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "ÜRÜNLER",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) =>
            _ProductCard(prdct: products[index]),
        itemCount: products.length,
        padding: EdgeInsetsGeometry.only(left: 16, right: 16, bottom: 40, top: 10),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => context.go('/'), child: Icon(Icons.arrow_back_outlined),),
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
        context.go('/products/${prdct.id}');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: Text(
            prdct.title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

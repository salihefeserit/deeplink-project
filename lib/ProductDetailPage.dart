import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:deeplink_product/Product.dart';

class ProductDetailPage extends StatefulWidget {
  final int productid;
  const ProductDetailPage({super.key, required this.productid});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _isLoading = true;
  late Product takenProduct;

  Future<void> getApiVerisi() async {
    final url = Uri.parse(
      "https://fakestoreapi.com/products/${widget.productid.toString()}",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          final Map<String, dynamic> data = jsonDecode(response.body);
          takenProduct = Product(
            widget.productid,
            data["title"],
            data["price"],
          );
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
        automaticallyImplyLeading: false,
        title: Card(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "ÜRÜN DETAY",
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
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 250, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.productid.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Text(
                  takenProduct.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Text(
                "${takenProduct.price.toString()} \$",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/products'),
        child: Icon(Icons.keyboard_return_rounded),
      ),
    );
  }
}

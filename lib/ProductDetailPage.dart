import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:deeplink_product/Products.dart';

class ProductDetailPage extends StatefulWidget {
  final int productid;
  const ProductDetailPage({super.key, required this.productid});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _isLoading = true;
  Product takenProduct = Product(0, "", 0);

  Future<void> getApiVerisi() async {
    final url = Uri.parse("https://fakestoreapi.com/products/${widget.productid.toString()}");
    final url1 = Uri.parse("my-json-server.typicode.com/salihefeserit/fake-api/products/${widget.productid}");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          final Map<String, dynamic> data = jsonDecode(response.body);
          takenProduct = Product(widget.productid, data["title"], data["price"]);
          debugPrint("${takenProduct.name}, ${takenProduct.id}, ${takenProduct.price}");
          _isLoading = false;
        });
      }
      else {
        setState(() {
          _isLoading = false;
        });
        debugPrint("İstek başarısız oldu. Durum Kodu : ${response.statusCode}");
      }
    }
    catch (e) {
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
              widget.productid.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(takenProduct.name),
            Text(takenProduct.price.toString()),
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

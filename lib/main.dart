import 'package:flutter/material.dart';
import 'HomePage.dart';

void main() => runApp(const dl_Product());

class dl_Product extends StatelessWidget {
  const dl_Product({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      debugShowCheckedModeBanner: false,
      home: Placeholder()
    );
  }
}

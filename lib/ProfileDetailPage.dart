import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'User.dart';

class ProfileDetailPage extends StatefulWidget {
  final int userid;
  const ProfileDetailPage({required this.userid, super.key});

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  bool _isLoading = true;
  late User takenUsr;

  Future<void> getApiVerisi() async {
    final url = Uri.parse(
      "https://fakestoreapi.com/users/${widget.userid.toString()}",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          final Map<String, dynamic> data = jsonDecode(response.body);
          takenUsr = User(
            data["id"],
            data["email"],
            data["username"],
            data["password"],
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
        title: const Card(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "PROFİL DETAY",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 280, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                takenUsr.id.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Text(
                  takenUsr.email,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Text(
                takenUsr.username,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                takenUsr.password,
                style: const TextStyle(
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
        onPressed: () => context.go('/profiles'),
        child: const Icon(Icons.keyboard_return_rounded),
      ),
    );
  }
}

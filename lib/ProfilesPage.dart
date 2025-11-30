import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'User.dart';
import 'dart:convert';

class ProfilesPage extends StatefulWidget {
  const ProfilesPage({super.key});

  @override
  State<ProfilesPage> createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  bool _isLoading = true;
  late List<User> users;

  Future<void> getApiVerisi() async {
    final url = Uri.parse("https://fakestoreapi.com/users");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          final List<dynamic> data = jsonDecode(response.body);
          users = data
              .map(
                (item) => User(
                  item["id"] as int,
                  item["email"],
                  item["username"],
                  item["password"],
                ),
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
        title: const Card(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "KULLANICILAR",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => _UsersCard(usr: users[index]),
        itemCount: users.length,
        padding: const EdgeInsetsGeometry.only(left: 16, right: 16, bottom: 40, top: 10),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/'),
        child: const Icon(Icons.arrow_back_outlined),
      ),
    );
  }
}

class _UsersCard extends StatelessWidget {
  final User usr;
  const _UsersCard({required this.usr, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.go('/profiles/${usr.id}');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: Text(
            usr.username,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

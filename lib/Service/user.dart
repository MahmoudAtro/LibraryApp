import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mylibrary/layout/provider.dart';
import 'package:provider/provider.dart';

class Role {
  final int id;
  final String name;
  final String guardName;
  final DateTime createdAt;
  final DateTime updatedAt;
  Role({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      guardName: json['guard_name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class User {
  final String name;
  final String email;
  final String country;
  final String address;
  final String password;
  final String confirmPassword;
  User(
      {required this.name,
      required this.email,
      required this.country,
      required this.address,
      required this.password,
      required this.confirmPassword});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'country': country,
      'address': address,
      'password': password,
      'password_confirmation': confirmPassword
    };
  }
}

class LoginUser {
  final String email;
  final String password;
  LoginUser({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class Storeuser {
  final String name;
  final String email;
  final String country;
  final String address;
  final String img;
  Storeuser(
      {required this.name,
      required this.email,
      required this.country,
      required this.address,
      required this.img});
  factory Storeuser.fromJson(Map<String, dynamic> json) {
    return Storeuser(
      name: json['name'],
      email: json['email'],
      country: json['country'],
      address: json['address'],
      img: json['img'],
    );
  }
}

// ignore: must_be_immutable
class SendData extends StatelessWidget {
  SendData({super.key});

  // function to send user to backend and register into library
  Future<void> sendUser(BuildContext context, User user) async {
    // var provider = Provider.of<Model>(context);
    try {
      // here you can use http package to send data to backend
      final url = Uri.parse("http://127.0.0.1:8000/api/register");
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(user.toJson()));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Storeuser user = Storeuser.fromJson(data);
        var provider = Provider.of<Model>(context, listen: false);
        provider.user.add(user);
        provider.login(true);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('start', (route) => false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to register user')));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginData(context, LoginUser user) async {
    try {
      // here you can use http package to send data to backend //login
      final url = Uri.parse("http://127.0.0.1:8000/api/login");
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(user.toJson()));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        Storeuser user = Storeuser.fromJson(data);
        var provider = Provider.of<Model>(context, listen: false);
        provider.user.add(user);
        print(provider.user[0].name);
        provider.login(true);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('start', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('email or password does not exist')));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      // here you can use http package to send data to backend //login
      final url = Uri.parse("http://127.0.0.1:8000/api/logout");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        var provider = Provider.of<Model>(context, listen: false);
        provider.logout();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('start', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('email or password does not exist')));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendMessage(
      context, String name, String email, String message) async {
    try {
      // here you can use http package to send data to backend //login
      final url = Uri.parse("http://127.0.0.1:8000/api/contact");
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body:
              json.encode({"name": name, "email": email, "message": message}));
      var provider = Provider.of<Model>(context, listen: false);
      if (response.statusCode == 200) {
        provider.send(true);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("your message has been send successfuly")));
      } else {
        provider.send(true);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('faild to send')));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mylibrary/layout/provider.dart';
import 'package:provider/provider.dart';

class Book extends StatelessWidget {
  const Book({super.key});

  Future<void> allbooks(BuildContext context) async {
    try {
      final url = Uri.parse("http://127.0.0.1:8000/api/book");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var provider = Provider.of<Model>(context, listen: false);
        List<dynamic> data = jsonDecode(response.body);
        provider.allbooks(data);
      } else {
        print('Failed to load books');
      }
    } catch (e) {
      print(e);
    }
  }

  // return categorie from database
  Future<void> allCats(BuildContext context) async {
    try {
      final url = Uri.parse("http://127.0.0.1:8000/api/categorie");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var provider = Provider.of<Model>(context, listen: false);
        final data = jsonDecode(response.body);
        provider.allCats(data);
      } else {
        print('Failed to load books');
      }
    } catch (e) {
      print(e);
    }
  }

  // return categorie of part from database
  Future<List<dynamic>> showpart(BuildContext context, String cat) async {
    try {
      final url = Uri.parse("http://127.0.0.1:8000/api/show/$cat");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        return data;
      } else {
        print('Failed to load books');
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  // return categorie of part from database
  Future<void> downloadbook(BuildContext context, int id) async {
    try {
      final url = Uri.parse("http://127.0.0.1:8000/api/upload");
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'id': id,
          }));
      if (response.statusCode == 200) {
        print(response.body);
        print("upload file");
      } else {
        print('Failed to load books');
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

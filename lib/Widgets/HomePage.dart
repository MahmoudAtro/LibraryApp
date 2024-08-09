import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mylibrary/Widgets/categorie.dart';
import 'package:mylibrary/layout/pagelayout.dart';
import 'package:mylibrary/layout/productwidget.dart';
import 'package:mylibrary/layout/provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<dynamic> img() async {
    final image =
        await get(Uri.parse("http://127.0.0.1:8000/api/img/1710709078.jpg"));
    if (image.statusCode == 200) {
      dynamic data = jsonDecode(image.body);
      return data;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);
    return Pagelayout(
        title: "Book Page",
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "الأقسام",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 5, left: 50),
                width: double.infinity,
                height: 100,
                child: provider.islodaing
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Categorie(),
              ),
              Container(
                height: 1,
                color: Colors.blue[500],
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  height: 445,
                  child: provider.islodaing
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 300,
                                  mainAxisSpacing: 10),
                          itemCount: provider.books.length,
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            return Productwidget(products: provider.books[i]);
                          }))
            ],
          ),
        ));
  }
}



// "http://127.0.0.1:8000/api/img/${provider.books[i]["img"]}",
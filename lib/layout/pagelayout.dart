import 'package:flutter/material.dart';
import 'package:mylibrary/layout/drawer.dart';
import 'package:mylibrary/layout/productwidget.dart';
import 'package:mylibrary/layout/provider.dart';
import 'package:provider/provider.dart';

class Pagelayout extends StatefulWidget {
  const Pagelayout({super.key, required this.title, required this.body});
  final String title;
  final Widget body;

  @override
  State<Pagelayout> createState() => _PagelayoutState();
}

class _PagelayoutState extends State<Pagelayout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 1.0,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 60, 149, 63),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: searchdel());
              },
              icon: Icon(Icons.search))
        ],
      ),
      drawer: MyDrawer(),
      body: widget.body,
    ));
  }
}

class searchdel extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            Icons.close,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    var provider = Provider.of<Model>(context);
    List<dynamic> result = provider.books.where((element) => element["title"].contains(query)).toList();
    return Container(
        color: Colors.grey[200],
        alignment: Alignment.center,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          itemCount: result.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 300,
              child: Productwidget(products: result[index]),
            );
          },
        ),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var provider = Provider.of<Model>(context);
    if (query.isEmpty) {
      // إذا كانت الكلمة المدخلة فارغة، عرض كل المنتجات
      return Container(
        color: Colors.grey[200],
        alignment: Alignment.center,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          itemCount: provider.books.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 300,
              child: Productwidget(
                products: provider.books[index],
              ),
            );
          },
        ),
      );
    }
    List<dynamic> searchResults = provider.books
        .where((element) => element["title"].contains(query))
        .toList();
    if (searchResults.length > 0) {
      return Container(
        color: Colors.grey[200],
        alignment: Alignment.center,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 300,
              child: Productwidget(products: searchResults[index]),
            );
          },
        ),
      );
    }else{
      return Center(child: Text("Not Found" , style: TextStyle(color: Colors.blueAccent, fontSize: 18),),);
    }
  }
}

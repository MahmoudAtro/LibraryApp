import 'package:flutter/material.dart';
import 'package:mylibrary/layout/pagelayout.dart';
import 'package:mylibrary/layout/productwidget.dart';
import 'package:mylibrary/layout/provider.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);
    return Pagelayout(title: "Favorite", 
    body: provider.favorite.isEmpty? 
          Center(child: Text("no book in your favorite" , style: TextStyle(color: Colors.greenAccent, fontSize: 20),),)
          :
          GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, mainAxisExtent: 300),
              itemCount: provider.favorite.length,
          itemBuilder: (context, i) {
            return Productwidget(products: provider.favorite[i]);
          }),
    );
  }
}

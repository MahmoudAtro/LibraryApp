import 'package:flutter/material.dart';
import 'package:mylibrary/Service/book.dart';
import 'package:mylibrary/Widgets/part.dart';
import 'package:mylibrary/layout/provider.dart';
import 'package:provider/provider.dart';

class Categorie extends StatefulWidget {
  Categorie({super.key});

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  Book books = Book();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    books.allCats(context);
  }

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<Model>(context);
    return Consumer<Model>(builder: (context, provider, child) {
      if (provider.categorie.isEmpty) {
        return const Text('No Categorie available', style: TextStyle(color: Colors.blue),);
      } else {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.categorie.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 32),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Part(categorie: provider.categorie[index]["name"].toString())));
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(
                          Icons.book,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      Text(provider.categorie[index]["name"])
                    ],
                  ),
                ),
              );
            });
      }
    });
  }
}

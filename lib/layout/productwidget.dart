import 'package:flutter/material.dart';
import 'package:mylibrary/Widgets/showbook.dart';
import 'package:mylibrary/layout/provider.dart';
import 'package:provider/provider.dart';

class Productwidget extends StatelessWidget {
  const Productwidget({super.key, required this.products});
  final Map products;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Showbook(book: products)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // photo
              Image.network(
                "http://127.0.0.1:8000/api/img/${products["img"]}",
                fit: BoxFit.contain,
                height: 200,
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    products["title"],
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Center(
                        child: Text(
                          products["author"],
                          style:
                              TextStyle(color: Colors.red[500], fontSize: 15),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: () {
                                  products["check"]
                                      ? provider.removefavorite(
                                          products["id"])
                                      : provider.addtofavorite(
                                          products["id"]);
                                },
                                icon: products["check"]
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(Icons.favorite_border))),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

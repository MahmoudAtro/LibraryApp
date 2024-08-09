import 'package:flutter/material.dart';
import 'package:mylibrary/Service/book.dart';
import 'package:mylibrary/Widgets/showbook.dart';
import 'package:mylibrary/layout/pagelayout.dart';
import 'package:mylibrary/layout/provider.dart';
import 'package:provider/provider.dart';

class Part extends StatefulWidget {
  const Part({super.key, required this.categorie});
  final String categorie;

  @override
  State<Part> createState() => _PartState();
}

class _PartState extends State<Part> {
  List<dynamic> books = [];
  bool isnotupload = true;
  Book part = Book();
  Future<void> start() async {
    books = await part.showpart(context, widget.categorie);
    setState(() {
      isnotupload = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);
    return Pagelayout(
        title: widget.categorie,
        body: isnotupload
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : books.isEmpty
                ? Center(
                    child: Text(
                      "no book in this categorie",
                      style: TextStyle(color: Colors.greenAccent, fontSize: 20),
                    ),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 300),
                    itemCount: books.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Showbook(book: books[i])));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                // photo
                                Image.network(
                                  "http://127.0.0.1:8000/api/img/${books[i]["img"]}",
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
                                      books[i]["title"],
                                      style: TextStyle(
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
                                            books[i]["author"],
                                            style: TextStyle(
                                                color: Colors.red[500],
                                                fontSize: 15),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                  onPressed: () {
                                                    provider.books[books[i]["id"]-1]["check"]
                                                        ? provider
                                                            .removefavorite(
                                                                books[
                                                                    i]["id"])
                                                        : provider
                                                            .addtofavorite(
                                                                books[
                                                                    i]["id"]);
                                                  },
                                                  icon: provider.books[books[i]["id"]-1]
                                                          ["check"]
                                                      ? const Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                        )
                                                      : const Icon(Icons
                                                          .favorite_border))),
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
                    }));
  }
}

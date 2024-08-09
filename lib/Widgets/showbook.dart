import 'package:flutter/material.dart';
import 'package:mylibrary/Service/book.dart';
import 'package:mylibrary/layout/pagelayout.dart';
import 'package:mylibrary/layout/provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Showbook extends StatefulWidget {
  const Showbook({super.key, required this.book});
  final Map book;

  @override
  State<Showbook> createState() => _ShowbookState();
}

class _ShowbookState extends State<Showbook> {
  Book upload = const Book();
  Future<void> readBook(int id) async {
    final String url = "http://127.0.0.1:8000/api/read/$id";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);
    return Pagelayout(
        title: "${widget.book["title"]}",
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: double.infinity,
                    height: 300,
                    child: Image.network(
                      "http://127.0.0.1:8000/api/img/${widget.book["img"]}",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textDirection: TextDirection.rtl,
                        "${widget.book["title"]}",
                        style: TextStyle(color: Colors.blue[900], fontSize: 22),
                      ),
                      const Text(
                        textDirection: TextDirection.ltr,
                        " : اسم الكتاب",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textDirection: TextDirection.rtl,
                        "${widget.book["author"]}",
                        style: TextStyle(color: Colors.blue[900], fontSize: 18),
                      ),
                      const Text(
                        textDirection: TextDirection.ltr,
                        " : اسم المؤلف",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.book["categorie"]}",
                        style:
                            TextStyle(color: Colors.amber[900], fontSize: 18),
                      ),
                      const Text(
                        " : الفئة",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      readBook(widget.book["id"]);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(15.0)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    color: Colors.blue[900],
                    hoverColor: Colors.amber[900],
                    child: const SizedBox(
                      width: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                        "قراءة الكتاب",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(width: 5,),
                      Icon(Icons.menu_book_rounded , size: 20.0, color: Colors.white,)
                        ],
                      ),
                    )
                  ),
                  const SizedBox(height: 10,),
                  MaterialButton(
                    onPressed: () {
                      upload.downloadbook(context, widget.book["id"]);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(15.0)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    color: Colors.blue[900],
                    hoverColor: Colors.green[900],
                    child: Container(
                      width: 70,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                        "تحميل",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(width: 5,),
                      Icon(Icons.download , size: 20.0, color: Colors.white,)
                        ],
                      ),
                    )
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  provider.books[widget.book["id"]-1]["check"] ? 
                  MaterialButton(
                    onPressed: () {
                      provider.removefavorite(widget.book["id"]);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(15.0)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    color: Colors.pink[500],
                    child: Container( 
                      width: 150,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [ 
                        Text(
                      "مضاف في المفضلة",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(width: 5.0,),
                    Icon(Icons.star , size: 20,color: Colors.white,)
                      ],),
                    )
                  )
                  :
                  MaterialButton(
                    onPressed: () {
                      provider.addtofavorite(widget.book["id"]);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(15.0)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    color: Colors.blue[900],
                    child: Container( 
                      width: 150,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [ 
                        Text(
                      "أضف الى المفضلة",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(width: 5.0,),
                    Icon(Icons.star_border , size: 20,color: Colors.white,)
                      ],),
                    )
                  ),
                ],
              ),
              Positioned(
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[200],
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 25,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                top: 0,
                left: 0,
              )
            ],
          ),
        ));
  }
}

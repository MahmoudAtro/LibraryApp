import 'package:flutter/material.dart';
import 'package:mylibrary/Service/book.dart';
import 'package:mylibrary/Widgets/HomePage.dart';
import 'package:mylibrary/Widgets/favorite.dart';
import 'package:mylibrary/Widgets/profile.dart';
import 'package:mylibrary/layout/provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static int numberbook = 0;
  Book books = Book();
  void start(){
    if(numberbook == 0){
      books.allbooks(context);
    }
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    start();
    numberbook = 1;
  }

  static List<Widget> _widgetOptions = <Widget>[
    Homepage(),
    Favorite(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          if (provider.isprofile)
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

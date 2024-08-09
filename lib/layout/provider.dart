import 'package:flutter/material.dart';
import 'package:mylibrary/Service/user.dart';

class Model extends ChangeNotifier {
  bool _islogin = true;
  bool _islodaing = true;

  bool _isprofile = false;
  get isprofile => _isprofile;

  bool get islogin => _islogin;
  bool get islodaing => _islodaing;

  bool _issend = true;
  bool get issend => _issend;

  List<dynamic> _books = [];
  List<dynamic> get books => _books;
  List<dynamic> _categorie = [];
  List<dynamic> get categorie => _categorie;
  List<dynamic> _favorite = [];
  List<dynamic> get favorite => _favorite;
  List<Storeuser> _user = [];
  List<Storeuser> get user => _user;

  void allbooks(List<dynamic> booksData) {
    _books = booksData.map((book) {
      book['check'] = false;
      return book;
    }).toList();
    notifyListeners();
    changeloading();
  }

  void allCats(List<dynamic> cats) {
    _categorie = cats;
    notifyListeners();
  }

  void changeloading() {
    _islodaing = false;
  }

  void login(bool login) {
    _islogin = login;
    _isprofile = true;
    notifyListeners();
  }

  void logout() {
    _user = [];
    _favorite = [];
    _islogin = false;
    _isprofile = false;
    notifyListeners();
  }

  void addtofavorite(int id) {
    _books[id-1]["check"] = true;
    _favorite.add(_books[id-1]);
    notifyListeners();
  }
  void removefavorite(int id)
  {
    _books[id-1]["check"] = false;
    _favorite.remove(_books[id-1]);
    notifyListeners();
  }

  int bookcount()
  {
    return books.length;
  }
  void send(bool state)
  {
    _issend = state;
    notifyListeners();
  }
}

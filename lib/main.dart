import 'package:flutter/material.dart';
import 'package:mylibrary/Widgets/HomePage.dart';
import 'package:mylibrary/Widgets/Start.dart';
import 'package:mylibrary/Widgets/contactus.dart';
import 'package:mylibrary/Widgets/favorite.dart';
import 'package:mylibrary/Widgets/profile.dart';
import 'package:mylibrary/auth/login.dart';
import 'package:mylibrary/auth/register.dart';
import 'package:mylibrary/layout/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Model(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        initialRoute: "start",
        routes: {
          'start' : (context)=>MyHomePage(),
          'register': (context) => const register(),
          'home': (context) => Homepage(),
          'login': (context) => const Login(),
          "profile" : (context) => Profile(),
          "favorite" : (context) => const Favorite(),
          "contact" : (context) => const Contactus(),
        },
      ),
    );
  }
}

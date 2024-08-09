import 'package:flutter/material.dart';
import 'package:mylibrary/Service/user.dart';
import 'package:mylibrary/layout/provider.dart';
import 'package:mylibrary/layout/style.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});
  Uri url = Uri.parse(
      "https://www.facebook.com/profile.php?id=100071745116138&mibextid=ZbWKwL");
  Future<void> _launchUrl() async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 150,
            child: DrawerHeader(
              child: Column(
                children: [
                  Icon(
                    Icons.book,
                    size: 60,
                    color: Colors.green,
                  ),
                  Text(
                    "AlManara Library",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'start', (route) => false);
                  },
                  leading: Icon(
                    Icons.home,
                    color: Colors.green[900],
                  ),
                  title: Text('HomePage', style: textstyle.styledrawer()),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, "contact");
                  },
                  leading: Icon(
                    Icons.chat,
                    color: Colors.green[900],
                  ),
                  title: Text(
                    "Contact Us",
                    style: textstyle.styledrawer(),
                  ),
                ),
              ),
              provider.isprofile
                  ? Card(
                      child: ListTile(
                        onTap: () {
                          SendData data = SendData();
                          data.logout(context);
                        },
                        leading: Icon(
                          Icons.logout,
                          color: Colors.green[900],
                        ),
                        title: Text('Logout', style: textstyle.styledrawer()),
                      ),
                    )
                  : Column(
                      children: [
                        Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'register', (route) => false);
                            },
                            leading: Icon(
                              Icons.login_sharp,
                              color: Colors.green[900],
                            ),
                            title:
                                Text('SignUp', style: textstyle.styledrawer()),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'login', (route) => false);
                            },
                            leading: Icon(
                              Icons.login,
                              color: Colors.green[900],
                            ),
                            title:
                                Text('Login', style: textstyle.styledrawer()),
                          ),
                        ),
                      ],
                    ),
            ],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Deployed By: ",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              TextButton(
                  onPressed: _launchUrl,
                  child: Text(
                    "Mahmoud Atro",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

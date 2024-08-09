import 'package:flutter/material.dart';
import 'package:mylibrary/layout/provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController country = TextEditingController();

  TextEditingController address = TextEditingController();

  late String img;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<Model>(context, listen: false);
    final user = provider.user[0];
    name.text = user.name;
    email.text = user.email;
    country.text = user.country;
    address.text = user.address;
    img = user.img;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.green[500]),
              ),
              centerTitle: true,
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  img.isEmpty
                      ? CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 60,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 50,
                          ))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(
                              "http://127.0.0.1:8000/api/img/$img",
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: name,
                    readOnly: true,
                    style: TextStyle(color: Colors.blue[500]),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("User name"),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: email,
                    readOnly: true,
                    style: TextStyle(color: Colors.blue[500]),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Your email"),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: country,
                    readOnly: true,
                    style: TextStyle(color: Colors.blue[500]),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Your Country"),
                      prefixIcon: Icon(Icons.add_moderator_rounded),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: address,
                    readOnly: true,
                    style: TextStyle(color: Colors.blue[500]),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Your address"),
                      prefixIcon: Icon(Icons.add_moderator_rounded),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.greenAccent,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),
            )));
  }
}

import 'package:flutter/material.dart';
import 'package:mylibrary/Service/user.dart';
import 'package:mylibrary/layout/provider.dart';
import 'package:provider/provider.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  // set controllers for textfield
  TextEditingController country = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController confirm = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //dispose the controller
  @override
  void dispose() {
    super.dispose();
    country.dispose();
    address.dispose();
    confirm.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.book_rounded,
                      size: 30,
                      color: Colors.blue,
                    ),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(70),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "Register",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: name,
                          style: TextStyle(color: Colors.blue),
                          decoration: const InputDecoration(
                            label: Text("enter your name"),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                            iconColor: Colors.blue,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: email,
                          style: TextStyle(color: Colors.blue),
                          decoration: const InputDecoration(
                            label: Text("enter your email"),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                            iconColor: Colors.blue,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: country,
                          style: TextStyle(color: Colors.blue),
                          decoration: const InputDecoration(
                            label: Text("enter your Country"),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.where_to_vote),
                            iconColor: Colors.blue,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter your country';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: address,
                          style: TextStyle(color: Colors.blue),
                          decoration: const InputDecoration(
                            label: Text("enter your Address"),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.home),
                            iconColor: Colors.blue,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter your address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: password,
                          style: TextStyle(color: Colors.blue),
                          decoration: const InputDecoration(
                            label: Text("enter your Password"),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.visibility_off),
                            iconColor: Colors.blue,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: confirm,
                          style: TextStyle(color: Colors.blue),
                          decoration: const InputDecoration(
                            label: Text("Confirm your Password"),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.password),
                            iconColor: Colors.blue,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter your confirm password';
                            }
                            if (value != password.text) {
                              return 'password is not match';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        SendData().sendUser(
                            context,
                            User(
                                name: name.text,
                                email: email.text,
                                country: country.text,
                                address: address.text,
                                password: password.text,
                                confirmPassword: confirm.text));
                      }
                    },
                    minWidth: double.maxFinite,
                    height: 50,
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: provider.islogin
                        ? const Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "you have an Account? ",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            'login', (rourte) => false);
                      },
                      child: Text(
                        "Login",
                        style:
                            TextStyle(color: Colors.amber[900], fontSize: 15),
                      ),
                    )
                  ],
                )
              ],
            ),
          ])),
    );
  }
}

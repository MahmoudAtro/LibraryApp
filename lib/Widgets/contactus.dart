import 'package:flutter/material.dart';
import 'package:mylibrary/Service/user.dart';
import 'package:mylibrary/layout/pagelayout.dart';
import 'package:mylibrary/layout/provider.dart';
import 'package:provider/provider.dart';

class Contactus extends StatefulWidget {
  const Contactus({super.key});

  @override
  State<Contactus> createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController message = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void clear() {
    name.clear();
    email.clear();
    message.clear();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);
    return Pagelayout(
        title: "Contact Us",
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "the feild is required";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: "enter your name",
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "the feild is required";
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'enter a valid email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: "enter your email",
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: message,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "the feild is required";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: "enter your message here",
                            border: OutlineInputBorder()),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      SendData data = SendData();
                      data.sendMessage(
                          context, name.text, email.text, message.text);
                      clear();
                      provider.send(false);
                    }
                  },
                  color: Colors.green[500],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: provider.issend ? 
                  Text(
                    "Send message",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                  :
                  CircularProgressIndicator(color: Colors.white,),
                )
              ],
            ),
          ),
        ));
  }
}

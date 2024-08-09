import 'package:flutter/material.dart';
import 'package:mylibrary/Service/user.dart';
import 'package:mylibrary/layout/provider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // set controllers for textfield
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //dispose the controller
  @override
  void dispose() {
    super.dispose();
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
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: email,
                          style: TextStyle(color: Colors.blue),
                          decoration: const InputDecoration(
                            label: Text("enter your email"),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                            prefixIconColor: Colors.blue,
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
                          obscureText: true,
                          controller: password,
                          style: TextStyle(color: Colors.blue),
                          decoration: const InputDecoration(
                            label: Text("enter your Password"),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.visibility_off),
                            prefixIconColor: Colors.blue,
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
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      provider.login(false);
                      SendData().loginData(
                          context,
                          LoginUser(
                              email: email.text, password: password.text));
                    }
                  },
                  minWidth: double.maxFinite,
                  height: 50,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: provider.islogin ? 
                  const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  )
                  :
                  Center(child: CircularProgressIndicator(color: Colors.white,),)
                ), 
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("create a new account? " , style: TextStyle(color: Colors.blue, fontSize: 15),),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamedAndRemoveUntil("register", (route) => false);
                      },
                      child: Text("Register" , style: TextStyle(color: Colors.amber[900], fontSize: 15,),),
                    )
                  ],
                )
              ],
            ),
          ])),
    );
  }
}

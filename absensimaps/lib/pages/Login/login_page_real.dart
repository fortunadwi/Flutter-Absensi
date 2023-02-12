import 'package:absensimaps/animation/FadeAnimation.dart';
import 'package:absensimaps/controller/login_func.dart';
import 'package:flutter/material.dart';

// import 'bloc navigator/navigation_bloc.dart';

class LoginPageReal extends StatelessWidget {
  const LoginPageReal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: 380,
                height: 300,
                margin: const EdgeInsets.only(top: 100),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/fresh.png'),
                        opacity: 68.0,
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                        1.8,
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              // ignore: prefer_const_literals_to_create_immutables
                              boxShadow: [
                                const BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade100))),
                                child: TextField(
                                  controller: emailC,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email or Phone number",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  obscureText: true,
                                  controller: passC,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        2,
                        InkWell(
                          onTap: () {
                            /// login
                            LogIn();
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ])),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Forgot Password? "),
                        FadeAnimation(
                            1.5,
                            InkWell(
                              onTap: () {
                                ResetPassword();
                              },
                              child: const Text(
                                "Reset Here",
                                style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                    fontSize: 12),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

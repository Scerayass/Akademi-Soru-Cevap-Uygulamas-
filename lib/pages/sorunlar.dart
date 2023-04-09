import 'package:flutter/material.dart';
import 'order.dart';

import 'menus.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(Colors.blue.shade300.value),
                Color(Colors.red.shade300.value),
                Color(Colors.green.shade300.value),
              ],
              stops: [0.1, 0.5, 0.9],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          blurRadius: 12,
                          offset: Offset(0, 5))
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 70,
                          height: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/akademi.png"),
                                fit: BoxFit.contain),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 70,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/oyun_ve_akademi.png",
                                ),
                                fit: BoxFit.contain),
                          ),
                        ),
                      ],
                    ),
                    //DropdownButtonExample()
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // ****** dÃ¼zeltilecek
                        Container(
                          width: 210,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                          ),
                          padding:
                          EdgeInsets.only(top: 10, left: 30, bottom: 15),
                          margin: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            "SORULAR",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto",
                              fontSize: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: SecondPageStatee(),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.maxFinite,
                  height: 60,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/girdi/post');

                        },
                        child: Icon(
                          Icons.add,
                          size: 40,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/google-logo.png"),
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.home,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
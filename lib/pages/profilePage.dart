import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'girdi.dart';

class EditProfilePage extends StatefulWidget {

  String selectedAlan;
  String profilName;
  String profilMail;
  EditProfilePage(this.selectedAlan,this.profilName,this.profilMail);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  final List<String> list = <String>['Flutter', 'Unity'];


  @override
  Widget build(BuildContext context) {
    print(widget.selectedAlan);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
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
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 70),
                padding: EdgeInsets.only(left: 16, top: 30, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      Text(
                        "Edit Profile",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Stack(children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                    AssetImage("assets/images/akademi.png"),
                                    fit: BoxFit.cover)),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  color: Colors.green),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(height: 35),
                      buildTextField(
                          "Ad-Soyad", widget.profilName,false,false),
                      buildTextField("E-mail", widget.profilMail, false, false),
                      buildTextField("Password", "***********", true, false),


                      DropdownButton(
                        isExpanded: true,
                        value: widget.selectedAlan,
                        items: list.map((option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            widget.selectedAlan = value!;
                          });
                        },underline: Container(height: 2,decoration: BoxDecoration(border:Border(bottom: BorderSide(width: 2.0,color: Colors.black12))),),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "CANCEL",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2.2,
                                    color: Colors.black),
                              )),
                          ElevatedButton(
                              onPressed: () {

                              },
                              child: Text(
                                "  SAVE  ",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2.2,
                                    color: Colors.black),
                              )),
                        ],
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

  Widget buildTextField(
      String labelText, String placeHolder, bool isPassword, bool isEnable) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        enabled: isEnable,
        obscureText: isPassword ? showPassword : false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeHolder,
            hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }
}
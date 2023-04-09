import 'package:app_jam/pages/profilePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChoicePage extends StatefulWidget {

  const ChoicePage({Key? key}) : super(key: key);

  @override
  State<ChoicePage> createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {

  User? currentUser= FirebaseAuth.instance.currentUser;
  FirebaseFirestore db = FirebaseFirestore.instance;
  //String profilAlan = "";
  String name = "";
  String mail = "";
  @override
  void initState()  {
    // TODO: implement initState
    generate();
    super.initState();
  }

  void generate(){

    final docRef = db.collection("users").doc(currentUser?.uid);
    docRef.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String,dynamic>;
      name = data["name"];
      mail = data["mail"];
      //profilAlan = data["alan"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(Colors.blue.shade400.value),
                Color(Colors.red.shade400.value),
                Color(Colors.green.shade400.value),
              ],
              stops: [0.1, 0.5, 0.7],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    image:
                                    AssetImage("assets/images/akademi.png"),
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
                  Padding(
                      padding: const EdgeInsets.only(left: 65, top: 30),
                      child: Text("Akademi Soru\n  Platformuna\n   Hoş geldin!",
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.normal,
                              fontSize: 40))),

                  SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        buildElevatedButton(Colors.blue, "Gönderilere Bak",'/girdi/sorunlar',),
                        SizedBox(height: 20),
                        buildElevatedButton(Colors.orange, "   Post Gönder   ",'/girdi/post'),
                        SizedBox(height: 20),
                        buildElevatedButton(
                            Colors.grey, "   Profilime Git   ",'/girdi/profil'),
                        SizedBox(height: 20),

                        buildElevatedButton(
                            Colors.white, "      Çıkış Yap      ",'/'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildElevatedButton(Color color, String text,String gidilcek) {
    return ElevatedButton(
      onPressed: () {
        if(gidilcek == '/'){
          Navigator.pushNamedAndRemoveUntil(context, gidilcek, (route) => false);
          FirebaseAuth.instance.signOut();
        }else if(gidilcek == '/girdi/profil'){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfilePage("Flutter",name, mail)));
        }
        else{
          Navigator.pushNamed(context, gidilcek);
        }
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 25,fontWeight: FontWeight.w200),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        primary: color,
      ),
    );
  }
}


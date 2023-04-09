import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constants/constants.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser= FirebaseAuth.instance.currentUser;
  TextEditingController _baslik = TextEditingController();
  TextEditingController _metin = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  String userName = "";
  int postIndex = 0;

  int userPostCount = 0;
  final List<String> list = <String>['Flutter','Unity'];
  String selectedAlan = "Flutter";

  @override
  void initState() {
    // TODO: implement initState
    generate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      //Color(Colors.white.value)
                      Color(Colors.blue.shade300.value),
                      Color(Colors.red.shade300.value),
                      Color(Colors.green.shade300.value),
                    ],
                    stops: [0.1, 0.5, 0.7],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 90.0),
                      Image.asset(
                        "images/loginimg.png",
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      _sorubasligi(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _soruMetni(),
                      SizedBox(
                        height: 20.0,
                      ),
                      //buildInputDecorator(context)
                      buildInputDecorator(context)
                      ,
                      SizedBox(
                        height: 20.0,
                      ),
                      _postButton(),


                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecorator buildInputDecorator(BuildContext context) {
    return InputDecorator(decoration: InputDecoration(
            labelText: 'Alan',
            labelStyle: kLabelStyle,
            border: const OutlineInputBorder(),
          ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(1.0),
                value: selectedAlan,
                icon: const Icon(Icons.arrow_downward,color: Colors.blue,),
                elevation: 8,
                style: const TextStyle(color:Colors.blue),
                underline: Container(
                  height: 10,
                  color: Colors.red,
                ),
                onChanged: (String? value){
                  setState(() {
                    selectedAlan = value!;
                  });
                },
                items : list.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                isExpanded: true,
                isDense: true,

            )),
          );
  }

  Widget _sorubasligi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Başlık',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 70.0,
          child: TextField(
            controller: _baslik,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.text_fields_sharp,
                color: Colors.white,
              ),
              hintText: 'Sorun Başlığı',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _soruMetni() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Metin',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 120.0,
          child: TextField(
            controller: _metin,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.text_format,
                color: Colors.white,
              ),
              hintText: 'Sorun Metni',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _postButton() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if(_baslik.text == "" || _metin.text == ""){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tüm Alanlar Doldurulmalı",textAlign: TextAlign.center,),backgroundColor: Colors.blue));
            }else{
              db.collection("posts").doc("${currentUser?.uid}${userPostCount + 1}").set({
                'baslik':_baslik.text,
                'metin':_metin.text,
                'name':userName,
                'alan':selectedAlan,
                'userid':currentUser?.uid,
                'postIndex':postIndex,
              });
              db.collection("users").doc(currentUser?.uid).set({
                'postCount' : userPostCount + 1,
                'name': userName,
                'mail': currentUser?.email,
              });
              db.collection("postIndex").doc("postSayi").set({
                'postIndex': postIndex + 1
              });

              Navigator.pushNamedAndRemoveUntil(context, '/girdi', (route) => false);
              Navigator.pushNamed(context, "/girdi/sorunlar");
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Post Başarıyla gönderildi",textAlign: TextAlign.center,),backgroundColor: Colors.blue));

            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            primary: Colors.blue,
            padding: EdgeInsets.all(15.0),
          ),
          child: Text(
            'Post Gönder',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        )
    );
  }

  void generate() {
    final docRef = db.collection("users").doc(currentUser?.uid);
    docRef.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String,dynamic>;
      userName =  data["name"];
      userPostCount = data["postCount"];
    });
    final docRef2 = db.collection("postIndex").doc("postSayi");
    docRef2.get().then((DocumentSnapshot doc){
      final data = doc.data() as Map<String,dynamic>;
      postIndex = data["postIndex"];

    });
  }
}

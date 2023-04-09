import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_jam/Constants/constants.dart';


class SignUp extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUp> {

  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _password1 = TextEditingController();
  final TextEditingController _password2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mailController.dispose();
    _password1.dispose();
    _password2.dispose();
    super.dispose();
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
                      Color(Colors.white.value)
                      /*
                      Color(Colors.green.value),
                      Color(Colors.deepOrangeAccent.value),
                      Color(Colors.red.value),
                      */
                    ],
                    //stops: [ 0.1, 0.5, 0.9],
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
                        "images/loginimg.png", height: 100, width: 100,),
                      SizedBox(
                        height: 20.0,

                      ),
                      _kayitText(),

                      _isim(),
                      _soyisim(),
                      _sifre(),
                      _sifre2(),

                      SizedBox(
                        height: 20.0,
                      ),
                      _kayitButton(),

                      _alreadyLogin(),
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

  Text _kayitText() {
    return Text(
                      'Kayıt Ol',
                      style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    );
  }

  Widget _isim() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),

        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            controller: _nameController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Fullname',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  Widget _soyisim() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),

        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            controller: _mailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.mail,
                color: Colors.white,
              ),
              hintText: 'Mail',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _sifre() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Şifre',
          style: kLabelStyle,
        ),

        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            controller: _password1,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Şifreyi girin',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  Widget _sifre2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Şifre',
          style: kLabelStyle,
        ),

        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            controller: _password2,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Şifreyi tekrar girin',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  Widget _kayitButton() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            if(_nameController.text == "" || _mailController.text == "" || _password1.text == "" || _password2.text == ""){
              _mailController.text = "";
              _password1.text = "";
              _password2.text = "";
              _nameController.text = "";
              _showDialog();
            }

            else if(_password1.text != _password2.text){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Şifreler Uyuşmuyor",textAlign: TextAlign.center,),backgroundColor: Colors.blue));
            }
            else if(_password1.text.length < 8){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Şifre en az 8 karakter olmalı",textAlign: TextAlign.center,),backgroundColor: Colors.blue));
            }
            else{
              var _user = await auth.createUserWithEmailAndPassword(email: _mailController.text, password: _password1.text);
              var currentUser = _user.user;

              db.collection("users").doc(currentUser?.uid).set({
              'name':_nameController.text,
              'mail':_mailController.text,
                'postCount':0
               });

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Hesap Oluşturuldu",textAlign: TextAlign.center,),backgroundColor: Colors.blue,));
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);


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
            'Kayıt Ol',
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




  Widget _alreadyLogin() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Zaten Hesabın Var mı?',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()..onTap = () {

              },
              text : ' Giriş Yap',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Tüm Alanları Doldurun"),
          content: new Text("Kayıt Olmak için tüm alanları doldurmalısınız"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Kapat"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}
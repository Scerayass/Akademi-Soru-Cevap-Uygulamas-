import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_jam/Constants/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _sifre = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    // TODO: implement initState

  }

  void createUserEmailAndPassword() async {
    var _userCredential = await auth.createUserWithEmailAndPassword(
        email: "mail@gmail.com", password: "sadettin");
    print(_userCredential.toString());
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
                      SizedBox(height: 100.0),
                      Image.asset(
                        "images/loginimg.png", height: 130, width: 130,),
                      SizedBox(height: 20.0),
                      Text(
                        'Giriş Yap',
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 0.0),
                      _buildEmailTF(),
                      SizedBox(height: 5.0),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      //_buildRememberMeCheckbox(),
                      _LoginButton(),
                      //_buildSignInWithText(),
                      //_buildSocialBtnRow(),
                      _buildSignupBtn(),
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

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _mail,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Mailinizi Girin',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Şifre',
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _sifre,
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
              hintText: 'Şifre girin',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        child: Text(
          'Şifremi Unuttum',
          style: TextStyle(
              color: Colors.blue
          ),
        ),
      ),
    );
  }


  Widget _LoginButton() {

    return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async{
            try {
              if(_mail.text == "" && _sifre.text == ""){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tüm Alanlar Doldurulmalı",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.blue));
              }else if(_mail.text != "" && _sifre.text == ""){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Şifre Boş Bırakılamaz",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.blue));

              }

              UserCredential userCredential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                  email: _mail.text
                  , password: _sifre.text
              );
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/girdi', (route) => false);

            }on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Kullanıcı Bulunamadı",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.blue));

              } else if (e.code == 'wrong-password') {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bu kullanıcı için girilen şifre yanlış",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),backgroundColor: Colors.blue));

              }
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
            'LOGIN',
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


  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/signUp');
      },
      child: RichText(

        text: TextSpan(

          children: [
            TextSpan(
              text: 'Hesabın yok mu?',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              /*
              recognizer: TapGestureRecognizer()..onTap = () {
                Navigator.push(context,MaterialPageRoute(builder: (BuildContext context)
                {

                }));
              },*/
              text: ' Kayıt Ol',
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
}
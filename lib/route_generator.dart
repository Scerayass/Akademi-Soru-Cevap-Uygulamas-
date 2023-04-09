import 'package:app_jam/pages/Post.dart';
import 'package:app_jam/pages/SignUpPage.dart';
import 'package:app_jam/pages/chatPage.dart';
import 'package:app_jam/pages/girdi.dart';
import 'package:app_jam/pages/loginPage.dart';
import 'package:app_jam/pages/profilePage.dart';
import 'package:app_jam/pages/sorunlar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? _routeOlustur(
      Widget gidilecekWidget, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => gidilecekWidget,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android)
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => gidilecekWidget,
      );
    else
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => gidilecekWidget,
      );
  }

  static Route<dynamic>? routeGenerator(RouteSettings settings){
    switch (settings.name){
      case '/':
        return _routeOlustur(LoginScreen(), settings);
      case '/signUp':
        return _routeOlustur(SignUp(), settings);
      case '/girdi':
        return _routeOlustur(ChoicePage(), settings);
      case '/girdi/post':
        return _routeOlustur(Post(), settings);
      case '/girdi/sorunlar':
        return _routeOlustur(FirstPage(), settings);
      case  '/girdi/sorunlar/chat':
       // return _routeOlustur(ChatPage(), settings);
      case '/girdi/profil':
        //return _routeOlustur(EditProfilePage("Flutter"), settings);

    }
  }

}
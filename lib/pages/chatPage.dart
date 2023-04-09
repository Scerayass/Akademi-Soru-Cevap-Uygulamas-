import 'package:app_jam/Constants/constants.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  String baslik;

  String metin;

  String name;

  ChatPage(this.baslik, this.metin, this.name);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soru - Cevap"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              widget.baslik,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 28.0
              ),
            ),
          ),Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0,top: 20.0,bottom: 10.0),
              child: Text(
                "- ${widget.metin}",
                style: TextStyle(
                    color: Colors.blue,

                    fontSize: 18.0,
                ),
              ),
            ),
          ),Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Text(
              "${widget.name} tarafından soruldu",
              style: TextStyle(
                color: Colors.blue,

                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(height: 100.0),
          Text("YAPIM AŞAMASINDA",style: TextStyle(
            fontSize: 25.0,fontWeight: FontWeight.bold
          ),),
        ],
      ),
    );
  }
}

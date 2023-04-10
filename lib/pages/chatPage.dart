import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  String baslik;
  String metin;
  String name;
  String alan;

  ChatPage(this.baslik, this.metin, this.name,this.alan);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, dynamic>> _messages = [];

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sohbet'),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/akademi.png'),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          widget.alan,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  widget.baslik,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  widget.metin,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "YORUMLAR",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 250),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: _messages.map((message) {
                      return Dismissible(
                        key: ValueKey(message),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        onDismissed: (_) {
                          _deleteMessage(message);
                        },
                        child: ListTile(
                          title: Text(message['sender']),
                          subtitle: Text(message['text']),
                          trailing: Text(message['time']),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'Mesaj yazın',
                          ),
                          onFieldSubmitted: (text) {
                            _sendMessage(text);
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          _sendMessage(_textController.text);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) {
    final now = DateTime.now();
    final message = {
      'sender': 'Ben',
      'text': text,
      'time': '${now.hour}:${now.minute}',
    };
    setState(() {
      _messages.add(message);
    });
    _textController.clear();
  }

  void _deleteMessage(Map<String, dynamic> message) {
    setState(() {
      _messages.remove(message);
    });
  }
}
/*
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
*/
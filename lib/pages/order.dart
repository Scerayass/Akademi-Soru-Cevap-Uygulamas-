import 'dart:async';

import 'package:app_jam/pages/chatPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SecondPageStatee extends StatefulWidget {
  const SecondPageStatee({super.key});

  @override
  State<SecondPageStatee> createState() => _SecondPageStatee();
}

class _SecondPageStatee extends State<SecondPageStatee> {
  PageController pageController = PageController(
      viewportFraction: 0.85); // SCAFFOLD sayfa demek onu yüzde 85 olarak düşün
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 220;
  FirebaseFirestore db = FirebaseFirestore.instance;
  User? currentUser= FirebaseAuth.instance.currentUser;
  List<Map<String,dynamic>> allPosts = [];
  List<Map<String,dynamic>> sortedPosts = [];

  List<Map<String,dynamic>> sikKarsilasilan = [];
  int sikKarsilastiranIndex = 0;
  bool initialized = false;
  Duration oneMilisecond = const Duration(milliseconds: 10);

  final stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    stopwatch.start();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
    initialize();
    //sortPosts(allPosts);
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if(stopwatch.elapsedMilliseconds > 50){
      stopwatch.stop();
      if(!initialized){
        setState(() {
          initialized= true;
          initialize();
        });
      }

    }
    return GestureDetector(

      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 40),
            child: Align(

              alignment: Alignment.centerLeft,
              child: InkWell(
                child: Text(
                  "Sık Karşılaşılan Sorular",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline),
                ),onTap: (){
                  setState(() {
                    if(!initialized){
                      initialize();
                      initialized = true;
                    }
                  });
              },
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 120,
            child: PageView.builder(
              itemCount: 5,
              controller:
              pageController, // burda yüzde 85 olarak düşündük ona göre yer kapladı
              itemBuilder: (context, position) {
                // position sayfanın indexi 1. sayfa 2.sayfa vs.
                return _buildPageItem(position,
                    text:
                    "Bu haftanın popüler en \nçok değerlendirilen ve  \n Tartışılan sorusu");
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          new DotsIndicator(
            dotsCount: 5,
            position: _currPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          SizedBox(height: 10),
          //**************************************************** */

          InkWell(
            onTap: (){
            },
            child: buildListView(
                text:
                "404 hatası aslında istenilen sağlanabiliyor ancak istediğini sonuca ulaşamıyordur.Bu nedenle 404 hata sayfaları... ",
                baslik: "404 Not Found Hatası alıyorum",name: "Ulas Dagdeviren",alan: "Flutter / Unity"),
          ),
        ],
      ),
    );
  }

  ListView buildListView({required String text, required String baslik,required String name,required String alan}) {

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: sortedPosts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            //Navigator.pushNamed(context,'/girdi/sorunlar/chat' );
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatPage(sortedPosts[index]["baslik"], sortedPosts[index]["metin"], sortedPosts[index]["name"])));
            },
          child: Container(
            width: 100,
            height: 125,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    blurRadius: 20,
                    offset: Offset(0, 5))
              ],
              color: Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 125,
                  margin: EdgeInsets.only(top: 10, left: 5),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: ImageIcon(AssetImage("images/loginimg.png")),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        sortedPosts[index]["name"],
                        style: TextStyle(
                            fontFamily: "Roboto", fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          "${sortedPosts[index]["alan"]}   ",
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8),
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Text(
                        sortedPosts[index]["baslik"],
                        style: TextStyle(
                            fontFamily: "Roboto",
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5, left: 5),
                          width: 200,
                          height: 80,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white70),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  sortedPosts[index]["metin"],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );

  }

  Widget _buildPageItem(int index, {required String text}) {
    // gelen index değer sayfanın yyanında gözüken değerler 0.sayfa 1. sayfa 2. sayfa gözküyor onları yazar
    Matrix4 matrix = new Matrix4.identity(); // 3 kordinatı vardır x,y,z
    if (index == _currPageValue.floor()) // floor tam sayıya yuvarlıyor
        {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans =
          _height * (1 - currScale) / 2; //geçişte sol taraf problem yaratıyordu
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(
            0, currScale, 0); // x,y,z deeri alan köşegen 3 değer
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height *
          (1 - currScale) /
          2; //aşşağıya insin diue burdan çıkan sonuç şu 1/10*220=22 bunu bir matrise atarsak 20 piksele iner
      matrix = Matrix4.diagonal3Values(1, currScale,
          1); // _curr..+index+1 değerinden 0 elde ediyoruz oyüzden burda 0.8 elde ediliyor
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currScale, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);

      matrix = Matrix4.diagonal3Values(1, currScale,
          1); // _curr..+index+1 değerinden 0 elde ediyoruz oyüzden burda 0.8 elde ediliyor
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currScale, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currScale, 1);
    }

    return Transform(
      // matrixi transform sayesinde kullandık.
      transform: matrix,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.green.shade200),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 125,
              margin: EdgeInsets.only(top: 10, left: 5),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Ulas Dagdeviren",
                    style: TextStyle(
                        fontFamily: "Roboto", fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      "Flutter / Unity    ",
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 4),
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "    Haftanın Sorusu",
                    style: TextStyle(
                        fontFamily: "Roboto",
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 5, left: 5),
                      width: 165,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            text,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void sikKarsilasilanText (){
    sikKarsilasilan.add({
      "name": "isim",
      "alan": "alanı",
      "baslik": "basliği",
      "metin":"metni",
    });
    sikKarsilasilan.add({
      "name": "isim",
      "alan": "alanı",
      "baslik": "basliği",
      "metin":"metni",
    });
    sikKarsilasilan.add({
      "name": "isim",
      "alan": "alanı",
      "baslik": "basliği",
      "metin":"metni",
    });
    sikKarsilasilan.add({
      "name": "isim",
      "alan": "alanı",
      "baslik": "basliği",
      "metin":"metni",
    });
    sikKarsilasilan.add({
      "name": "isim",
      "alan": "alanı",
      "baslik": "basliği",
      "metin":"metni",
    });
  }

  void initialize() {
    void queryValues() async{

      final snapshot = await FirebaseFirestore.instance.collection("posts").get();
      snapshot.docs.forEach((element) {
        String docId = element.id;
        final docRef = db.collection("posts").doc(docId);
        docRef.get().then((DocumentSnapshot doc){
          final data = doc.data() as Map<String,dynamic>;
          allPosts.add(data);
        });
      });
    }
    queryValues();
    void sortPosts(List<Map<String,dynamic>> list){

      Map<int,Map<String,dynamic>> myMap = {};
      for(int i = 0 ; i < list.length ; i++){
        Map<String,dynamic> temp = list[i];
        myMap[temp["postIndex"]] = temp;

      }
      for(int i = myMap.length - 1 ; i >= 0 ;i--){
        sortedPosts.add(myMap[i]!);
      }
    }
    sortPosts(allPosts);


  }
}

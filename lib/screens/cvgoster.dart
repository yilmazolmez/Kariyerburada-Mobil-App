import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import '../main.dart';

class CvGoster extends StatefulWidget {
  final List list;
  final int index;
  CvGoster({this.list, this.index});
  @override
  _CvGosterState createState() => _CvGosterState();
}

class _CvGosterState extends State<CvGoster> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Color(0xFF73AEF5),
        backgroundColorEnd: Color(0xFF398AE5),
        title: Text("CV : " + widget.list[widget.index]["uyecvadisoyadi"]),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
              0.1,
              0.4,
              0.6,
              0.9
            ],
                colors: [
              Color(0xFF73AEF5),
              Color(0xFF73AEF5),
              Color(0xFF398AE5),
              Color(0xFF398AE5),
            ])),
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Card(
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "CV Görüntülenme : " +
                        widget.list[widget.index]["uyecvgoruntulemesayisi"],
                    style: TextStyle(fontSize: 13.0),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(anaurl+widget.list[widget.index]["uyecvresim2"]),
                ),
                Text(
                    "Ad Soyad : " + widget.list[widget.index]["uyecvadisoyadi"],
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
                Text("TC : " + widget.list[widget.index]["uyecvtcno"],
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
                Text("Mail : " + widget.list[widget.index]["uyecveposta"],
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
                Text("Telefon :" + widget.list[widget.index]["uyecvtelefonno"],
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Doğum Tarihi : " +
                        widget.list[widget.index]["uyecvdogumtarihi"],
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
                Text("Anne Adı : " + widget.list[widget.index]["uyecvanaadi"],
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
                Text("Baba Adı : " + widget.list[widget.index]["uyecvbabaadi"],
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
                Text("Adres : " + widget.list[widget.index]["uyecvadresi"],
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
                Text("Şehir : " + widget.list[widget.index]["uyecvsehir"],
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Mezun Olunan Bölüm : " +
                        widget.list[widget.index]["uyecvsonmezunbolum"],
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Meslek Ünvanı : " +
                        widget.list[widget.index]["uyecvmeslekunvani"],
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Eğitim Seviyesi : " +
                        widget.list[widget.index]["uyeecvgitimseviye"],
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                    "Cv Özet : " + widget.list[widget.index]["uyecvozetbilgi1"],
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

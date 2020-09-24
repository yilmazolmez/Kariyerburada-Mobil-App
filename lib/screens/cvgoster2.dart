import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class CvGoster2 extends StatefulWidget {
  final int id;

  CvGoster2(this.id);

  @override
  _CvGosterState createState() => _CvGosterState();
}

class _CvGosterState extends State<CvGoster2> {
  Future<List> CvGosterme() async {
    //ilanlar
    final response = await http.post(
        anaurl+"my_store/cv.php",
        body: {"id": widget.id.toString()});

    return json.decode(response.body);
  }

  @override
  void initState() {
    CvGosterme();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Color(0xFF73AEF5),
        backgroundColorEnd: Color(0xFF398AE5),
        title: Text("CV"),
      ),
      body: FutureBuilder<List>(
        future: CvGosterme(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }

          return snapshot.hasData
              ? ItemList(list: snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;

  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
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
                      "CV Görüntülenme : " + list[i]["uyecvgoruntulemesayisi"],
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(anaurl+list[i]["uyecvresim2"]),
                  ),
                  Text("Ad Soyad : " + list[i]["uyecvadisoyadi"],
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("TC : " + list[i]["uyecvtcno"],
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Mail : " + list[i]["uyecveposta"],
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Telefon :" + list[i]["uyecvtelefonno"],
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Doğum Tarihi : " + list[i]["uyecvdogumtarihi"],
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Anne Adı : " + list[i]["uyecvanaadi"],
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Baba Adı : " + list[i]["uyecvbabaadi"],
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Adres : " + list[i]["uyecvadresi"],
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Şehir : " + list[i]["uyecvsehir"],
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Mezun Olunan Bölüm : " + list[i]["uyecvsonmezunbolum"],
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Meslek Ünvanı : " + list[i]["uyecvmeslekunvani"],
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Eğitim Seviyesi : " + list[i]["uyeecvgitimseviye"],
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Cv Özet : " + list[i]["uyecvozetbilgi1"],
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(
                    height: 10.0,
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}

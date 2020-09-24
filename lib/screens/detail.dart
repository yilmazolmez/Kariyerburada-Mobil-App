import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:kariyerburadamobil/main.dart';
import 'package:kariyerburadamobil/main.dart';
import 'package:kariyerburadamobil/screens/basvurulanilanlar.dart';
import 'package:kariyerburadamobil/screens/uye_login.dart';


class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index, this.list});
  @override
  _DetailState createState() => _DetailState();
}

String deneme = "bos";

class _DetailState extends State<Detail> {
  Future<void> mesaj() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('İlan Başvuru'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Başvuru Alınmıştır.'),
                Icon(Icons.beenhere),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
          ],
        );
      },
    );
  }

  var currDt = DateTime.now();

  Future<List> basvur() async {
    String tarih = currDt.year.toString() +
        "-" +
        currDt.month.toString() +
        "-" +
        currDt.day.toString();

    final response = await http
        .post(anaurl+"my_store/basvur.php", body: {
      "username": username,
      "isilanno": widget.list[widget.index]["isilanno"].toString(),
      "isaciklamasi": widget.list[widget.index]["isaciklamasi"],
      "uyefirmaunvani": widget.list[widget.index]["uyefirmaunvani"],
      "uyefirmano": widget.list[widget.index]["uyefirmano"].toString(),
      "uyecvno": id.toString(),
      "meslek": widget.list[widget.index]["meslek"],
      "tarih": tarih.toString(),
      "ilannot": widget.list[widget.index]["isilannotlari"]
    });
  }

  Future<List> basvurKontrol() async {
    final response = await http.post(
        anaurl+"my_store/basvurukontrol.php",
        body: {
          "uyecvno": id.toString(),
          "isilanno": widget.list[widget.index]["isilanno"].toString(),
        });
    setState(() {
      var data = json.decode(json.encode(response.body));
      if (data.length != 2) {
        deneme = "doldu";
      } else {
        deneme = "bos";
      }
      print(data);
    });
  }

  @override
  void initState() {
    basvurKontrol();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Color(0xFF73AEF5),
        backgroundColorEnd: Color(0xFF398AE5),
        title: Text("${widget.list[widget.index]["uyefirmaunvani"]}"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 10,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Başlangıç : " +
                          widget.list[widget.index]["isbasvurubaslamatarihi"],
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Bitiş : " +
                          widget.list[widget.index]["isbasvurubitistarihi"],
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      widget.list[widget.index]["tur"],
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  Text(
                    widget.list[widget.index]["uyefirmaunvani"],
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.list[widget.index]["meslek"],
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Sehir : " + widget.list[widget.index]["issehir"],
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Lokasyon : " + widget.list[widget.index]["islokasyonu"],
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Askerlik Durumu : " +
                        widget.list[widget.index]["isaskerlikdurum"],
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Cinsiyet : " + widget.list[widget.index]["iscinsiyet"],
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Yaş Sınırı : " + widget.list[widget.index]["isyassiniri"],
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Çalışma Saatleri: " +
                        widget.list[widget.index]["issaatleri"],
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Maaş : " + widget.list[widget.index]["ismaasi"],
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Açıklama : " + widget.list[widget.index]["isaciklamasi"],
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "İlan Notu : " + widget.list[widget.index]["isilannotlari"],
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      child: deneme == "bos"
                          ? RaisedButton(
                              child: Text("Başvur"),
                              color: Colors.green,
                              onPressed: () {
                                basvur();
                                mesaj();
                              })
                          : RaisedButton(
                              child: Text("Başvuru Mevcuttur"),
                              color: Colors.red,
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('İlan Başvuru'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text('Başvuru Mevcuttur...'),
                                            Icon(Icons.block),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Tamam'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

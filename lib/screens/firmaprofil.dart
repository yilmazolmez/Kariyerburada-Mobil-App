import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:kariyerburadamobil/main.dart';
import 'package:kariyerburadamobil/screens/uye_login.dart';
import 'package:http/http.dart' as http;
import 'package:kariyerburadamobil/utilities/constants.dart';

class FirmaProfil extends StatefulWidget {
  @override
  _FirmaProfil createState() => _FirmaProfil();
}

String uyefirmaunvani;
String uyefirmaadres;
String uyefirmaeposta;
String uyefirmasifre;
String uyefirmasehir;
String uyefirmavergino;
String uyefirmavergidairesi;
String uyefirmatelefonno;
String uyefirmailgilisahis;
String uyefirmacalisansayisi;
String uyefirmaozetbilgi1;

var formKey = GlobalKey<FormState>();

class _FirmaProfil extends State<FirmaProfil> {
  Future<List> firma() async {
    final response = await http
        .post(anaurl + "my_store/firma.php", body: {"id": id.toString()});
    return json.decode(response.body);
  }

  @override
  void initState() {
    FirmaProfil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Color(0xFF73AEF5),
        backgroundColorEnd: Color(0xFF398AE5),
        title: Text(username),
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
        child: Padding(
          padding: EdgeInsets.all(1.0),
          child: Container(
            child: FutureBuilder<List>(
              future: firma(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return snapshot.hasData
                    ? listele(list: snapshot.data)
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class listele extends StatelessWidget {
  final List list;

  listele({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
            padding: const EdgeInsets.all(5.0),
            child: Card(
                elevation: 10,
                child: Form(
                  key: formKey,
                  child: Column(children: [
                    ClipOval( child:
                    Image.network(anaurl+firmaresim,fit:BoxFit.fill,width: 150,height: 150,),
                    ),
                    TextFormField(
                      maxLength: 75,
                      cursorColor: Colors.black,
                      style: kLabelStyleCV,
                      initialValue: list[i]["uyefirmaunvani"],
                      decoration: InputDecoration(
                        labelText: "Firma Ünvan",
                        hintText: "xxx Firma",
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                      ),
                      onSaved: (String value) {
                        uyefirmaunvani = value;
                      },
                    ),
                    TextFormField(
                      maxLength: 45,
                      style: kLabelStyleCV,
                      initialValue: list[i]["uyefirmaeposta"],
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "Firma Mail",
                          hintText: "xxxx@xxxx.com"),
                      onSaved: (String value) {
                        uyefirmaeposta = value;
                      },
                    ),
                    TextFormField(
                        maxLength: 75,
                        style: kLabelStyleCV,
                        initialValue: list[i]["uyefirmaadres"],
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            labelText: "Firma Adres",
                            hintText: "....."),
                        onSaved: (String value) {
                          uyefirmaadres = value;
                        }),
                    TextFormField(
                        maxLength: 25,
                        style: kLabelStyleCV,
                        initialValue: list[i]["uyefirmasehir"],
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            labelText: "Firma Şehir",
                            hintText: "İstanbul,İzmir,Ankara...."),
                        onSaved: (String value) {
                          uyefirmasehir = value;
                        }),
                    TextFormField(
                      maxLength: 25,
                      style: kLabelStyleCV,
                      initialValue: list[i]["uyefirmasifre"],
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "Şifre",
                          hintText: "Şifreniz"),
                      onSaved: (String value) {
                        uyefirmasifre = value;
                      },
                    ),
                    TextFormField(
                        maxLength: 25,
                        style: kLabelStyleCV,
                        initialValue: list[i]["uyefirmavergino"],
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            labelText: "Vergi No",
                            hintText: "222222"),
                        onSaved: (String value) {
                          uyefirmavergino = value;
                        }),
                    TextFormField(
                      maxLength: 35,
                      style: kLabelStyleCV,
                      initialValue: list[i]["uyefirmavergidairesi"],
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "Vergi Dairesi",
                          hintText: "...."),
                      onSaved: (String value) {
                        uyefirmavergidairesi = value;
                      },
                    ),
                    TextFormField(
                      maxLength: 15,
                      style: kLabelStyleCV,
                      initialValue: list[i]["uyefirmatelefonno"],
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "Firma Telefon",
                          hintText: "05554443366"),
                      onSaved: (String value) {
                        uyefirmatelefonno = value;
                      },
                    ),
                    TextFormField(
                      maxLength: 25,
                      style: kLabelStyleCV,
                      initialValue: list[i]["uyefirmailgilisahis"],
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "İlgili Şahıs",
                          hintText: "XXX Kişi"),
                      onSaved: (String value) {
                        uyefirmailgilisahis = value;
                      },
                    ),
                    TextFormField(
                      maxLength: 15,
                      style: kLabelStyleCV,
                      initialValue: list[i]["uyefirmacalisansayisi"],
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "Firma Çalışan Sayısı",
                          hintText: "1111"),
                      onSaved: (String value) {
                        uyefirmacalisansayisi = value;
                      },
                    ),
                    TextFormField(
                      maxLength: 250,
                      style: kLabelStyleCV,
                      initialValue: list[i]["uyefirmaozetbilgi1"],
                      maxLines: 6,
                      decoration: InputDecoration.collapsed(
                        hintText: "Firma Özet Giriniz.(max 250)",
                      ),
                      onSaved: (String value) {
                        uyefirmaozetbilgi1 = value;
                      },
                    ),
                    RaisedButton(
                        elevation: 5.0,
                        padding: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.green,
                        child: Text(
                          "Güncelle",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "OpenSans",
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            guncelle();
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Firma Bilgi'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text('Güncelleme Başarılı'),
                                        Icon(Icons.beenhere),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Tamam'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        MyApp()));
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            Navigator.of(context).pop();
                          }
                        })
                  ]),
                )));
      },
    );
  }

  void guncelle() {
    var url = "my_store/firmaguncelle.php";
    http.post(anaurl + url, body: {
      "id": id.toString(),
      "uyefirmaunvani": uyefirmaunvani,
      "uyefirmaadres": uyefirmaadres,
      "uyefirmaeposta": uyefirmaeposta,
      "uyefirmasifre": uyefirmasifre,
      "uyefirmasehir": uyefirmasehir,
      "uyefirmavergino": uyefirmavergino,
      "uyefirmavergidairesi": uyefirmavergidairesi,
      "uyefirmatelefonno": uyefirmatelefonno,
      "uyefirmailgilisahis": uyefirmailgilisahis,
      "uyefirmacalisansayisi": uyefirmacalisansayisi,
      "uyefirmaozetbilgi1": uyefirmaozetbilgi1,
    });
  }
}

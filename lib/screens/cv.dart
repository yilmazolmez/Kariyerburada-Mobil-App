import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:kariyerburadamobil/main.dart';
import 'package:kariyerburadamobil/screens/uye_login.dart';
import 'package:http/http.dart' as http;
import 'package:kariyerburadamobil/utilities/constants.dart';

class Cv extends StatefulWidget {
  @override
  _CvState createState() => _CvState();
}

String ad;
String tc;
String mail;
String tel;
String sifre;
String tarih;
String anne;
String baba;
String adres;
String sehir;
String bolum;
String meslek;
String okul;
String ozet;
var formKey = GlobalKey<FormState>();

class _CvState extends State<Cv> {
  Future<List> cv() async {
    final response = await http.post(
        "http://10.0.2.2/kariyerburada/my_store/cv.php",
        body: {"id": id.toString()});
    return json.decode(response.body);
  }

  @override
  void initState() {
    Cv();
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
              future: cv(),
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
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "CV Görüntülenme : " +
                            list[i]["uyecvgoruntulemesayisi"],
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(anaurl+list[i]["uyecvresim2"]),
                    ),
                    TextFormField(
                      maxLength: 35,
                      cursorColor: Colors.black,
                      style: kLabelStyleCV,
                      initialValue: list[i]["uyecvadisoyadi"],
                      decoration: InputDecoration(
                        labelText: "Ad Soyad",
                        hintText: "Mustafa ALTUNDAG",
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                      ),
                      onSaved: (String value) {
                        ad = value;
                      },
                    ),
                    TextFormField(
                      maxLength: 11,
                      style: kLabelStyleCV,
                      initialValue: list[i]["uyecvtcno"],
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "TC No",
                          hintText: "11111111111"),
                      onSaved: (String value) {
                        tc = value;
                      },
                    ),
                    TextFormField(
                        maxLength: 25,
                        style: kLabelStyleCV,
                        initialValue: list[i]["uyecveposta"],
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            labelText: "Eposta",
                            hintText: "xxxx@xxx.com"),
                        onSaved: (String value) {
                          mail = value;
                        }),
                    TextFormField(
                        maxLength: 15,
                        style: kLabelStyleCV,
                        initialValue: list[i]["uyecvtelefonno"],
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            labelText: "Telefon",
                            hintText: "05322100976"),
                        onSaved: (String value) {
                          tel = value;
                        }),
                    TextFormField(
                      maxLength: 25,
                      style: kLabelStyleCV,
                      initialValue: list[i]["uyecvsifre"],
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "Şifre",
                          hintText: "Şifreniz"),
                      onSaved: (String value) {
                        sifre = value;
                      },
                    ),
                    TextFormField(
                        maxLength: 25,
                        style: kLabelStyleCV,
                        initialValue: list[i]["uyecvdogumtarihi"],
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            labelText: "Doğum Tarihi",
                            hintText: "2020-04-04"),
                        onSaved: (String value) {
                          tarih = value;
                        }),
                    TextFormField(
                      maxLength: 25,
                      style: kLabelStyleCV,
                      initialValue: list[i]["uyecvanaadi"],
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "Anne Adı",
                          hintText: "Anne Adiniz"),
                      onSaved: (String value) {
                        anne = value;
                      },
                    ),
                    TextFormField(
                      maxLength: 25,
                      style: kLabelStyleCV,
                      initialValue: list[i]["uyecvbabaadi"],
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "Baba adı",
                          hintText: "Baba Adiniz"),
                      onSaved: (String value) {
                        baba = value;
                      },
                    ),
                    TextFormField(
                      maxLength: 100,
                      style: kLabelStyleCV,
                      initialValue: list[i]["uyecvadresi"],
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "Adres",
                          hintText: "Adresiniz"),
                      onSaved: (String value) {
                        adres = value;
                      },
                    ),
                    TextFormField(
                      maxLength: 25,
                      style: kLabelStyleCV,
                      initialValue: list[i]["uyecvsehir"],
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "Şehir",
                          hintText: "Şehir"),
                      onSaved: (String value) {
                        sehir = value;
                      },
                    ),
                    TextFormField(
                      maxLength: 25,
                      style: kLabelStyleCV,
                      initialValue: list[i]["uyecvsonmezunbolum"],
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          labelText: "Son Mezun Olduğunuz Bölüm",
                          hintText: "Bilgisayar Mühendisliği"),
                      onSaved: (String value) {
                        bolum = value;
                      },
                    ),
                    TextFormField(
                        maxLength: 45,
                        style: kLabelStyleCV,
                        initialValue: list[i]["uyecvmeslekunvani"],
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            labelText: "Mesleğiniz",
                            hintText: "Mühendis"),
                        onSaved: (String value) {
                          meslek = value;
                        }),
                    TextFormField(
                        maxLength: 35,
                        style: kLabelStyleCV,
                        initialValue: list[i]["uyeecvgitimseviye"],
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            labelText: "Okul Durumunuz",
                            hintText: "Lise,Üniversite..."),
                        onSaved: (String value) {
                          okul = value;
                        }),
                    TextFormField(
                        maxLength: 250,
                        style: kLabelStyleCV,
                        initialValue: list[i]["uyecvozetbilgi1"],
                        maxLines: 6,
                        decoration: InputDecoration.collapsed(
                          hintText: "Cv Özet Giriniz.(max 250)",
                        ),
                        onSaved: (String value) {
                          ozet = value;
                        }),
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
                                  title: Text('CV Güncelleme'),
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
    var url = "my_store/cvguncelle.php";
    http.post(anaurl+url, body: {
      "id": id.toString(),
      "ad": ad,
      "tc": tc,
      "mail": mail,
      "tel": tel,
      "sifre": sifre,
      "tarih": tarih,
      "anne": anne,
      "baba": baba,
      "adres": adres,
      "sehir": sehir,
      "bolum": bolum,
      "meslek": meslek,
      "okul": okul,
      "ozet": ozet,
    });
  }
}

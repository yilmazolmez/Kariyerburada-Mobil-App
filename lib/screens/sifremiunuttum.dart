import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:kariyerburadamobil/main.dart';
import 'package:kariyerburadamobil/screens/uye_login.dart';
import 'package:kariyerburadamobil/screens/send_password.dart';
import 'package:kariyerburadamobil/utilities/constants.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class SifremiUnuttum extends StatefulWidget {
  @override
  _SifremiUnuttumState createState() => _SifremiUnuttumState();
}

class _SifremiUnuttumState extends State<SifremiUnuttum> {

  String nameSurname, email,emailsifre, subject, message;

  TextEditingController email1 = new TextEditingController();
  TextEditingController yanit = new TextEditingController();
  String msg = '';
  Future<List> _sifremigetir() async {
    final response = await http
        .post(anaurl+"my_store/sifremigetir.php", body: {
      "mail": email1.text,
      "yanit": yanit.text,
    });
    print(email1.text);
    print(yanit.text);
    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "Bilgilerinizi Kontrol Ediniz!";
      });
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Şifre İşlemleri'),
            content: SingleChildScrollView(

                child: ListBody(
                  children: <Widget>[
                    //datauser[0]["uyecvadisoyadi"] != null
                    //    ? Text("Şifreniz=" + datauser[0]["uyecvsifre"])
                    //    : Text("Şifreniz=" + datauser[0]["uyefirmasifre"]),
                    Text(email1.text+"  adresini kontrol ediniz..."),
                    Icon(Icons.beenhere),
                  ],
                ),
              ),
            actions: <Widget>[
              FlatButton(
                child: Text('Tamam'),
                onPressed: () async {
                  //
                        emailsifre=email1.text;
                        datauser[0]["uyecvadisoyadi"] != null ? {message="Şifreniz=" + datauser[0]["uyecvsifre"],nameSurname=datauser[0]["uyecvadisoyadi"]}
                        : {message="Uye Şifreniz=" + datauser[0]["uyefirmasifre"],nameSurname=datauser[0]["uyefirmaunvani"]};
                        bool sendingStatus = await sendMail(
                        nameSurname, email,emailsifre, subject, message, context);
                  //
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UyeLogin()));
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("Şifremi Unuttum"),
        backgroundColorStart: Color(0xFF73AEF5),
        backgroundColorEnd: Color(0xFF398AE5),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF73AEF5),
                Color(0xFF61A4F1),
                Color(0xFF478DE0),
                Color(0xFF398AE5),
              ],
              stops: [0.1, 0.4, 0.7, 0.9],
            )),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 50.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Şifremi Getir",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "OpenSans",
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: kLabelStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        height: 60.0,
                        child: TextField(
                          controller: email1,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              color: Colors.white, fontFamily: "OpenSans"),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              hintText: "Email Adresi Giriniz..."),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gizli Soru Yanıt",
                        style: kLabelStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        height: 60.0,
                        child: TextField(
                          controller: yanit,
                          obscureText: true,
                          style: TextStyle(
                              color: Colors.white, fontFamily: "OpenSans"),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              hintText: "Gizli Yanınıtız..."),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 25.0),
                    width: double.infinity,
                    child: RaisedButton(
                        elevation: 5.0,
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.white,
                        child: Text(
                          "Şifremi Getir",
                          style: TextStyle(
                            color: Color(0xFF527DAA),
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "OpenSans",
                          ),
                        ),
                        onPressed: () {
                          _sifremigetir();
                        }),
                  ),
                  Text(
                    msg,
                    style: TextStyle(fontSize: 20.0, color: Colors.red),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

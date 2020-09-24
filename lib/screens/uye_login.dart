import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kariyerburadamobil/screens/drawermenuuye.dart';
import 'package:kariyerburadamobil/screens/sifremiunuttum.dart';
import 'package:kariyerburadamobil/screens/uye_signup.dart';
import 'package:kariyerburadamobil/utilities/constants.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import '../main.dart';

class UyeLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UyeLogin();
  }
}

String username = "";
String tur = "";
int id = 0;
String uyeresim="";
String firmaresim="";

class _UyeLogin extends State {
  TextEditingController email = new TextEditingController();
  TextEditingController sifre = new TextEditingController();
  ProgressDialog pr; //PROGRESSBAR TANIMLAMA

  String msg = '';
  Future<List> _login() async {
    final response = await http
        .post(anaurl+"my_store/login.php", body: {
      "username": email.text,
      "password": sifre.text,
    });
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      setState(() {
        msg = "Bilgilerinizi Kontrol Ediniz!";
      });
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
      setState(() {
        username = datauser[0]["uyecvadisoyadi"];
        id = int.tryParse(datauser[0]["uyecvno"].toString());
        tur = "uye";
        uyeresim=datauser[0]["uyecvresim2"];

        if (username == null) {
          username = datauser[0]["uyefirmaunvani"];
          tur = "firma";
          id = int.tryParse(datauser[0]["uyefirmano"].toString());
          firmaresim=datauser[0]["uyefirmaresim2"];
        }
        title_string =" Hosgeldin "+username; //ANA SAYFAYA HOSGELDIN ATIYORUZ
        //
          pr.show();//PROGRESS
          Future.delayed(Duration(seconds: 3)).then((value) {//PROGRESS
          pr.hide().whenComplete(() {//PROGRES;
          });//PROGRESS
        });//PROGRESS
        //
      });
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);//PROGRESSBAR
    pr.style(message: 'Isleminiz Yapiliyor...');//PROGRESSBAR

    return Scaffold(
      appBar: GradientAppBar(
        title: Text('$title_string'),
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
                    "Sisteme Giriş",
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
                          controller: email,
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
                        "Şifre",
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
                          controller: sifre,
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
                              hintText: "Şifre Giriniz..."),
                        ),
                      ),
                    ],
                  ),
                  _buildForgetPassword(context),
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
                          "Giriş",
                          style: TextStyle(
                            color: Color(0xFF527DAA),
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "OpenSans",
                          ),
                        ),
                        onPressed: () {
                          _login();
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

Widget _buildEmail() {
  return null;
}

Widget _buildPassword() {
  return null;
}

Widget _buildForgetPassword(BuildContext context) {
  return Container(
    alignment: Alignment.centerRight,
    child: FlatButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => SifremiUnuttum())),
      padding: EdgeInsets.only(right: 0.0),
      child: Text(
        "Şifremi Unuttum",
        style: kLabelStyle,
      ),
    ),
  );
}

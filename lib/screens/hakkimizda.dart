import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:kariyerburadamobil/screens/iletisim.dart';
import 'package:kariyerburadamobil/utilities/constants.dart';
import 'package:kariyerburadamobil/utilities/personel.dart';
import 'package:kariyerburadamobil/main.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import '../main.dart';
class hakkimizda extends StatefulWidget {

  @override
  _hakkimizda createState() => _hakkimizda();
}

class _hakkimizda extends State<hakkimizda> {
  ProgressDialog pr; //PROGRESSBAR TANIMLAMA

  List<Person> persons = [
    Person(name: 'Mustafa ALTUNDAG', profileImg: 'assets/images/person101.jpg', bio: "\nMobile App Developer \nBilgisayar Muhendisi \nNamık Kemal Universitesi \nCorlu Muhendislik Fakultesi \nmustafa.altundag@turkcell.com.tr\n\nMobil Uyg: kariyerburada v1.00 "),
    Person(name: 'Yilmaz OLMEZ', profileImg: 'assets/images/person100.jpg', bio: "\nWeb App Developer\nBilgisayar Muhendisi \nNamık Kemal Universitesi \nCorlu Muhendislik Fakultesi \nyilmazlmez@gmail.com\n\nWeb Uyg: kariyerburada v1.00 "),
  ];

  Widget personDetailCard(Person) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 5, 5),
                child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: new BoxDecoration(
                        //shape: BoxShape.circle,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            scale: 1.5,
                            image: AssetImage(Person.profileImg),
                        )
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(Person.name,
                    style: TextStyle (
                        color: Colors.white,
                        fontSize: 18
                    ),
                  ),
                  Text(Person.bio,
                    style: TextStyle (
                        color: Colors.white,
                        fontSize: 12
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
        showLogs: true); //PROGRESSBAR
    pr.style(message: 'Isleminiz Yapiliyor...'); //PROGRESSBAR
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('$title_string'+" /hakkimizda",
          style: TextStyle(color: Colors.white, fontSize: 16.0)),
        backgroundColorStart: Color(0xFF73AEF5),
        backgroundColorEnd: Color(0xFF398AE5),
      ),
      //backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: Column(

          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.menu, size: 45, color: Colors.white),
                Text('Notifications',
                  style: TextStyle (
                      color: Colors.white,
                      fontSize: 25
                  ),
                ),
                Icon(Icons.notifications_none, size: 35, color: Colors.white)
              ],
            ),
            Column(
                children: persons.map((p) {
                  return personDetailCard(p);
                }).toList()
            )
          ],

        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Ana Sayfa")),
            BottomNavigationBarItem(
                icon: Icon(Icons.info), title: Text("Hakkimizda")),
            BottomNavigationBarItem(
                icon: Icon(Icons.mail), title: Text("Iletisim")),
          ],
          onTap: (int i) {
            switch (i) {
              case 0:
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
                break;
              case 1:
                pr.show(); //PROGRESS
                Future.delayed(Duration(seconds: 3)).then((value) {
                  //PROGRESS
                  pr.hide().whenComplete(() {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => hakkimizda()));
                  }); //PROGRESS
                }); //PROGRESS
                break;
              case 2:
                {
                  //controller.animateTo(0,
                  //    duration: Duration(milliseconds: 500),
                  //    curve: Curves.easeInOut);
                  pr.show(); //PROGRESS
                  Future.delayed(Duration(seconds: 3)).then((value) {
                    //PROGRESS
                    pr.hide().whenComplete(() {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => MailSend()));
                    }); //PROGRESS
                  }); //PROGRESS
                }
                break;
            }
          }),
      //ALT MENU
    );
  }
}
import 'package:flutter/material.dart';
import 'package:kariyerburadamobil/screens/basvurulanilanlar.dart';
import 'package:kariyerburadamobil/screens/cv.dart';
import 'package:kariyerburadamobil/screens/hakkimizda.dart';
import 'package:kariyerburadamobil/screens/iletisim.dart';
import 'package:kariyerburadamobil/screens/kisiresimupload.dart';
import 'package:kariyerburadamobil/screens/uye_login.dart';
import 'package:kariyerburadamobil/utilities/constants.dart';
import 'package:kariyerburadamobil/utilities/menu.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../main.dart';


class drawermenuuye extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _drawermenuuye();
}

class _drawermenuuye extends State {
  ProgressDialog pr; //PROGRESSBAR TANIMLAMA

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);//PROGRESSBAR
    pr.style(message: 'Isleminiz Yapiliyor...');//PROGRESSBAR
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(anaurl+uyeresim),
                  ),
                  Text(
                    title_string,
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Anasayfa'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_queue),
            title: Text('CV'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Cv()));
            },
          ),
          ListTile(
            leading: Icon(Icons.lock_open),
            title: Text('Basvurulan Ilanlar'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BasvurulanIlanlar()));
            },
          ),

          ListTile(
            leading: Icon(Icons.add_a_photo),
            title: Text('Resim Ekle'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => kisiresimupload()));/////RESIM EKLEME
            },
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('Cikis'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              username = "";
              tur = "";
              id = 0;
              setState((){
                title_string = "kariyerburada.com";
              });
              pr.show();//PROGRESS
              Future.delayed(Duration(seconds: 3)).then((value) {//PROGRESS
                pr.hide().whenComplete(() {//PROGRESS
                });//PROGRESS
              });//PROGRESS

              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kariyerburadamobil/screens/firmaprofil.dart';
import 'package:kariyerburadamobil/screens/firmaresimupload.dart';
import 'package:kariyerburadamobil/screens/hakkimizda.dart';
import 'package:kariyerburadamobil/screens/ilanlar.dart';
import 'package:kariyerburadamobil/screens/ilanver.dart';
import 'package:kariyerburadamobil/screens/iletisim.dart';
import 'package:kariyerburadamobil/screens/uye_login.dart';
import 'package:kariyerburadamobil/utilities/constants.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../main.dart';

class drawermenufirma extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _drawermenufirma();
}

class _drawermenufirma extends State {
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 1, 5, 5),
                    child: Container(
                        width: 250.0,
                        height: 100.0,
                        decoration: new BoxDecoration(
                          //shape: BoxShape.circle,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            image: new DecorationImage(
                                        image: NetworkImage(anaurl+firmaresim),
                              fit: BoxFit.contain
                            )
                        )),
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
            leading: Icon(Icons.next_week),
            title: Text('Firma Profili'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FirmaProfil()));
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Ilan Ver'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => IlanVer()));
            },
          ),
          ListTile(
            leading: Icon(Icons.android),
            title: Text('Ilanlarim'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Ilanlar()));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_a_photo),
            title: Text('Resim Ekle'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => firmaresimupload()));/////RESIM EKLEME
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

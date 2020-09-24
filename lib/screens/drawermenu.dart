import 'package:flutter/material.dart';
import 'package:kariyerburadamobil/screens/firma_signup.dart';
import 'package:kariyerburadamobil/screens/hakkimizda.dart';
import 'package:kariyerburadamobil/screens/iletisim.dart';
import 'package:kariyerburadamobil/screens/kisiresimupload.dart';
import 'package:kariyerburadamobil/screens/uye_login.dart';
import 'package:kariyerburadamobil/screens/uye_signup.dart';
import 'package:kariyerburadamobil/utilities/constants.dart';
import '../main.dart';

class drawermenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _drawermenu();
}

class _drawermenu extends State {
  @override
  Widget build(BuildContext context) {
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
                              fit: BoxFit.contain,
                              scale: 1.5,
                              image: AssetImage('assets/images/kariyerburada.jpg'),
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
            leading: Icon(Icons.add_to_queue),
            title: Text('Üye Ol'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UyeSignUp()));
            },
          ),
          ListTile(
            leading: Icon(Icons.lock_open),
            title: Text('Üye Giriş'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UyeLogin()));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_queue),
            title: Text('Firma Kayit'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FirmaSignUp()));
            },
          ),
          ListTile(
            leading: Icon(Icons.lock_open),
            title: Text('Firma Giris'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UyeLogin()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Hakkimizda'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => hakkimizda()));
            },
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Iletisim'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MailSend()));
            },
          ),
        ],
      ),
    );
  }
}

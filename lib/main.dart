import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kariyerburadamobil/screens/basvurulanilanlar.dart';
import 'package:kariyerburadamobil/screens/cv.dart';
import 'package:kariyerburadamobil/screens/cvgoster.dart';
import 'package:kariyerburadamobil/screens/detail.dart';
import 'package:kariyerburadamobil/screens/drawermenufirma.dart';
import 'package:kariyerburadamobil/screens/drawermenuuye.dart';
import 'package:kariyerburadamobil/screens/firma_signup.dart';
import 'package:kariyerburadamobil/screens/firmaprofil.dart';
import 'package:kariyerburadamobil/screens/hakkimizda.dart';
import 'package:kariyerburadamobil/screens/ilanhizliara.dart';
import 'package:kariyerburadamobil/screens/ilanlar.dart';
import 'package:kariyerburadamobil/screens/ilanver.dart';
import 'package:kariyerburadamobil/screens/iletisim.dart';
import 'package:kariyerburadamobil/screens/turdetail.dart';
import 'package:kariyerburadamobil/screens/uye_login.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:kariyerburadamobil/screens/uye_signup.dart';
import 'package:kariyerburadamobil/utilities/menu.dart';
import 'package:kariyerburadamobil/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:kariyerburadamobil/screens/drawermenu.dart';

//KARIYERBURADA MOBIL UYGULAMASI
//VERSIYON 1.00
//MOBIL DEVELOPER : MUSTAFA ALTUNDAG
//WEB DEVELOPER : YILMAZ OLMEZ
//DILERSENIZ LOCALHOST UZERINDEN DILERSENIZDE ONLINE WEB HOST UZERINDEN VERILERI TAKIP EDEBILIRSINIZ
void main() {
  runApp(MyApp());
}

TextEditingController sehir = TextEditingController();
TextEditingController meslek = TextEditingController();
//final String anaurl ="http://10.0.2.2/kariyerburada/"; //TUM HERYERDE GECERLI LOCAL KARIYERBURADA DATA URLSI
final String anaurl="https://kariyerburadamobile.000webhostapp.com/kariyerburada/";//TUM HERYERDE GECERLI ONLINE KARIYERBURADA DATA URLSI

class MyApp extends StatelessWidget {
  final String username;
  final String tur;
  final int id;

  MyApp({this.username, this.tur, this.id});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ('kariyerburada.com'),
      home: KariyerBurada(),
    );
  }
}

class KariyerBurada extends StatefulWidget {
  @override
  _KariyerBurada createState() => _KariyerBurada();
}

enum Options { uyeOl, uyeGiris, firmaKayit, firmaGiris }

class _KariyerBurada extends State<KariyerBurada> {
  ProgressDialog pr; //PROGRESSBAR TANIMLAMA

  List<Widget> categoryTur = List<Widget>();

//  String title_string = "kariyerburada.com";//iletisim butonuna tıklarsanız title degistigini gorursunuz

  Future<List> getData() async {
    //ilanlar
    var response = await http.get(
        Uri.encodeFull(anaurl + "my_store/ilanlar.php"),
        headers: {"Accept": "application/json"});
      return json.decode(response.body);
 }

  Future<List> getUserData() async {
    //ilanlar
    final response = await http.get(anaurl + "my_store/users.php");
    return json.decode(response.body);
  }

  @override
  void initState() {
    getCategoriesTur();
    getData();
    getUserData();
    super.initState();
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
        showLogs: true); //PROGRESSBAR
    pr.style(message: 'Isleminiz Yapiliyor...'); //PROGRESSBAR

    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Color(0xFF73AEF5),
        backgroundColorEnd: Color(0xFF398AE5),
        title: Text('$title_string',
            style: TextStyle(color: Colors.white, fontSize: 16.0)),
        actions: [
          PopupMenuButton<String>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) {
              if (tur == "") {
                return Menu.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              } else if (tur == "firma") {
                return Menu.choices_firma.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              } else if (tur == "uye") {
                return Menu.choices_uye.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              }
            },
          )
        ],
      ),

      drawer: tur == "uye"
          ? drawermenuuye()
          : (tur == "firma"
              ? drawermenufirma()
              : drawermenu()), //KULLANICIYA GORE DRAWERMENU SECTIRIYORUZ

      body: Container(
        child: SingleChildScrollView(
          controller: controller,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                decoration: new BoxDecoration(color: Colors.blueAccent),
                child: new Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Meslek",
                              style: kLabelStyle,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: kBoxDecorationStyle,
                              height: 30.0,
                              child: TextField(
                                controller: meslek,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "OpenSans"),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 0.0),
                                    prefixIcon: Icon(
                                      Icons.work,
                                      color: Colors.white,
                                    ),
                                    hintText: "Meslek Giriniz"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Şehir",
                              style: kLabelStyle,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: kBoxDecorationStyle,
                              height: 30.0,
                              child: TextField(
                                controller: sehir,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "OpenSans"),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 0.0),
                                    prefixIcon: Icon(
                                      Icons.location_city,
                                      color: Colors.white,
                                    ),
                                    hintText: "Şehir İsmi Giriniz"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 25.0),
                          width: double.infinity,
                          child: RaisedButton(
                            elevation: 5.0,
                            padding: EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.white,
                            child: Text(
                              "İlan Ara",
                              style: TextStyle(
                                color: Color(0xFF527DAA),
                                letterSpacing: 1.5,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "OpenSans",
                              ),
                            ),
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        IlanHizliAra(
                                            sehir: sehir.text,
                                            meslek: meslek.text))),
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categoryTur,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Son İlanlar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                  )
                ],
              ),
              Container(
                height: 350.0,
                child: FutureBuilder<List>(
                  future: getData(), //Son 8 ilan
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 50.0, bottom: 20.0, right: 20.0),
                    child: Text(
                      "İş Arayanlar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                  )
                ],
              ),
              Container(
                height: 400.0,
                child: FutureBuilder<List>(
                  future: getUserData(), //Son 8 üye
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                    }

                    return snapshot.hasData
                        ? ItemListUser(list: snapshot.data)
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisSize: MainAxisSize.max,
                children: [],
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("En Uste Cik")),
            BottomNavigationBarItem(
                icon: Icon(Icons.info), title: Text("Hakkimizda")),
            BottomNavigationBarItem(
                icon: Icon(Icons.mail), title: Text("Iletisim")),
          ],
          onTap: (int i) {
            switch (i) {
              case 0:
                controller.animateTo(0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
                //Navigator.push(
                //  context, MaterialPageRoute(builder: (context) => MyApp()));
                break;
              case 1:
                pr.show(); //PROGRESS
                Future.delayed(Duration(seconds: 3)).then((value) {
                  //PROGRESS
                  pr.hide().whenComplete(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => hakkimizda()));
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MailSend()));
                    }); //PROGRESS
                  }); //PROGRESS
                }
                break;
            }
          }),
      //ALT MENU
    );
  }

//  void _onTap(int i) {
//    controller.animateTo(0,
//        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
//  }

  void selectProcess(String options) async {
    switch (options) {
      case "Üye Ol":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UyeSignUp()));
        break;
      case "Üye Giriş":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UyeLogin()));
        break;
      case "Firma Kayıt":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FirmaSignUp()));
        break;
      case "Firma Giriş":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UyeLogin()));

        break;
      case "Çıkış":
        username = "";
        tur = "";
        id = 0;
        setState(() {
          title_string = "kariyerburada.com";
        });
        pr.show(); //PROGRESS
        Future.delayed(Duration(seconds: 3)).then((value) {
          //PROGRESS
          pr.hide().whenComplete(() {
            //PROGRESS
          }); //PROGRESS
        }); //PROGRESS

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
        break;

      case "Basvurulan İlanlar":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BasvurulanIlanlar()));
        break;
      case "CV":
        Navigator.push(context, MaterialPageRoute(builder: (context) => Cv()));
        break;
      case "Firma Profili":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FirmaProfil()));
        break;
      case "İlan Ver":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => IlanVer()));
        break;
      case "İlanlarım":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Ilanlar()));
        break;

      default:
    }
  }

  List<Widget> getCategoriesTur() {
    for (int i = 0; i < Menu.choicesTur.length; i++) {
      categoryTur.add(getTurWidget(Menu.choicesTur[i]));
    }
    return categoryTur;
  }

  Widget getTurWidget(tur) {
    return FlatButton(
      child: Text(
        tur,
        style: TextStyle(color: Colors.blueGrey),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.blue)),
      onPressed: () {
        print(tur);
        if (tur == "Tüm İş İlanı") {
          tur = "";
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TurDetail(
                      tur: tur,
                    )));
      },
    );
  }
}

class ItemListUser extends StatelessWidget {
  final List list;

  ItemListUser({this.list});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(list.length, (index) {
        return InkWell(
          onTap: () => tur == "firma"
              ? Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => CvGoster(
                        list: list,
                        index: index,
                      )))
              : null,
          child: Card(
            elevation: 6,
            child: Column(
              children: [
                Container(
                  child: Image.network(anaurl + list[index]["uyecvresim2"]),
                  height: 100.0,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                SizedBox(height: 10.0),
                Text(list[index]["uyecvadisoyadi"]),
                Text(
                  list[index]["uyecvmeslekunvani"],
                  style: TextStyle(fontSize: 15.0, color: Colors.grey),
                ),
                SizedBox(height: 10.0),
                Text(list[index]["uyecvsehir"]),
              ],
            ),
          ),
        );
      }),
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
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () => tur == "uye"
                ? Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Detail(list: list, index: i)))
                : null,
            child: Card(
              elevation: 6,
              child: ListTile(
                title: Text(list[i]["uyefirmaunvani"]),
                leading: Image.network(anaurl + list[i]["resim"]),
                subtitle: Text(list[i]["meslek"]),
                trailing: Text(list[i]["isbasvurubaslamatarihi"]),
              ),
            ),
          ),
        );
      },
    );
  }
}

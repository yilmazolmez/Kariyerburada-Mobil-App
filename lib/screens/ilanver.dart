import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:kariyerburadamobil/main.dart';
import 'package:kariyerburadamobil/screens/uye_login.dart';
import 'package:kariyerburadamobil/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:kariyerburadamobil/validation/text_validator.dart';
import '../main.dart';

class IlanVer extends StatefulWidget {
  @override
  _IlanVerState createState() => _IlanVerState();
}

var formKey = GlobalKey<FormState>();
var currDt = DateTime.now();

String egitimdurumu;
String askerlikdurumu;
String cinsiyet;
String yassinir;
String lokasyon;
String sehir;
String issaatleri;
String meslek;
String maas;
String tecrubeyil;
String basmalatarih;
String bitistarih;
String isaciklama;
String ilannotlari;

String tarih = currDt.year.toString() +
    "-" +
    currDt.month.toString() +
    "-" +
    currDt.day.toString();

class _IlanVerState extends State<IlanVer> with TextValidationMixin {
  void ilanver() {
    var url = "my_store/ilanver.php";
    http.post(anaurl+url, body: {
      "id": id.toString(),
      "egitimdurumu": egitimdurumu,
      "askerlikdurumu": askerlikdurumu,
      "cinsiyet": cinsiyet,
      "yassinir": yassinir.toString(),
      "lokasyon": lokasyon,
      "sehir": sehir,
      "issaatleri": issaatleri,
      "meslek": meslek,
      "maas": maas.toString(),
      "tecrubeyil": tecrubeyil.toString(),
      "basmalatarih": basmalatarih,
      "bitistarih": bitistarih,
      "isaciklama": isaciklama,
      "ilannotlari": ilannotlari,
      "tur": _selectedTur.name,
    });
    print(id.toString());
    print(egitimdurumu);
    print(askerlikdurumu);
    print(cinsiyet);
    print(yassinir);
    print(lokasyon);
    print(sehir);
    print(issaatleri);
    print(meslek);
    print(maas);
    print(tecrubeyil.toString());
    print(basmalatarih);
    print(bitistarih);
    print(isaciklama);
    print(ilannotlari);
    print(_selectedTur.name);
  }

  List<Tur> _turler = Tur.getTur();
  List<DropdownMenuItem<Tur>> _dropdownMenuItems;
  Tur _selectedTur;
  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_turler);
    _selectedTur = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Tur>> buildDropdownMenuItems(List turler) {
    List<DropdownMenuItem<Tur>> items = List();
    for (Tur tur in turler) {
      items.add(
        DropdownMenuItem(
          value: tur,
          child: Text(tur.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Tur tur) {
    setState(() {
      _selectedTur = tur;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Color(0xFF73AEF5),
        backgroundColorEnd: Color(0xFF398AE5),
        title: Text("İlan Ver"),
      ),
      body: SingleChildScrollView(
        child: Container(
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
          padding: const EdgeInsets.all(25.0),
          child: Card(
            elevation: 10,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 75,
                    cursorColor: Colors.black,
                    style: kLabelStyleCV,
                    decoration: InputDecoration(
                      labelText: "Meslek",
                      hintText: "Şoför,Mühendis,Halkla İlişkiler...",
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    onSaved: (String value) {
                      meslek = value;
                    },
                  ),
                  TextFormField(
                    maxLength: 50,
                    cursorColor: Colors.black,
                    style: kLabelStyleCV,
                    decoration: InputDecoration(
                      labelText: "Eğitim Durumu",
                      hintText: "Ortaokul, Lise, Üniversite...",
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    onSaved: (String value) {
                      egitimdurumu = value;
                    },
                  ),
                  TextFormField(
                    maxLength: 50,
                    cursorColor: Colors.black,
                    style: kLabelStyleCV,
                    decoration: InputDecoration(
                      labelText: "Askerlik Durumu",
                      hintText: "Yok,Tecil...",
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    onSaved: (String value) {
                      askerlikdurumu = value;
                    },
                  ),
                  TextFormField(
                    maxLength: 20,
                    cursorColor: Colors.black,
                    style: kLabelStyleCV,
                    decoration: InputDecoration(
                      labelText: "Cinsiyet",
                      hintText: "Bay,Bayan,Farketmez...",
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    onSaved: (String value) {
                      cinsiyet = value;
                    },
                  ),
                  TextFormField(
                    maxLength: 20,
                    cursorColor: Colors.black,
                    style: kLabelStyleCV,
                    decoration: InputDecoration(
                      labelText: "Yaş Sınırı",
                      hintText: "20,22,30+...",
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    onSaved: (String value) {
                      yassinir = value;
                    },
                  ),
                  TextFormField(
                    maxLength: 75,
                    cursorColor: Colors.black,
                    style: kLabelStyleCV,
                    decoration: InputDecoration(
                      labelText: "İş Lokasyonu",
                      hintText: "İstanbul(Avrupa),Ankara merkez....",
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    onSaved: (String value) {
                      lokasyon = value;
                    },
                  ),
                  TextFormField(
                    maxLength: 75,
                    cursorColor: Colors.black,
                    style: kLabelStyleCV,
                    decoration: InputDecoration(
                      labelText: "Şehir",
                      hintText: "İstanbul,Ankara,İzmir...",
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    onSaved: (String value) {
                      sehir = value;
                    },
                  ),
                  TextFormField(
                    maxLength: 20,
                    cursorColor: Colors.black,
                    style: kLabelStyleCV,
                    decoration: InputDecoration(
                      labelText: "Maaş",
                      hintText: "2000,2300+,4000-5000...",
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    onSaved: (String value) {
                      maas = value;
                    },
                  ),
                  TextFormField(
                    maxLength: 20,
                    cursorColor: Colors.black,
                    style: kLabelStyleCV,
                    decoration: InputDecoration(
                      labelText: "İş Saatleri",
                      hintText: "9-5,8-6,esnek çalışma....",
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    onSaved: (String value) {
                      issaatleri = value;
                    },
                  ),
                  TextFormField(
                    maxLength: 20,
                    cursorColor: Colors.black,
                    style: kLabelStyleCV,
                    decoration: InputDecoration(
                      labelText: "İş Tecrübe Yıl",
                      hintText: "2,3,4...",
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    onSaved: (String value) {
                      tecrubeyil = value;
                    },
                  ),
                  TextFormField(
                    maxLength: 20,
                    cursorColor: Colors.black,
                    style: kLabelStyleCV,
                    initialValue: tarih,
                    decoration: InputDecoration(
                      labelText: "Başvuru Tarihi",
                      hintText: "Yıl-Ay-Gün",
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    onSaved: (String value) {
                      basmalatarih = value;
                    },
                  ),
                  TextFormField(
                    maxLength: 20,
                    cursorColor: Colors.black,
                    style: kLabelStyleCV,
                    decoration: InputDecoration(
                      labelText: "Başvuru Bitiş",
                      hintText: "2020-01-01(Yıl-Ay-Gün Şeklinde Giriniz...)",
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    onSaved: (String value) {
                      bitistarih = value;
                    },
                  ),
                  Text("İş Açıklaması"),
                  TextFormField(
                    maxLength: 190,
                    cursorColor: Colors.black,
                    style: kLabelStyleCV,
                    maxLines: 6,
                    decoration: InputDecoration.collapsed(
                      hintText: "İş Açıklamalarını Giriniz.(max 190)",
                    ),
                    onSaved: (String value) {
                      isaciklama = value;
                    },
                  ),
                  Text("İlan Notları"),
                  TextFormField(
                    maxLength: 200,
                    cursorColor: Colors.black,
                    style: kLabelStyleCV,
                    maxLines: 6,
                    decoration: InputDecoration.collapsed(
                      hintText: "İlan Notlarını Giriniz.(max 200)",
                    ),
                    onSaved: (String value) {
                      ilannotlari = value;
                    },
                  ),
                  Text("İlan Türü"),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 60.0,
                    child: DropdownButton(
                      isExpanded: true,
                      value: _selectedTur,
                      items: _dropdownMenuItems,
                      onChanged: onChangeDropdownItem,
                    ),
                  ),
                  RaisedButton(
                      elevation: 5.0,
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.green,
                      child: Text(
                        "İlan Ver",
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
                          ilanver();

                          showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('İlan'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text('İlan Verme Başarılı'),
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
                                              builder: (BuildContext context) =>
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Tur {
  String name;

  Tur(this.name);

  static List<Tur> getTur() {
    return <Tur>[
      Tur('Acil İş İlanı'),
      Tur('Part Time İlan'),
      Tur('Staj İlan'),
      Tur('Freelance İlan'),
      Tur('Engelli İş İlanı'),
      Tur('Normal İş İlanı'),
    ];
  }
}

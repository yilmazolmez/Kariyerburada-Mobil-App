import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:kariyerburadamobil/main.dart';
import 'package:kariyerburadamobil/screens/basvurankisiler.dart';
import 'package:kariyerburadamobil/screens/uye_login.dart';
import '../main.dart';

class Ilanlar extends StatefulWidget {
  @override
  _IlanlarState createState() => _IlanlarState();
}

class _IlanlarState extends State<Ilanlar> {
  Future<List> FirmaIlanlar() async {
    //ilanlar
    final response = await http.post(
        anaurl+"my_store/firmailanlar.php",
        body: {"id": id.toString()});

    return json.decode(response.body);
  }

  @override
  void initState() {
    FirmaIlanlar();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Color(0xFF73AEF5),
        backgroundColorEnd: Color(0xFF398AE5),
        title: Text("İlanlarım"),
      ),
      body: Container(
        child: FutureBuilder<List>(
          future: FirmaIlanlar(),
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
    );
  }
}

String newValue;

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
          child: Card(
            elevation: 6,
            child: ListTile(
              title: Text(list[i]["uyefirmaunvani"]),
              leading: Image.network(anaurl + list[i]["resim"]),
              subtitle: Text(list[i]["meslek"]),
              trailing: new DropdownButton<String>(
                  hint: Text(''),
                  onChanged: (String changedValue) {
                    newValue = changedValue;
                    if (newValue == "Başvuran Kişiler") {
                      print("başvuran kişiler");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BasvuranKisiler(
                                  int.tryParse(list[i]["isilanno"]))));
                    } else if (newValue == "İlan Sil") {
                      print("İlan Sil");
                      SilIlan(context, int.parse(list[i]["isilanno"]));
                    }
                  },
                  value: newValue,
                  items: <String>['Başvuran Kişiler', 'İlan Sil']
                      .map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList()),
            ),
          ),
        );
      },
    );
  }
}

Widget SilIlan(BuildContext context, int ilan_id) {
  //ilanlar
  final response = http.post(
      anaurl+"my_store/firmailansil.php",
      body: {"id": ilan_id.toString()});
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:kariyerburadamobil/main.dart';
import 'package:kariyerburadamobil/screens/detail.dart';
import 'package:kariyerburadamobil/screens/uye_login.dart';

class BasvurulanIlanlar extends StatefulWidget {
  @override
  _BasvurulanIlanlarState createState() => _BasvurulanIlanlarState();
}

class _BasvurulanIlanlarState extends State<BasvurulanIlanlar> {
  Future<List> basvurulanIlanlar() async {
    //ilanlar
    final response = await http.post(
        anaurl+"my_store/basvurulanilanlar.php",
        body: {"id": id.toString()});

    return json.decode(response.body);
  }

  @override
  void initState() {
    basvurulanIlanlar();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Color(0xFF73AEF5),
        backgroundColorEnd: Color(0xFF398AE5),
        title: Text("Başvurduğum İlanlar"),
      ),
      body: Container(
        child: FutureBuilder<List>(
          future: basvurulanIlanlar(),
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
              leading: Image.network(
                  "https://cdn.pixabay.com/photo/2018/02/26/14/45/check-3183213_960_720.png"),
              subtitle: Text(list[i]["meslek"]),
              trailing: new DropdownButton<String>(
                  hint: Text(''),
                  onChanged: (String changedValue) {
                    newValue = changedValue;
                    print(newValue);
                    SilIlan(context, int.parse(list[i]["isilanbasvuruno"]));
                  },
                  value: newValue,
                  items: <String>['Başvuru İptal'].map((String value) {
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
      anaurl+"my_store/ilansil.php",
      body: {"id": ilan_id.toString()});
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
}

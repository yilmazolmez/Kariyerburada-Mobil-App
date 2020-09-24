import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:kariyerburadamobil/screens/cvgoster2.dart';
import '../main.dart';

class BasvuranKisiler extends StatefulWidget {
  int id;

  BasvuranKisiler(this.id);

  @override
  _BasvuranKisilerState createState() => _BasvuranKisilerState();
}

class _BasvuranKisilerState extends State<BasvuranKisiler> {
  Future<List> BasvuranKisiler() async {
    //ilanlar
    final response = await http.post(
        anaurl+"my_store/basvurankisiler.php",
        body: {"id": widget.id.toString()});

    return json.decode(response.body);
  }

  @override
  void initState() {
    BasvuranKisiler();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Color(0xFF73AEF5),
        backgroundColorEnd: Color(0xFF398AE5),
        title: Text("İlana Başvuranlar"),
      ),
      body: Container(
        child: FutureBuilder<List>(
          future: BasvuranKisiler(),
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
              title: Text(list[i]["uyecvadisoyadi"]),
              leading: Image.network(
                  "https://cdn.pixabay.com/photo/2018/09/06/18/26/person-3658927_960_720.png"),
              subtitle: Text(list[i]["basvurutarihi"]),
              trailing: new DropdownButton<String>(
                  hint: Text(''),
                  onChanged: (String changedValue) {
                    newValue = changedValue;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            CvGoster2(int.tryParse(list[i]["uyecvno"]))));
                    print(list[i]["uyecvno"]);
                  },
                  value: newValue,
                  items: <String>['CV Görüntüle'].map((String value) {
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

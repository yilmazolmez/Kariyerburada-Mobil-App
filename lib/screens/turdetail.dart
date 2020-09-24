import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:kariyerburadamobil/screens/detail.dart';
import 'package:kariyerburadamobil/screens/uye_login.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class TurDetail extends StatefulWidget {
  String tur;
  TurDetail({this.tur});
  @override
  _TurDetailState createState() => _TurDetailState();
}

class _TurDetailState extends State<TurDetail> {
  Future<List> getData() async {
    //ilanlar
    final response = await http
        .post(anaurl+"my_store/ozelilanlar.php", body: {
      "tur": widget.tur,
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Color(0xFF73AEF5),
        backgroundColorEnd: Color(0xFF398AE5),
        title: widget.tur == "" ? Text("Tüm İlanlar") : Text("${widget.tur}"),
      ),
      body: Container(
        child: FutureBuilder<List>(
          future: getData(), //butona göre ilanlar
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }

            return snapshot.hasData
                ? ItemList(list: snapshot.data)
                : Center(
                    //child: CircularProgressIndicator(),
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
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
              elevation: 7,
              child: ListTile(
                title: Text(list[i]["uyefirmaunvani"]),
                //leading: Icon(Icons.archive),
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

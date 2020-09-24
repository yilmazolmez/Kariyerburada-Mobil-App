import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:kariyerburadamobil/main.dart';
import 'package:kariyerburadamobil/screens/detail.dart';
import 'package:kariyerburadamobil/screens/uye_login.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class IlanHizliAra extends StatefulWidget {
  String sehir;
  String meslek;

  IlanHizliAra({this.sehir, this.meslek});

  @override
  _IlanHizliAra createState() => _IlanHizliAra();
}

class _IlanHizliAra extends State<IlanHizliAra> {
  Future<List> getData() async {
    //ilanlar
    final response = await http
        .post(anaurl+"my_store/ilanhizliara.php", body: {
      "sehir": widget.sehir,
      "meslek": widget.meslek,
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Color(0xFF73AEF5),
        backgroundColorEnd: Color(0xFF398AE5),
        title: Text("Hizli arama : ${widget.meslek} & ${widget.sehir}"),
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

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:kariyerburadamobil/main.dart';
import 'package:kariyerburadamobil/utilities/constants.dart';
import 'package:kariyerburadamobil/screens/send_mail.dart';

class MailSend extends StatefulWidget {
  @override
  _MailSendState createState() => _MailSendState();
}

class _MailSendState extends State<MailSend> {
  final formKey = GlobalKey<FormState>();

  String nameSurname, email,emailsifre, subject, message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Color(0xFF73AEF5),
        backgroundColorEnd: Color(0xFF398AE5),
        title: Text('$title_string' + " /iletisim",
            style: TextStyle(color: Colors.white, fontSize: 16.0)),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          //color: Colors.greenAccent.shade100,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  //validator: validateName,
                  onSaved: (a) => nameSurname = a,
                  decoration: InputDecoration(
                    labelText: "Ad Soyad :",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.account_circle),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  //validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (a) => email = a,
                  decoration: InputDecoration(
                    labelText: "e-mail :",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  //validator: validateName,
                  onSaved: (a) => subject = a,
                  decoration: InputDecoration(
                    labelText: "Konu :",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.subject),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  //validator: validateName,
                  onSaved: (a) => message = a,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Mesaj :",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.message),
                  ),
                  maxLines: 4,
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton.icon(
                  icon: Icon(Icons.send),
                  label: Text("E-Mail Gonder"),
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      bool sendingStatus = await sendMail(
                          nameSurname, email,emailsifre, subject, message, context);
                      showSnackbar(sendingStatus);
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text("Temizle"),
                  onPressed: () {
                    formKey.currentState.reset();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String validateName(String value) {
    if (value.length < 6)
      return 'En az 6 karakter olmalıdır.';
    final RegExp nameExp = new RegExp(r'^[A-za-z ]+$');
    if (!nameExp.hasMatch(value)) return 'Lütfen geçerli bir isim giriniz.';
    return null;
  }

  String validateEmail(String value) {
    if (value.isEmpty) return 'e-mail boş bırakılamaz';

    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    //final RegExp nameExp = new RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');

    if (!regExp.hasMatch(value))
      return 'Geçersiz e-mail adresi';
    return null;
  }

  void showSnackbar(bool sendingStatus) {
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      margin: EdgeInsets.all(8),
      borderRadius: 15,
      backgroundGradient: LinearGradient(
        colors: [Colors.lightBlueAccent, Colors.green],
      ),
      backgroundColor: Colors.red,
      boxShadows: [
        BoxShadow(
          color: Colors.blue[800],
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
      //title: "Mesaj Bildirimi",
      message: sendingStatus == true
          ? "Mesaj Gönderildi. En kısa sürede geri dönüş sağlanacaktır."
          : "Mesaj Gönderilmede Hata Oluştu.",
      icon: Icon(
        sendingStatus == true ? Icons.done_all : Icons.error,
        size: 28.0,
        color: Colors.white,
      ),
      duration: Duration(seconds: 3),
      //leftBarIndicatorColor: Colors.blue[300],
    )..show(context);
  }
}
//String name, String email, String subject, String message,BuildContext context
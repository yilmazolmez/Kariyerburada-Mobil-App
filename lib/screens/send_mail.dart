import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<bool> sendMail(String name, String email, String emailsifre, String subject,
    String messages, BuildContext context) async {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "kariyerburada.com...\nMesaj Gönderiliyor...",
                style: TextStyle(color: Colors.white,fontSize: 36),
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }));
  bool sendStates;
  try {
    String _username = 'kariyerburadatest@gmail.com'; //EMAILIN GONDERILECEGI MAIL ADRESI
    String _password = 'Ym2020202000';

    final smtpServer = new SmtpServer('smtp.gmail.com',
        username: _username,
        password: _password,
        ignoreBadCertificate: false,
        ssl: false,
        allowInsecure: true);

    /* final smtpServer=hotmail(_username, _password); */

    String date = DateTime.now().toString();
    String sendmail = "mustafaaltundag34@gmail.com";//EMAILIN GELECEGI MAIL ADRESI
    if (emailsifre=="") {String sendmail = "mustafaaltundag34@gmail.com";}
    else{String sendmail = emailsifre;}//EMAILIN GELECEGI MAIL ADRESI
    String konu = subject;
    String mesajIcerigi =
        "Date/Tarih: $date \nSender name/ Gönderen İsim: $name \nSender e-mail/email: $email \nMesage/Mesaj: $messages";

    // Create our message.
    final message = Message()
      ..from = Address("$_username")
      ..recipients.add('$sendmail')
      ..subject = konu
      ..text = mesajIcerigi;

    try {
      final sendReport = await send(message, smtpServer);
      sendStates = true;
      print('Mesaj Iletildi: ' + sendReport.toString());
    } on MailerException catch (e) {
      sendStates = false;
      print('Mesaj Gonderilemedi.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  } catch (Exception) {
    //Handle Exception
  } finally {
    Navigator.pop(context);
  }
  return sendStates;
}
import 'package:flutter/material.dart';
import 'package:kariyerburadamobil/main.dart';
import 'package:kariyerburadamobil/screens/uye_login.dart';
import 'package:kariyerburadamobil/utilities/cities.dart';
import 'package:kariyerburadamobil/utilities/constants.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:kariyerburadamobil/utilities/secretQuestions.dart';
import 'package:http/http.dart' as http;

class FirmaSignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirmaSignUp();
  }
}

TextEditingController name = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController telefon = TextEditingController();
TextEditingController cevap = TextEditingController();
TextEditingController sifre = TextEditingController();

class _FirmaSignUp extends State {
  List<SecretQuestions> _secretQuestions = SecretQuestions.getSecretQuestions();
  List<DropdownMenuItem<SecretQuestions>> _dropdownMenuItems;
  SecretQuestions _selectedSecretQuestion;

  List<Cities> _cities = Cities.getCities();
  List<DropdownMenuItem<Cities>> _dropdownMenuItemsCities;
  Cities _selectedcity;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_secretQuestions);
    _selectedSecretQuestion = _dropdownMenuItems[0].value;
    _dropdownMenuItemsCities = buildDropdownMenuItemsCities(_cities);
    _selectedcity = _dropdownMenuItemsCities[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Cities>> buildDropdownMenuItemsCities(List cities) {
    List<DropdownMenuItem<Cities>> items = List();
    for (Cities city in cities) {
      items.add(
        DropdownMenuItem(
          value: city,
          child: Text(city.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItemCity(Cities selectCity) {
    setState(() {
      _selectedcity = selectCity;
    });
  }

  List<DropdownMenuItem<SecretQuestions>> buildDropdownMenuItems(
      List secretQuestions) {
    List<DropdownMenuItem<SecretQuestions>> items = List();
    for (SecretQuestions secretQuestion in secretQuestions) {
      items.add(
        DropdownMenuItem(
          value: secretQuestion,
          child: Text(secretQuestion.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(SecretQuestions selectedQuestion) {
    setState(() {
      _selectedSecretQuestion = selectedQuestion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('Kariyer Burada'),
        backgroundColorStart: Color(0xFF73AEF5),
        backgroundColorEnd: Color(0xFF398AE5),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF73AEF5),
                Color(0xFF61A4F1),
                Color(0xFF478DE0),
                Color(0xFF398AE5),
              ],
              stops: [0.1, 0.4, 0.7, 0.9],
            )),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 30.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Firma Kayıt",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "OpenSans",
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildName(),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildEmail(),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buildPhone(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    //Şehirler
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Şehir",
                        style: kLabelStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        height: 60.0,
                        child: DropdownButton(
                          isExpanded: true,
                          value: _selectedcity,
                          items: _dropdownMenuItemsCities,
                          onChanged: onChangeDropdownItemCity,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    //Şehirler
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gizli Soru",
                        style: kLabelStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        height: 60.0,
                        child: DropdownButton(
                          isExpanded: true,
                          value: _selectedSecretQuestion,
                          items: _dropdownMenuItems,
                          onChanged: onChangeDropdownItem,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buildSecretAnswer(),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buildPassword(),
                  _buildLoginButton(
                      context, _selectedcity, _selectedSecretQuestion),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildLoginButton(BuildContext context, Cities _selectedcity,
    SecretQuestions _selectedSecretQuestion) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25.0),
    width: double.infinity,
    child: RaisedButton(
      elevation: 5.0,
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white,
      child: Text(
        "Firma Kayıt",
        style: TextStyle(
          color: Color(0xFF527DAA),
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: "OpenSans",
        ),
      ),
      onPressed: () => signIn(context, _selectedcity, _selectedSecretQuestion),
    ),
  );
}

void signIn(BuildContext context, Cities _selectedcity,
    SecretQuestions _selectedSecretQuestion) {
  var url = "my_store/firmaadddata.php";
  http.post(anaurl+url, body: {
    "name": name.text,
    "email": email.text,
    "telefon": telefon.text,
    "cevap": cevap.text,
    "sifre": sifre.text,
    "sehir": _selectedcity.name,
    "gizlisoru": _selectedSecretQuestion.name
  });
  /* var alert = AlertDialog(
    title: Text("İşlem"),
    content: Text("Kayıt Başarılı"),
  );
  showDialog(context: context, builder: (BuildContext context) => alert); */
  name.clear();
  email.clear();
  telefon.clear();
  cevap.clear();
  sifre.clear();
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
}

Widget _buildEmail() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Firma Email",
        style: kLabelStyle,
      ),
      SizedBox(
        height: 10.0,
      ),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextField(
          maxLength: 35,
          controller: email,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.white, fontFamily: "OpenSans"),
          decoration: InputDecoration(
              counter: Offstage(),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: "Email Adresi Giriniz..."),
        ),
      ),
    ],
  );
}

Widget _buildName() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Firma Ünvan",
        style: kLabelStyle,
      ),
      SizedBox(
        height: 10.0,
      ),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextField(
          maxLength: 45,
          controller: name,
          style: TextStyle(color: Colors.white, fontFamily: "OpenSans"),
          decoration: InputDecoration(
              counter: Offstage(),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_box,
                color: Colors.white,
              ),
              hintText: "Ünvan"),
        ),
      ),
    ],
  );
}

Widget _buildPhone() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Firma Telefon",
        style: kLabelStyle,
      ),
      SizedBox(
        height: 10.0,
      ),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextField(
          maxLength: 15,
          controller: telefon,
          style: TextStyle(color: Colors.white, fontFamily: "OpenSans"),
          decoration: InputDecoration(
              counter: Offstage(),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              hintText: "Telefon"),
        ),
      ),
    ],
  );
}

Widget _buildPassword() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Şifre",
        style: kLabelStyle,
      ),
      SizedBox(
        height: 10.0,
      ),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextField(
          maxLength: 25,
          controller: sifre,
          obscureText: true,
          style: TextStyle(color: Colors.white, fontFamily: "OpenSans"),
          decoration: InputDecoration(
              counter: Offstage(),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: "Şifre Giriniz..."),
        ),
      ),
    ],
  );
}

Widget _buildSecretAnswer() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Gizli Soru Cevap",
        style: kLabelStyle,
      ),
      SizedBox(
        height: 10.0,
      ),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextField(
          maxLength: 25,
          controller: cevap,
          style: TextStyle(color: Colors.white, fontFamily: "OpenSans"),
          decoration: InputDecoration(
              counter: Offstage(),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.security,
                color: Colors.white,
              ),
              hintText: "Gizli Soru Cevabınız"),
        ),
      ),
    ],
  );
}

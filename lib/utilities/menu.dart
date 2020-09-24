import 'package:flutter/material.dart';

class Menu {
  Menu({this.title, this.icon});
  String title;
  IconData icon;

  static const String UyeOl = "Üye Ol";
  static const String UyeGiris = "Üye Giriş";
  static const String FirmaKayit = "Firma Kayıt";
  static const String FirmaGiris = "Firma Giriş";
  static const String Cv = "CV";
  static const String Cikis = "Çıkış";
  static const String BasvurulanIlanlar = "Basvurulan İlanlar";
  static const String Tum = "Tüm İş İlanı";
  static const String Acil = "Acil İş İlanı";
  static const String PartTime = "Part Time İlan";
  static const String Staj = "Staj İlan";
  static const String Freelance = "Freelance İlan";
  static const String Engelli = "Engelli İş İlanı";
  static const String FirmaProfil = "Firma Profili";

  static const String IlanVer = "İlan Ver";

  static const String Ilanlarim = "İlanlarım";

  static const List<String> choices = <String>[
    UyeOl ,
    UyeGiris,
    FirmaKayit,
    FirmaGiris
  ];

  static const List<String> choices_firma = <String>[
    IlanVer,
    Ilanlarim,
    FirmaProfil,
    Cikis
  ];

  static const List<String> choices_uye = <String>[
    Cv,
    BasvurulanIlanlar,
    Cikis
  ];
  static const List<String> choicesTur = <String>[
    Tum,
    Acil,
    Staj,
    PartTime,
    Engelli
  ];
}

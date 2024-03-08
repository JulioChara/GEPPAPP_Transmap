
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPGlobal {

  static final SPGlobal _instance = SPGlobal._();

  SPGlobal._();

  factory SPGlobal(){
    return _instance;
  }

  late SharedPreferences _prefs;

  Future<void> initShared() async{
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isLogin => _prefs.getBool("isLogin") ?? false;

  set isLogin(bool value){
    _prefs.setBool("isLogin", value);
  }

  String get idUser => _prefs.getString("idUser") ?? "";
  set idUser(String value){
    _prefs.setString("idUser", value);
  }

  String get rolId => _prefs.getString("rolId") ?? "";
  set rolId(String value){
    _prefs.setString("rolId", value);
  }

  String get rolName => _prefs.getString("rolName") ?? "";
  set rolName(String value){
    _prefs.setString("rolName", value);
  }

  String get usNombre => _prefs.getString("usNombre") ?? "";
  set usNombre(String value){
    _prefs.setString("usNombre", value);
  }

  String get usIdPlaca => _prefs.getString("usIdPlaca") ?? "";
  set usIdPlaca(String value){
    _prefs.setString("usIdPlaca", value);
  }
  String get usIdPlacaDesc => _prefs.getString("usIdPlacaDesc") ?? "";
  set usIdPlacaDesc(String value){
    _prefs.setString("usIdPlacaDesc", value);
  }
  String get usIdPlacaRef => _prefs.getString("usIdPlacaRef") ?? "";
  set usIdPlacaRef(String value){
    _prefs.setString("usIdPlacaRef", value);
  }
  String get usIdPlacaRefDesc => _prefs.getString("usIdPlacaRefDesc") ?? "";
  set usIdPlacaRefDesc(String value){
    _prefs.setString("usIdPlacaRefDesc", value);
  }


  String get spInformeCloud => _prefs.getString("spInformeCloud") ?? "";  //1 DESCARGDO // 0 SUBIDO REGRESA
  set spInformeCloud(String value){
    _prefs.setString("spInformeCloud", value);
  }

  //todo: GUIAS IMPRESION
  String get spGuiaOffline => _prefs.getString("spGuiaOffline") ?? "";  //1 DESCARGDO // 0 SUBIDO REGRESA
  set spGuiaOffline(String value){
    _prefs.setString("spGuiaOffline", value);
  }

  //PARA VALORES DE IMPRESION XD//

  String get spImpEmpEmpresa => _prefs.getString("spImpEmpEmpresa") ?? "";
  set spImpEmpEmpresa(String value){
    _prefs.setString("spImpEmpEmpresa", value);
  }
  String get spImpEmpRuc => _prefs.getString("spImpEmpRuc") ?? "";
  set spImpEmpRuc(String value){
    _prefs.setString("spImpEmpRuc", value);
  }

  String get spImpEmpDireccion => _prefs.getString("spImpEmpDireccion") ?? "";
  set spImpEmpDireccion(String value){
    _prefs.setString("spImpEmpDireccion", value);
  }

  String get spImpEmpTelefono => _prefs.getString("spImpEmpTelefono") ?? "";
  set spImpEmpTelefono(String value){
    _prefs.setString("spImpEmpTelefono", value);
  }


//todo: cosmeticos

  // Color get colorA => Color(_prefs.getInt('color') ?? Colors.green.value);
  // set colorA(Color value) {
  //   //_prefs.getInt("colorA", value);
  // }
  Color get colorA => Color(_prefs.getInt('colorA') ?? Colors.green.value);
  set colorA(Color value) {
    _prefs.setInt('colorA', value.value);
  }

  Color get colorB => Color(_prefs.getInt('colorB') ?? Colors.deepPurple.value);
  set colorB(Color value) {
    _prefs.setInt('colorB', value.value);
  }



}
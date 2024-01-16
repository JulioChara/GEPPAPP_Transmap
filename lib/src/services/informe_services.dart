import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transmap_app/src/models/informes_model.dart';
import 'package:transmap_app/src/constants/constants.dart';


class InformeService {


  Future<List<InformelistaModel>> cargarInforme(String initDate, String endDate) async {
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String  idUser =  prefs.getString('idUser')!;
      print(idUser);

      // var resp = await http.post(kUrl+"/ListadoInformes",
      //     headers: {
      //       'Content-type': 'application/json',
      //       'Accept': 'application/json'
      //     },
      String url = kUrl + "/ListadoInformes";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({'FecIni': initDate, 'FecFin': endDate, 'usr':idUser}));

      var decodeData = json.decode(resp.body);

      final List<InformelistaModel> informes = [];

      decodeData.forEach((informeMap) {
        final prodTemp = InformelistaModel.fromJson(informeMap);
        informes.add(prodTemp);
      });
      return informes;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<String> estadoAnularInforme(String id,String idUser) async {

    try{

      print(jsonEncode({'Id': id,'usr': idUser,}));

      // var resp = await http.post(kUrl+"/AnularInforme",
      //     headers: {
      //       'Content-type': 'application/json',
      //       'Accept': 'application/json'
      //     },
      String url = kUrl + "/AnularInforme";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({'Id': id,'usr': idUser,}));

      var decodeData = json.decode(resp.body);

      return decodeData["resultado"];


    }catch(e){
      print(e);
      return "0";
    }

  }



  Future<String> registrarInforme(InformeModel informe) async{

    try {

      InformeModel f = new  InformeModel();


      print(informe.toJson());

      // var resp = await http.post(kUrl+"/GenerarInforme",
      //     headers: {
      //       'Content-type': 'application/json',
      //       'Accept': 'application/json'
      //     },
      String url = kUrl + "/GenerarInforme";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(informe.toJson()));
      print(jsonEncode(informe.toJson()));
      var decodeData = json.decode(resp.body);

      print(decodeData["resultado"]);

      return decodeData["resultado"];



    } catch (e) {
      print(e);
    return "0";
    }
  }


}

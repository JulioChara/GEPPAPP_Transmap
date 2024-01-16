import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transmap_app/src/models/consumosListado_model.dart';
import 'package:transmap_app/src/constants/constants.dart';


class ConsumoService {


  Future<List<consumoModel>> cargarConsumos() async {
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String  idViaje =  prefs.getString('IdVijae')! ;

      String url = kUrl + "/ListadoConsumos";
      http.Response response = await http.post(Uri.parse(url),

      //var resp = await http.post(kUrl+"/ListadoConsumos",
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({ 'viaje':idViaje}));

      var decodeData = json.decode(response.body);

      final List<consumoModel> consumos = [];

      decodeData.forEach((consumoMap) {
        final prodTemp = consumoModel.fromJson(consumoMap);
        consumos.add(prodTemp);
      });
      return consumos;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<String> estadoAnularConsumo(String id) async {

    try{

      // var resp = await http.post(kUrl+"/AnularConsumo",
      String url = kUrl + "/AnularConsumo";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'Id': id,'usr':"1"}));

      var decodeData = json.decode(resp.body);

      return decodeData["resultado"];


    }catch(e){
      print(e);
      return "0";
    }

  }



  Future<String> vincularConsumo(consumoModel consumo) async{

    try {

      consumoModel f = new  consumoModel();


      print(consumo.toJson());

      // var resp = await http.post(kUrl+"/VincularConsumo",
      String url = kUrl + "/VincularConsumo";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(consumo.toJson()));
      print(jsonEncode(consumo.toJson()));
      var decodeData = json.decode(resp.body);

      print(decodeData["resultado"]);

      return decodeData["resultado"];



    } catch (e) {
      print(e);
      return "0";
    }
  }


}

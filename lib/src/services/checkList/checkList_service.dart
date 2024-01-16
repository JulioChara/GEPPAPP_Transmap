


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transmap_app/src/constants/constants.dart';
import 'package:transmap_app/src/models/checkList/checkList_model.dart';
import 'package:transmap_app/src/models/general_model.dart';
import 'package:transmap_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transmap_app/utils/sp_global.dart';


class CheckListServices {

  SPGlobal _prefs = SPGlobal();

  Future<List<CheckListModel>> postCheckList_ObtenerListaGeneral(String id, String FecIni, String FecFin) async {
    List<CheckListModel> modelList = [];
    String url = kUrl + "/CheckList_ObtenerListaGeneral";
    print("Send Data---------");
    print(id);
    print(FecIni);
    print(FecFin);
    print(_prefs.idUser);
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({'Id': id,
          "FecIni": FecIni,
          "FecFin": FecFin,
          "idUsuario": _prefs.idUser
        }));
    print(response.statusCode);
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      modelList = list.map((e) => CheckListModel.fromJson(e)).toList();
      return modelList;
    }
    return modelList;
  }

  Future<List<TiposModel>> CheckList_ObtenerTiposOpciones() async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/CheckList_ObtenerTiposOpciones";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });

      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => TiposModel.fromJson(e)).toList();
        return tiposList;
      }
      return tiposList;

    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<TiposModel>> CheckList_ObtenerTiposCategorias() async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/CheckList_ObtenerTiposCategorias";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });

      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => TiposModel.fromJson(e)).toList();
        return tiposList;
      }
      return tiposList;

    } catch (e) {
      print(e);
      return [];
    }
  }


  // Future<String> CheckList_GenerarCheckDiario(CheckListModel informe) async{
  //   try {
  //     print(informe.toJson());
  //     String url = kUrl + "/CheckList_GenerarCheckDiario";
  //     http.Response response = await http.post(Uri.parse(url),
  //         headers: {
  //           'Content-type': 'application/json',
  //           'Accept': 'application/json'
  //         },
  //         body: jsonEncode(informe.toJson()));
  //     print(jsonEncode(informe.toJson()));
  //     var decodeData = json.decode(response.body);
  //
  //     print(decodeData["resultado"]);
  //
  //     return decodeData["resultado"];
  //   } catch (e) {
  //     print(e);
  //     return "0";
  //   }
  // }

  Future<TestClassModel> CheckList_GenerarCheckDiario(CheckListModel informe) async{
    try {
      print(informe.toJson());
      TestClassModel modi = new TestClassModel();
      String url = kUrl + "/CheckList_GenerarCheckDiario";
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(informe.toJson()));
      print(jsonEncode(informe.toJson()));

     //  print("-----------PRE DATA RECIBIDA -----------");
     //  TestClassModel modi = json.decode(response.body);
     //
     //  print("-----------POST DATA RECIBIDA -----------");
     //  print(jsonEncode(modi));
     //
     // // return TestClassModel.fromJson(response.data);
     //  return modi;
      print(response.statusCode);
      if (response.statusCode == 200) {
        modi = TestClassModel.fromJson(json.decode(response.body));
        //pedidosmodel = PedidosDeliveryModel.fromJson(json.decode(response.body));
        return modi;
      }
      return modi;


    } catch (e) {
      print(e);
      TestClassModel modi =new TestClassModel();
      return modi;
    }
  }

  Future<String> CheckList_ConsultaExistenciaxUsuario(String idUsuario) async{

    try {

      String url = kUrl + "/CheckList_ConsultaExistenciaxUsuario";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'idUsuario': idUsuario}));
      // body: jsonEncode(turno.toJson()));
      //   print(jsonEncode(turno.toJson()));
      var decodeData = json.decode(resp.body);
      print(decodeData["resultado"]);
      return decodeData["resultado"];
    } catch (e) {
      print(e);
      return "error";
    }
  }



}
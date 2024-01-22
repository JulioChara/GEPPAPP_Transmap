




import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transmap_app/src/constants/constants.dart';
import 'package:transmap_app/src/models/guia_model.dart';
import 'package:transmap_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transmap_app/utils/sp_global.dart';

class GuiasElectronicasServices {

  SPGlobal _prefs = SPGlobal();




  Future<List<SubClientesModel>> obtenerSubClientesxCliente(String idCliente) async {
    try {
      String url = kUrl + "/SubClientes_ObtenerSubClientesxCliente";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({'Id': idCliente}));
      print(resp.statusCode);
      var decodeData = json.decode(resp.body);
      final List<SubClientesModel> modelData = [];
      decodeData.forEach((map) {
        final prodTemp = SubClientesModel.fromJson(map);
        modelData.add(prodTemp);
      });
      return modelData;
    } catch (e) {
      print(e);
      return [];
    }
  }





  Future<List<TiposModel>> GuiasElectronicas_ObtenerConductores() async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerConductores";
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



  Future<List<TiposModel>> GuiasElectronicas_ObtenerClientes() async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerClientes";
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


  Future<List<TiposModel>> GuiasElectronicas_ObtenerPlacasAll() async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerPlacasAll";
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


  Future<List<TiposModel>> GuiasElectronicas_ObtenerTipoSituacion() async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerTipoSituacion";
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




  Future<List<TiposModel>> GuiasElectronicas_ObtenerTipoTipos() async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerTipoTipos";
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



  Future<List<TiposModel>> GuiasElectronicas_ObtenerUbigeoFinal() async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerUbigeoFinal";
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



  Future<List<TiposModel>> GuiasElectronicas_ObtenerUbigeoFinalPost(String term) async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerUbigeoFinalPost";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({'Text': term,}));

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



  // todo: OLD

  List<TiposModel> Old_cargarTipoSituacion() {
    List<TiposModel> list = [
      new TiposModel(
          tipoDescripcion: "CONTADO",
          tipoId: "10181"),
          // titulo: "TipoSituacion"),
      new TiposModel(
        //  categoria: "",
          tipoDescripcion: "CREDITO",
          tipoId: "10182"),
       //  titulo: "TipoSituacion"),
    ];

    return list;
  }


  List<TiposModel> Old_cargarTipoProducto() {
    List<TiposModel> list = [
      new TiposModel(
          tipoDescripcionCorta: "",
          tipoDescripcion: "COMBUSTIBLE",
          tipoId: "75"),
         // titulo: "TiposProductos"),
      new TiposModel(
          tipoDescripcionCorta: "",
          tipoDescripcion: "AGUA",
          tipoId: "76"),
         // titulo: "TiposProductos"),
      new TiposModel(
          tipoDescripcionCorta: "",
          tipoDescripcion: "SERVICIO DE CARGA DE AGREGADOS - TOLVA OTROS",
          tipoId: "79"),
         // titulo: "TiposProductos"),
    ];

    return list;
  }











}
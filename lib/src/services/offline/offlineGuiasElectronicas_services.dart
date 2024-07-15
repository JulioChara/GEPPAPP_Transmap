
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transmap_app/src/constants/constants.dart';
import 'package:transmap_app/src/models/general_model.dart';
import 'package:transmap_app/src/models/offline/offlineGuiasElectronicas_model.dart';
// import 'package:transmap_app/src/models/guia_model.dart';
// import 'package:transmap_app/src/models/guiasElectronicas/guiasElectronicas_model.dart';
// import 'package:transmap_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transmap_app/utils/sp_global.dart';

class OfflineServices {

  SPGlobal _prefs = SPGlobal();



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
        for (var item in tiposList) {
          item.tipoOffline = 'conductores';  // Reemplaza 'tu_valor' con el valor que deseas asignar
        }
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
        for (var item in tiposList) {
          item.tipoOffline = 'clientes';
        }
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
        for (var item in tiposList) {
          if (item.idTipoGeneralFkDesc == "VEHICULO")
            {
              item.tipoOffline = 'vehiculos';
            }else
              {
                item.tipoOffline = 'placas';
              }

        }
        return tiposList;
      }
      return tiposList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  List<TiposModel> Old_cargarTipoSituacion() {
    List<TiposModel> list = [
      new TiposModel(
          tipoOffline: "tipoTipos",
          tipoDescripcion: "CONTADO",
          tipoId: "10181"),
      // titulo: "TipoSituacion"),
      new TiposModel(
        //  categoria: "",
          tipoOffline: "tipoTipos",
          tipoDescripcion: "CREDITO",
          tipoId: "10182"),
      //  titulo: "TipoSituacion"),
    ];

    return list;
  }


  List<TiposModel> Old_cargarTipoProducto() {
    List<TiposModel> list = [
      new TiposModel(
        tipoOffline: "producto",
          tipoDescripcionCorta: "",
          tipoDescripcion: "COMBUSTIBLE",
          tipoId: "75"),
      // titulo: "TiposProductos"),
      new TiposModel(
          tipoOffline: "producto",
          tipoDescripcionCorta: "",
          tipoDescripcion: "AGUA",
          tipoId: "76"),
      // titulo: "TiposProductos"),
      new TiposModel(
          tipoOffline: "producto",
          tipoDescripcionCorta: "",
          tipoDescripcion: "SERVICIO DE CARGA DE AGREGADOS - TOLVA OTROS",
          tipoId: "79"),
      // titulo: "TiposProductos"),
    ];

    return list;
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
        for (var item in tiposList) {
          item.tipoOffline = 'situacion';
        }
        return tiposList;
      }
      return tiposList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<TiposModel>> GuiasElectronicas_ObtenerTipoUnidadMedida() async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerTipoUnidadMedida";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => TiposModel.fromJson(e)).toList();
        for (var item in tiposList) {
          item.tipoOffline = 'tipoUnidadMedida';
        }
        return tiposList;
      }
      return tiposList;
    } catch (e) {
      print(e);
      return [];
    }
  }



  Future<List<SubProductosModel>> Offline_GuiasElectronicas_ObtenerSubProductos() async {
    try {
      List<SubProductosModel> tiposList = [];
      String url = kUrl + "/Offline_GuiasElectronicas_ObtenerSubProductos";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => SubProductosModel.fromJson(e)).toList();
        // for (var item in tiposList) {
        //   item.tipoOffline = 'subProductos';
        // }
        return tiposList;
      }
      return tiposList;
    } catch (e) {
      print(e);
      return [];
    }
  }



  Future<List<SubClientesModel>> Offline_GuiasElectronicas_ObtenerSubClientes() async {
    try {
      List<SubClientesModel> tiposList = [];
      String url = kUrl + "/Offline_GuiasElectronicas_ObtenerSubClientes";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => SubClientesModel.fromJson(e)).toList();
        // for (var item in tiposList) {
        //   item.tipoOffline = 'subProductos';
        // }
        return tiposList;
      }
      return tiposList;
    } catch (e) {
      print(e);
      return [];
    }
  }



  Future<List<ClientesUbigeoModel>> Offline_GuiasElectronicas_ObtenerDireccionesxCliente() async {
    try {
      List<ClientesUbigeoModel> tiposList = [];
      String url = kUrl + "/Offline_GuiasElectronicas_ObtenerDireccionesxCliente";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });

      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => ClientesUbigeoModel.fromJson(e)).toList();
        return tiposList;
      }
      return tiposList;
    } catch (e) {
      print(e);
      return [];
    }
  }



  /// ///////////////////////////////////////////
  /// ////////// todo: SUBIR DATA ///////////////
  /// ///////////////////////////////////////////

  Future<TestClassModel> Offline_GuiasElectronicas_SubirInformacion(
      List<GuiasElectronicasModel> guias, List<GuiasElectronicasDetalleModel> detalle,List<GuiasElectronicasConductoresModel> conductores, List<GuiasElectronicasPlacasModel> placas ) async {
    try {
      // print(detalle.toJson());
      TestClassModel model = new TestClassModel();
      var guiasJson = jsonEncode(guias.map((e) => e.toJson()).toList());
      var detallesJson = jsonEncode(detalle.map((e) => e.toJson()).toList());
      var conductoresJson = jsonEncode(conductores.map((e) => e.toJson()).toList());
      var placasJson = jsonEncode(placas.map((e) => e.toJson()).toList());


      String url = kUrl + "/Offline_GuiasElectronicas_SubirInformacion";
      http.Response response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        //body: jsonEncode(detalle));
        body: jsonEncode({
          "guias": guias,
          "detalle": detalle,
          "conductores": conductores,
          "placas": placas,
        }),
      );
      //  print(jsonEncode(detalle.toJson()));
      // print(jsonEncode(body));
      var decodeData = json.decode(response.body);
      model = TestClassModel.fromJson(decodeData);
      return model;
     // return decodeData["resultado"];
    } catch (e) {
      print(e);
      TestClassModel model = new TestClassModel();
      model.resultado ="0";
      model.id ="0";
      model.mensaje ="Error en Future";
      return model;
    }
  }




}



import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transmap_app/src/models/cliente_model.dart';
import 'package:transmap_app/src/models/conductor_model.dart';
import 'package:transmap_app/src/constants/constants.dart';
import 'package:transmap_app/src/models/extra_model.dart';
import 'package:transmap_app/src/models/general_model.dart';
import 'package:transmap_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transmap_app/src/models/login_model.dart';
import 'package:transmap_app/src/models/placa_model.dart';
import 'package:transmap_app/src/models/placa_preferencial_model.dart';
import 'package:transmap_app/src/models/consumosListado_model.dart';

class DetailServices {
  Future<List<Conductor>> cargarConductor() async {
    try {
      // var resp = await http.get(kUrl + "/UtilidadesGuias");
      // String url = kUrl + "/VincularConsumo";
      String url = kUrl + "/UtilidadesGuias";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
      });
      var decodeData = json.decode(resp.body);

      final List<Conductor> conductores = [];

      decodeData["Conductores"].forEach((item) {
        final conductorTemp = Conductor.fromJson(item);
        conductores.add(conductorTemp);
      });

      return conductores;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Cliente>> cargarCliente() async {
    try {
      // var resp = await http.get(kUrl + "/ObtenerClientes");
      String url = kUrl + "/ObtenerClientes";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
          });
      var decodeData = json.decode(resp.body);

      final List<Cliente> clientes = [];

      decodeData["Clientes"].forEach((item) {
        final clienteTemp = Cliente.fromJson(item);
        clientes.add(clienteTemp);
      });

      return clientes;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Remitente>> cargarRemitente() async {
    try {
      // var resp = await http.get(kUrl + "/ObtenerClientes");
      String url = kUrl + "/ObtenerClientes";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
          });
      var decodeData = json.decode(resp.body);

      final List<Remitente> remitente = [];

      decodeData["Clientes"].forEach((item) {
        final remitenteTemp = Remitente.fromJson(item);
        remitente.add(remitenteTemp);
      });

      return remitente;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Destinatario>> cargarDestinatario() async {
    try {
      // var resp = await http.get(kUrl + "/ObtenerClientes");
      String url = kUrl + "/ObtenerClientes";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });

      var decodeData = json.decode(resp.body);

      final List<Destinatario> destinatario = [];

      decodeData["Clientes"].forEach((item) {
        final destinatarioTemp = Destinatario.fromJson(item);
        destinatario.add(destinatarioTemp);
      });

      return destinatario;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<PlacaPreferencial>> cargarPlacaPreferencial() async {
    try {
      // var resp = await http.get(kUrl + "/UtilidadesGuias");
      String url = kUrl + "/UtilidadesGuias";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      var decodeData = json.decode(resp.body);

      final List<PlacaPreferencial> placaPreferenciales = [];
      decodeData["PlacasReferencial"].forEach((item) {
        final placaTemp = PlacaPreferencial.fromJson(item);
        placaPreferenciales.add(placaTemp);
      });
      return placaPreferenciales;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Placa>> cargarPlaca() async {
    try {
      // var resp = await http.get(kUrl + "/UtilidadesGuias");
      String url = kUrl + "/UtilidadesGuias";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });

      var decodeData = json.decode(resp.body);

      final List<Placa> placas =[];

      decodeData["Placas"].forEach((item) {
        final placaTemp = Placa.fromJson(item);
        placas.add(placaTemp);
      });


      return placas;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<TipoTipo>> cargarTipoTipo() async {
    try {
      // var resp = await http.get(kUrl + "/UtilidadesGuias");
      String url = kUrl + "/UtilidadesGuias";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });

      var decodeData = json.decode(resp.body);

      final List<TipoTipo> tipos = [];

      decodeData["TipoTipo"].forEach((item) {
        final tipoTemp = TipoTipo.fromJson(item);
        tipos.add(tipoTemp);
      });


      return tipos;

    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<vinculacionModel>> cargarVinculacion() async {
    try {
      // var resp = await http.get(kUrl + "/ObtenerDocumentosSinVincular");
      String url = kUrl + "/ObtenerDocumentosSinVincular";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });

      var decodeData = json.decode(resp.body);

      final List<vinculacionModel> vinculacion = [];

      decodeData["Documentos"].forEach((item) {
        final documentoTemp = vinculacionModel.fromJson(item);
        vinculacion.add(documentoTemp);
      });

      return vinculacion;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<TipoPrioridad>> cargarTipoPrioridad() async {
    try {
      // var resp = await http.get(kUrl + "/UtilidadesGuias");
      String url = kUrl + "/UtilidadesGuias";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });

      var decodeData = json.decode(resp.body);

      final List<TipoPrioridad> tipos = [];

      decodeData["TipoPrioridad"].forEach((item) {
        final tipoTemp = TipoPrioridad.fromJson(item);
        tipos.add(tipoTemp);
      });

      return tipos;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<TipoInsidencia>> cargarTipoInsidencias() async {
    try {
      // var resp = await http.get(kUrl + "/UtilidadesGuias");
      String url = kUrl + "/UtilidadesGuias";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });


      var decodeData = json.decode(resp.body);

      final List<TipoInsidencia> tipos = [];

      decodeData["TipoInsidencias"].forEach((item) {
        final tipoTemp = TipoInsidencia.fromJson(item);
        tipos.add(tipoTemp);
      });

      return tipos;
    } catch (e) {
      print(e);
      return [];
    }
  }

  List<TipoProducto> cargarTipoProducto() {
    List<TipoProducto> list = [
      new TipoProducto(
          categoria: "",
          descripcion: "COMBUSTIBLE",
          id: "75",
          titulo: "TiposProductos"),
      new TipoProducto(
          categoria: "",
          descripcion: "AGUA",
          id: "76",
          titulo: "TiposProductos"),
      new TipoProducto(
          categoria: "",
          descripcion: "SERVICIO DE CARGA DE AGREGADOS - TOLVA OTROS",
          id: "79",
          titulo: "TiposProductos"),
    ];

    return list;
  }




  List<TipoSituacion> cargarTipoSituacion() {
    List<TipoSituacion> list = [
      new TipoSituacion(
          categoria: "",
          descripcion: "CONTADO",
          id: "10181",
          titulo: "TipoSituacion"),
      new TipoSituacion(
          categoria: "",
          descripcion: "CREDITO",
          id: "10182",
          titulo: "TipoSituacion"),
    ];

    return list;
  }


  Future<List<SubProductosModel>> getGuias_ObtenerSubProductos(String id) async {
    try {
      String url = kUrl + "/Guias_ObtenerSubProductos";
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'Id': id}));

      var decodeData = json.decode(response.body);

      final List<SubProductosModel> tipos = [];
      decodeData.forEach((item) {
        final tipoTemp = SubProductosModel.fromJson(item);
        tipos.add(tipoTemp);
      });

      return tipos;
    } catch (e) {
      print(e);
      return [];
    }
  }


  Future<List<LoginTiposModel>> Login_ObtenerPlacas() async {
    try {
      List<LoginTiposModel> tiposList = [];
      // String url = kUrl + "/Login_ObtenerPlacas";
      String url = kUrl + "/Login_ObtenerPlacas_Login";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });

      // var decodeData = json.decode(resp.body);
      // final List<Placa> placas =[];
      // decodeData["Placas"].forEach((item) {
      //   final placaTemp = Placa.fromJson(item);
      //   placas.add(placaTemp);
      // });
      // return placas;
      //
      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => LoginTiposModel.fromJson(e)).toList();
        return tiposList;
      }
      return tiposList;

    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<LoginTiposModel>> Login_ObtenerSubPlacas() async {
    try {
      List<LoginTiposModel> tiposList = [];
      // String url = kUrl + "/Login_ObtenerSubPlacas";
      String url = kUrl + "/Login_ObtenerSubPlacas_Login";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });

      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => LoginTiposModel.fromJson(e)).toList();
        return tiposList;
      }
      return tiposList;

    } catch (e) {
      print(e);
      return [];
    }
  }




  Future<TestClassModel> AppInfo_ObtenerInfoApp() async {
    try {
      TestClassModel model = new TestClassModel();

      String url = kUrl + "/AppInfo_ObtenerInfoApp";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });

      var decodeData = json.decode(resp.body);

      // Aquí debes llenar tu modelo con los datos decodificados.
      // Esto es solo un ejemplo, debes ajustarlo a la estructura de tu modelo y los datos que recibes.
      model.mensaje = decodeData['mensaje'];

      return model;
    } catch (e) {
      print(e);
      TestClassModel model = new TestClassModel();
      return model;  // Es mejor devolver null en caso de error en lugar de un string.
    }
  }




}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:transmap_app/src/constants/constants.dart';
import 'package:transmap_app/src/models/empleado_model.dart';
import 'package:transmap_app/src/models/informe_detalle_model.dart';

class EmpleadoService {
  Future<List<EmpleadoModel>> getEmpleadosList() async {
    List<EmpleadoModel> empleadoList = [];

    // String url = kUrl + "/ListadoEmpleados";
    // http.Response response = await http.post(
    //   url,
    //   headers: {
    //     'Content-type': 'application/json',
    //     'Accept': 'application/json'
    //   },
    // );
    String url = kUrl + "/ListadoEmpleados";
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });

    if(response.statusCode == 200){
      List list = jsonDecode(response.body);
      empleadoList = list.map((e) => EmpleadoModel.fromJson(e)).toList();
      return empleadoList;
    }
    return empleadoList;

  }

  Future<List<EmpleadoModel>> cargarTrabajadores() async {
    try {
      // var resp = await http.get(kUrl + "/ListadoEmpleados");
      String url = kUrl + "/ListadoEmpleados";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });

      var decodeData = json.decode(resp.body);

      final List<EmpleadoModel> trabajador = [];

      decodeData["EmpleadoModel"].forEach((item) {
        final EmpleadoModelTemp = EmpleadoModel.fromJson(item);
        trabajador.add(EmpleadoModelTemp);
      });

      return trabajador;
    } catch (e) {
      print(e);
      return [];
    }
  }



}

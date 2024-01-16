import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:transmap_app/src/constants/constants.dart';
import 'package:transmap_app/src/models/reportes/informe_unidad_reporte_model.dart';

class ReporteServices {
  Future<List<InformeUnidadReporteModel>> getInformeUnidadReporte(String placa, String fecha1, String fecha2) async {

    List<InformeUnidadReporteModel> informeList = [];

   // String url = kUrl + "/ReporteIncidenciasxPlaca";
    // http.Response response = await http.post(
    //   url,
    //   headers: {
    //     "Content-Type": "application/json",
    //   },
    String url = kUrl + "/ReporteIncidenciasxPlaca";
    http.Response response = await http.post(Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: json.encode(
        {
          // "Placa": "V1M-993",
          // "FechInicio": "2022-04-18",
          // "FechFin": "2022-05-19"

          "Placa": placa,
          "FechInicio": fecha1,
          "FechFin": fecha2
        },
      ),
    );

  //  print(jsonEncode(model.toJson()));
    if(response.statusCode == 200){
     List list = json.decode(response.body);
     informeList = list.map<InformeUnidadReporteModel>((e) => InformeUnidadReporteModel.fromJson(e)).toList();
     return informeList;
    }
    return informeList;
  }
}

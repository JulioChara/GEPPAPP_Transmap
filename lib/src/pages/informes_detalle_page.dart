import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transmap_app/src/models/empleado_model.dart';
import 'package:transmap_app/src/models/informe_detalle_model.dart';
import 'package:transmap_app/src/models/proceso_informe_model.dart';
import 'package:transmap_app/src/services/empleado_services.dart';
import 'package:transmap_app/src/services/informe_detalle_services.dart';
import 'package:transmap_app/src/widgets/adjuntar_facturas_informeUnidad_widget.dart';
import 'package:transmap_app/src/widgets/mostrar_estado_detalle.dart';
import 'package:transmap_app/src/widgets/observacion_dialog_widget.dart';

import 'package:transmap_app/src/widgets/observacion_aq_dialog_widget.dart';
import 'package:transmap_app/utils/sp_global.dart';

class InformeDetallePage extends StatefulWidget {
  String? id;
  String? placa;
  String? conductor;


  InformeDetallePage({this.id, this.placa, this.conductor});
//  InformeDetallePage({this.placa});

  @override
  State<InformeDetallePage> createState() => _InformeDetallePageState();
}

class _InformeDetallePageState extends State<InformeDetallePage> {

  SPGlobal _prefs = SPGlobal();
  InformeDetalleService _informeDetalleService = InformeDetalleService();
  List<InformeDetalleModel> informeDetalleList = [];
  ProcesoInformeModel? _procesoInformeModel;

  String idCabezera = "";
  String idDetalle = "";
  String incidenciaGen = "";
  int idAccion = 0;
  bool loading = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<String> getIdRol() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("rolId")!;
  }


  getData() {
    _informeDetalleService.getInformeDetalle(widget.id!).then((value) {
      informeDetalleList = value;
      setState(() {
        loading = false;
      });
    });
  }

  showObservacion() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ObservacionAqDialogWidget(
          idCabezera: idCabezera,
          idAccion: idAccion,
          idDetalle: idDetalle,
          incidenciaGen: incidenciaGen,
        );
      },
    );
  }

  showFacturas() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AdjuntarFacturasInformeUnidadWidget(
          idDetalle: idDetalle
        );
      },
    );
  }



  showEstadoDetalle() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ObservacionEstadoDetalleDialog(
          idDetalle: idDetalle
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[_prefs.colorA, _prefs.colorB])),
        ),
       // title: Text("Informe Detalle: ${widget.id} "),
       // title: Text("Informe Detalle: ${widget.placa} " + "-"+ widget.conductor),
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: widget.placa,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
              children: <TextSpan>[
                TextSpan(
                  text: '\n' + widget.conductor!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  )
                )
              ]
          ),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          :  ListView.builder(
        itemCount: informeDetalleList.length,
        itemBuilder: (BuildContext context, int index) {
          String id = informeDetalleList[index].idTipoEstadoAtencion!;
          Color miColor = Colors.blue;
          switch(informeDetalleList[index].idTipoEstadoAtencion) {
            case "10537": { //INFORMADA
              miColor = Colors.blue.withOpacity(0.4);
            }break;
            case "10538": {  //EN PROCESO
              miColor = Colors.yellow.withOpacity(0.5);
            }break;
            case "10539": { //SOLUCIONADO
              miColor = Colors.green.withOpacity(0.5);
            }break;
            default: {  //ANULADO : 10548
              miColor = Colors.red.withOpacity(0.5);
            }break;
          }

          return ListTile(
            tileColor: miColor,
            leading: Column(
              children: [
                Icon(Icons.insert_drive_file),
                Text(informeDetalleList[index].tipoEstadoIncidenciaFkDesc!, style: TextStyle(
                  fontSize: 11.0, // Cambia esto al tamaño que desees
                ),)
              ],
            ),
            title: Text(informeDetalleList[index].descripcion!.toUpperCase()),
            subtitle: Text(
                "Tipo: ${informeDetalleList[index].idTipoIncidenciaDesc} | ${informeDetalleList[index].idTipoEstadoAtencionDesc!.toUpperCase()}"),
            onTap: (){
              //print(informeDetalleList[index].idDetalle);
              idDetalle = informeDetalleList[index].idDetalle!;
              showEstadoDetalle();
            },
            trailing: FutureBuilder(
              future: getIdRol(),
              builder: (BuildContext context, AsyncSnapshot snap){
                if(snap.hasData){
                  String idRol = snap.data;
                  return id != "10539"
                      ? id != "10548"
                      ? PopupMenuButton<String>(
                    onSelected: (String value) {


                      if(value == "Anular"){
                        idAccion = 3;
                      }else if(value == "Procesar"){
                        idAccion = 1;
                      }else if(value == "Solucionar"){
                        idAccion = 2;
                      }
                      else if(value == "Adjuntar"){
                        idAccion = 4;
                      }

                      idCabezera = informeDetalleList[index].idCabezera!;
                      idDetalle = informeDetalleList[index].idDetalle!;
                      incidenciaGen = informeDetalleList[index].idTipoIncidencia!;
                      idAccion = idAccion;


                      print("Envio incidenciaGen :" +incidenciaGen);

                      print("idAccion:" + idAccion.toString());
                      print("idCabezera:" + idCabezera.toString());
                      print("idDetalle:" + idDetalle.toString());

//AQUI VER UN SWITCH PARA CAMBIAR SEGUN LA ACCION
                      if (idAccion == 4){
                        showFacturas();
                      } else {
                        showObservacion();
                      }


                    },
                    itemBuilder: (BuildContext context) {
                    return [
                    if (id != "10538") PopupMenuItem<String>(
                        child: Text("Anular"),
                        value: "Anular",
                      ),
                      if (id != "10538" && (idRol == "1" || idRol == "12")) PopupMenuItem<String>(
                        child: Text("Procesar"),
                        value: "Procesar",
                      ),
                      if (id != "10537") PopupMenuItem<String>(
                        child: Text("Solucionar"),
                        value: "Solucionar",
                      ),
                      if (id != "10537") PopupMenuItem<String>(
                        child: Text("Adjuntar Facturas"),
                        value: "Adjuntar",
                      ),

                    // itemBuilder: (BuildContext context) {
                    //   return [
                    //     id != "10538"
                    //         ? PopupMenuItem<String>(
                    //       child: Text("Anular"),
                    //       value: "Anular",
                    //     )
                    //         : null,
                    //     id != "10538" && (idRol == "1" || idRol == "12")
                    //         ? PopupMenuItem(
                    //       child: Text("Procesar"),
                    //       value: "Procesar",
                    //     )
                    //         : null,
                    //     id != "10537"
                    //         ? PopupMenuItem(
                    //       child: Text("Solucionar"),
                    //       value: "Solucionar",
                    //     )
                    //         : null,
                      ];
                    },
                  )
                      : SizedBox()
                      : SizedBox();
                }
                return SizedBox();

              },
            ),
          );
        },
      ),
    );
  }
}

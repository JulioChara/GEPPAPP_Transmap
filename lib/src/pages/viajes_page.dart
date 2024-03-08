import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transmap_app/src/models/viaje_model.dart';
import 'package:transmap_app/src/pages/viajesCreate_page.dart';
import 'package:transmap_app/src/pages/viajes_documentos/viajes_documentos_page.dart';
import 'package:transmap_app/src/pages/viajes_planilla_gastos_page.dart';
import 'package:transmap_app/src/services/checkList/checkList_service.dart';
import 'package:transmap_app/src/widgets/menu_widget.dart';
import 'package:transmap_app/src/services/viaje_services.dart';
import 'package:transmap_app/src/services/detail_services.dart';
import 'package:transmap_app/utils/sp_global.dart';

class ViajePage extends StatefulWidget {
  @override
  _ViajePageState createState() => _ViajePageState();
}

//Future<String> sendData_() async {
//  SharedPreferences prefs = await SharedPreferences.getInstance();
// String id = await prefs.getString("idUser");
// print(id);
// return id;
//}

class _ViajePageState extends State<ViajePage> {

  SPGlobal _prefs = SPGlobal();
  var viaje = new ViajeService();
  var datailServices = new DetailServices();
  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);
  String usr = "";

  TextEditingController inputFieldDateController = new TextEditingController();

  DateTime selectedDate = DateTime.now();

  String idViajeSeleccionada = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // prefs.ultimaPagina = HomePage.routeName;.

    return Scaffold(
        appBar: AppBar(
          title: Text("Lista Viajes"),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[_prefs.colorA, _prefs.colorB])),
          ),
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.add_circle_outline),
            //   color: Colors.white,
            //   iconSize: 30.0,
            //   onPressed: () {
            //     Navigator.pushNamed(context, 'viajesCreate');
            //   },
            // )
            PopupMenuButton(
              onSelected: (choice) => choiceActionViaj(choice, context),
              icon: Icon(Icons.add),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("CREAR VIAJE"),
                  // value: 10763,
                  value:  1,
                ),
                PopupMenuItem(
                  child: Text("DOCUMENTOS VIAJE"),
                  //  value: 10769,
                  value:  2,
                ),


              ],
            )




          ],
        ),
        drawer: MenuWidget(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: _listViaje(context, viaje),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0XFF51E2A7),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade400, blurRadius: 3)
                        ]),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 7.0,
                          ),
                          Text(
                            initDate,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                      onPressed: () {
                        _selectDateInit(context);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade400, blurRadius: 3)
                        ]),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 7.0,
                          ),
                          Text(
                            endDate,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                      onPressed: () {
                        _selectDateEnd(context);
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Widget _listViaje(BuildContext context, ViajeService viajeService) {
    //print(usr);

    return FutureBuilder(
      future: viajeService.cargarViaje(initDate, endDate),
      builder:
          (BuildContext context, AsyncSnapshot<List<ViajeModel>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            {
              return new Center(
                child: CircularProgressIndicator(),
              );
            }
          case ConnectionState.active:
            {
              break;
            }
          case ConnectionState.none:
            {
              break;
            }
          case ConnectionState.done:
            {
              if (snapshot.hasData) {
                final viajeModel = snapshot.data;
                return viajeModel!.length > 0
                    ? ListView.builder(
                        itemCount: viajeModel.length,
                        itemBuilder: (context, i) {
                          return (ListTile(
                            onTap: () {
                              print("xd");
                              print(viajeModel[i].ViajId);
                            },
                            title: Text(
                              "${viajeModel[i].correlativo}-${viajeModel[i].conductor}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            subtitle: Text(
                                "${viajeModel[i].vehiculo}   |   ${viajeModel[i].fechacreacion}  |  ${viajeModel[i].kilometraje} km.   |  ${viajeModel[i].kilometrajeFinal}  km."),
                            leading: Icon(
                              Icons.content_paste,
                              color: Colors.green,
                            ),
                            trailing: Container(
                              child: PopupMenuButton<String>(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.green,
                                ),
                                itemBuilder: (BuildContext context) {
                                  String finalizar = "Finalizar";
                                  String planillagastos = "Planilla de Gastos";
                                  String listarvincular = "Ver Consumos";
                                  String vincular = "Vincular";
                                  String anular = "Anular";

                                  List<String> choices =[];

                                  if (viajeModel[i].estado == "10513") {
                                    choices.add(finalizar);
                                    choices.add(planillagastos);
                                    choices.add(vincular);
                                    choices.add(listarvincular);
                                    choices.add(anular);
                                  }

                                  return choices.map((String choice) {
                                    return PopupMenuItem<String>(
                                      value: viajeModel[i].ViajId! +
                                          "," +
                                          choice +
                                          "," +
                                          viajeModel[i].saldoInicial!, //aquaaaa
                                      child: Text(choice),
                                    );
                                  }).toList();
                                },
                                onSelected: (String value) {
                                  choiceAction(value, viajeModel[i]);
                                },
                              ),
                            ),
                          ));
                        },
                      )
                    : Center(
                        child: Text(
                          "No hay información disponible.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black26),
                        ),
                      );
              }
            }
        }

        return new Center(child: CircularProgressIndicator());
      },
    );
  }

  void choiceAction(String choice, ViajeModel model) {
    idViajeSeleccionada = choice;
    var arr = choice.split(',');

    if (arr[1] == "Anular") {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Anular Viaje"),
                  SizedBox(
                    height: 10.0,
                  ),
//                                      Icon(Icons.warning, size: 45.0, color: Colors.yellow,)
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar"),
                ),
                FlatButton(
                  onPressed: () {
                    _anularViaje(arr[0]);
                    Navigator.pop(context);
                  },
                  child: Text("Aceptar"),
                )
              ],
            );
          });
    } else if (arr[1] == "Ver Consumos") {
      print("entro a los listados");
      vincularId(arr[0]);
      Navigator.pushNamed(context, 'consumosListado');
    } else if (arr[1] == "Vincular") {
      print("entro a los listados");
      vincularId(arr[0]);
      Navigator.pushNamed(context, 'vincularviaje');
    } else if (arr[1] == "Finalizar") {
      print("entro a finalizar");
      vincularId(arr[0]);
      Navigator.pushNamed(context, 'viajeFinalizar');
    } else if (arr[1] == "Planilla de Gastos") {
      print("entro a Planilla de Gastos Gaaa: "+ arr[2]);
      vincularId2(arr[0], arr[2]);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlanillaGastosPage(
            saldoInicial: model.saldoInicial,
          ),
        ),
      );
    }
  }

  vincularId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("IdVijae", id);
  }

  vincularId2(String id, String sini) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("IdVijae", id);
    await prefs.setString("sInicial", sini);
  }

  _anularViaje(String id) async {
    ViajeService service = new ViajeService();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idUser = prefs.getString('idUser')!;

    String res = await service.estadoAnularViaje(id, idUser);

    if (res == "1") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text("Viaje Anulado Correctamente"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    setState(() {});
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, 'viajes');
                  },
                  child: Text("Aceptar"),
                )
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text("Hubo un problema, inténtelo nuevamente."),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Aceptar"),
                )
              ],
            );
          });
    }
  }

  Future<Null> _selectDateInit(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: new DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        initDate = picked.toString().substring(0, 10);
        _listViaje(context, viaje);
      });
  }

  Future<Null> _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: new DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        endDate = picked.toString().substring(0, 10);
        _listViaje(context, viaje);
      });
  }



  existeCheckList() async{

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String id = await prefs.getString("idUser")!;
    // var _checkServices = new CheckListServices();
    // String existTurn = await _checkServices.CheckList_ConsultaExistenciaxUsuario(id);
    //
    // if(existTurn == "1"){ //cuando existe si podremos crear
    //   Navigator.pushNamed(context, 'general');
    // }else if(existTurn =="0"){
    //   showMessajeAWYesNo(DialogType.ERROR, "CHECK LIST","No hay registro de checklist para el dia de hoy, ¿Desea ingresarlo?", 1);
    // }


  }

  showMessajeAWYesNo(DialogType type, String titulo, String desc, int accion) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: type,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close_fullscreen_outlined),
      title: titulo,
      descTextStyle: TextStyle(fontSize: 18),
      desc: desc,
      btnCancelText: "No",
      btnOkText: "Si",
      btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {
        switch (accion) {
          case 0:
            {
              // nada
            }
            break;
          case 1:
            {
              Navigator.pushReplacementNamed(
                context,
                'checkListHome',
                // 'checkListCreate',
              );
            }
            break;
        }
      },
    ).show();
  }


  showMessajeAW(DialogType type, String titulo, String desc, int accion) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: type,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close_fullscreen_outlined),
      title: titulo,
      descTextStyle: TextStyle(fontSize: 18),
      desc: desc,
      //  btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {
        switch (accion) {
          case 0:
            {
              // nada
            }
            break;
          case 1:
            {
              // Navigator.pushReplacementNamed(
              //   context,
              //   'turno',
              // );
            }
            break;
        }
      },
    ).show();
  }

  void choiceActionViaj(dynamic choice, BuildContext context) async {  //aqua 26/09/2023


 //   existeCheckList();

    var _checkServices = new CheckListServices();
    String existTurn = await _checkServices.CheckList_ConsultaExistenciaxUsuario(_prefs.idUser);

    if(existTurn == "1"){ //cuando existe si podremos crear
      if (choice == 1) {
        //CREAR VIAJE
        Navigator.pushNamed(context, 'viajesCreate');
      } else if (choice == 2) {
        //CREAR DOCUMENTOS
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ViajesDocumentos()));
      }
    }else if(existTurn =="0"){
      showMessajeAWYesNo(DialogType.ERROR, "CHECK LIST","No hay registro de checklist para el dia de hoy, ¿Desea ingresarlo?", 1);
    }


    // if (choice == 1) {
    //   //CREAR VIAJE
    //   Navigator.pushNamed(context, 'viajesCreate');
    // } else if (choice == 2) {
    //   //CREAR DOCUMENTOS
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ViajesDocumentos()));
    // }
  }

  void choiceActionDoc(int choice, BuildContext context) {
    print(choice);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (choice == 1) {
            //CREAR VIAJE
            Navigator.pushNamed(context, 'viajesCreate');
          //  Navigator.push(context, MaterialPageRoute(builder: (context)=> ViajeCreatePage()));
            // return AlertasDocumentosWidget(
            //     idVehi: idVehiculo);
          } else if (choice == 2) {
            //CREAR DOCUMENTOS

         //   Navigator.push(context, MaterialPageRoute(builder: (context)=> InformeUnidadReportePage()));
            // return AlertasMantenimientosWidget(
            //   idVehi: idVehiculo,);
          }
          return Container();
        }
      //   },
    ).then((val){
      //Navigator.pop(context);
      //getData();
      setState(() {});
    });
  }





}

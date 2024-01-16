






import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:transmap_app/src/models/checkList/checkList_model.dart';
import 'package:transmap_app/src/services/checkList/checkList_service.dart';
import 'package:transmap_app/src/widgets/menu_widget.dart';
import 'package:transmap_app/utils/sp_global.dart';

class CheckListPage extends StatefulWidget {


  @override
  State<CheckListPage> createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> {


  SPGlobal _prefs = SPGlobal();





  var _dataServices = new CheckListServices();
  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);
  // String idPedGlobLocal = "0";
  // String cantTotalGlob = "0";
  // String usr = "";
  int Accion = 0;

  TextEditingController inputFieldDateController = new TextEditingController();

  DateTime selectedDate = DateTime.now();

  String idInformeSeleccionada = "";

   List<CheckListModel> listaModel = [];
  // List<PlanInventarioModel> informeModelList3 = [];
  //
  // List<PlanInventarioDetalleModel> pendientesList = [];

  bool isLoading = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print("Dataaaa");

  }


  getData(){
    //idPedGlobLocal = "0";
    isLoading = true;
    _dataServices.postCheckList_ObtenerListaGeneral("0", initDate, endDate).then((value) {
      listaModel = value;
   //   informeModelList3.addAll(informeModelList2);
      Accion = 0;
      setState(() {
        isLoading = false;
      });
    });
  }

  existeCheckList() async{
    if(_prefs.usIdPlaca != "0" && _prefs.usIdPlaca != ""){ //cuando existe si podremos crear
      Navigator.pushNamed(context, 'checkListCreate');
    }else {
      showMessajeAWYesNo(DialogType.ERROR, "SIN PLACA","No se selecciono ninguna PLACA, ¿Desea Ingresarlo?", 1);
    }
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
                'login',
                // 'checkListCreate',
              );
            }
            break;
        }
      },
    ).show();
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CHECK LIST DIARIO"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[_prefs.colorA, _prefs.colorB])),
        ),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            color: Colors.white,
            iconSize: 30.0,
            onPressed: () {
              //Navigator.pushNamed(context, 'general');
            existeCheckList();
            },
          )
        ],
      ),
      drawer: MenuWidget(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => setState(() {
      //     getData();
      //   }),
      //   tooltip: 'Actualizar',
      //   child: const Icon(Icons.refresh),
      // ),
      body: !isLoading
          ? Column(
        children: <Widget>[

          Expanded(
            child: ListView.builder(
              itemCount: listaModel.length,
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  // tileColor: miColor,
                  onTap: () {
                    print(listaModel[i].estado!);
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${listaModel[i].vehiculoFkDesc}" ,
                        // "${informeModelList2[i].piFechaApertura}" +
                        //     "-" +
                        //     "${informeModelList2[i].usuarioCreacionDesc}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      Text(
                        // "${double.parse(informeModelList2[i].usuarioCreacionDesc!).toStringAsFixed(2)}",
                        listaModel[i].chUsuario!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  // subtitle: Text(informeModelList2[i].fecha!),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                      listaModel[i].placaFkDesc! ,
                      //   "RESTANTES?",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ) , Text(
                        // "${double.parse(informeModelList2[i].usuarioCreacionDesc!).toStringAsFixed(2)}",
                        listaModel[i].fechaCreacion!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),

                      // listaModel[i].estado == "False" ? const Text(
                      //   "ABIERTO",
                      //   //   "RESTANTES?",
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 1,
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.blueAccent),
                      // ) : const Text(
                      //   "FINALIZADO",
                      //   //   "RESTANTES?",
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 1,
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.green),
                      // ),
                    ],
                  ),


                  leading: IconButton(
                    icon: Icon(Icons.paste, color: Colors.red, size: 30,),
                    onPressed: () {
                      // showDetalle(informeModelList2[i].descripcion != null ? informeModelList2[i].descripcion!: "-");
                      // print(informeModelList2[i].idPedido);
                    },
                  ),

                  trailing: listaModel[i].estado! ==
                      "True" && listaModel[i].estado! == "True"
                      ? Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 50.0,
                  )
                      : null
                  //     : FutureBuilder(
                  //   future: getIdRol(),
                  //   builder:
                  //       (BuildContext context, AsyncSnapshot snap) {
                  //     if (snap.hasData) {
                  //       String idRol = snap.data;
                  //       return PopupMenuButton<String>(
                  //         icon: Icon(
                  //           Icons.more_vert,
                  //           color: Colors.redAccent,
                  //         ),
                  //         itemBuilder: (BuildContext context) {
                  //           return [
                  //             PopupMenuItem<String>(
                  //               value: "1",
                  //               child: Row(
                  //                 children: [ Icon(Icons.production_quantity_limits, color: Colors.blueAccent,),
                  //                   Text(" Ver Productos"),
                  //                 ],
                  //               ),
                  //               onTap: () {
                  //                 Accion = 1;
                  //                 // cantTotalGlob = informeModelList2[i].pedtotalGalones.toString();
                  //                 // globalizar(
                  //                 //     informeModelList2[i].idPedido!);
                  //               },
                  //             ),
                  //             PopupMenuItem<String>(
                  //               value: "2",
                  //               child: Row(
                  //                 children: [
                  //                   Icon(Icons.close, color: Colors.redAccent,),
                  //                   Text(" Cerrar"),
                  //                 ],
                  //               ),
                  //               onTap: () {
                  //                 Accion = 2;
                  //                 // cantTotalGlob = informeModelList2[i].pedtotalGalones.toString();
                  //                 // globalizar(
                  //                 //     informeModelList2[i].idPedido!);
                  //               },
                  //             ),
                  //           ];
                  //         },
                  //         onSelected: (choice) =>
                  //             choiceAction(Accion, informeModelList2[i].id!, context),
                  //         //   onSelected: choiceAction(s)
                  //       );
                  //     }
                  //
                  //     return SizedBox(
                  //       width: 1,
                  //       height: 1,
                  //     );
                  //   },
                  // ),
                );
              },
            ),
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
                        BoxShadow(
                            color: Colors.grey.shade400, blurRadius: 3)
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
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
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
                        BoxShadow(
                            color: Colors.grey.shade400, blurRadius: 3)
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
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
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
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }



  showMensajeriaAW(DialogType tipo, String titulo, String desc) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: tipo,
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
      btnOkOnPress: () {},
    ).show().then((value) {
      getData();
      setState(() {});
    });
  }

  // globalizar(String id) async {
  //   idPedGlobLocal = id;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString("idPed", id);
  // }

  //
  // showMessajeAW(DialogType type, String titulo, String desc, int accion) {
  //   AwesomeDialog(
  //     dismissOnTouchOutside: false,
  //     context: context,
  //     dialogType: type,
  //     headerAnimationLoop: false,
  //     animType: AnimType.TOPSLIDE,
  //     showCloseIcon: true,
  //     closeIcon: const Icon(Icons.close_fullscreen_outlined),
  //     title: titulo,
  //     descTextStyle: TextStyle(fontSize: 18),
  //     desc: desc,
  //     //  btnCancelOnPress: () {},
  //     onDissmissCallback: (type) {
  //       debugPrint('Dialog Dissmiss from callback $type');
  //     },
  //     btnOkOnPress: () {
  //       switch (accion) {
  //         case 0:
  //           {
  //             // nada
  //           }
  //           break;
  //         case 1:
  //           {
  //             //Cuando se genera el pedido
  //             Navigator.pushReplacementNamed(
  //               context,
  //               'home',
  //             );
  //           }
  //           break;
  //       }
  //     },
  //   ).show();
  // }


  //
  // listarPendientes(String idCab) {
  //   _planInventarioServices.getPlanInventariosDetallesxId(idCab).then((value) {
  //     pendientesList = value;
  //     String desc = "";
  //     String titulo = "";
  //
  //     titulo = "Resumen";
  //
  //     desc = desc +"\n Total Productos: ${pendientesList.length}" ;
  //     desc = desc +"\n Procesados: ${pendientesList.where((element) => element.pdProcesadoCierre=="True").length}" ;
  //     desc = desc +"\n Pendientes: ${pendientesList.where((element) => element.pdProcesadoCierre=="False").length}" ;
  //
  //
  //     AwesomeDialog(
  //       dismissOnTouchOutside: false,
  //       context: context,
  //       dialogType: DialogType.WARNING,
  //       headerAnimationLoop: false,
  //       animType: AnimType.TOPSLIDE,
  //       showCloseIcon: true,
  //       closeIcon: const Icon(Icons.close_fullscreen_outlined),
  //       title: titulo,
  //       descTextStyle: TextStyle(fontSize: 18),
  //       desc: desc,
  //       btnCancelOnPress: () {},
  //       onDissmissCallback: (type) {
  //         debugPrint('Dialog Dissmiss from callback $type');
  //       },
  //       btnCancelText: "No",
  //       btnOkText: "Si",
  //       btnCancelIcon: Icons.cancel,
  //       btnOkIcon: Icons.check,
  //       btnOkOnPress: () {
  //         finalizarPlanInventario(idCab);
  //       },
  //     ).show().then((val) {
  //       //Acciones para finalizar el formulario
  //       getData();
  //       setState(() {});
  //     });
  //   });
  // }

  finalizarPlanInventario(String id) async {
    // try {
    //   setState(() {
    //     isLoading = true;
    //   });
    //   String res = await _planInventarioServices.finalizarPlanInventario(id);
    //   if (res == "1") {
    //     showMensajeriaAW(
    //         DialogType.SUCCES, "Confirmacion", "Plan de inventario cerrado con exito");
    //   } else {
    //     showMensajeriaAW(DialogType.ERROR, "Error",
    //         "Ocurrio un error al finalizar el pedido");
    //   }
    //   setState(() {
    //     isLoading = false;
    //   });
    //   //desea grabar?
    //
    // } catch (e) {
    //   print(e);
    // }
  }

  mensajeToast(String mensaje, Color colorFondo, Color colorText) {
    Fluttertoast.showToast(
        msg: mensaje,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colorFondo,
        textColor: colorText,
        fontSize: 16.0);
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
              //Cuando se genera el pedido
              Navigator.pushReplacementNamed(
                context,
                'home',
              );
            }
            break;
        }
      },
    ).show();
  }


  //
  // void choiceAction(int choice,String idCabecera, BuildContext context) {
  //   if (choice == 1) {
  //     print("ID CABECERA: "+idCabecera  );
  //     // Navigator.pushNamed(context, 'pedidosDetalleOffline');
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => PlanInventarioDetallePage(idCabecera: idCabecera),
  //       ),
  //     );
  //   }
  //   if (choice ==2){
  //     listarPendientes(idCabecera);
  //   }
  //
  // }

  Future<Null> _selectDateInit(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: DateTime.parse(initDate),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        initDate = picked.toString().substring(0, 10);
        //_listInforme(context, informe);
        getData();
      });
  }

  Future<Null> _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: DateTime.parse(endDate),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        endDate = picked.toString().substring(0, 10);
        //_listInforme(context, informe);
        getData();
      });
  }










}
















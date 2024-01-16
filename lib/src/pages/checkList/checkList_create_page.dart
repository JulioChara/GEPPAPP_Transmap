

import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:transmap_app/src/models/checkList/checkList_model.dart';
import 'package:transmap_app/src/models/general_model.dart';
import 'package:transmap_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transmap_app/src/services/checkList/checkList_service.dart';
import 'package:transmap_app/utils/sp_global.dart';

class CheckListCreatePage extends StatefulWidget {

  @override
  State<CheckListCreatePage> createState() => _CheckListCreatePageState();
}

class _CheckListCreatePageState extends State<CheckListCreatePage> {


  SPGlobal _prefs = SPGlobal();

  //CheckListDetalleModel TemporalDet = new CheckListDetalleModel();  //se elimina cada vez que se

  String temCat = "0";
  String temOpc = "0";
  String temDesc = "0";


  bool loading = true;
  bool loadingSend = false;

  bool esOtros = false;

  CheckListModel sendModel = new CheckListModel();

  static List<TiposModel> tipoOpciones = [];
  static List<TiposModel> tipoCategorias = [];
  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keyTipoOpciones = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keyTipoCategorias = new GlobalKey();


  List<CheckListDetalleModel> productoLista = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  AutoCompleteTextField? searchPlaca;
  AutoCompleteTextField? searchTipo;
  AutoCompleteTextField? searchTipoInsidencia;
  TextEditingController ConceptoEditingController = new TextEditingController();

  var _sendServices = new CheckListServices();
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

 // CheckListModel informeModel = new CheckListModel();


  TiposModel? _selectedOpciones;
  TiposModel? _selectedCategorias;

  List<DropdownMenuItem<TiposModel>>? _tipoOpcionesDropdownMenuItems;
  List<DropdownMenuItem<TiposModel>>? _tipoCategoriasDropdownMenuItems;

  void getData() async {
    try {

      print("Parte 1");
      tipoOpciones = await _sendServices.CheckList_ObtenerTiposOpciones();
      var json = jsonEncode(tipoOpciones.map((e) => e.toJson()).toList());
      print(json);

      print(tipoOpciones[0].tipoDescripcion);
      _tipoOpcionesDropdownMenuItems = buildDropDownMenuTiposOpciones(tipoOpciones);


      print("Parte 2");
      tipoCategorias = await _sendServices.CheckList_ObtenerTiposCategorias();
      _tipoCategoriasDropdownMenuItems = buildDropDownMenuTiposCategorias(tipoCategorias);

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }
  addItemProducto(CheckListDetalleModel producto) {

    bool aes = false;
    if (productoLista.length > 0) {
      for (CheckListDetalleModel items in productoLista) {
        if (items.tipoCategoriaFk == producto.tipoCategoriaFk) {
          aes = true;
        }
      }
    } else {
      productoLista.add(producto);
      print("adddd1");
      aes = true;
    }

    if (aes == false) {
      print("adddd2");
      productoLista.add(producto);
    }


    // tipoCategorias.removeWhere((item) => item.tipoId == producto.tipoCategoriaFk);  //pruebas
    // _tipoCategoriasDropdownMenuItems = buildDropDownMenuTiposCategorias(tipoCategorias);

  //  productoLista.add(producto);
    var pr= productoLista;
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List<DropdownMenuItem<TiposModel>> buildDropDownMenuTiposOpciones(List tipos) {
    List<DropdownMenuItem<TiposModel>> items = [];
    for (TiposModel tipo in tipos) {
      items.add(DropdownMenuItem( value: tipo, child: Text(tipo.tipoDescripcion!,  style: TextStyle(
        color: Colors.grey,  //pene
      //  color: productoLista.contains(tipo.tipoId) ? Colors.grey : null,  //pene
      ),),));
    }
    return items;
  }
  List<DropdownMenuItem<TiposModel>> buildDropDownMenuTiposCategorias(List tipos) {

    print("tipos");
    var json = jsonEncode(tipos.map((e) => e.toJson()).toList());
    print(json);

    List<DropdownMenuItem<TiposModel>> items = [];
    for (TiposModel tipo in tipos) {
      items.add(DropdownMenuItem( value: tipo, child: Text(tipo.tipoDescripcion!)));
    }
    return items;
  }


  onChangeDropdownTiposOpciones(TiposModel? selected) {
    ConceptoEditingController.text ="";
    if (selected!.tipoDescripcion! =="OTROS"){
      esOtros= true;
    }else{
      esOtros =false;
    }

    temOpc = selected.tipoId!;
    setState(() {
      _selectedOpciones = selected;
    });
  }
  onChangeDropdownTiposCategorias(TiposModel? selected) {
    // var selectedDoc = snapshot.data.documents.firstWhere(
    //         (doc) => doc.documentID == selectedStand,
    //     orElse: () => null,

    temCat = selected!.tipoId!;
    setState(() {
      _selectedCategorias = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bar = SnackBar(content: Text('Hello, world!'));

    return Scaffold(
        appBar: AppBar(
          title: Text("Crear Check List Vehicular"),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[_prefs.colorA, _prefs.colorB])),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   elevation: 150,
        //   onPressed: () {
        //     setState(() {
        //       print(sendModel.toJson());
        //       print("Cat: " + temCat);
        //       print("Opc: " +temOpc);
        //       print("Desc: " +temDesc);
        //       sendModel.detalle = [];
        //       sendModel.detalle = productoLista;
        //       // print("---------------------------------");
        //       // var json = jsonEncode(tipoCategorias.map((e) => e.toJson()).toList());
        //       // print(json);
        //     });
        //   },
        //   child: const Icon(Icons.navigation),
        // ),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : Stack(
          children: <Widget>[
            Container(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[

                      SizedBox(
                        height: 20.0,
                      ),
                      Divider(
                        height: 20.0,
                      ),
                      Text(
                        "DETALLE",
                        style: TextStyle(
                            fontSize: 18.0,
                            letterSpacing: 1.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Tipo Categoria",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              "assets/icons/service.svg", color: Colors.black54,),
                          ),
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        isExpanded: true,
                        value: _selectedCategorias,
                        items: _tipoCategoriasDropdownMenuItems,
                        onChanged: onChangeDropdownTiposCategorias,
                        elevation: 2,
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                        isDense: true,
                        iconSize: 40.0,
                      ),

                      SizedBox(
                        height: 20.0,
                      ),

                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Tipo Opciones",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              "assets/icons/service.svg", color: Colors.black54,),
                          ),
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        isExpanded: true,
                        value: _selectedOpciones,
                        items: _tipoOpcionesDropdownMenuItems,
                        onChanged: onChangeDropdownTiposOpciones,
                        elevation: 2,
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                        isDense: true,
                        iconSize: 40.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: ConceptoEditingController,
                        decoration: InputDecoration(
                          hintText: "Coloque la descripcion detallada",
                          labelText: "Descripcion",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/adjust.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 3,
                        keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onChanged: (value) {
                          setState(() {});
                        },
                        //readOnly: ocultarDesc,
                        enabled: esOtros,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      CupertinoButton(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "Agregar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(10),
                          // ),

                        ),
                         color: Color(0XFF51E2A7),


                        // onPressed: ConceptoEditingController.text.length > 0
                        onPressed: (temCat != "0" && temOpc != "0")
                            ? () {
                          print("mayor que cero");
                          var prod = new CheckListDetalleModel(
                            tipoCategoriaFk: _selectedCategorias!.tipoId,
                            tipoCategoriaFkDesc: _selectedCategorias!.tipoDescripcion,
                            tipoOpcionFk: _selectedOpciones!.tipoId,
                            tipoOpcionFkDesc: _selectedOpciones!.tipoDescripcion,
                            cdObservacion: ConceptoEditingController.text,
                         //   cdObservacion:
                          );
                          addItemProducto(prod);
                          ConceptoEditingController.clear();
                        }
                            : null,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 200, // fixed height
                            child: productoLista.length > 0
                                ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.all(8),
                                itemCount: productoLista.length,
                                itemBuilder: (BuildContext context,
                                    int index) {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15.0,
                                    ),
                                    title: Text(
                                      productoLista[index]
                                          .tipoCategoriaFkDesc!
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.black54),
                                    ),
                                    subtitle: Text(
                                      // "Tipo.: ${productoLista[index].tipoCategoriaFk} ",
                                      "Tipo.: ${productoLista[index].tipoOpcionFkDesc} ",
                                      style:
                                      TextStyle(fontSize: 13.0),
                                    ),
                                    trailing: Container(
                                      padding: EdgeInsets.zero,
                                      child: IconButton(
                                        icon: Icon(Icons.delete),
                                        color:
                                        Colors.redAccent.shade200,
                                        onPressed: () {
                                          print(index);
                                          productoLista
                                              .removeAt(index);
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    onTap: () {
                                      // abrirScan(scans[i], context);
                                    },
                                  );
                                })
                                : Center(
                              child: Text(
                                "No hay productos en la lista.",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.black26),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Divider(
                        height: 20.0,
                      ),

                      CupertinoButton(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "REGISTRAR INFORME",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        // color: Colors.redAccent,
                        color: _prefs.colorB,
                        onPressed: () {

                         sendModel.detalle = productoLista;
                         if(sendModel.detalle == null){
                           mensajeToast("SIN ITEMS", Colors.red, Colors.white);
                          return;
                         }
                          if (tipoCategorias.length == sendModel.detalle!.length){
                            mensajeToast("OK", Colors.lightGreenAccent, Colors.black);
                          }else {
                            mensajeToast("Agrege todas las opciones", Colors.red, Colors.white);
                            return;
                          }
                         AwesomeDialog(
                           dismissOnTouchOutside: false,
                           context: context,
                           dialogType: DialogType.WARNING,
                           headerAnimationLoop: false,
                           animType: AnimType.TOPSLIDE,
                           showCloseIcon: true,
                           closeIcon: const Icon(Icons.close_fullscreen_outlined),
                           title: "Atencion",
                           descTextStyle: TextStyle(fontSize: 18),
                           desc: "Esta Seguro de guardar el CheckLis Diario?",
                           btnCancelOnPress: () {},
                           onDissmissCallback: (type) {
                             debugPrint('Dialog Dissmiss from callback $type');
                           },
                           btnCancelText: "No",
                           btnOkText: "Si",
                           btnCancelIcon: Icons.cancel,
                           btnOkIcon: Icons.check,
                           btnOkOnPress: () {
                               _sendData();
                               // setState(() {
                               //
                               // });
                           },
                         ).show().then((val) {
                           //Acciones para finalizar el formulario
                         //  getData();
                           setState(() {});
                         });

//                           showDialog(
//                               context: context,
//                               barrierDismissible: true,
//                               builder: (context) {
//                                 return AlertDialog(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                       BorderRadius.circular(20.0)),
//                                   title: Text("Atención"),
//                                   content: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: <Widget>[
//                                       Text(
//                                           "Esta seguro de grabar el Informe"),
//                                       SizedBox(
//                                         height: 10.0,
//                                       ),
// //                                      Icon(Icons.warning, size: 45.0, color: Colors.yellow,)
//                                     ],
//                                   ),
//                                   actions: <Widget>[
//                                     FlatButton(
//                                       onPressed: () {
//                                         Navigator.pop(context);
//                                       },
//                                       child: Text("Cancelar"),
//                                     ),
//                                     FlatButton(
//                                       onPressed: () {
//                                      //   _sendData();
//                                         setState(() {
//                                         });
//                                         Navigator.pop(context);
//                                       },
//                                       child: Text("Enviar"),
//                                     )
//                                   ],
//                                 );
//                               });



                        },
                      ),
                      SizedBox(
                        height: 70.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (loadingSend)
              Positioned(
                child: Container(
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ));
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


  _sendData() async {
    // String validar = validado();
    // if (validar.length > 0) {
    //   print("Pre");
    //   showMessajeAW(DialogType.ERROR, "Validacion", validar);
    //   print("Pos");
    //  // print(validar);
    //   return;
    // }

   // print(usuarioGlobal);
    sendModel.vehiculoFk = _prefs.usIdPlaca;
    sendModel.placaFk = _prefs.usIdPlacaRef;
    sendModel.usuarioCreacion = _prefs.idUser;

    setState(() {
      loadingSend = true;
    });
    // String res = await _sendServices.CheckList_GenerarCheckDiario(sendModel);
    TestClassModel res = await _sendServices.CheckList_GenerarCheckDiario(sendModel);

    print(res);
    if (res.resultado == "1") {
      showMessajeAW(DialogType.SUCCES, "Confirmacion",
          res.mensaje.toString(), 1);
    } else {
      showMessajeAW(DialogType.ERROR, "Error",
          // "Ocurrio un error al generar el pedido, revise la informacion.", 0);
          res.mensaje.toString(), 0);
    }
    loadingSend = false;
    setState(() {});
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
                'checkListHome',
              );
            }
            break;
        }
      },
    ).show();
  }



// _sendData() async {
  //   InformeService service = new InformeService();
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String id = await prefs.getString("idUser")!;
  //   print(id);
  //   informeModel.usercreacion = id;
  //   informeModel.tipoestado="10537";
  //   informeModel.Detalle = productoLista;
  //   setState(() {
  //     loadingSend = true;
  //   });
  //
  //
  //
  //   String res = await service.registrarInforme(informeModel);
  //
  //
  //   if (res == "1") {
  //
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context){
  //           return AlertDialog(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius:
  //                 BorderRadius.circular(20.0)),
  //             title: Text("Atención"),
  //             content: Text("Informe Vehicular Grabado Correctamente"),
  //             actions: <Widget>[
  //               FlatButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                   Navigator.pop(context);
  //                   Navigator.pushReplacementNamed(context, 'informeAdm');
  //                 },
  //                 child: Text("Aceptar"),
  //               )
  //             ],
  //           );
  //         }
  //     );
  //
  //     setState(() {
  //       loadingSend = false;
  //     });
  //
  //   }else{
  //
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context){
  //           return AlertDialog(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius:
  //                 BorderRadius.circular(20.0)),
  //             title: Text("Atención"),
  //             content: Text("Hubo un problema, Verifique que todos los datos esten llenos e inténtelo nuevamente."),
  //             actions: <Widget>[
  //               FlatButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text("Aceptar"),
  //               )
  //             ],
  //           );
  //         }
  //     );
  //     setState(() {
  //       loadingSend = false;
  //     });
  //   }
  //
  //
  // }










}

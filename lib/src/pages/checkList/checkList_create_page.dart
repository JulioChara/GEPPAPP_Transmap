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
import 'package:transmap_app/src/services/guiasElectronicas/guiasElectronicas_services.dart';
import 'package:transmap_app/utils/sp_global.dart';

class CheckListCreatePage extends StatefulWidget {
  @override
  State<CheckListCreatePage> createState() => _CheckListCreatePageState();
}

// const List<String> list = <String>['SELECCIONE---','DIARIO', 'SEMANAL'];
const List<String> list = <String>['DIARIO', 'SEMANAL'];


class _CheckListCreatePageState extends State<CheckListCreatePage> {
  SPGlobal _prefs = SPGlobal();

  //CheckListDetalleModel TemporalDet = new CheckListDetalleModel();  //se elimina cada vez que se

  String dropdownValue = list.first;
  String _opcionCheck = "";


  String temCat = "0";
  String temOpc = "0";
  String temDesc = "0";
  int valorNeumaticos = 0;

  bool loading = true;
  bool loadingSend = false;

  bool esOtros = true;

  String LocalPlacaFk = "";
  String LocalPlacaFkDesc = "";

  CheckListModel sendModel = new CheckListModel();

  static List<TiposModel> tipoOpciones = [];
  static List<TiposModel> tipoCategorias = [];
  List<TiposModel> tipoCategoriasAux = [];
  static List<TiposModel> subproducto = [];
  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keyTipoOpciones =
      new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keyTipoCategorias =
      new GlobalKey();

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
  TiposModel? _selectedTipoSubProducto;

  List<DropdownMenuItem<TiposModel>>? _tipoOpcionesDropdownMenuItems;
  List<DropdownMenuItem<TiposModel>>? _tipoCategoriasDropdownMenuItems;
  List<DropdownMenuItem<TiposModel>>? _tipoCategoriasDropdownMenuItemsAux;
  List<DropdownMenuItem<TiposModel>>? _subproductoDropdownMenuItems;

  void getData() async {
    try {
      if (_prefs.spAlternarPlaca =="2"){
        LocalPlacaFk = _prefs.usIdPlacaRef;
        LocalPlacaFkDesc = _prefs.usIdPlacaRefDesc;
      }else {
        LocalPlacaFk = _prefs.usIdPlaca;
        LocalPlacaFkDesc = _prefs.usIdPlacaDesc;
      }





      print("Parte 1");
      tipoOpciones = await _sendServices.CheckList_ObtenerTiposOpciones();
      var json = jsonEncode(tipoOpciones.map((e) => e.toJson()).toList());
      print(json);

      print(tipoOpciones[0].tipoDescripcion);
      _tipoOpcionesDropdownMenuItems =
          buildDropDownMenuTiposOpciones(tipoOpciones);

      print("Parte 2");
      if (_prefs.spTipoCheckList == "S") {
        tipoCategorias = await _sendServices
            // .CheckList_ObtenerTiposCategoriasxVehiculoSemanal(_prefs.usIdPlaca);
            .CheckList_ObtenerTiposCategoriasxVehiculoSemanal(LocalPlacaFk);
      } else {
        tipoCategorias = await _sendServices.CheckList_ObtenerTiposCategorias(LocalPlacaFk);
      }
      _selectedCategorias = tipoCategorias.first;
      _tipoCategoriasDropdownMenuItems =
          buildDropDownMenuTiposCategorias(tipoCategorias);



      if (_prefs.spTipoCheckList =="S"){
        dropdownValue = "SEMANAL";
      }else {
        dropdownValue = "DIARIO";
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void ActualizadoresTipo(int cate, String id) async {
    //  loading = true;
    if (cate == 1) {
    } else if (cate == 2) {
      print("nani");
      print("Send:" + id);

      var objDetailServices = new CheckListServices();
      // subproducto = await objDetailServices.CheckList_ObtenerSubTiposCategorias(_prefs.usIdPlaca, id); //para sub estantes
      subproducto = await objDetailServices.CheckList_ObtenerSubTiposCategorias(LocalPlacaFk, id); //para sub estantes
      print(subproducto.length);
      _subproductoDropdownMenuItems =
          buildSubProductoDropDownMenuItems(subproducto);
      _selectedTipoSubProducto = subproducto.first;
      // SetearDescripcion(id);
      //mensajeToast("Categoria Seleccionada: "+id +"         Valor Neumaticos: " +subproducto.length.toString(), Colors.amberAccent, Colors.black);
      if (id == '10790') {
        //NEUMATICOS
        valorNeumaticos = subproducto.length;
      }
    }
    setState(() {
      //loading =false;
    });
  }

  addItemProducto(CheckListDetalleModel producto) {
    bool aes = false;
    if (productoLista.length > 0) {
      for (CheckListDetalleModel items in productoLista) {
        if (items.tipoCategoriaFk == "10790") //05/04/2024
        {
          if (items.subTiposDetalle == producto.subTiposDetalle) {
            aes = true;
          }
        } else {
          if (items.tipoCategoriaFk == producto.tipoCategoriaFk) {
            aes = true;
          }
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
    var pr = productoLista;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List<DropdownMenuItem<TiposModel>> buildDropDownMenuTiposOpciones(
      List tipos) {
    List<DropdownMenuItem<TiposModel>> items = [];
    for (TiposModel tipo in tipos) {
      items.add(DropdownMenuItem(
        value: tipo,
        child: Text(
          tipo.tipoDescripcion!,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ));
    }
    return items;
  }

  List<DropdownMenuItem<TiposModel>> buildDropDownMenuTiposCategorias(
      List tipos) {
    print("tipos");
    var json = jsonEncode(tipos.map((e) => e.toJson()).toList());
    print(json);

    List<DropdownMenuItem<TiposModel>> items = [];
    for (TiposModel tipo in tipos) {
      items.add(
          DropdownMenuItem(value: tipo, child: Text(tipo.tipoDescripcion!)));
    }
    return items;
  }

  List<DropdownMenuItem<TiposModel>> buildSubProductoDropDownMenuItems(
      List lista) {
    List<DropdownMenuItem<TiposModel>> items = [];
    for (TiposModel p in lista) {
      items.add(DropdownMenuItem(
        value: p,
        child: Text(p.tipoDescripcion!),
      ));
    }
    return items;
  }

  onChangeDropdownTiposOpciones(TiposModel? selected) {
    ConceptoEditingController.text = "";
    if (selected!.tipoDescripcion! == "OTROS") {
      esOtros = true;
    } else {
      esOtros = true;
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

      ActualizadoresTipo(2, selected.tipoId!); //
    });
  }

  onTipoSubProductoChangeDropdownItem(TiposModel? selected) {
    setState(() {
      _selectedTipoSubProducto = selected;
      print(_selectedTipoSubProducto!.tipoDescripcion);
      // SetearDescripcion(_selectedTipoSubProducto!.tipoId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bar = SnackBar(content: Text('Hello, world!'));
    print(tipoCategorias);
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
        //
        //       mensajeToast("Valor Neumaticos:"+valorNeumaticos.toString(), Colors.yellow, Colors.black);
        //       String s = sendModel.toJson().toString();
        //       debugPrint(" =======> " + s, wrapWidth: 1024);
        //       // print(sendModel.toJson());
        //       // print("Cat: " + temCat);
        //       // print("Opc: " +temOpc);
        //       // print("Desc: " +temDesc);
        //       // sendModel.detalle = [];
        //       // sendModel.detalle = productoLista;
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
                            Text(
                              _prefs.spTipoCheckList == "S"
                                  ? "CHECKLIST SEMANAL"
                                  : "CHECKLIST DIARIO",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  letterSpacing: 1.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              // _prefs.usIdPlacaDesc,
                              LocalPlacaFkDesc,
                              style: TextStyle(
                                  fontSize: 25.0,
                                  letterSpacing: 1.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),




                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 4,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value!;
                                  _opcionCheck=value;
                                  if (value=="DIARIO"){
                                    _prefs.spTipoCheckList="D";
                                  }
                                  if (value=="SEMANAL"){
                                    _prefs.spTipoCheckList="S";
                                  }


                                  Navigator.pushReplacementNamed(
                                    context,
                                    'checkListCreate',
                                  );

                                  // productoLista = [];
                                  // getData();


                                });
                              },
                              items: list.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
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

                            // aquanew 04/04/2024
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: "Sub Categoria",
                                prefixIcon: Container(
                                  width: 20,
                                  height: 40,
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    "assets/icons/service.svg",
                                    color: Colors.black54,
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              isExpanded: true,
                              value: _selectedTipoSubProducto,
                              items: _subproductoDropdownMenuItems,
                              onChanged: onTipoSubProductoChangeDropdownItem,
                              elevation: 2,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                              isDense: true,
                              iconSize: 40.0,
                            ),
                            // DropdownButtonFormField <String>(
                            //   decoration: InputDecoration(
                            //     labelText: "Sub Categoria",
                            //     prefixIcon: Container(
                            //       width: 20,
                            //       height: 40,
                            //       padding: EdgeInsets.all(10),
                            //       child: SvgPicture.asset(
                            //         "assets/icons/service.svg", color: Colors.black54,),
                            //     ),
                            //     contentPadding: EdgeInsets.all(10.0),
                            //     border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10)),
                            //   ),
                            //   isExpanded: true,
                            //   value: _selectedTipoSubProducto,
                            //   items: _subproductoDropdownMenuItems!.map(String value) {
                            //     return DropdownMenuItem(
                            //       value: value,
                            //       child: Text(value.), // Asegúrate de que 'nombre' es un campo válido en tu modelo
                            //       // Deshabilita el ítem si ya ha sido seleccionado
                            //       enabled: !productoLista.contains(value),
                            //     );
                            //   }).toList(),
                            //   onChanged: onTipoSubProductoChangeDropdownItem,
                            //   elevation: 2,
                            //   style: TextStyle(color: Colors.black54, fontSize: 16),
                            //   isDense: true,
                            //   iconSize: 40.0,
                            // ),

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
                                    "assets/icons/service.svg",
                                    color: Colors.black54,
                                  ),
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
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
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
                                        tipoCategoriaFk:
                                            _selectedCategorias!.tipoId,
                                        tipoCategoriaFkDesc:
                                            _selectedCategorias!
                                                .tipoDescripcion,
                                        subTiposDetalle:
                                            _selectedTipoSubProducto!.tipoId ==
                                                    '0'
                                                ? ''
                                                : _selectedTipoSubProducto!
                                                    .tipoDescripcion,
                                        tipoOpcionFk: _selectedOpciones!.tipoId,
                                        tipoOpcionFkDesc:
                                            _selectedOpciones!.tipoDescripcion,
                                        cdObservacion:
                                            ConceptoEditingController.text,
                                        //   cdObservacion:
                                      );

                                      addItemProducto(prod);
                                      ConceptoEditingController.clear();

                                      // List res = productoLista
                                      //     .where((element) =>
                                      //         element.tipoCategoriaFk ==
                                      //         _selectedCategorias!.tipoId)
                                      //     .toList();
                                      // if (res.isNotEmpty) {
                                      //   ScaffoldMessenger.of(context)
                                      //       .showSnackBar(SnackBar(
                                      //     content: Text("xxxxxxx"),
                                      //     backgroundColor: Colors.red,
                                      //   ));
                                      // } else {
                                      //   addItemProducto(prod);
                                      //   ConceptoEditingController.clear();
                                      // }

                                      // tipoCategoriasAux.add(_selectedCategorias!);
                                      // tipoCategorias.remove(_selectedCategorias!);
                                      // //_selectedCategorias = tipoCategorias.first;
                                      // print(tipoCategoriasAux);
                                      //
                                      // setState(() {
                                      //
                                      // });
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
                                              subtitle: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (productoLista[index]
                                                          .subTiposDetalle !=
                                                      '')
                                                    Text(
                                                      // "Tipo.: ${productoLista[index].tipoCategoriaFk} ",
                                                      "Sub Categoria.: ${productoLista[index].subTiposDetalle} ",
                                                      style: TextStyle(
                                                          fontSize: 13.0),
                                                    ),
                                                  Text(
                                                    // "Tipo.: ${productoLista[index].tipoCategoriaFk} ",
                                                    "Tipo.: ${productoLista[index].tipoOpcionFkDesc} ",
                                                    style: TextStyle(
                                                        fontSize: 13.0),
                                                  ),
                                                ],
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
                                            "No hay Items en la lista.",
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
                                if (sendModel.detalle == null) {
                                  mensajeToast(
                                      "SIN ITEMS", Colors.red, Colors.white);
                                  return;
                                }
                                print("tipoCategorias:" +
                                    tipoCategorias.length.toString());
                                print("valorNeumaticos:" +
                                    valorNeumaticos.toString());
                                print("sendModel.detalle:" +
                                    sendModel.detalle!.length.toString());
                                if (tipoCategorias.length -
                                        1 +
                                        valorNeumaticos ==
                                    sendModel.detalle!.length) {
                                  ///AHORA ES MENOS 1 PORQUE NEUMATICOS ABHORA ES MANEJA INDEPENDIENTEMENTE
                                  mensajeToast("OK", Colors.lightGreenAccent,
                                      Colors.black);
                                } else {

                                  List<String> detalleDescripciones = productoLista.map((item) => item.tipoCategoriaFkDesc as String).toList();
                                  List<String> categoriasDescripciones = tipoCategorias.map((item) => item.tipoDescripcion as String).toList();

                                  List<String> faltantes = categoriasDescripciones.where((item) => !detalleDescripciones.contains(item)).toList();

                                //  print('Faltan agregar las siguientes categorías: $faltantes');

                                  List<String> tipoCabecera = productoLista.map((item) => item.subTiposDetalle as String).toList();
                                  List<String> categoriasDescripcionesDETALLE = subproducto.map((item) => item.tipoDescripcion as String).toList();
                                  List<String> Neumaticosfaltantes = categoriasDescripcionesDETALLE.where((item) => !tipoCabecera.contains(item)).toList();


                                  print('LISTA COMPLETA INI///////////' );
                                  print('FALTAN NEUMATICOS: $detalleDescripciones');
                                  print('LISTA COMPLETA END///////////' );

                                  print('FALTAN NEUMATICOS: $Neumaticosfaltantes');
                                  showMessajeAW(
                                      DialogType.ERROR,"FALTAN OPCIONES",
                                      '\n$faltantes'+ '\n$Neumaticosfaltantes' ,
                                      0);

                                  mensajeToast("Agrege todas las opciones",
                                      Colors.red, Colors.white);
                                  return;
                                }
                                if (valorNeumaticos <= 1) {
                                  //  mensajeToast("La placa seleccionada no especifico la cantidad de Neumaticos, Comuniquese comuniquese con el area correspondiente", Colors.red, Colors.white);
                                  showMessajeAW(
                                      DialogType.ERROR,
                                      "Sin Neumaticos",
                                      "La placa " +
                                          // _prefs.usIdPlacaDesc +
                                          LocalPlacaFkDesc +
                                          " no especifico la cantidad de Neumaticos, Comuniquese con el area Administrativa",
                                      0);
                                  return;
                                }
                                if (sendModel.detalle!
                                        .where((item) =>
                                            item.tipoCategoriaFk == "10790")
                                        .length !=
                                    valorNeumaticos) {
                                  showMessajeAW(
                                      DialogType.WARNING,
                                      "Faltan Neumaticos",
                                      "Debe asignar todos los neumaticos a la Lista",
                                      0);
                                  return;
                                }

                                AwesomeDialog(
                                  dismissOnTouchOutside: false,
                                  context: context,
                                  dialogType: DialogType.WARNING,
                                  headerAnimationLoop: false,
                                  animType: AnimType.TOPSLIDE,
                                  showCloseIcon: true,
                                  closeIcon: const Icon(
                                      Icons.close_fullscreen_outlined),
                                  title: "Atencion",
                                  descTextStyle: TextStyle(fontSize: 18),
                                  desc: "Esta Seguro de guardar el CheckList?",
                                  btnCancelOnPress: () {},
                                  onDissmissCallback: (type) {
                                    debugPrint(
                                        'Dialog Dissmiss from callback $type');
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

    sendModel.tipoCheckList = _prefs.spTipoCheckList;
    // sendModel.vehiculoFk = _prefs.usIdPlaca;
    // sendModel.placaFk = _prefs.usIdPlacaRef;
    sendModel.vehiculoFk = LocalPlacaFk;
    sendModel.placaFk = LocalPlacaFkDesc;
    sendModel.usuarioCreacion = _prefs.idUser;

    setState(() {
      loadingSend = true;
    });
    // String res = await _sendServices.CheckList_GenerarCheckDiario(sendModel);
    TestClassModel res =
        await _sendServices.CheckList_GenerarCheckDiario(sendModel);

    print("Mando a Imprimir");

    String s = sendModel.toJson().toString();
    debugPrint(" =======> " + s, wrapWidth: 1024);


    print("Mando a Imprimir END");


    print(res);
    if (res.resultado == "1") {
      showMessajeAW(
          DialogType.SUCCES, "Confirmacion", res.mensaje.toString(), 1);
    } else {
      showMessajeAW(
          DialogType.ERROR,
          "Error",
          // "Ocurrio un error al generar el pedido, revise la informacion.", 0);
          res.mensaje.toString(),
          0);
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
              _prefs.spTipoCheckList = "D";
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

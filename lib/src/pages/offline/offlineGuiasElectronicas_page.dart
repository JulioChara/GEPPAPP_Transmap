import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transmap_app/db/db_admin.dart';

// import 'package:transmap_app/src/models/guiasElectronicas/guiasElectronicas_model.dart';
import 'package:transmap_app/src/models/offline/offlineGuiasElectronicas_model.dart';
import 'package:transmap_app/src/services/guiasElectronicas/guiasElectronicas_services.dart';
import 'package:transmap_app/src/widgets/menu_widget.dart';
import 'package:transmap_app/utils/sp_global.dart';

// import 'package:url_launcher/url_launcher.dart';
import 'package:transmap_app/src/constants/constants.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:qr/qr.dart';

class OfflineGuiasElectronicasPage extends StatefulWidget {
  @override
  State<OfflineGuiasElectronicasPage> createState() =>
      _OfflineGuiasElectronicasPageState();
}

class _OfflineGuiasElectronicasPageState
    extends State<OfflineGuiasElectronicasPage> {
  SPGlobal _prefs = SPGlobal();

  var _dataServices = new GuiasElectronicasServices();

  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate =
      DateTime.now().add(const Duration(days: 1)).toString().substring(0, 10);

  int Accion = 0;

  TextEditingController inputFieldDateController = new TextEditingController();
  DateTime selectedDate = DateTime.now();
  List<GuiasElectronicasModel> listaModel = [];
  bool isLoading = true;

  double progress = 0;
  bool didDownloadPDF = false;
  String progressString = 'no';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print("Dataaaa");
  }

  getData() async {
    isLoading = true;
    // _dataServices.GuiasElectronicas_ObtenerListaGeneral("0", initDate, endDate).then((value) {
    await DBAdmin().getDB_OfflineListaGuiasElectronicas().then((value) {
      listaModel = value;
      //  informeModelList3.addAll(informeModelList2);
      Accion = 0;
      setState(() {
        isLoading = false;
      });
    });
  }

  Future download(Dio dio, String url, String IdGuia, String savePath) async {
    try {
      Response response = await dio.post(
        url,
        data: {
          'Id': IdGuia,
        },
        onReceiveProgress: updateProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(savePath);
      var file = File(savePath).openSync(mode: FileMode.write);
      file.writeFromSync(response.data);
      await file.close();
    } catch (e) {
      print(e);
    }
  }

  void updateProgress(done, total) {
    progress = done / total;
    setState(() {
      if (progress >= 1) {
        progressString =
            '✅ File has finished downloading. Try opening the file.';
        didDownloadPDF = true;
        mensajeToast("Documento Descargado", Colors.green, Colors.white);
      } else {
        progressString = 'Download progress: ' +
            (progress * 100).toStringAsFixed(0) +
            '% done.';
      }
    });
  }

  _openAndroidPrivateFile(String ruta) async {
    final result = await OpenFilex.open(ruta);
  }

  existeCheckList() async {
    if (_prefs.usIdPlaca != "0" && _prefs.usIdPlaca != "") {
      //cuando existe si podremos crear
      Navigator.pushNamed(context, 'checkListCreate');
    } else {
      showMessajeAWYesNo(DialogType.ERROR, "SIN PLACA",
          "No se selecciono ninguna PLACA, ¿Desea Ingresarlo?", 1);
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

  void Pruebas(String Id) async {
    try {
      var _guiasElectronicasServices = new GuiasElectronicasServices();
      String a =
          await _guiasElectronicasServices.DescargarGuiaElectronicaPDF(Id);
    } catch (ex) {}
  }

  // _launchURL() async {
  //
  //   String FUrl = kUrl + "/Download";
  //   final Uri url = Uri.parse(FUrl);
  //   if (!await launchUrl(url)) {
  //     throw Exception('Could not launch ');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista Guias Elec. Offline"),
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
              Navigator.pushNamed(context, 'offlineGuiasElectronicasCreate');

              // existeCheckList();
            },
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
      //   tooltip: 'Increment',
      //   onPressed: (){
      //     print("Que riko aprietas kata");
      //     // print(_selectedTipoSubClientes!.scId);
      //   //  _launchURL();
      //    // Pruebas();
      //    // PDF().cachedFromUrl('http://192.168.2.92:9091/Service/Service1.svc/Download');
      //   },
      //   child: const Icon(Icons.add, color: Colors.white, size: 28),
      // ),
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
                ListTile(
                  onTap: null,
                  tileColor: Colors.white54,
                  leading: CircleAvatar(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Sunat",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold)),
                        //  Text(informeModelList2[i].cabNumero!, style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  // leading: CircleAvatar(
                  //   backgroundColor: Colors.transparent,
                  // ),
                  //  leading: Expanded(child: Text("SUNAT",style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.activeBlue),)),
                  title: Row(children: <Widget>[
                    Expanded(
                        child: Text(
                      "Documento",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    Expanded(
                        child: Text(
                      "Fecha",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                        child: Text(
                      "Acciones",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    )),
                    //Expanded(child: Text("Id")),
                  ]),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: listaModel.length,
                    itemBuilder: (BuildContext context, int i) {
                      return ListTile(
                        // tileColor: miColor,
                        onTap: () {
                          //print(listaModel[i].re!);
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${listaModel[i].gutrSerie}" +
                                  "-" +
                                  "${listaModel[i].gutrNumero}",
                              // "${informeModelList2[i].piFechaApertura}" +
                              //     "-" +
                              //     "${informeModelList2[i].usuarioCreacionDesc}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              // "${double.parse(informeModelList2[i].usuarioCreacionDesc!).toStringAsFixed(2)}",
                              listaModel[i].gutrFechaEmision!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        // subtitle: Text(informeModelList2[i].fecha!),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                listaModel[i].clientesFkDesc!,
                                // "aaaaaaaal istaModel[i]. clienteRemiteneeeeeteFk Desc!" ,
                                //   "RESTANTES?",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            //Text(
                            //   // "${double.parse(informeModelList2[i].usuarioCreacionDesc!).toStringAsFixed(2)}",
                            //   listaModel[i].fechaCreacion!,
                            //   overflow: TextOverflow.ellipsis,
                            //   maxLines: 1,
                            //   style: const TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.green),
                            // ),
                          ],
                        ),

                        leading: listaModel[i].estadoSunatFk! == "56"
                            ? IconButton(
                                icon: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                onPressed: () {},
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.warning_outlined,
                                  color: Colors.orangeAccent,
                                  size: 30,
                                ),
                                onPressed: () {
                                  AwesomeDialog(
                                    dismissOnTouchOutside: false,
                                    context: context,
                                    dialogType: DialogType.QUESTION,
                                    headerAnimationLoop: false,
                                    animType: AnimType.TOPSLIDE,
                                    showCloseIcon: true,
                                    closeIcon: const Icon(
                                        Icons.close_fullscreen_outlined),
                                    title: "Enviar Sunat",
                                    btnCancelText: "No",
                                    btnOkText: "Si",
                                    descTextStyle: TextStyle(fontSize: 18),
                                    desc: "¿Desea enviar el documento a Sunat?",
                                    btnCancelOnPress: () {},
                                    onDissmissCallback: (type) {
                                      debugPrint(
                                          'Dialog Dissmiss from callback $type');
                                    },
                                    btnOkOnPress: () {
                                      EnviarSunat(listaModel[i].gutrId!);
                                      print("Enviando Guia Nro: " +
                                          listaModel[i].gutrId!);
                                    },
                                  ).show().then((value) {
                                    getData();
                                    setState(() {});
                                  });
                                },
                              ),

                        trailing: Wrap(
                          spacing: 12, // space between two icons
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.print, color: Colors.blue),
                              // onPressed: didDownloadPDF ? null : () async {
                              onPressed: () async {
                                Navigator.pushNamed(context,
                                    'offlineImpresionGuiasElectronicas');
                                _prefs.spGuiaOffline =
                                    listaModel[i].id.toString();
                                print("Enviando a Imprimir el ID: " +
                                    _prefs.spGuiaOffline);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.picture_as_pdf,
                                  color: Colors.redAccent),
                              // onPressed: didDownloadPDF ? null : () async {
                              onPressed: () async {
                                _prefs.spGuiaOffline =
                                    listaModel[i].id.toString();
                                ImpresionPDF();
                              },
                            ),
                            // IconButton(
                            //   icon: Icon(Icons.download_for_offline,
                            //       color: Colors.green),
                            //   // onPressed: didDownloadPDF ? null : () async {
                            //   onPressed: () async {
                            //     var tempDir = await getTemporaryDirectory();
                            //     var imageUrl = kUrl + "/GuiasElectronicas_DescargarPDF";
                            //     download(Dio(), imageUrl, listaModel[i].gutrId!, tempDir.path +'/'+listaModel[i].gutrSerie! + listaModel[i].gutrNumero!+'.pdf' );
                            //   },
                            // ),
                            // IconButton(
                            //   icon: Icon(Icons.remove_red_eye_outlined,
                            //       color: Colors.blue),
                            //   // onPressed: !didDownloadPDF ? null : () async {
                            //   onPressed:  () async {
                            //     var tempDir = await getTemporaryDirectory();
                            //     //_openAndroidPrivateFile(tempDir.path + fileName);
                            //     _openAndroidPrivateFile(tempDir.path+'/' +listaModel[i].gutrSerie! + listaModel[i].gutrNumero!+'.pdf' );
                            //   },
                            // ),
                          ],
                        ),
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
            {}
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

  EnviarSunat(String id) async {
    try {
      setState(() {
        isLoading = true;
      });
      var _guiasElectronicasServices = new GuiasElectronicasServices();

      String res =
          await _guiasElectronicasServices.GuiasElectronicas_EnviarSunat(id);
      if (res == "1") {
        showMensajeriaAW(DialogType.SUCCES, "Confirmacion",
            "Guia Electronica enviada con exito");
      } else {
        showMensajeriaAW(
            DialogType.ERROR, "Error", "Ocurrio un error al enviar la guia");
      }
      setState(() {
        isLoading = false;
      });
      //desea grabar?

    } catch (e) {
      print(e);
    }
  }

  void ImpresionPDF() async {
    String NroDocCliente = "";
    String NroDocRemitente = "";
    String NroDocDestinatario = "";

    String NroDocConductor = "";
    String NroPlacaPrimaria = "";
    String NroPlacaSecundaria = "";

    //ImpresionEntregaModel _model = new ImpresionEntregaModel();
    GuiasElectronicasModel _model = new GuiasElectronicasModel();
    List<GuiasElectronicasDetalleModel> _modelDetalle = [];
    List<GuiasElectronicasConductoresModel> _modelConductor = [];
    List<GuiasElectronicasPlacasModel> _modelPlacas = [];

    List<GuiasElectronicasModel> informeModelList = [];

    await DBAdmin()
        .getDBOffline_ImpresionGuiaElectronicaxId(_prefs.spGuiaOffline)
        .then((value) async {
      _model = value.first; //nomas porque es lista xd
      var json = jsonEncode(value.map((e) => e.toJson()).toList());

      NroDocCliente = await DBAdmin().getCampoPorId(
          _model.clientesFk.toString(), "clientes", "extraNumero");
      NroDocRemitente = await DBAdmin().getCampoPorId(
          _model.clienteRemitenteFk.toString(), "clientes", "extraNumero");
      NroDocDestinatario = await DBAdmin().getCampoPorId(
          _model.clienteDestinatarioFk.toString(), "clientes", "extraNumero");

      print(json);
      setState(() {
        // isLoading=false;
      });
    });

    _modelDetalle = await DBAdmin()
        .getDBOffline_ImpresionGuiaElectronicaDetallexId(_prefs.spGuiaOffline);
    _modelConductor = await DBAdmin()
        .getDBOffline_ImpresionGuiaElectronicaConductoresxId(
            _prefs.spGuiaOffline);
    _modelPlacas = await DBAdmin()
        .getDBOffline_ImpresionGuiaElectronicaPlacasxId(_prefs.spGuiaOffline);

    String jsonDetalle = jsonEncode(_modelDetalle);
    String jsonConductor = jsonEncode(_modelConductor);
    String jsonPlacas = jsonEncode(_modelPlacas);
    print(jsonDetalle);
    print(jsonConductor);
    print(jsonPlacas);

    //
    // final qrCode = QrCode.fromData(
    //   data: _prefs.spImpEmpRuc + "|31|" + _model.gutrSerie! + "-" + _model.gutrNumero! + "||" + _model.gutrPesoTotal! + "|" + _model.gutrFechaEmision! + "|" + _model.clientesFkDesc!,
    //   errorCorrectLevel: QrErrorCorrectLevel.L,
    // );

    var filteredModelConductor =
        _modelConductor.where((item) => item.coreEstado == "1");
    for (var item in filteredModelConductor) {
      NroDocConductor = await DBAdmin().getCampoPorId(
          item.conductoresFk.toString(), "conductores", "extraNumero");
    }

    for (var item in _modelPlacas) {
      if (item.plreEstado == "1") {
        NroPlacaPrimaria = await DBAdmin().getCampoPorId(
            item.vehiculosFk.toString(), "vehiculos", "tipoDescripcion");
        print("Consultando 2... vehiculosFk: " + item.vehiculosFk.toString());
      } else if (item.vehiculosFk != null) {
        NroPlacaSecundaria = await DBAdmin().getCampoPorId(
            item.vehiculosFk.toString(), "vehiculos", "tipoDescripcion");
      } else {
        NroPlacaSecundaria = await DBAdmin().getCampoPorId(
            item.placasFk.toString(), "placas", "tipoDescripcion");
      }
    }

    print("valor Placa Primaria " + NroPlacaPrimaria);
    print(NroPlacaSecundaria);

    pw.Document pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        maxPages: 40,
        pageFormat: PdfPageFormat.a4,
        //  pw.Page(
        build: (pw.Context context) => [
          pw.Column(
            children: [
              pw.Text(' '),
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  _prefs.spImpEmpDireccion,
                  style: pw.TextStyle(fontSize: 20),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  _prefs.spImpEmpRuc,
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Text(' '),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
                  style: pw.TextStyle(fontSize: 20),
                ),
              ),
              pw.Divider(),
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  "GUIA REMISION TRANSPORTISTA ELECTRONICA",
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  _model.gutrSerie! + "-" + _model.gutrNumero!,
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Divider(),

              /// /////////////////////////////////////////
              /// //////// Todo: CUERPO  CLIENTE //////////
              /// /////////////////////////////////////////

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('F. Emision:${_model.gutrFechaEmision}',
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Text('F. Traslado:${_model.gutrFechaTraslado}',
                      style: pw.TextStyle(fontSize: 20)),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.SizedBox(height: 10),
                  pw.Text("Cliente:",
                      style: pw.TextStyle(
                          fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  pw.Text("Doc.:" + NroDocCliente,
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Text("Cliente:" + _model.clientesFkDesc!,
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Text("Remitente:",
                      style: pw.TextStyle(
                          fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  pw.Text("Doc.:" + NroDocRemitente,
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Text("Remitente:" + _model.clienteRemitenteFkDesc!,
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Text("Destinatario:",
                      style: pw.TextStyle(
                          fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  pw.Text("Doc.:" + NroDocDestinatario,
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Text("Destinatario:" + _model.clienteDestinatarioFkDesc!,
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Text("Punto Partida:",
                      style: pw.TextStyle(
                          fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  pw.Text(_model.gutrPuntoPartida!,
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Text("Punto Llegada:",
                      style: pw.TextStyle(
                          fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  pw.Text(_model.gutrPuntoLlegada!,
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Text("Guia Remision:",
                      style: pw.TextStyle(
                          fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  pw.Text(_model.gutrGuiaRemision == null ? "":_model.gutrGuiaRemision!,
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Divider(),
                ],
              ),

              /// /////////////////////////////////////////
              /// //////// Todo: CUERPO  CONDUCTOR  ///////
              /// /////////////////////////////////////////

              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.SizedBox(height: 10),
                  pw.Text("Conductor:",
                      style: pw.TextStyle(
                          fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  pw.Text("Doc. Conductor:" + NroDocConductor,
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Text(
                      "Conductor:" +
                          _modelConductor
                              .firstWhere(
                                  (element) => element.coreEstado == "1")
                              .conductoresFkDesc!,
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Text("Unidades de Transporte:",
                      style: pw.TextStyle(
                          fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  pw.Text("Principal:" + NroPlacaPrimaria,
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Text("Secundaria:" + NroPlacaSecundaria,
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Divider(),
                ],
              ),

              /// /////////////////////////////////////////
              /// //////// Todo: CUERPO  DETALLE  ////////
              /// /////////////////////////////////////////

              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Row(
                    children: <pw.Widget>[
                      pw.Expanded(
                          flex: 6,
                          child: pw.Text('Descripcion',
                              style: pw.TextStyle(
                                  fontSize: 20,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Expanded(
                          flex: 3,
                          child: pw.Text('UM.',
                              style: pw.TextStyle(
                                  fontSize: 20,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Expanded(
                          flex: 3,
                          child: pw.Text('Cant.',
                              style: pw.TextStyle(
                                  fontSize: 20,
                                  fontWeight: pw.FontWeight.bold))),
                    ],
                  ),
                  ..._modelDetalle.map((itemsito) {
                    var lines = itemsito.gudeProductoDescripcion!.split(' ');
                    var cont = 1;
                    return pw.Column(
                      children: lines.map((line) {
                        var row = pw.Row(
                          children: <pw.Widget>[
                            pw.Expanded(
                                flex: 6,
                                child: pw.Text(line,
                                    style: pw.TextStyle(fontSize: 20))),
                            pw.Expanded(
                                flex: 3,
                                child: pw.Text(
                                    cont == 1
                                        ? itemsito
                                            .tipoProductoUnidadMedidaFkDesc!
                                        : '',
                                    style: pw.TextStyle(fontSize: 20))),
                            pw.Expanded(
                                flex: 3,
                                child: pw.Text(
                                    cont == 1 ? itemsito.gudeCantidad! : '',
                                    style: pw.TextStyle(fontSize: 20))),
                          ],
                        );
                        cont = cont + 1;
                        return row;
                      }).toList(),
                    );
                  }).toList(),
                  pw.Divider(),
                ],
              ),

              /// /////////////////////////////////////////
              /// //////// Todo: CUERPO  UNIDADES  ////////
              /// /////////////////////////////////////////

              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Text("Unidad de Medida: " + _model.unidadMedidaFkDesc!,
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Text("Peso bruto: " + _model.gutrPesoTotal!,
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Text("Observaciones: " + _model.gutrObservaciones!,
                      style: pw.TextStyle(fontSize: 20)),
                  pw.Divider(),
                ],
              ),

              /// /////////////////////////////////////////
              /// //////// Todo: FOTTER  HASH  ///////////
              /// /////////////////////////////////////////
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: <pw.Widget>[
                  pw.SizedBox(height: 10),
                  pw.Text("Cod. HASH:",
                      style: pw.TextStyle(
                        fontSize: 20,
                      )),
                  pw.Text("Representacion impresa de la guia Transportista",
                      style: pw.TextStyle(
                        fontSize: 20,
                      )),
                  pw.Text("XML y CDR se descarga en",
                      style: pw.TextStyle(
                        fontSize: 20,
                      )),
                  pw.Text("http://www.sunat.gob.pe",
                      style: pw.TextStyle(
                        fontSize: 20,
                      )),
                  pw.Text("",
                      style: pw.TextStyle(
                        fontSize: 20,
                      )),
                ],
              ),

              /// /////////////////////////////////////////
              /// //////// Todo: FOTTER  QR END  //////////
              /// /////////////////////////////////////////
              pw.Text(""),
              pw.Center(
                child: pw.BarcodeWidget(
                  barcode: pw.Barcode.qrCode(),
                  data: _prefs.spImpEmpRuc +
                      "|31|" +
                      _model.gutrSerie! +
                      "-" +
                      _model.gutrNumero! +
                      "||" +
                      _model.gutrPesoTotal! +
                      "|" +
                      _model.gutrFechaEmision! +
                      "|" +
                      _model.clientesFkDesc!,
                  width: 150,
                  height: 150,
                ),
              ),
            ],
          ),
        ],
      ),
      // ),
    );

    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}

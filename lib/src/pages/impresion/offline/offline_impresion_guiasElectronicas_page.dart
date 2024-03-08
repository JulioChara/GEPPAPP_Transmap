
import 'dart:convert';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transmap_app/db/db_admin.dart';
import 'package:transmap_app/src/models/offline/offlineGuiasElectronicas_model.dart';

import 'package:transmap_app/utils/sp_global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as Image;


class OfflineImpresionGuiasElectronicasPage extends StatefulWidget {


  @override
  State<OfflineImpresionGuiasElectronicasPage> createState() => _OfflineImpresionGuiasElectronicasPageState();
}

class _OfflineImpresionGuiasElectronicasPageState extends State<OfflineImpresionGuiasElectronicasPage> {







  SPGlobal _prefs = SPGlobal();

  String NroDocCliente="";
  String NroDocRemitente="";
  String NroDocDestinatario="";

  String NroDocConductor="";
  String NroPlacaPrimaria="";
  String NroPlacaSecundaria="";

  //ImpresionEntregaModel _model = new ImpresionEntregaModel();
  GuiasElectronicasModel _model = new GuiasElectronicasModel();
  List<GuiasElectronicasDetalleModel> _modelDetalle = [];
  List<GuiasElectronicasConductoresModel> _modelConductor = [];
  List<GuiasElectronicasPlacasModel> _modelPlacas = [];

  List<GuiasElectronicasModel> informeModelList = [];

  @override
  void initState() {
    super.initState();
    getData();
    getBluetooth();
  }

  getData() async {
    // old
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String idDet = await prefs.getString("idDet")!;
    // print("Id Detalle: " + idDet);

    print("Fecha a imprimir :" + DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()));
    //DBAdmin().getDBOfflinePedidosDetallexId(idDet).then((value){
    await DBAdmin().getDBOffline_ImpresionGuiaElectronicaxId(_prefs.spGuiaOffline).then((value) async{
      _model = value.first; //nomas porque es lista xd
      var json = jsonEncode(value.map((e) => e.toJson()).toList());

      NroDocCliente = await DBAdmin().getCampoPorId(_model.clientesFk.toString(),"clientes", "extraNumero");
      NroDocRemitente = await DBAdmin().getCampoPorId(_model.clienteRemitenteFk.toString(),"clientes", "extraNumero");
      NroDocDestinatario = await DBAdmin().getCampoPorId(_model.clienteDestinatarioFk.toString(),"clientes", "extraNumero");


      print(json);
      setState(() {
        // isLoading=false;
      });
    });



    _modelDetalle = await DBAdmin().getDBOffline_ImpresionGuiaElectronicaDetallexId(_prefs.spGuiaOffline);
    _modelConductor =await DBAdmin().getDBOffline_ImpresionGuiaElectronicaConductoresxId(_prefs.spGuiaOffline);
    _modelPlacas = await DBAdmin().getDBOffline_ImpresionGuiaElectronicaPlacasxId(_prefs.spGuiaOffline);


    String jsonDetalle = jsonEncode(_modelDetalle);
    String jsonConductor = jsonEncode(_modelConductor);
    String jsonPlacas = jsonEncode(_modelPlacas);
    print(jsonDetalle);
    print(jsonConductor);
    print(jsonPlacas);


    _modelConductor.where((item) => item.coreEstado =="1" ).forEach((item) async {
      NroDocConductor = await DBAdmin().getCampoPorId(item.conductoresFk.toString(),"conductores", "tipoDescripcion");
    });
    _modelPlacas.where((item) => item.plreEstado =="1").forEach((item)async {
      NroPlacaPrimaria = await DBAdmin().getCampoPorId(item.vehiculosFk.toString(),"vehiculos", "tipoDescripcion");

    });

    _modelPlacas.forEach((item) async {
      if(item.plreEstado =="1"){
        NroPlacaPrimaria = await DBAdmin().getCampoPorId(item.vehiculosFk.toString(),"vehiculos", "tipoDescripcion");
      }else if(item.vehiculosFk != null){
        NroPlacaSecundaria = await DBAdmin().getCampoPorId(item.vehiculosFk.toString(),"vehiculos", "tipoDescripcion");
      }else {
        NroPlacaSecundaria = await DBAdmin().getCampoPorId(item.placasFk.toString(),"placas", "tipoDescripcion");
      }
    });






  }

  bool connected = false;
  List availableBluetoothDevices = [];

  Future<void> getBluetooth() async {
    List? bluetooths = await BluetoothThermalPrinter.getBluetooths;
    print("Print $bluetooths");
    setState(() {
      availableBluetoothDevices = bluetooths ?? [];
    });
  }

  Future<void> setConnect(String mac) async {
    print(mac);
    String? result = await BluetoothThermalPrinter.connect(mac);


    print("state conneected $result");
    if (result == "true") {
      // var snackBar = SnackBar(content: Text("Conectado"));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        connected = true;
      });
    }
  }

  Future<void> printTicket() async {
    String? isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == "true") {
      List<int> bytes = await getTicket();
      final result = await BluetoothThermalPrinter.writeBytes(bytes);
      print("Print $result");
    } else {
      //Hadnle Not Connected Senario
    }
  }

  showMensajeriaAW(DialogType tipo, String titulo, String desc) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: tipo,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close),
      title: titulo,
      descTextStyle: TextStyle(fontSize: 18),
      desc: desc,
      btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {
        printTicket().then((value) {}).whenComplete(() {
          //Navigator.pop(context);
        });
      },
    ).show().then((value) {
      getData();
      setState(() {});
    });
  }

  //@override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(
  //         "Dispositivos",
  //       ),
  //     ),
  //     body: availableBluetoothDevices.isNotEmpty
  //         ? ListView.builder(
  //       itemCount: availableBluetoothDevices.length,
  //       itemBuilder: (context, index) {
  //         String nameDevice =
  //         availableBluetoothDevices[index].split("#")[0];
  //         String mac = availableBluetoothDevices[index].split("#")[1];
  //         return ListTile(
  //           onTap: () {
  //             setConnect(mac);
  //             // var snackBar = SnackBar(content: Text("Hola"));
  //             // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //             showMensajeriaAW(DialogType.QUESTION, "Confirmacion",
  //                 "Desea Imprimir el Documento?");
  //             //  showViewPrint();
  //           },
  //           title: Text(nameDevice),
  //           subtitle: Text(mac),
  //         );
  //       },
  //     )
  //         : Center(
  //       child: Text(
  //         "No hay dispositivos mapeados",
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dispositivos OFF",
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[_prefs.colorA, _prefs.colorB])),
        ),
      ),
      body: availableBluetoothDevices.isNotEmpty
          ? ListView.builder(
        itemCount: availableBluetoothDevices.length,
        itemBuilder: (context, index) {
          String nameDevice =
          availableBluetoothDevices[index].split("#")[0];
          String mac = availableBluetoothDevices[index].split("#")[1];
          if (nameDevice.startsWith("MTP")) {
            return ListTile(
              onTap: () {
                setConnect(mac);
                showMensajeriaAW(DialogType.QUESTION, "Confirmacion",
                    "Desea Imprimir el Documento?");
              },
              title: Text(nameDevice),
              subtitle: Text(mac),
            );
          } else {
            return Container(); // Retorna un contenedor vacío si el dispositivo no comienza con "MTP"
          }
        },
      )
          : Center(
        child: Text(
          "No hay dispositivos mapeados",
        ),
      ),
    );
  }






  Future<List<int>> getTicket() async {
    List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);

    bytes += generator.text(
      // "Grifo Aeropuerto 610",
     _prefs.spImpEmpEmpresa,
      styles: PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
      linesAfter: 1,
    );

//Imagem
//     final ByteData data = await rootBundle.load('assets/logomini.jpg');
//     final Uint8List imgBytes = data.buffer.asUint8List();
//     final Image.Image image = Image.decodeImage(imgBytes)!;
//    bytes += generator.image(image, align: PosAlign.center);
//     bytes += generator.text(
//       " ",
//       styles: PosStyles(align: PosAlign.center),
//     );
//     bytes += generator.row(
//       [
//         PosColumn(
//             text: 'ENTREGA DE PRODUCTO',
//             width: 12,
//             styles: PosStyles(align: PosAlign.center, width: PosTextSize.size2)),
//       ],
//     );

    bytes += generator.text(
      " ",
      styles: PosStyles(align: PosAlign.center),
    );
    bytes += generator.text(
      //"Carretera Panamericana Sur Nro 610",
      _prefs.spImpEmpDireccion,
      styles: PosStyles(align: PosAlign.center),
    );

    bytes += generator.text(_prefs.spImpEmpRuc,
        styles: PosStyles(align: PosAlign.center, bold: true));
    bytes += generator.text(" ");
    bytes += generator.text(DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
        styles: PosStyles(align: PosAlign.left, bold: false));


    // bytes += generator.hr(ch: '=', linesAfter: 1);
    bytes += generator.hr();
    bytes += generator.text("GUIA REMISION TRANSPORTISTA ELECTRONICA",
        styles: PosStyles(align: PosAlign.center, bold: true));
    bytes += generator.text(_model.gutrSerie!+"-"+_model.gutrNumero!,
        styles: PosStyles(align: PosAlign.center, bold: true));

    bytes += generator.hr();

    /// /////////////////////////////////////////
    /// //////// Todo: CUERPO  CLIENTE //////////
    /// /////////////////////////////////////////

    // bytes += generator.text(
    //   'Fec.Emision: ${DateTime.now.toString()}',
    //   styles: PosStyles(align: PosAlign.left),
    // );
    bytes += generator.row(
      [
        PosColumn(
            text: 'F. Emision:${_model.gutrFechaEmision}',
            width: 6,
            styles: PosStyles(align: PosAlign.left, bold: false)),
        PosColumn(
            text: 'F. Traslado:${_model.gutrFechaTraslado}',
            width: 6,
            styles: PosStyles(align: PosAlign.right, bold: false)),
      ],
    );

    bytes += generator.text("Cliente:",
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text("Doc.:"+NroDocCliente,
        styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.text("Cliente:" + _model.clientesFkDesc!,
        styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.text("Remitente:",
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text("Doc.:"+NroDocRemitente,
        styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.text("Remitente:"+ _model.clienteRemitenteFkDesc!,
        styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.text("Destinatario:",
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text("Doc.:"+NroDocDestinatario,
        styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.text("Destinatario:"+ _model.clienteDestinatarioFkDesc!,
        styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.text("Punto Partida:",
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text( _model.gutrPuntoPartida!,
        styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.text("Punto Llegada:",
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text( _model.gutrPuntoLlegada!,
        styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.text("Guia Remision:",
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text( _model.gutrGuiaRemision!,
        styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.hr();

    /// /////////////////////////////////////////
    /// //////// Todo: CUERPO  CONDUCTOR  ///////
    /// /////////////////////////////////////////

    bytes += generator.text("Conductor:",
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text("Doc. Conductor:"+ NroDocConductor,
        styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.text("Conductor:" + _modelConductor.firstWhere((element) => element.coreEstado == "1").conductoresFkDesc!,
       styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.text("Unidades de Transporte:",
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text("Principal:"+ NroPlacaPrimaria,
        styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.text("Secundaria:"+ NroPlacaSecundaria,
        styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.hr();

    /// /////////////////////////////////////////
    /// //////// Todo: CUERPO  DETALLE  ////////
    /// /////////////////////////////////////////

    bytes += generator.row(
      [
        PosColumn(
            text: 'Descripcion',
            width: 6,
            styles: PosStyles(align: PosAlign.left, bold: true)),
        PosColumn(
            text: 'UM.',
            width: 3,
            styles: PosStyles(align: PosAlign.left, bold: true)),
        PosColumn(
            text: 'Cant.',
            width: 3,
            styles: PosStyles(align: PosAlign.right, bold: true)),
      ],
    );

    _modelDetalle.forEach((itemsito) {
      var lines = itemsito.gudeProductoDescripcion!.split(' ');
      var cont = 1;
      for (var line in lines) {

        bytes += generator.row([
          PosColumn(
              text: line,
              width: 6,
              styles: PosStyles(
                align: PosAlign.left,
              )),
          PosColumn(
              text: cont ==1 ?itemsito.tipoProductoUnidadMedidaFkDesc! : '',
              width: 3,
              styles: PosStyles(
                align: PosAlign.left,
              )),
          PosColumn(
            text: cont ==1 ?itemsito.gudeCantidad! :'' ,
            width: 3,
            styles: PosStyles(align: PosAlign.right),
          ),
        ]);
        cont = cont+1;
      }

    });
    bytes += generator.hr();


    /// /////////////////////////////////////////
    /// //////// Todo: CUERPO  UNIDADES  ////////
    /// /////////////////////////////////////////
    bytes += generator.text( "Unidad de Medida: "+ _model.unidadMedidaFkDesc!,
        styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.text( "Peso bruto: "+ _model.gutrPesoTotal!,
        styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.text( "Observaciones: " +_model.gutrObservaciones!,
        styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.hr();

    /// /////////////////////////////////////////
    /// //////// Todo: FOTTER  HASH  ///////////
    /// /////////////////////////////////////////
    bytes += generator.text(" ");
    bytes += generator.text( "Cod.HASH: ",
        styles: PosStyles(align: PosAlign.center, bold: false));
    bytes += generator.text( "Representacion impresa de la guia Transportista, XML y CDR se descarga en :",
        styles: PosStyles(align: PosAlign.center, bold: false));
    bytes += generator.text( "http://www.sunat.gob.pe",
        styles: PosStyles(align: PosAlign.center, bold: false));

    /// /////////////////////////////////////////
    /// //////// Todo: FOTTER  QR END  //////////
    /// /////////////////////////////////////////
    bytes += generator.text(" ");
    // var QRString = _prefs.spImpEmpRuc + "|31|" + _model.gutrSerie! + "-" + _model.gutrNumero! + "||" + _model.gutrPesoTotal! + "|" + _model.gutrFechaEmision! + "|" + tipocli_ + "|" + entcli.EntiNroDocumento + "|" + ven.GutrCodigoHash;
    var QRString = _prefs.spImpEmpRuc + "|31|" + _model.gutrSerie! + "-" + _model.gutrNumero! + "||" + _model.gutrPesoTotal! + "|" + _model.gutrFechaEmision! + "|" + _model.clientesFkDesc!;
    bytes += generator.qrcode(QRString);
    bytes += generator.cut();
    return bytes;
  }
















}

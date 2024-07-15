
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transmap_app/db/db_admin.dart';
import 'package:transmap_app/src/models/checkList/checkList_model.dart';
import 'package:transmap_app/src/services/checkList/checkList_service.dart';



import 'package:transmap_app/utils/sp_global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as Image;



class ImpresionCheckListPage extends StatefulWidget {
  const ImpresionCheckListPage({super.key});

  @override
  State<ImpresionCheckListPage> createState() => _ImpresionCheckListPageState();
}

class _ImpresionCheckListPageState extends State<ImpresionCheckListPage> {







  SPGlobal _prefs = SPGlobal();
  bool loading = true;


  ImpresionCheckListModel _model = new ImpresionCheckListModel();


  @override
  void initState() {
    super.initState();
    getData();
    getBluetooth();
  }

  getData() async {

    print("Fecha a imprimir :" + DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()));

    CheckListServices _Services = new CheckListServices();


    await _Services.CheckList_Impresion_Directa(_prefs.spIdCheckList).then((value) async{
      _model = value; //nomas porque es lista xd
      // print(jsonEncode(_model));
      print("Hola");
      print(_model.toJson());
      setState(() {
        loading = false;
      });
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dispositivos ON",
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
      body:  loading
          ? Center(child: CircularProgressIndicator()) : availableBluetoothDevices.isNotEmpty
          ? ListView.builder(
        itemCount: availableBluetoothDevices.length,
        itemBuilder: (context, index) {
          String nameDevice =
          availableBluetoothDevices[index].split("#")[0];
          String mac = availableBluetoothDevices[index].split("#")[1];
          if (nameDevice.contains("MTP")|| nameDevice.contains("Printer")|| nameDevice.contains("PRINTER")) {
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

    bytes += generator.text(
      " ",
      styles: PosStyles(align: PosAlign.center),
    );
    bytes += generator.text(
      //"Carretera Panamericana Sur Nro 610",
      _prefs.spImpEmpDireccion,
      styles: PosStyles(align: PosAlign.center),
    );

    // bytes += generator.text(_model.cabEmpresaRuc!,
    //     styles: PosStyles(align: PosAlign.center, bold: true));
    // bytes += generator.text(" ");
    // bytes += generator.text(DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
    //     styles: PosStyles(align: PosAlign.left, bold: false));
    //
    //
    // // bytes += generator.hr(ch: '=', linesAfter: 1);
    // bytes += generator.hr();
    // bytes += generator.text("GUIA REMISION TRANSPORTISTA ELECTRONICA",
    //     styles: PosStyles(align: PosAlign.center, bold: true));
    // bytes += generator.text(_model.cabGuiaSerie!+"-"+_model.cabGuiaNumero!,
    //     styles: PosStyles(align: PosAlign.center, bold: true));
    //
    bytes += generator.text( _model.tipoCheckList =="S" ? "CHECKLIST SEMANAL" : "CHECKLIST DIARIO",
             styles: PosStyles(align: PosAlign.center, bold: true));

     bytes += generator.hr();
    /// /////////////////////////////////////////
    /// //////// Todo: CUERPO  RESUMEN //////////
    /// /////////////////////////////////////////
    bytes += generator.text("CHECK LIST (" +_model.detalle!.where((itemsito) => itemsito.tipoCategoriaFk != "10790").length.toString() +")",
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text("TOTAL:  B:" +_model.detalle!.where((itemsito) => itemsito.tipoCategoriaFk != "10790" && itemsito.tipoOpcionFkDesc =="BUENO").length.toString() +" R:"+_model.detalle!.where((itemsito) => itemsito.tipoCategoriaFk != "10790" && itemsito.tipoOpcionFkDesc =="REGULAR").length.toString()+" M:"+_model.detalle!.where((itemsito) => itemsito.tipoCategoriaFk != "10790" && itemsito.tipoOpcionFkDesc =="MALO").length.toString()+ " O:"+_model.detalle!.where((itemsito) => itemsito.tipoCategoriaFk != "10790" && itemsito.tipoOpcionFkDesc =="OTROS").length.toString(),
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.hr();
    /// /////////////////////////////////////////
    /// //////// Todo: CUERPO  CABECERA //////////
    /// /////////////////////////////////////////
    ///
    bytes += generator.text("Fecha:",
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text(_model.fechaCreacion!,
        styles: PosStyles(align: PosAlign.left, bold: false));

    bytes += generator.text("Vehiculo:",
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text(_model.vehiculoFkDesc!,
        styles: PosStyles(align: PosAlign.left, bold: false));
    bytes += generator.hr();
    // bytes += generator.row(
    //   [
    //     PosColumn(
    //         text: 'Fecha:${_model.fechaCreacion}',
    //         width: 6,
    //         styles: PosStyles(align: PosAlign.left, bold: false)),
    //     PosColumn(
    //         text: 'F. Traslado:${_model.cabFechaTraslado}',
    //         width: 6,
    //         styles: PosStyles(align: PosAlign.right, bold: false)),
    //   ],
    // );


    /// /////////////////////////////////////////
    /// //////// Todo: CUERPO  CATEGORIAS  ////////
    /// /////////////////////////////////////////

    // _model.detalle!.where((itemsito) => !itemsito.contains('AGG')).forEach((itemsito) {
    _model.detalle!.where((itemsito) => itemsito.tipoCategoriaFk != "10790" ).forEach((itemsito) {
      bytes += generator.text(itemsito.tipoCategoriaFkDesc!,
          styles: PosStyles(align: PosAlign.left, bold: true));
      bytes += generator.text(itemsito.tipoOpcionFkDesc!,
          styles: PosStyles(align: PosAlign.left, bold: false));
    });
    bytes += generator.hr();


    /// /////////////////////////////////////////
    /// //////// Todo: CUERPO  RESUMEN //////////
    /// /////////////////////////////////////////
    bytes += generator.text("CHECK LIST NEUMATICOS (" +_model.detalle!.where((itemsito) => itemsito.tipoCategoriaFk == "10790").length.toString() +")",
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text("TOTAL:  B:" +_model.detalle!.where((itemsito) => itemsito.tipoCategoriaFk == "10790" && itemsito.tipoOpcionFkDesc =="BUENO").length.toString() +" R:"+_model.detalle!.where((itemsito) => itemsito.tipoCategoriaFk == "10790" && itemsito.tipoOpcionFkDesc =="REGULAR").length.toString()+" M:"+_model.detalle!.where((itemsito) => itemsito.tipoCategoriaFk == "10790" && itemsito.tipoOpcionFkDesc =="MALO").length.toString()+ " O:"+_model.detalle!.where((itemsito) => itemsito.tipoCategoriaFk == "10790" && itemsito.tipoOpcionFkDesc =="OTROS").length.toString(),
        styles: PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.hr();
    /// ///////////////////////////////
    /// //////// Todo: CUERPO  DETALLE  ////////
    /// /////////////////////////////////////////
    bytes += generator.text("NEUMATICOS",
        styles: PosStyles(align: PosAlign.center, bold: true));
    bytes += generator.row(
      [
        PosColumn(
            text: 'Sub Categoria',
            width: 9,
            styles: PosStyles(align: PosAlign.left, bold: true)),

        PosColumn(
            text: 'Estado.',
            width: 3,
            styles: PosStyles(align: PosAlign.right, bold: true)),
      ],
    );

    _model.detalle!.where((itemsito) => itemsito.tipoCategoriaFk == "10790" ).forEach((itemsito) {
      var lines = itemsito.tipoOpcionFkDesc!.split(' ');
      var cont = 1;
      for (var line in lines) {
        // Obtener la letra correspondiente según el valor de EstadoA
        String letter;
        switch (itemsito.tipoOpcionFkDesc) {
          case 'BUENO':
            letter = 'B';
            break;
          case 'REGULAR':
            letter = 'R';
            break;
          case 'MALO':
            letter = 'M';
            break;
          case 'OTROS':
            letter = 'O';
            break;
          default:
            letter = ''; // Si no hay coincidencia, dejarlo vacío
        }

        bytes += generator.row([


          PosColumn(
            text: cont == 1 ? itemsito.subTiposDetalle! : '',
            width: 9,
            styles: PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: itemsito.tipoOpcionFkDesc!, // Agregar la letra correspondiente
            width: 3,
            styles: PosStyles(align: PosAlign.center), // Alineación centrada
          ),
        ]);

        // Incrementa el contador solo si es la primera columna
        if (cont == 1) {
          cont++;
        } else {
          // Si ya se imprimieron dos cuadrados, agrega una nueva fila
          cont = 1;
          bytes += generator.row([]);
        }
      }
    });

    bytes += generator.hr();
    // _model.detalle!.forEach((itemsito) {
    //   var lines = itemsito.detProductoDescripcion.split(' ');
    //   var cont = 1;
    //   for (var line in lines) {
    //
    //     bytes += generator.row([
    //       PosColumn(
    //           text: line,
    //           width: 6,
    //           styles: PosStyles(
    //             align: PosAlign.left,
    //           )),
    //       PosColumn(
    //           text: cont ==1 ?itemsito.detUnidadMedida : '',
    //           width: 3,
    //           styles: PosStyles(
    //             align: PosAlign.left,
    //           )),
    //       PosColumn(
    //         text: cont ==1 ?itemsito.detCantidad :'' ,
    //         width: 3,
    //         styles: PosStyles(align: PosAlign.right),
    //       ),
    //     ]);
    //     cont = cont+1;
    //   }
    //
    // });
    // bytes += generator.hr();


    // _model.detalle!.forEach((itemsito) {
    //   var lines = itemsito.tipoOpcionFkDesc!.split(' ');
    //   var cont = 1;
    //   for (var line in lines) {
    //     // Obtener la letra correspondiente según el valor de EstadoA
    //     String letter;
    //     switch (itemsito.tipoOpcionFkDesc) {
    //       case 'BUENO':
    //         letter = 'B';
    //         break;
    //       case 'REGULAR':
    //         letter = 'R';
    //         break;
    //       case 'MALO':
    //         letter = 'M';
    //         break;
    //       case 'OTROS':
    //         letter = 'O';
    //         break;
    //       default:
    //         letter = ''; // Si no hay coincidencia, dejarlo vacío
    //     }
    //
    //     bytes += generator.row([
    //       PosColumn(
    //         text: line,
    //         width: 5,
    //         styles: PosStyles(align: PosAlign.left),
    //       ),
    //       PosColumn(
    //         text: cont == 1 ? itemsito.tipoCategoriaFkDesc! : '',
    //         width: 3,
    //         styles: PosStyles(align: PosAlign.left),
    //       ),
    //       PosColumn(
    //         text: cont == 1 ? itemsito.tipoOpcionFkDesc! : '',
    //         width: 3,
    //         styles: PosStyles(align: PosAlign.right),
    //       ),
    //       PosColumn(
    //         text: letter, // Agregar la letra correspondiente
    //         width: 1,
    //         styles: PosStyles(align: PosAlign.center), // Alineación centrada
    //       ),
    //     ]);
    //
    //     // Incrementa el contador solo si es la primera columna
    //     if (cont == 1) {
    //       cont++;
    //     } else {
    //       // Si ya se imprimieron dos cuadrados, agrega una nueva fila
    //       cont = 1;
    //       bytes += generator.row([]);
    //     }
    //   }
    // });

    // _model.detalle!.forEach((itemsito) {
    //   var lines = itemsito.tipoCategoriaFkDesc!.split(' ');
    //   var cont = 1;
    //   for (var line in lines) {
    //     // Obtener la letra correspondiente según el valor de EstadoA
    //     String letter;
    //     switch (itemsito.tipoOpcionFkDesc) {
    //           case 'BUENO':
    //             letter = 'B';
    //             break;
    //           case 'REGULAR':
    //             letter = 'R';
    //             break;
    //           case 'MALO':
    //             letter = 'M';
    //             break;
    //           case 'OTROS':
    //             letter = 'O';
    //             break;
    //           default:
    //             letter = ''; // Si no hay coincidencia, dejarlo vacío
    //         }
    //
    //     // Crear una cadena de texto con el formato deseado
    //     final formattedText = '$line ${cont == 1 ? itemsito.tipoCategoriaFkDesc : ''} ${cont == 1 ? itemsito.tipoOpcionFkDesc : ''} $letter';
    //
    //     bytes += generator.row([
    //       PosColumn(
    //         text: formattedText,
    //         width: 12, // Ajusta el ancho total de la fila según tus necesidades
    //         styles: PosStyles(align: PosAlign.left),
    //       ),
    //     ]);
    //
    //     // Incrementa el contador solo si es la primera columna
    //     if (cont == 1) {
    //       cont++;
    //     } else {
    //       // Si ya se imprimieron dos cuadrados, agrega una nueva fila
    //       cont = 1;
    //       //bytes += generator.row([]);
    //     }
    //   }
    // });

    /// /////////////////////////////////////////
    /// //////// Todo: CUERPO  UNIDADES  ////////
    /// /////////////////////////////////////////
    // bytes += generator.text( "Unidad de Medida: "+ _model.cabUnidadMedida!,
    //     styles: PosStyles(align: PosAlign.left, bold: false));
    // bytes += generator.text( "Peso bruto: "+ _model.cabPesoBruto!,
    //     styles: PosStyles(align: PosAlign.left, bold: false));
    // bytes += generator.text( "Observaciones: " + (_model.cabObservaciones == null ? "" :_model.cabObservaciones!),
    //     styles: PosStyles(align: PosAlign.left, bold: false));
    // bytes += generator.hr();

    /// /////////////////////////////////////////
    /// //////// Todo: FOTTER  HASH  ///////////
    /// /////////////////////////////////////////
    // bytes += generator.text(" ");
    // bytes += generator.text( "Cod.HASH: ",
    //     styles: PosStyles(align: PosAlign.center, bold: false));
    // bytes += generator.text( "Representacion impresa de la guia Transportista, XML y CDR se descarga en :",
    //     styles: PosStyles(align: PosAlign.center, bold: false));
    // bytes += generator.text( "http://www.sunat.gob.pe",
    //     styles: PosStyles(align: PosAlign.center, bold: false));

    /// /////////////////////////////////////////
    /// //////// Todo: FOTTER  QR END  //////////
    /// /////////////////////////////////////////
    // bytes += generator.text(" ");
    // // var QRString = _prefs.spImpEmpRuc + "|31|" + _model.gutrSerie! + "-" + _model.gutrNumero! + "||" + _model.gutrPesoTotal! + "|" + _model.gutrFechaEmision! + "|" + tipocli_ + "|" + entcli.EntiNroDocumento + "|" + ven.GutrCodigoHash;
    // var QRString = _model.cabQrSunat!;
    // bytes += generator.qrcode(QRString);
    bytes += generator.cut();
    return bytes;
  }











}

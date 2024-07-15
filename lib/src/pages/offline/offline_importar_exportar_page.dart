import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transmap_app/db/db_admin.dart';
import 'package:transmap_app/src/models/general_model.dart';
import 'package:transmap_app/src/models/offline/offlineGuiasElectronicas_model.dart';
import 'package:transmap_app/src/services/offline/offlineGuiasElectronicas_services.dart';
import 'package:transmap_app/src/widgets/menu_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:transmap_app/utils/sp_global.dart';
import 'package:lottie/lottie.dart';

class OfflineImportarExportarPage extends StatefulWidget {
  @override
  State<OfflineImportarExportarPage> createState() =>
      _OfflineImportarExportarPageState();
}

class _OfflineImportarExportarPageState
    extends State<OfflineImportarExportarPage> {
  SPGlobal _prefs = SPGlobal();
  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);

  bool Loading =false;
  int _tapCount = 0;


  var _offlineServices = new OfflineServices();

  @override
  void initState() {
    super.initState();

  }



  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(),
      body: Loading
          ? Center(child: Lottie.asset("assets/animation/animation_loading_fly.json", height: 250)): Stack(
        children: <Widget>[dashBg, content],
      ),
    );
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

  showMensajeriaBasic(
      DialogType tipo,
      String titulo,
      String desc,
      ) {
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
      //   btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {},
    ).show().then((val) {
      //getData();
      setState(() {});
    });
  }

  showMensajeriaAW(DialogType tipo, String titulo, String desc, String Accion) {
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
        //   btnCancelOnPress: () {},
        onDissmissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
        btnCancelOnPress: () {},
        btnCancelText: "NO",
        btnOkOnPress: () {
          if (Accion == "1") {
            print("Procesando Descargar Data");
            // DBAdmin().initDatabase();
            // DBAdmin().getdata(initDate, endDate);
            traerInformacionOffline();
          }
          if (Accion == "2") {

             subirInformacionOffline();


            mensajeToast("Procesando...", Colors.black, Colors.white);
          }
          if (Accion == "3") {
            print("Procesando Eliminar");
            DBAdmin().deleteDatabase();
          }
        },
        btnOkText: "SI")
        .show()
        .then((val) {
      print("Accion Posterior");
      setState(() {});
    });
  }

  get dashBg => Column(
    children: <Widget>[
      Expanded(
        child: Container(color: _prefs.colorA),
        flex: 2,
      ),
      Expanded(
        child: Container(color: Colors.transparent),
        flex: 5,
      ),
    ],
  );

  get content => Container(
    child: Column(
      children: <Widget>[
        header,
        grid,
        fechas,
      ],
    ),
  );

  get header => ListTile(
    contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
    title: Text(
      'IMPORTAR / EXPORTAR',
      style: TextStyle(color: Colors.white),
    ),
    subtitle: Text(
      'Pedidos Delivery',
      style: TextStyle(color: Colors.blue),
    ),
      trailing: GestureDetector(
        onTap: () {
          _tapCount++;
          if (_tapCount == 10) {
            if (_prefs.spInformeCloud == "0"){
              _prefs.spInformeCloud = "1";
              _prefs.colorA = Colors.red;
              _prefs.colorB = Colors.red;
            } else {
              _prefs.spInformeCloud = "0";
              _prefs.colorA = Colors.green;
              _prefs.colorB = Colors.green;
            }
            setState(() {});
            _tapCount = 0; // reset the tap count
          }
        },
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              "https://www.anmosugoi.com/wp-content/uploads/2022/04/date-a-live-iv-portada-1.jpg"
          ),
        ),
      ),
  );



  get grid => Expanded(
    child: Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: GridView.count(
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: 2,
          childAspectRatio: .90,
          children: [
            InkWell(
              onTap: () {
                if (_prefs.spInformeCloud == "0" || _prefs.spInformeCloud =="") {
                  showMensajeriaAW(
                      DialogType.QUESTION,
                      "DESCARGAR INFORMACION?",
                      "Se descargaran datos del servidor \n *****NOTA***** \n *SE ELIMINARAN REGISTROS NO SUBIDOS AL SERVIDOR",
                      "1");
                } else {
                  mensajeToast("Suba su informacion pendiente",
                      Colors.orange, Colors.white);
                }
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //children: <Widget>[FlutterLogo(), Text('SUBIR')],
                    children: <Widget>[
                      Icon(Icons.cloud_download,
                          color: Colors.green, size: 80),
                      Text('DESCARGAR')
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (_prefs.spInformeCloud == "1") {
                  showMensajeriaAW(
                      DialogType.QUESTION,
                      "SUBIR INFORMACION?",
                      "Se subiran las Guias Realizadas en el modo Offline",
                      "2");
                } else {
                //  _prefs.spInformeCloud = "1";
                  mensajeToast("Primero descarge informacion",
                      Colors.orange, Colors.white);
                }
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //children: <Widget>[FlutterLogo(), Text('SUBIR')],
                    children: <Widget>[
                      Icon(Icons.cloud_upload,
                          color: Colors.blueAccent, size: 80),
                      Text('SUBIR')
                    ],
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: () {
                showMensajeriaAW(
                    DialogType.QUESTION,
                    "ELIMINAR BASE DE DATOS?",
                    "Esto eliminara la base de datos completa y todos los registros locales sin guardar",
                    "3");
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //children: <Widget>[FlutterLogo(), Text('SUBIR')],
                    children: <Widget>[
                      Icon(Icons.delete_forever,
                          color: Colors.red, size: 80),
                      Text('ELIMINAR')
                    ],
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: () {
                if  ( _prefs.spInformeCloud == "1") { //OFFLINE
                  Navigator.pushReplacementNamed(
                      context, 'offlineGuiasElectronicasHome');
                }else {
                  Navigator.pushReplacementNamed(
                      context, 'guiasElectronicasHome');
                }


                // mensajeToast("Hola", Colors.white, Colors.black);
                // checkStatus();
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.home,
                          color: Colors.orange, size: 80),
                      Text('HOME')
                    ],
                  ),
                ),
              ),
            ),
          ]

        // List.generate(8, (_) {
        //   return Card(
        //     elevation: 2,
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(8)
        //     ),
        //     child: Center(
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: <Widget>[FlutterLogo(), Text('data')],
        //       ),
        //     ),
        //   );
        // }),
      ),
    ),
  );

  get fechas => Row(
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
  );

  traerInformacionOffline() async {
    Loading =true;
    DBAdmin().initDatabase();
    String res = await DBAdmin().getdata(initDate, endDate);

    if (res == "1") {
      mensajeToast(
          "Proceso Completato", CupertinoColors.systemGreen, Colors.white);
      _prefs.spInformeCloud = "1";
      _prefs.colorA = Colors.red;
      _prefs.colorB = Colors.red;
    } else {
      mensajeToast(
          "Ocurrio un error", CupertinoColors.destructiveRed, Colors.white);
    }
    setState(() {
      Loading = false;
    });

  }

  subirInformacionOffline() async {
    Loading =true;
    List<GuiasElectronicasModel> _guias = await DBAdmin().upload_DBOffline_GuiasElectronicas();
    List<GuiasElectronicasDetalleModel> _detalles = await DBAdmin().upload_DBOffline_GuiasElectronicasDetalle();
    List<GuiasElectronicasConductoresModel> _conductores = await DBAdmin().upload_DBOffline_GuiasElectronicasConductores();
    List<GuiasElectronicasPlacasModel> _placas = await DBAdmin().upload_DBOffline_GuiasElectronicasPlacas();

    TestClassModel res =
    await _offlineServices.Offline_GuiasElectronicas_SubirInformacion(_guias, _detalles, _conductores, _placas);

    if (res.resultado == "1") {
      Loading =false;
      showMensajeriaBasic(
          DialogType.SUCCES, "EXITO", res.mensaje!);
      _prefs.spInformeCloud = "0";
      _prefs.colorA = Colors.green;
      _prefs.colorB = Colors.green;

    } else {
      Loading =false;
      showMensajeriaBasic(
          DialogType.ERROR, "ERROR", res.mensaje!);
    }
    setState(() {

    });
    print(res);

    // return res;
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
        //   getData();
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
        //  getData();
      });
  }

}

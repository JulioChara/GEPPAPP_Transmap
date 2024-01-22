


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:transmap_app/src/models/guiasElectronicas/guiasElectronicas_model.dart';
import 'package:transmap_app/src/services/guiasElectronicas/guiasElectronicas_services.dart';
import 'package:transmap_app/src/widgets/menu_widget.dart';
import 'package:transmap_app/utils/sp_global.dart';

class GuiasElectronicasPage extends StatefulWidget {

  @override
  State<GuiasElectronicasPage> createState() => _GuiasElectronicasPageState();

}




class _GuiasElectronicasPageState extends State<GuiasElectronicasPage> {


  SPGlobal _prefs = SPGlobal();





  var _dataServices = new GuiasElectronicasServices();

  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);

  int Accion = 0;

  TextEditingController inputFieldDateController = new TextEditingController();
  DateTime selectedDate = DateTime.now();
  List<GuiasElectronicasModel> listaModel = [];
  bool isLoading = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print("Dataaaa");

  }


  getData(){
    // isLoading = true;
    // _dataServices.postCheckList_ObtenerListaGeneral("0", initDate, endDate).then((value) {
    //   listaModel = value;
    //   //   informeModelList3.addAll(informeModelList2);
    //   Accion = 0;
      setState(() {
        isLoading = false;
      });
    // });
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
        title: Text("Lista Guias Electronicas"),
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
              Navigator.pushNamed(context, 'guiasElectronicasCreate');

             // existeCheckList();
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
                      //print(listaModel[i].re!);
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${listaModel[i].gutrSerie}" + "-"+"${listaModel[i].gutrNumero}" ,
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
                          listaModel[i].gutrFechaEmision!,
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
                          listaModel[i].clienteRemitenteFk! ,
                          //   "RESTANTES?",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ) ,
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


                    leading: IconButton(
                      icon: Icon(Icons.paste, color: Colors.red, size: 30,),
                      onPressed: () {

                      },
                    ),

                    trailing: listaModel[i].gutrEstado! ==
                        "True" && listaModel[i].gutrEstado! == "True"
                        ? Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 50.0,
                    )
                        : null

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

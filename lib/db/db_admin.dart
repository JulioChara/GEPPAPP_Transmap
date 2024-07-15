
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:transmap_app/src/models/guia_model.dart';
// import 'package:transmap_app/src/models/guiasElectronicas/guiasElectronicas_model.dart';
// import 'package:transmap_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transmap_app/src/services/offline/offlineGuiasElectronicas_services.dart';
import 'package:transmap_app/utils/sp_global.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../src/models/offline/offlineGuiasElectronicas_model.dart';

class DBAdmin {
  Database? _myDatabase;
  SPGlobal _prefs = SPGlobal();

  static final DBAdmin _instance = DBAdmin._();

  DBAdmin._();

  factory DBAdmin() {
    return _instance;
  }

  getDatabase() async {
    if (_myDatabase != null) return _myDatabase;
    _myDatabase = await initDatabase();
    return _myDatabase;
  }

  //
  // Future<Database> deleteAllData() async {
  //   Directory directory = await getApplicationDocumentsDirectory();
  //   String pathDB = join(directory.path, "GrifoDB.db");
  //   return openDatabase(
  //     pathDB,
  //     version: 1,
  //     onOpen: (db) {},
  //     onCreate: (Database db, int version) async {
  //       await db.transaction(
  //             (txn) async {
  //           txn.execute(
  //               "DROP TABLE IF EXISTS Clientes");
  //           txn.execute(
  //               "DROP TABLE IF EXISTS PedidosDelivery");
  //           txn.execute(
  //               "DROP TABLE IF EXISTS PedidosDeliveryDetalle");
  //           txn.execute(
  //               "DROP TABLE IF EXISTS PedidosDeliverySalida");
  //         },
  //       );
  //     },
  //   );
  // }
  // DROP TABLE IF EXISTS my_table

//---TESTE DELETE ----//
  deleteDatabase() async {
    // ///OLD DE¿LETE DATABASE
    Directory directory = await getApplicationDocumentsDirectory();
    String pathDB = join(directory.path, "TransmapDB.db");
    deleteDatabaseRoute(pathDB);
    return true;
  }

  Future<void> deleteDatabaseRoute(String path) =>
      databaseFactory.deleteDatabase(path);

  //---TESTE DELETE ----//

  //INTEGER, TEXT, REAL


  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String pathDB = join(directory.path, "TransmapDB.db");
    return openDatabase(
      pathDB,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.transaction(
              (txn) async {

                ///todo: TIPOS
            txn.execute(
                "CREATE TABLE Tipos(tipoId TEXT,idAccion TEXT, tipoDescripcionCorta TEXT,  idTipoGeneralFk TEXT,  idTipoGeneralFkDesc TEXT,  usuario TEXT,  tipoDescripcion TEXT, extraNumero TEXT, extraDescripcion TEXT, mensaje TEXT, resultado TEXT, tipoOffline TEXT)");

            ///todo: SUBPRODUCTOS
            txn.execute(
                // "CREATE TABLE SubProductos(tipoId TEXT,tipoDescripcion TEXT, tipoDescripcionCorta TEXT, tipoEstado TEXT, tiposGeneralFk TEXT)");
                "CREATE TABLE SubProductos(TipoId TEXT,TipoDescripcion TEXT, TipoDescripcionCorta TEXT, TipoEstado TEXT, TiposGeneralFk TEXT)");

            ///todo: SUBCLIENTES
            txn.execute(
                "CREATE TABLE SubClientes("
                    "clientesFk TEXT,"
                    "clientesFkDesc TEXT,"
                    "fechaCreacion TEXT,"
                    "scEstado TEXT,"
                    "scId TEXT,"
                    "subClientesFk TEXT,"
                    "subClientesFkDesc TEXT,"
                    "usuarioCreacion TEXT)");

            ///todo: CLIENTES UBIGEO
            txn.execute(
                "CREATE TABLE ClientesUbigeo("
                    "ClientesFk TEXT, "
                    "ClientesFkDesc TEXT, "
                    "ClubDireccionLlegada TEXT, "
                    "ClubDireccionPartida TEXT, "
                    "ClubEstado TEXT,"
                    "ClubFecCreacion TEXT,"
                    "ClubFecModificacion TEXT,"
                    "ClubId TEXT,"
                    "ClubUsrCreacion TEXT,"
                    "ClubUsrModificacion TEXT,"
                    "UbigeoLlegadaFk TEXT, "
                    "UbigeoLlegadaFkDesc TEXT,"
                    "UbigeoPartidaFk TEXT,"
                    "UbigeoPartidaFkDesc TEXT)");

            ///TODO: guias electronicas OFFLINE
                ///
            // txn.execute("CREATE TABLE GuiasElectronicas("
            //     "id INTEGER PRIMARY KEY AUTOINCREMENT ,"
            //     "GutrId TEXT,"
            //     "EmpresasFk TEXT,"
            //     "TipoGuiaFk TEXT,"
            //     "TipoGuiaFkDesc TEXT,"
            //     "UnidadMedidaFk TEXT,"
            //     "UnidadMedidaFkDesc TEXT,"
            //     "ClientesFk TEXT,"
            //     "ClientesFkDesc TEXT,"
            //     "TransportistasFk TEXT,"
            //     "TransportistasFkDesc TEXT,"
            //     "ClienteRemitenteFk TEXT,"
            //     "ClienteRemitenteFkDesc TEXT,"
            //     "ClienteDestinatarioFk TEXT,"
            //     "ClienteDestinatarioFkDesc TEXT,"
            //     "ProveedorFk TEXT,"
            //     "ProveedorFkDesc TEXT,"
            //     "CompradorFk TEXT,"
            //     "CompradorFkDesc TEXT,"
            //     "TipoServicioFk TEXT,"
            //     "TipoServicioFkDesc TEXT,"
            //     "TipoEstadoSituacionFk TEXT,"
            //     "TipoEstadoSituacionFkDesc TEXT,"
            //     "GutrPuntoLlegada TEXT,"
            //     "GutrPuntoLlegadaUbigeo TEXT,"
            //     "GutrPuntoPartida TEXT,"
            //     "GutrPuntoPartidaUbigeo TEXT,"
            //     "GutrGuiaRemision TEXT,"
            //     "GutrSerie TEXT,"
            //     "GutrNumero TEXT,"
            //     "GutrCorrelativo TEXT,"
            //     "GutrPesoTotal TEXT,"
            //     "GutrMontoTotal TEXT,"
            //     "GutrEstado TEXT,"
            //     "GutrObservaciones TEXT,"
            //     "GutrFechaEmision TEXT,"
            //     "GutrFechaTraslado TEXT,"
            //     "GuirFechaRegistro TEXT,"
            //     "GutrFecCreacion TEXT,"
            //     "GutrUsrCreacion TEXT,"
            //     "GutrFecModificacion TEXT,"
            //     "GutrUsrModificacion TEXT,"
            //     "GutrMotivoAnulacion TEXT,"
            //     "CodigoAnterior TEXT,"
            //     "EstadoSunatFk TEXT,"
            //     "EstadoSunatFkDesc TEXT,"
            //     "GutrTicketSunat TEXT,"
            //     "GutrUrlTicket TEXT,"
            //     "GutrCodigoValidacionSunat TEXT,"
            //     "GutrCodigoHash TEXT");


            txn.execute("CREATE TABLE GuiasElectronicas("
                "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                "GutrId TEXT,"
                "EmpresasFk TEXT,"
                "TipoGuiaFk TEXT,"
                "TipoGuiaFkDesc TEXT,"
                "UnidadMedidaFk TEXT,"
                "UnidadMedidaFkDesc TEXT,"
                "ClientesFk TEXT,"
                "ClientesFkDesc TEXT,"
                "TransportistasFk TEXT,"
                "TransportistasFkDesc TEXT,"
                "ClienteRemitenteFk TEXT,"
                "ClienteRemitenteFkDesc TEXT,"
                "ClienteDestinatarioFk TEXT,"
                "ClienteDestinatarioFkDesc TEXT,"
                "ProveedorFk TEXT,"
                "ProveedorFkDesc TEXT,"
                "CompradorFk TEXT,"
                "CompradorFkDesc TEXT,"
                "TipoServicioFk TEXT,"
                "TipoServicioFkDesc TEXT,"
                "TipoEstadoSituacionFk TEXT,"
                "TipoEstadoSituacionFkDesc TEXT,"
                "GutrPuntoLlegada TEXT,"
                "GutrPuntoLlegadaUbigeo TEXT,"
                "GutrPuntoPartida TEXT,"
                "GutrPuntoPartidaUbigeo TEXT,"
                "GutrGuiaRemision TEXT,"
                "GutrSerie TEXT,"
                "GutrNumero TEXT,"
                "GutrCorrelativo TEXT,"
                "GutrPesoTotal TEXT,"
                "GutrMontoTotal TEXT,"
                "GutrEstado TEXT,"
                "GutrObservaciones TEXT,"
                "GutrFechaEmision TEXT,"
                "GutrFechaTraslado TEXT,"
                "GuirFechaRegistro TEXT,"
                "GutrFecCreacion TEXT,"
                "GutrUsrCreacion TEXT,"
                "GutrFecModificacion TEXT,"
                "GutrUsrModificacion TEXT,"
                "GutrMotivoAnulacion TEXT,"
                "CodigoAnterior TEXT,"
                "EstadoSunatFk TEXT,"
                "EstadoSunatFkDesc TEXT,"
                "GutrTicketSunat TEXT,"
                "GutrUrlTicket TEXT,"
                "GutrCodigoValidacionSunat TEXT,"
                "GutrCodigoHash TEXT)"
                );


            txn.execute("CREATE TABLE GuiasElectronicasDetalle("
                "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                "GudeId TEXT,"
                "EmpresasFk TEXT,"
                "GuiaTransportistasElectronicaFk TEXT,"
                "ProductosFk TEXT,"
                "ProductosFkDesc TEXT,"
                "TipoProductoFk TEXT,"
                "TipoProductoFkDesc TEXT,"
                "TipoProductoUnidadMedidaFk TEXT,"
                "TipoProductoUnidadMedidaFkDesc TEXT,"
                "GudeItem TEXT,"
                "GudeProductoDescripcion TEXT,"
                "GudeCantidad TEXT,"
                "GudePrecioUnitario TEXT,"
                "GudePesoUnitario TEXT,"
                "GudeMontoTotal TEXT,"
                "GudePesoTotal TEXT,"
                "GudeFecCreacion TEXT,"
                "GudeUsrCreacion TEXT,"
                "GudeFecModificacion TEXT,"
                "GudeUsrModificacion TEXT,"
                "SubProductoFk TEXT)");

            txn.execute("CREATE TABLE GuiasElectronicasConductores("
                "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                "CoreId TEXT,"
                "ConductoresFk TEXT,"
                "ConductoresFkDesc TEXT,"
                "GuiaTransportistaElectronicaFk TEXT,"
                "CoreEstado TEXT,"
                "CoreFecCreacion TEXT,"
                "CoreUsrCreacion TEXT,"
                "CoreFecModificacion TEXT,"
                "CoreUsrModificacion TEXT)");
            txn.execute("CREATE TABLE GuiasElectronicasPlacas("
                "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                "PlreId TEXT,"
                "VehiculosFk TEXT,"
                "VehiculosFkDesc TEXT,"
                "PlacasFk TEXT,"
                "PlacasFkDesc TEXT,"
                "GuiaTransportistasElectronicaFk TEXT,"
                "PlreEstado TEXT,"
                "PlreFecCreacion TEXT,"
                "PlreUsrCreacion TEXT,"
                "PlreFecModificacion TEXT,"
                "PreUsrModificacion TEXT)");

            // txn.execute(
            //     "CREATE TABLE ProductosOffline("
            //         "gudeId TEXT,"
            //         "empresasFk TEXT,"
            //         "guiaTransportistasElectronicaFk TEXT,"
            //         "productosFk TEXT,"
            //         "productosFkDesc TEXT,"
            //         "tipoProductoFk TEXT,"
            //         "tipoProductoFkDesc TEXT,"
            //         "tipoProductoUnidadMedidaFk TEXT,"
            //         "tipoProductoUnidadMedidaFkDesc TEXT,"
            //         "gudeItem TEXT,"
            //         "gudeProductoDescripcion TEXT,"
            //         "gudeCantidad TEXT,"
            //         "gudePrecioUnitario TEXT,"
            //         "gudePesoUnitario TEXT,"
            //         "gudeMontoTotal TEXT,"
            //         "gudePesoTotal TEXT,"
            //         "gudeFecCreacion TEXT,"
            //         "gudeUsrCreacion TEXT,"
            //         "gudeFecModificacion TEXT,"
            //         "gudeUsrModificacion TEXT,"
            //         "subProductoFk TEXT,)");



            // txn.execute(
            //     "CREATE TABLE Clientes(cliId TEXT, credito TEXT,  descProducto10011 TEXT,  descProducto2 TEXT,  descProducto3 TEXT,  descProducto5 TEXT, entDocumento TEXT, entRazonSocial TEXT, idEntidad TEXT, mensaje TEXT, resultado TEXT)");
            // txn.execute(
            //     "CREATE TABLE Tipos(tipoId TEXT, tipoDescripcionCorta TEXT,  tipoDescripcion TEXT,  tipoEstado TEXT)");
            // txn.execute(
            //     "CREATE TABLE PedidosDelivery(idPedido TEXT, pedSerie TEXT, pedNumero TEXT, asignadoFk TEXT, asignadoFkDesc TEXT, destinoFk TEXT, destinoFkDesc TEXT, pedtotalGalones TEXT, pedGalonesEntregados TEXT, estadoPedidoFk TEXT, estadoPedidoFkDesc TEXT, usuarioFk TEXT, usuarioFkDesc TEXT, fechaCreacion TEXT , descripcion TEXT)");
            // txn.execute(
            //     "CREATE TABLE PedidosDeliveryDetalle(id INTEGER PRIMARY KEY AUTOINCREMENT, idDet TEXT, idCab TEXT, cabSerie TEXT, cabNumero TEXT, clienteFk TEXT, clienteFkDesc TEXT, productoFk TEXT, productoFkDesc TEXT, cantidad TEXT, cantidadEntregada TEXT, precioFinal TEXT, precioTotal TEXT, estadoPagoFk TEXT, estadoPagoFkDesc TEXT, estadoEntregaFk TEXT, entregaPlus TEXT, historialPlus TEXT, estadoEntregaFkDesc TEXT, usuario TEXT, fechaCreacion TEXT, isOffline TEXT)");
            // txn.execute(
            //     "CREATE TABLE PedidosDeliverySalida(pedcId TEXT, pedidosDeliveryFk TEXT, pedcDocumento TEXT, productoFk TEXT, productoFkDesc TEXT, pedcCantidad TEXT, pedcPrecio TEXT, pedcEstado TEXT, usuarioCreacion TEXT, fechaCreacion TEXT)");
            // txn.execute(
            //     "CREATE TABLE PedidosDeliveryPagos(id INTEGER PRIMARY KEY AUTOINCREMENT, idCab TEXT, idDet TEXT, idPag TEXT,idOffDet TEXT, medioPagoFk TEXT, medioPagoFkDesc TEXT, pedpDescripcion TEXT, pedpEstadoCaja TEXT, pedpEstadoDesc TEXT, pedpFechaRegistro TEXT, pedpImporte TEXT, pedpItem TEXT, clienteFk TEXT, clienteFkDesc TEXT, usuario TEXT, totalVenta TEXT, usuarioDesc TEXT, productoFk TEXT, productoFkDesc TEXT, isOffline TEXT, codigoCobranza TEXT, impresiones TEXT)");
          },
        );
      },
    );
  }

  //----------------------------------------//
  //----------------GET DATA----------------//
  //----------------------------------------//
  // List<GuiasElectronicasModel> _guiasModel = [];
  // List<GuiasElectronicasDetalleModel> _guiasDetalleModel = [];
  // List<GuiasElectronicasConductoresModel> _guiasConductoresModel = [];
  // List<GuiasElectronicasPlacasModel> _guiasPlacasModel = [];

  List<TiposModel> _modelTipos = [];
  List<SubProductosModel> _modelSubProductos = [];
  List<SubClientesModel> _modelSubClientes = [];
  List<ClientesUbigeoModel> _modelClientesUbigeo = [];



  var _offlineServices = new OfflineServices();


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

  Future<String> getdata(String fecIni, String fecEnd) async {
    try {
      eliminarContenidosDBOffline(); //PROBAR LA ELIMINACION XD
      _modelTipos = await _offlineServices.GuiasElectronicas_ObtenerConductores();
       insertarTipos(_modelTipos); //CONDUCTORES
      _modelTipos = await _offlineServices.GuiasElectronicas_ObtenerClientes();
      insertarTipos(_modelTipos); //CLIENTES
       _modelTipos = await _offlineServices.GuiasElectronicas_ObtenerPlacasAll();
      insertarTipos(_modelTipos); //PLACAS
      _modelTipos = await _offlineServices.Old_cargarTipoSituacion();
      insertarTipos(_modelTipos); //TIPOS TIPOS
      _modelTipos = await _offlineServices.Old_cargarTipoProducto();
      insertarTipos(_modelTipos); //PRODUCTOS
      _modelTipos = await _offlineServices.GuiasElectronicas_ObtenerTipoTipos();
      insertarTipos(_modelTipos); //SITUACION
      _modelTipos = await _offlineServices.GuiasElectronicas_ObtenerTipoUnidadMedida();
      insertarTipos(_modelTipos); //TIPO UNIDAD MEDIDA


      _modelSubProductos = await _offlineServices.Offline_GuiasElectronicas_ObtenerSubProductos();
      insertarSubProductos(_modelSubProductos);
      _modelSubClientes = await _offlineServices.Offline_GuiasElectronicas_ObtenerSubClientes();
      insertarSubClientes(_modelSubClientes);
      _modelClientesUbigeo = await _offlineServices.Offline_GuiasElectronicas_ObtenerDireccionesxCliente();
      insertarClientesUbigeo(_modelClientesUbigeo);


      print("END");

      return "1";
    } catch (e) {
      return "0";
    }
  }


  ///TOdo: LISTAR DESDE DATABASE- TRABAJA COMO SERVICE


    Future<List<TiposModel>> getDBTipos(String Tipo) async {
    final Database db = await getDatabase();
    List res = await db
         .rawQuery("Select DISTINCT * from Tipos where tipoOffline = '${Tipo}'");

    List<TiposModel> dataOffline =
    res.map((e) => TiposModel.fromJson(e)).toList();
    return dataOffline;
  }

  Future<List<ClientesUbigeoModel>> getDB_ObtenerDireccionesxCliente(
      String id) async {
    final Database db = await getDatabase();
    //print("Recibido IdCliente: " + idCli);
    List res = await db
        .rawQuery("Select DISTINCT * from ClientesUbigeo where clientesFk = '${id}'");

    if(res.length==0){
      res = await db
          .rawQuery("Select DISTINCT * from ClientesUbigeo where clientesFk = '0'");
    }
    List<ClientesUbigeoModel> dataOffline =
    res.map((e) => ClientesUbigeoModel.fromJson(e)).toList();
    print("Cantidad de ClientesUbigeo: " + dataOffline.length.toString());
    return dataOffline;
  }
  Future<List<SubClientesModel>> getDB_ObtenerSubClientes(
      String id) async {
    final Database db = await getDatabase();
    //print("Recibido IdCliente: " + idCli);
    List res = await db
        .rawQuery("Select DISTINCT * from SubClientes where clientesFk = '${id}'");

    if(res.length==0){
      res = await db
          .rawQuery("Select DISTINCT * from SubClientes where clientesFk = '0'");
    }
    List<SubClientesModel> dataOffline =
    res.map((e) => SubClientesModel.fromJson(e)).toList();
    return dataOffline;
  }

  Future<List<SubProductosModel>> getDB_ObtenerSubProductos(
      String id) async {
    final Database db = await getDatabase();
    //print("Recibido IdCliente: " + idCli);
    List res = await db
        .rawQuery("Select DISTINCT * from SubProductos where tiposGeneralFk = '${id}'");

    if(res.length==0){
      res = await db
          .rawQuery("Select DISTINCT * from SubProductos where tiposGeneralFk = '0'");
    }
    List<SubProductosModel> dataOffline =
    res.map((e) => SubProductosModel.fromJson(e)).toList();
    String jsonList = jsonEncode(dataOffline);
    print(jsonList);
   // print(dataOffline);
    print("Cantidad de Sub Productos: " + dataOffline.length.toString());

    return dataOffline;
  }
  /// /////////////////////////////////////////////////////////////////
  /// ///////////////////todo: sabe ///////////////////////////////////
  /// /////////////////////////////////////////////////////////////////

  Future<String> grabarDB_GuiaElectronica(List<GuiasElectronicasModel> _model, List<GuiasElectronicasDetalleModel> _modelDetalle, List<GuiasElectronicasConductoresModel> _modelConductores,List<GuiasElectronicasPlacasModel> _modelPlacas) async {
    try{
      final Database db = await getDatabase();
      db.transaction((txn) async {
        int IdGuiaLocal = 0;
        for (var element in _model) {
          element.estadoSunatFk = "53";
          IdGuiaLocal =
          await txn.insert("GuiasElectronicas", element.toJson()).catchError((
              error) => print("ERRORES GE NO CONTROLADOS"));
          print('El último ID insertado en GuiasElectronicas es: $IdGuiaLocal');

          _modelDetalle.forEach((element) async {
            element.guiaTransportistasElectronicaFk = IdGuiaLocal.toString();
            await txn.insert("GuiasElectronicasDetalle", element.toJson())
                .catchError((error) => print("ERRORES GED NO CONTROLADOS"));
          });
          _modelConductores.forEach((element) async {
            element.guiaTransportistaElectronicaFk = IdGuiaLocal.toString();
            await txn.insert("GuiasElectronicasConductores", element.toJson())
                .catchError((error) => print("ERRORES GEC NO CONTROLADOS"));
          });
          String idVehiculo = ""; //new
          _modelPlacas.forEach((element) async {
            if (element.vehiculosFk != null && element.vehiculosFk != "null" &&
                element.plreEstado == "1") {
              idVehiculo = element.vehiculosFk!;
            }


            element.guiaTransportistasElectronicaFk = IdGuiaLocal.toString();

            await txn.insert("GuiasElectronicasPlacas", element.toJson())
                .catchError((error) => print("ERRORES GEP NO CONTROLADOS"));
          });


          db.transaction((txn) async {
            txn.execute("UPDATE Tipos SET extraNumero = extraNumero + 1 WHERE tipoId = '${idVehiculo}' AND tipoOffline = 'vehiculos'");
          }).whenComplete(() {
            print("Correlativo + 1");
          });

          // List<Map> result = await db.rawQuery(
          //     "SELECT extraNumero FROM Tipos WHERE tipoId = '$idVehiculo'");
          // if (result.isNotEmpty) {
          //   int currentExtraNumero = int.parse(result.first['extraNumero']);
          //   // Incrementa extraNumero en 1
          //   int newExtraNumero = currentExtraNumero + 1;
          //   // Actualiza el valor en la base de datos
          //   await db.rawUpdate(
          //     "UPDATE Tipos SET extraNumero = '${newExtraNumero}' WHERE tipoId = '${idVehiculo}' AND tipoOffline = 'vehiculos'",
          //   );
          // }



        }


      }).whenComplete(() {
        print("Insertados: " + _model.length.toString() + " Guias Electronicas");
        print("Insertados: " + _modelDetalle.length.toString() + " Guias Electronicas Detalle");
        print("Insertados: " + _modelConductores.length.toString() + " Guias Electronicas Conductures");
        print("Insertados: " + _modelPlacas.length.toString() + " Guias Electronicas Placas");
      });
      return "1";
    }catch(e){
      return "0";
    }
  }
  Future<String> actionDB_GuiasElectronicas_AumentarCorrelativoVehiculos(String idPago) async {
    try {
      final Database db = await getDatabase();
      db.transaction((txn) async {
        txn.execute("UPDATE PedidosDeliveryPagos SET impresiones = impresiones + 1 WHERE id= '${idPago}'");
      }).whenComplete(() {
        print("Impresion + 1");
      });
      return "1";
    } catch (e) {
      return "0";
    }
  }




  /// /////////////////////////////////////////////////////////////////
  /// ///////////////////todo: CONSULTADORES //////////////////////////
  /// /////////////////////////////////////////////////////////////////

  Future<List<GuiasElectronicasModel>>
  getDB_OfflineListaGuiasElectronicas() async {
    final Database db = await getDatabase();
    print("Listando todos las Guias electronicas Offline");
    // List res = await db.rawQuery("Select * from PedidosDeliveryDetalle");
    List res = await db
        .rawQuery("Select * from GuiasElectronicas order by id DESC");
    List<GuiasElectronicasModel> informeOffline =
    res.map((e) => GuiasElectronicasModel.fromJson(e)).toList();
    return informeOffline;
  }

  /// todo: PARA IMPRESIONES CONSULTAS
  Future<List<GuiasElectronicasModel>>
  getDBOffline_ImpresionGuiaElectronicaxId(String id) async {
    final Database db = await getDatabase();
    var res = [];
    print("Lega a consultar Offline:" + id);
    res = await db.rawQuery(
        "SELECT * FROM GuiasElectronicas WHERE id = '${id}'");
    List<GuiasElectronicasModel> informeOffline =
    res.map((e) => GuiasElectronicasModel.fromJson(e)).toList();
    return informeOffline;
  }
  Future<List<GuiasElectronicasDetalleModel>> getDBOffline_ImpresionGuiaElectronicaDetallexId(String id) async {
    final Database db = await getDatabase();
    var res = [];
    res = await db.rawQuery(
        "SELECT * FROM GuiasElectronicasDetalle WHERE GuiaTransportistasElectronicaFk = '${id}'");
        List<GuiasElectronicasDetalleModel> informeOffline =
    res.map((e) => GuiasElectronicasDetalleModel.fromJson(e)).toList();
    return informeOffline;
  }
  Future<List<GuiasElectronicasConductoresModel>>getDBOffline_ImpresionGuiaElectronicaConductoresxId(String id) async {
    final Database db = await getDatabase();
    var res = [];
    res = await db.rawQuery(
        "SELECT * FROM GuiasElectronicasConductores WHERE GuiaTransportistaElectronicaFk = '${id}'");
    List<GuiasElectronicasConductoresModel> informeOffline =
    res.map((e) => GuiasElectronicasConductoresModel.fromJson(e)).toList();
    return informeOffline;
  }
  Future<List<GuiasElectronicasPlacasModel>> getDBOffline_ImpresionGuiaElectronicaPlacasxId(String id) async {
    final Database db = await getDatabase();
    var res = [];
    res = await db.rawQuery(
        "SELECT * FROM GuiasElectronicasPlacas WHERE GuiaTransportistasElectronicaFk = '${id}'");
    List<GuiasElectronicasPlacasModel> informeOffline =
    res.map((e) => GuiasElectronicasPlacasModel.fromJson(e)).toList();
    return informeOffline;
  }


  Future<String> getCampoPorId(String id,String tipoOffline ,String campo) async {
    final Database db = await getDatabase();

    var res = await db.rawQuery(
        "SELECT ${campo} FROM Tipos WHERE tipoId = '${id}'and tipoOffline = '${tipoOffline}'");
    if (res.isNotEmpty) {
      return res.first[campo].toString();
    } else {
      return "-";
    }
  }





  //OTRAS CONSULTAS GENERALES DELETE//

  eliminarContenidosDBOffline() async {
    final Database db = await getDatabase();
    db.transaction((txn) async {
      txn.execute("DELETE FROM Tipos");
      txn.execute("DELETE FROM SubProductos");
      txn.execute("DELETE FROM SubClientes");
      txn.execute("DELETE FROM ClientesUbigeo");
      txn.execute("DELETE FROM GuiasElectronicas");
      txn.execute("DELETE FROM GuiasElectronicasDetalle");
      txn.execute("DELETE FROM GuiasElectronicasConductores");
      txn.execute("DELETE FROM GuiasElectronicasPlacas");
    }).whenComplete(() {
      print("- ELIMIUADNOS PAPU--");
    });
  }

//-----------------------------------------------------------------------------
//-----------------------------INSERCIONES------------------------------------
//-----------------------------------------------------------------------------

  // insertarCliente(List<OfflineClientesRelaveModel> clientesModel) async {
  //   final Database db = await getDatabase();
  //   db.transaction((txn) async {
  //     clientesModel.forEach((element) async {
  //       await db.insert("Clientes", element.toJson());
  //     });
  //   }).whenComplete(() {
  //     print("Insertados: " + clientesModel.length.toString() + " Clientes");
  //   });
  // }
  //

  insertarTipos(List<TiposModel> _model) async {
    try {
      final Database db = await getDatabase();
      db.transaction((txn) async {
        _model.forEach((element) async {
          await db.insert("Tipos", element.toJson());
        });
      }).whenComplete(() {
        print("Insertados: " + _model.length.toString() + " Tipos");
      });
    } catch (e) {
      print('Se produjo un error: $e');
    } finally {
      //print('El bloque try-catch ha terminado.');
    }
  }

  insertarSubProductos(List<SubProductosModel> _model) async {
    try {
      final Database db = await getDatabase();
      db.transaction((txn) async {
        _model.forEach((element) async {
          await db.insert("SubProductos", element.toJson());
        });
      }).whenComplete(() {
        print("Insertados: " + _model.length.toString() + " SubProductos");
      });
    } catch (e) {
      print('Se produjo un error: $e');
    } finally {
     // print('El bloque try-catch ha terminado.');
    }
  }

  insertarSubClientes(List<SubClientesModel> _model) async {
    try {
      final Database db = await getDatabase();
      db.transaction((txn) async {
        _model.forEach((element) async {
          await db.insert("SubClientes", element.toJson());
        });
      }).whenComplete(() {
        print("Insertados: " + _model.length.toString() + " Sub Clientes");
      });
    } catch (e) {
      print('Se produjo un error: $e');
    } finally {
      //print('El bloque try-catch ha terminado.');
    }
  }

  insertarClientesUbigeo(List<ClientesUbigeoModel> _model) async {
    try {
      final Database db = await getDatabase();
      db.transaction((txn) async {
        _model.forEach((element) async {
          await db.insert("ClientesUbigeo", element.toJson());
        });
      }).whenComplete(() {
        print("Insertados: " + _model.length.toString() + " Clientes Ubigeo");
      });
    } catch (e) {
      print('Se produjo un error: $e');
    } finally {
      //print('El bloque try-catch ha terminado.');
    }
  }


  /// //////////////////////////////////////////////////////
  /// ///////////// todo: SUBIDA AL SERVIDOR ///////////////
  /// //////////////////////////////////////////////////////
  Future<List<GuiasElectronicasModel>> upload_DBOffline_GuiasElectronicas() async {
    final Database db = await getDatabase();
    var res = [];
    res = await db
        .rawQuery("Select * from GuiasElectronicas");
    List<GuiasElectronicasModel> informeOffline =
    res.map((e) => GuiasElectronicasModel.fromJson(e)).toList();
    var json = jsonEncode(informeOffline.map((e) => e.toJson()).toList());
   // print(json);
   // String s = guiaModel.toJson().toString();
    print("//////////////////////// GUIAS INI /////////////////////////");
    debugPrint(" =======> " + json, wrapWidth: 1024);
    print("//////////////////////// GUIAS END /////////////////////////");
    return informeOffline;
  }
  Future<List<GuiasElectronicasDetalleModel>> upload_DBOffline_GuiasElectronicasDetalle() async {
    final Database db = await getDatabase();
    var res = [];
    res = await db
        .rawQuery("Select * from GuiasElectronicasDetalle");
    List<GuiasElectronicasDetalleModel> informeOffline =
    res.map((e) => GuiasElectronicasDetalleModel.fromJson(e)).toList();
    var json = jsonEncode(informeOffline.map((e) => e.toJson()).toList());
    print("//////////////////////// GUIAS DETALLE INI /////////////////////////");
    debugPrint(" =======> " + json, wrapWidth: 1024);
    print("//////////////////////// GUIAS DETALLE END /////////////////////////");
    return informeOffline;
  }
  Future<List<GuiasElectronicasConductoresModel>> upload_DBOffline_GuiasElectronicasConductores() async {
    final Database db = await getDatabase();
    var res = [];
    res = await db
        .rawQuery("Select * from GuiasElectronicasConductores");
    List<GuiasElectronicasConductoresModel> informeOffline =
    res.map((e) => GuiasElectronicasConductoresModel.fromJson(e)).toList();
    var json = jsonEncode(informeOffline.map((e) => e.toJson()).toList());
    print("//////////////////////// GUIAS CONDUCTIRES INI /////////////////////////");
    debugPrint(" =======> " + json, wrapWidth: 1024);
    print("//////////////////////// GUIAS CONDUCTORES END /////////////////////////");
    return informeOffline;
  }
  Future<List<GuiasElectronicasPlacasModel>> upload_DBOffline_GuiasElectronicasPlacas() async {
    final Database db = await getDatabase();
    var res = [];
    res = await db
        .rawQuery("Select * from GuiasElectronicasPlacas");
    List<GuiasElectronicasPlacasModel> informeOffline =
    res.map((e) => GuiasElectronicasPlacasModel.fromJson(e)).toList();
    var json = jsonEncode(informeOffline.map((e) => e.toJson()).toList());
    print("//////////////////////// GUIAS PLACAS INI /////////////////////////");
    debugPrint(" =======> " + json, wrapWidth: 1024);
    print("//////////////////////// GUIAS PLACAS END /////////////////////////");
    return informeOffline;
  }



}
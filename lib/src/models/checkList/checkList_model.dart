



import 'dart:convert';


class CheckListModel {
  String? chId;
  String? chUsuario;
  String? estado;
  String? fechaCreacion;
  String? placaFk;
  String? placaFkDesc;
  String? usuarioCreacion;
  String? vehiculoFk;
  String? vehiculoFkDesc;
  String? tipoCheckList;
  List<CheckListDetalleModel>? detalle;

  CheckListModel({
    this.chId,
    this.chUsuario,
    this.estado,
    this.fechaCreacion,
    this.placaFk,
    this.placaFkDesc,
    this.usuarioCreacion,
    this.vehiculoFk,
    this.vehiculoFkDesc,
    this.tipoCheckList,
    this.detalle,
  });

  factory CheckListModel.fromJson(Map<String, dynamic> json) => CheckListModel(
    chId: json["ChId"],
    chUsuario: json["ChUsuario"],
    estado: json["Estado"],
    fechaCreacion: json["FechaCreacion"],
    placaFk: json["PlacaFk"],
    placaFkDesc: json["PlacaFkDesc"],
    usuarioCreacion: json["UsuarioCreacion"],
    vehiculoFk: json["VehiculoFk"],
    vehiculoFkDesc: json["VehiculoFkDesc"],
    tipoCheckList: json["TipoCheckList"],
    detalle: List<CheckListDetalleModel>.from(json["Detalle"]?.map((x) => CheckListDetalleModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ChId": chId,
    "ChUsuario": chUsuario,
    "Estado": estado,
    "FechaCreacion": fechaCreacion,
    "PlacaFk": placaFk,
    "PlacaFkDesc": placaFkDesc,
    "UsuarioCreacion": usuarioCreacion,
    "VehiculoFk": vehiculoFk,
    "VehiculoFkDesc": vehiculoFkDesc,
    "TipoCheckList": tipoCheckList,
    // "Detalle": List<dynamic>.from(detalle!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    "Detalle": detalle != null ? List<dynamic>.from(detalle!.map((x) => x.toJson())): null,
  };
}






class CheckListDetalleModel {
  String? cdId;
  String? cdObservacion;
  String? fechaCreacion;
  String? placaFk;
  String? placaFkDesc;
  String? tipoCategoriaFk;
  String? tipoCategoriaFkDesc;
  String? tipoOpcionFk;
  String? tipoOpcionFkDesc;
  String? subTiposDetalle;
  String? usuarioCreacion;
  String? vehiculoFk;
  String? vehiculoFkDesc;
  String? vehiculosChekListFk;

  CheckListDetalleModel({
    this.cdId,
    this.cdObservacion,
    this.fechaCreacion,
    this.placaFk,
    this.placaFkDesc,
    this.tipoCategoriaFk,
    this.tipoCategoriaFkDesc,
    this.tipoOpcionFk,
    this.tipoOpcionFkDesc,
    this.subTiposDetalle,
    this.usuarioCreacion,
    this.vehiculoFk,
    this.vehiculoFkDesc,
    this.vehiculosChekListFk,
  });

  factory CheckListDetalleModel.fromJson(Map<String, dynamic> json) => CheckListDetalleModel(
    cdId: json["CdId"],
    cdObservacion: json["CdObservacion"],
    fechaCreacion: json["FechaCreacion"],
    placaFk: json["PlacaFk"],
    placaFkDesc: json["PlacaFkDesc"],
    tipoCategoriaFk: json["TipoCategoriaFk"],
    tipoCategoriaFkDesc: json["TipoCategoriaFkDesc"],
    tipoOpcionFk: json["TipoOpcionFk"],
    tipoOpcionFkDesc: json["TipoOpcionFkDesc"],
    subTiposDetalle: json["SubTiposDetalle"],
    usuarioCreacion: json["UsuarioCreacion"],
    vehiculoFk: json["VehiculoFk"],
    vehiculoFkDesc: json["VehiculoFkDesc"],
    vehiculosChekListFk: json["VehiculosChekListFk"],
  );

  Map<String, dynamic> toJson() => {
    "CdId": cdId,
    "CdObservacion": cdObservacion,
    "FechaCreacion": fechaCreacion,
    "PlacaFk": placaFk,
    "PlacaFkDesc": placaFkDesc,
    "TipoCategoriaFk": tipoCategoriaFk,
    "TipoCategoriaFkDesc": tipoCategoriaFkDesc,
    "TipoOpcionFk": tipoOpcionFk,
    "TipoOpcionFkDesc": tipoOpcionFkDesc,
    "SubTiposDetalle": subTiposDetalle,
    "UsuarioCreacion": usuarioCreacion,
    "VehiculoFk": vehiculoFk,
    "VehiculoFkDesc": vehiculoFkDesc,
    "VehiculosChekListFk": vehiculosChekListFk,
  };
}





class ImpresionCheckListModel {
  String? chId;
  String? chUsuario;
  String? estado;
  String? fechaCreacion;
  String? placaFk;
  String? placaFkDesc;
  String? tipoCheckList;
  String? usuarioCreacion;
  String? usuarioCreacionDesc;
  String? vehiculoFk;
  String? vehiculoFkDesc;
  List<Detalle>? detalle;

  ImpresionCheckListModel({
    this.chId,
    this.chUsuario,
    this.detalle,
    this.estado,
    this.fechaCreacion,
    this.placaFk,
    this.placaFkDesc,
    this.tipoCheckList,
    this.usuarioCreacion,
    this.usuarioCreacionDesc,
    this.vehiculoFk,
    this.vehiculoFkDesc,
  });

  factory ImpresionCheckListModel.fromJson(Map<String, dynamic> json) => ImpresionCheckListModel(
    chId: json["ChId"],
    chUsuario: json["ChUsuario"],
    detalle: List<Detalle>.from(json["Detalle"]?.map((x) => Detalle.fromJson(x))),
    estado: json["Estado"],
    fechaCreacion: json["FechaCreacion"],
    placaFk: json["PlacaFk"],
    placaFkDesc: json["PlacaFkDesc"],
    tipoCheckList: json["TipoCheckList"],
    usuarioCreacion: json["UsuarioCreacion"],
    usuarioCreacionDesc: json["UsuarioCreacionDesc"],
    vehiculoFk: json["VehiculoFk"],
    vehiculoFkDesc: json["VehiculoFkDesc"],
  );

  Map<String, dynamic> toJson() => {
    "ChId": chId,
    "ChUsuario": chUsuario,
    "Detalle": List<dynamic>.from(detalle!.map((x) => x.toJson())),
    "Estado": estado,
    "FechaCreacion": fechaCreacion,
    "PlacaFk": placaFk,
     "PlacaFkDesc": placaFkDesc,
    "TipoCheckList": tipoCheckList,
    "UsuarioCreacion": usuarioCreacion,
    "UsuarioCreacionDesc": usuarioCreacionDesc,
    "VehiculoFk": vehiculoFk,
    "VehiculoFkDesc": vehiculoFkDesc,
  };
}

class Detalle {
  String? cdId;
  String? cdObservacion;
  String? fechaCreacion;
  String? placaFk;
  // String? placaFkDesc;
  String? subTiposDetalle;
  String? tipoCategoriaFk;
  String? tipoCategoriaFkDesc;
  String? tipoOpcionFk;
  String? tipoOpcionFkDesc;
  String? usuarioCreacion;
  String? vehiculoFk;
  String? vehiculosChekListFk;

  Detalle({
    this.cdId,
    this.cdObservacion,
    this.fechaCreacion,
    this.placaFk,
    //this.placaFkDesc,
    this.subTiposDetalle,
    this.tipoCategoriaFk,
    this.tipoCategoriaFkDesc,
    this.tipoOpcionFk,
    this.tipoOpcionFkDesc,
    this.usuarioCreacion,
    this.vehiculoFk,
    this.vehiculosChekListFk,
  });

  factory Detalle.fromJson(Map<String, dynamic> json) => Detalle(
    cdId: json["CdId"],
    cdObservacion: json["CdObservacion"],
    fechaCreacion: json["FechaCreacion"],
    placaFk: json["PlacaFk"],
    // placaFkDesc: json["PlacaFkDesc"],
    subTiposDetalle: json["SubTiposDetalle"],
    tipoCategoriaFk: json["TipoCategoriaFk"],
    tipoCategoriaFkDesc: json["TipoCategoriaFkDesc"],
    tipoOpcionFk: json["TipoOpcionFk"],
    tipoOpcionFkDesc: json["TipoOpcionFkDesc"],
    usuarioCreacion: json["UsuarioCreacion"],
    vehiculoFk: json["VehiculoFk"],
    vehiculosChekListFk: json["VehiculosChekListFk"],
  );

  Map<String, dynamic> toJson() => {
    "CdId": cdId,
    "CdObservacion": cdObservacion,
    "FechaCreacion": fechaCreacion,
    "PlacaFk": placaFk,
    // "PlacaFkDesc": placaFkDesc,
    "SubTiposDetalle": subTiposDetalle,
    "TipoCategoriaFk": tipoCategoriaFk,
    "TipoCategoriaFkDesc": tipoCategoriaFkDesc,
    "TipoOpcionFk": tipoOpcionFk,
    "TipoOpcionFkDesc": tipoOpcionFkDesc,
    "UsuarioCreacion": usuarioCreacion,
    "VehiculoFk": vehiculoFk,
    "VehiculosChekListFk": vehiculosChekListFk,
  };
}




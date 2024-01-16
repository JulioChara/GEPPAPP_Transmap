



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
    "UsuarioCreacion": usuarioCreacion,
    "VehiculoFk": vehiculoFk,
    "VehiculoFkDesc": vehiculoFkDesc,
    "VehiculosChekListFk": vehiculosChekListFk,
  };
}



// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';


class LoginModel {
  String? id;
  String? mensaje;
  String? placaFk;
  String? placaFkDesc;
  String? placaRefFk;
  String? placaRefFkDesc;
  String? resultado;
  String? rol;
  String? rolName;
  String? rolid;
  String? usEntidad;
  String? usNombre;

  LoginModel({
    this.id,
    this.mensaje,
    this.placaFk,
    this.placaFkDesc,
    this.placaRefFk,
    this.placaRefFkDesc,
    this.resultado,
    this.rol,
    this.rolName,
    this.rolid,
    this.usEntidad,
    this.usNombre,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    id: json["id"],
    mensaje: json["mensaje"],
    placaFk: json["placaFk"],
    placaFkDesc: json["placaFkDesc"],
    placaRefFk: json["placaRefFk"],
    placaRefFkDesc: json["placaRefFkDesc"],
    resultado: json["resultado"],
    rol: json["rol"],
    rolName: json["rolName"],
    rolid: json["rolid"],
    usEntidad: json["usEntidad"],
    usNombre: json["usNombre"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mensaje": mensaje,
    "placaFk": placaFk,
    "placaFkDesc": placaFkDesc,
    "placaRefFk": placaRefFk,
    "placaRefFkDesc": placaRefFkDesc,
    "resultado": resultado,
    "rol": rol,
    "rolName": rolName,
    "rolid": rolid,
    "usEntidad": usEntidad,
    "usNombre": usNombre,
  };
}





class LoginTiposModel {
  String? tipoDescripcion;
  String? tipoDescripcionCorta;
  String? tipoEstado;
  String? tipoId;
  String? tiposGeneralFk;
  String? mensaje;
  String? resultado;

  LoginTiposModel({
    this.tipoDescripcion,
    this.tipoDescripcionCorta,
    this.tipoEstado,
    this.tipoId,
    this.tiposGeneralFk,
    this.mensaje,
    this.resultado,
  });

  factory LoginTiposModel.fromJson(Map<String, dynamic> json) => LoginTiposModel(
    tipoDescripcion: json["TipoDescripcion"],
    tipoDescripcionCorta: json["TipoDescripcionCorta"],
    tipoEstado: json["TipoEstado"],
    tipoId: json["TipoId"],
    tiposGeneralFk: json["TiposGeneralFk"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
  );

  Map<String, dynamic> toJson() => {
    "TipoDescripcion": tipoDescripcion,
    "TipoDescripcionCorta": tipoDescripcionCorta,
    "TipoEstado": tipoEstado,
    "TipoId": tipoId,
    "TiposGeneralFk": tiposGeneralFk,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}

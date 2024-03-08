


class AlertasListadoModel {
  AlertasListadoModel({
    this.documento,
    this.fechaCaducidad,
    this.kmActual,
    this.kmCaducidad,
    this.alertaKM,
    this.kmMantenimiento,
    this.documentoGeneral,
    this.tipoDocumentoFk,
    this.tipoDocumentoFkDesc,
    this.vehiId,
    this.idTab,
    this.estadoAlerta,
    this.mensaje,
    this.resultado,
  });

  String? documento;
  String? fechaCaducidad;
  String? kmActual;
  String? kmCaducidad;
  String? kmMantenimiento;
  String? alertaKM;
  String? documentoGeneral;
  String? tipoDocumentoFk;
  String? tipoDocumentoFkDesc;
  String? vehiId;
  String? idTab;
  String? estadoAlerta;
  String? mensaje;
  String? resultado;

  factory AlertasListadoModel.fromJson(Map<String, dynamic> json) => AlertasListadoModel(
    documento: json["Documento"],
    fechaCaducidad: json["FechaCaducidad"],
    kmActual: json["KmActual"],
    kmCaducidad: json["KmCaducidad"],
    kmMantenimiento: json["KmMantenimiento"],
    alertaKM: json["alertaKM"],
    documentoGeneral: json["DocumentoGeneral"],
    tipoDocumentoFk: json["TipoDocumentoFk"],
    tipoDocumentoFkDesc: json["TipoDocumentoFkDesc"],
    vehiId: json["VehiId"],
    idTab: json["IdTab"],
    estadoAlerta: json["estadoAlerta"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
  );

  Map<String, dynamic> toJson() => {
    "Documento": documento,
    "FechaCaducidad": fechaCaducidad,
    "KmActual": kmActual,
    "KmCaducidad": kmCaducidad,
    "KmMantenimiento": kmMantenimiento,
    "alertaKM": alertaKM,
    "DocumentoGeneral": documentoGeneral,
    "TipoDocumentoFk": tipoDocumentoFk,
    "TipoDocumentoFkDesc": tipoDocumentoFkDesc,
    "VehiId": vehiId,
    "IdTab": idTab,
    "estadoAlerta": estadoAlerta,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}



class TiposModel {
  TiposModel({
    this.idAccion,
    this.tipoDescripcionCorta,
    this.idTipoGeneralFk,
    this.idTipoGeneralFkDesc,
    this.usuario,
    this.tipoDescripcion,
    this.tipoId,
    this.extraNumero,
    this.extraDescripcion,
    this.mensaje,
    this.resultado,
    this.tipoOffline,
  });
  String? idAccion;
  String? tipoDescripcionCorta;
  String? idTipoGeneralFk;
  String? idTipoGeneralFkDesc;
  String? usuario;
  String? tipoDescripcion;
  String? tipoId;
  String? extraNumero;
  String? extraDescripcion;
  String? mensaje;
  String? resultado;
  String? tipoOffline;

  factory TiposModel.fromJson(Map<String, dynamic> json) => TiposModel(
    idAccion: json["idAccion"],
    tipoDescripcionCorta: json["tipoDescripcionCorta"],
    idTipoGeneralFk: json["idTipoGeneralFk"],
    idTipoGeneralFkDesc: json["idTipoGeneralFkDesc"],
    usuario: json["usuario"],
    tipoDescripcion: json["tipoDescripcion"],
    tipoId: json["tipoId"],
    extraNumero: json["extraNumero"],
    extraDescripcion: json["extraDescripcion"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
    tipoOffline: json["tipoOffline"],
  );

  Map<String, dynamic> toJson() => {
    "idAccion": idAccion,
    "tipoDescripcionCorta": tipoDescripcionCorta,
    "idTipoGeneralFk": idTipoGeneralFk,
    "idTipoGeneralFkDesc": idTipoGeneralFkDesc,
    "usuario": usuario,
    "tipoDescripcion": tipoDescripcion,
    "tipoId": tipoId,
    "extraNumero": extraNumero,
    "extraDescripcion": extraDescripcion,
    "mensaje": mensaje,
    "resultado": resultado,
    "tipoOffline": tipoOffline,
  };
}



//PARA SALVAR EN DOCUMENTOS


class AlertasDocumentosModel {
  AlertasDocumentosModel({
    this.idAccion,
    this.vehiculoFk,
    this.tipoDocFk,
    this.documemtoRef,
    this.fechaEmision,
    this.fechaCaducidad,
    this.usuario,
    this.idC,
  });

  String? idAccion;
  String? vehiculoFk;
  String? tipoDocFk;
  String? documemtoRef;
  String? fechaEmision;
  String? fechaCaducidad;
  String? usuario;
  String? idC;

  factory AlertasDocumentosModel.fromJson(Map<String, dynamic> json) => AlertasDocumentosModel(
    idAccion: json["IdAccion"],
    vehiculoFk: json["vehiculoFk"],
    tipoDocFk: json["tipoDocFk"],
    documemtoRef: json["documemtoRef"],
    fechaEmision: json["fechaEmision"],
    fechaCaducidad: json["fechaCaducidad"],
    usuario: json["usuario"],
    idC: json["idC"],
  );

  Map<String, dynamic> toJson() => {
    "IdAccion": idAccion,
    "vehiculoFk": vehiculoFk,
    "tipoDocFk": tipoDocFk,
    "documemtoRef": documemtoRef,
    "fechaEmision": fechaEmision,
    "fechaCaducidad": fechaCaducidad,
    "usuario": usuario,
    "idC": idC,
  };
}





class AlertasMantenimientosModel {
  AlertasMantenimientosModel({
    this.idAccion,
    this.vehiculoFk,
    this.tipoDocFk,
    this.tipoControl,
    this.fechaEmision,
    this.fechaCaducidad,
    this.kilometroInicial,
    this.kilometroMantenimiento,
    this.kilometroCaducidad,
    this.usuario,
    this.idC,
  });

  int? idAccion;
  String? vehiculoFk;
  String? tipoDocFk;
  String? tipoControl;
  String? fechaEmision;
  String? fechaCaducidad;
  String? kilometroInicial;
  String? kilometroMantenimiento;
  String? kilometroCaducidad;
  String? usuario;
  String? idC;

  factory AlertasMantenimientosModel.fromJson(Map<String, dynamic> json) => AlertasMantenimientosModel(
    idAccion: json["IdAccion"],
    vehiculoFk: json["vehiculoFk"],
    tipoDocFk: json["tipoDocFk"],
    tipoControl: json["tipoControl"],
    fechaEmision: json["fechaEmision"],
    fechaCaducidad: json["fechaCaducidad"],
    kilometroInicial: json["kilometroInicial"],
    kilometroMantenimiento: json["kilometroMantenimiento"],
    kilometroCaducidad: json["kilometroCaducidad"],
    usuario: json["usuario"],
    idC: json["idC"],
  );

  Map<String, dynamic> toJson() => {
    "IdAccion": idAccion,
    "vehiculoFk": vehiculoFk,
    "tipoDocFk": tipoDocFk,
    "tipoControl": tipoControl,
    "fechaEmision": fechaEmision,
    "fechaCaducidad": fechaCaducidad,
    "kilometroInicial": kilometroInicial,
    "kilometroMantenimiento": kilometroMantenimiento,
    "kilometroCaducidad": kilometroCaducidad,
    "usuario": usuario,
    "idC": idC,
  };
}




class SubProductosModel {
  String? tipoId;
  String? tipoDescripcion;
  String? tipoDescripcionCorta;
  String? tipoEstado;
  String? tiposGeneralFk;

  SubProductosModel({
    this.tipoId,
    this.tipoDescripcion,
    this.tipoDescripcionCorta,
    this.tipoEstado,
    this.tiposGeneralFk,
  });

  factory SubProductosModel.fromJson(Map<String, dynamic> json) => SubProductosModel(
    tipoId: json["TipoId"],
    tipoDescripcion: json["TipoDescripcion"],
    tipoDescripcionCorta: json["TipoDescripcionCorta"],
    tipoEstado: json["TipoEstado"],
    tiposGeneralFk: json["TiposGeneralFk"],
  );

  Map<String, dynamic> toJson() => {
    "TipoId": tipoId,
    "TipoDescripcion": tipoDescripcion,
    "TipoDescripcionCorta": tipoDescripcionCorta,
    "TipoEstado": tipoEstado,
    "TiposGeneralFk": tiposGeneralFk,
  };
}


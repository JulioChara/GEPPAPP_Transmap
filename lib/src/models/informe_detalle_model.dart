
class InformeDetalleModel {
  InformeDetalleModel({
    this.comentarioAnulado,
    this.comentarioProcesado,
    this.comentarioSolucionado,
    this.descripcion,
    this.fechaAnulado,
    this.fechaCreacion,
    this.fechaModificacion,
    this.fechaProcesar,
    this.fechaSolucionado,
    this.idAccion,
    this.idCabezera,
    this.Placa,
    this.Conductor,
    this.idDetalle,
    this.idResponsableProcesado,
    this.idResponsableProcesadoDesc,
    this.idResponsableSolucionado,
    this.idResponsableSolucionadoDesc,
    this.idTipoEstadoAtencion,
    this.idTipoEstadoAtencionDesc,
    this.idTipoIncidencia,
    this.idTipoIncidenciaDesc,
    this.idUsuarioAnulado,
    this.idUsuarioAnuladoDesc,
    this.idUsuarioCreacion,
    this.idUsuarioCreacionDesc,
    this.mensaje,
    this.resultado,
    this.tipoEstadoIncidenciaFk,
    this.tipoEstadoIncidenciaFkDesc,
  });

  String? comentarioAnulado;
  String? comentarioProcesado;
  String? comentarioSolucionado;
  String? descripcion;
  String? fechaAnulado;
  String? fechaCreacion;
  String? fechaModificacion;
  String? fechaProcesar;
  String? fechaSolucionado;
  dynamic idAccion;
  String? idCabezera;
  String? Placa;
  String? Conductor;
  String? idDetalle;
  String? idResponsableProcesado;
  String? idResponsableProcesadoDesc;
  String? idResponsableSolucionado;
  String? idResponsableSolucionadoDesc;
  String? idTipoEstadoAtencion;
  String? idTipoEstadoAtencionDesc;
  String? idTipoIncidencia;
  String? idTipoIncidenciaDesc;
  String? idUsuarioAnulado;
  String? idUsuarioAnuladoDesc;
  String? idUsuarioCreacion;
  String? idUsuarioCreacionDesc;
  String? mensaje;
  String? resultado;
  String? tipoEstadoIncidenciaFk;
  String? tipoEstadoIncidenciaFkDesc;

  factory InformeDetalleModel.fromJson(Map<String, dynamic> json) => InformeDetalleModel(
    comentarioAnulado: json["ComentarioAnulado"],
    comentarioProcesado: json["ComentarioProcesado"],
    comentarioSolucionado: json["ComentarioSolucionado"],
    descripcion: json["Descripcion"],
    fechaAnulado: json["FechaAnulado"],
    fechaCreacion: json["FechaCreacion"],
    fechaModificacion: json["FechaModificacion"],
    fechaProcesar: json["FechaProcesar"],
    fechaSolucionado: json["FechaSolucionado"],
    idAccion: json["IdAccion"],
    idCabezera: json["IdCabezera"],
    Placa: json["Placa"],
    Conductor: json["Conductor"],
    idDetalle: json["IdDetalle"],
    idResponsableProcesado: json["IdResponsableProcesado"],
    idResponsableProcesadoDesc: json["IdResponsableProcesadoDesc"],
    idResponsableSolucionado: json["IdResponsableSolucionado"],
    idResponsableSolucionadoDesc: json["IdResponsableSolucionadoDesc"],
    idTipoEstadoAtencion: json["IdTipoEstadoAtencion"],
    idTipoEstadoAtencionDesc: json["IdTipoEstadoAtencionDesc"],
    idTipoIncidencia: json["IdTipoIncidencia"],
    idTipoIncidenciaDesc: json["IdTipoIncidenciaDesc"],
    idUsuarioAnulado: json["IdUsuarioAnulado"],
    idUsuarioAnuladoDesc: json["IdUsuarioAnuladoDesc"],
    idUsuarioCreacion: json["IdUsuarioCreacion"],
    idUsuarioCreacionDesc: json["IdUsuarioCreacionDesc"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
    tipoEstadoIncidenciaFk: json["TipoEstadoIncidenciaFk"],
    tipoEstadoIncidenciaFkDesc: json["TipoEstadoIncidenciaFkDesc"],
  );

  Map<String, dynamic> toJson() => {
    "ComentarioAnulado": comentarioAnulado,
    "ComentarioProcesado": comentarioProcesado,
    "ComentarioSolucionado": comentarioSolucionado,
    "Descripcion": descripcion,
    "FechaAnulado": fechaAnulado,
    "FechaCreacion": fechaCreacion,
    "FechaModificacion": fechaModificacion,
    "FechaProcesar": fechaProcesar,
    "FechaSolucionado": fechaSolucionado,
    "IdAccion": idAccion,
    "IdCabezera": idCabezera,
    "Placa": Placa,
    "Conductor": Conductor,
    "IdDetalle": idDetalle,
    "IdResponsableProcesado": idResponsableProcesado,
    "IdResponsableProcesadoDesc": idResponsableProcesadoDesc,
    "IdResponsableSolucionado": idResponsableSolucionado,
    "IdResponsableSolucionadoDesc": idResponsableSolucionadoDesc,
    "IdTipoEstadoAtencion": idTipoEstadoAtencion,
    "IdTipoEstadoAtencionDesc": idTipoEstadoAtencionDesc,
    "IdTipoIncidencia": idTipoIncidencia,
    "IdTipoIncidenciaDesc": idTipoIncidenciaDesc,
    "IdUsuarioAnulado": idUsuarioAnulado,
    "IdUsuarioAnuladoDesc": idUsuarioAnuladoDesc,
    "IdUsuarioCreacion": idUsuarioCreacion,
    "IdUsuarioCreacionDesc": idUsuarioCreacionDesc,
    "mensaje": mensaje,
    "TipoEstadoIncidenciaFk": tipoEstadoIncidenciaFk,
    "TipoEstadoIncidenciaFkDesc": tipoEstadoIncidenciaFkDesc,
  };
}





class InformeUnidadFacturasModel {
  String? comprasFk;
  String? documento;
  String? fecha;
  String? fechaCreacion;
  String? id;
  String? informeUnidadFk;
  String? monto;
  String? proveedor;
  String? usuarioCreacion;

  InformeUnidadFacturasModel({
    this.comprasFk,
    this.documento,
    this.fecha,
    this.fechaCreacion,
    this.id,
    this.informeUnidadFk,
    this.monto,
    this.proveedor,
    this.usuarioCreacion,
  });

  factory InformeUnidadFacturasModel.fromJson(Map<String, dynamic> json) => InformeUnidadFacturasModel(
    comprasFk: json["ComprasFk"],
    documento: json["Documento"],
    fecha: json["Fecha"],
    fechaCreacion: json["FechaCreacion"],
    id: json["Id"],
    informeUnidadFk: json["InformeUnidadFk"],
    monto: json["Monto"],
    proveedor: json["Proveedor"],
    usuarioCreacion: json["UsuarioCreacion"],
  );

  Map<String, dynamic> toJson() => {
    "ComprasFk": comprasFk,
    "Documento": documento,
    "Fecha": fecha,
    "FechaCreacion": fechaCreacion,
    "Id": id,
    "InformeUnidadFk": informeUnidadFk,
    "Monto": monto,
    "Proveedor": proveedor,
    "UsuarioCreacion": usuarioCreacion,
  };
}

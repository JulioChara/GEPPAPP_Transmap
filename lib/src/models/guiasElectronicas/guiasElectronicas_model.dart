



import 'dart:convert';

class GuiasElectronicasModel {
  String? gutrId;
  String? empresasFk;
  String? tipoGuiaFk;
  String? conductoresRelacionFk;
  String? placasRelacionFk;
  String? unidadMedidaFk;
  String? clientesFk;
  String? transportistasFk;
  String? clienteRemitenteFk;
  String? clienteDestinatarioFk;
  String? proveedorFk;
  String? compradorFk;
  String? tipoServicioFk;
  String? tipoEstadoSituacionFk;
  String? gutrPuntoLlegada;
  String? gutrPuntoLlegadaUbigeo;
  String? gutrPuntoPartida;
  String? gutrPuntoPartidaUbigeo;
  String? gutrGuiaRemision;
  String? gutrSerie;
  String? gutrNumero;
  String? gutrPesoTotal;
  String? gutrMontoTotal;
  String? gutrEstado;
  String? gutrObservaciones;
  String? gutrFechaEmision;
  String? gutrFechaTraslado;
  String? guirFechaRegistro;
  String? gutrFecCreacion;
  String? gutrUsrCreacion;
  String? gutrFecModificacion;
  String? gutrUsrModificacion;
  String? gutrMotivoAnulacion;
  String? codigoAnterior;
  String? estadoSunatFk;
  String? gutrTicketSunat;
  String? gutrCodigoValidacionSunat;
  String? gutrCodigoHash;
  List<GuiasElectronicasDetalleModel>? detalle;

  GuiasElectronicasModel({
    this.gutrId,
    this.empresasFk,
    this.tipoGuiaFk,
    this.conductoresRelacionFk,
    this.placasRelacionFk,
    this.unidadMedidaFk,
    this.clientesFk,
    this.transportistasFk,
    this.clienteRemitenteFk,
    this.clienteDestinatarioFk,
    this.proveedorFk,
    this.compradorFk,
    this.tipoServicioFk,
    this.tipoEstadoSituacionFk,
    this.gutrPuntoLlegada,
    this.gutrPuntoLlegadaUbigeo,
    this.gutrPuntoPartida,
    this.gutrPuntoPartidaUbigeo,
    this.gutrGuiaRemision,
    this.gutrSerie,
    this.gutrNumero,
    this.gutrPesoTotal,
    this.gutrMontoTotal,
    this.gutrEstado,
    this.gutrObservaciones,
    this.gutrFechaEmision,
    this.gutrFechaTraslado,
    this.guirFechaRegistro,
    this.gutrFecCreacion,
    this.gutrUsrCreacion,
    this.gutrFecModificacion,
    this.gutrUsrModificacion,
    this.gutrMotivoAnulacion,
    this.codigoAnterior,
    this.estadoSunatFk,
    this.gutrTicketSunat,
    this.gutrCodigoValidacionSunat,
    this.gutrCodigoHash,
    this.detalle,
  });

  factory GuiasElectronicasModel.fromJson(Map<String, dynamic> json) => GuiasElectronicasModel(
    gutrId: json["GutrId"],
    empresasFk: json["EmpresasFk"],
    tipoGuiaFk: json["TipoGuiaFk"],
    conductoresRelacionFk: json["ConductoresRelacionFk"],
    placasRelacionFk: json["PlacasRelacionFk"],
    unidadMedidaFk: json["UnidadMedidaFk"],
    clientesFk: json["ClientesFk"],
    transportistasFk: json["TransportistasFk"],
    clienteRemitenteFk: json["ClienteRemitenteFk"],
    clienteDestinatarioFk: json["ClienteDestinatarioFk"],
    proveedorFk: json["ProveedorFk"],
    compradorFk: json["CompradorFk"],
    tipoServicioFk: json["TipoServicioFk"],
    tipoEstadoSituacionFk: json["TipoEstadoSituacionFk"],
    gutrPuntoLlegada: json["GutrPuntoLlegada"],
    gutrPuntoLlegadaUbigeo: json["GutrPuntoLlegadaUbigeo"],
    gutrPuntoPartida: json["GutrPuntoPartida"],
    gutrPuntoPartidaUbigeo: json["GutrPuntoPartidaUbigeo"],
    gutrGuiaRemision: json["GutrGuiaRemision"],
    gutrSerie: json["GutrSerie"],
    gutrNumero: json["GutrNumero"],
    gutrPesoTotal: json["GutrPesoTotal"],
    gutrMontoTotal: json["GutrMontoTotal"],
    gutrEstado: json["GutrEstado"],
    gutrObservaciones: json["GutrObservaciones"],
    gutrFechaEmision: json["GutrFechaEmision"],
    gutrFechaTraslado: json["GutrFechaTraslado"],
    guirFechaRegistro: json["GuirFechaRegistro"],
    gutrFecCreacion: json["GutrFecCreacion"],
    gutrUsrCreacion: json["GutrUsrCreacion"],
    gutrFecModificacion: json["GutrFecModificacion"],
    gutrUsrModificacion: json["GutrUsrModificacion"],
    gutrMotivoAnulacion: json["GutrMotivoAnulacion"],
    codigoAnterior: json["CodigoAnterior"],
    estadoSunatFk: json["EstadoSunatFk"],
    gutrTicketSunat: json["GutrTicketSunat"],
    gutrCodigoValidacionSunat: json["GutrCodigoValidacionSunat"],
    gutrCodigoHash: json["GutrCodigoHash"],
    detalle: List<GuiasElectronicasDetalleModel>.from(json["Detalle"]?.map((x) => GuiasElectronicasDetalleModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "GutrId": gutrId,
    "EmpresasFk": empresasFk,
    "TipoGuiaFk": tipoGuiaFk,
    "ConductoresRelacionFk": conductoresRelacionFk,
    "PlacasRelacionFk": placasRelacionFk,
    "UnidadMedidaFk": unidadMedidaFk,
    "ClientesFk": clientesFk,
    "TransportistasFk": transportistasFk,
    "ClienteRemitenteFk": clienteRemitenteFk,
    "ClienteDestinatarioFk": clienteDestinatarioFk,
    "ProveedorFk": proveedorFk,
    "CompradorFk": compradorFk,
    "TipoServicioFk": tipoServicioFk,
    "TipoEstadoSituacionFk": tipoEstadoSituacionFk,
    "GutrPuntoLlegada": gutrPuntoLlegada,
    "GutrPuntoLlegadaUbigeo": gutrPuntoLlegadaUbigeo,
    "GutrPuntoPartida": gutrPuntoPartida,
    "GutrPuntoPartidaUbigeo": gutrPuntoPartidaUbigeo,
    "GutrGuiaRemision": gutrGuiaRemision,
    "GutrSerie": gutrSerie,
    "GutrNumero": gutrNumero,
    "GutrPesoTotal": gutrPesoTotal,
    "GutrMontoTotal": gutrMontoTotal,
    "GutrEstado": gutrEstado,
    "GutrObservaciones": gutrObservaciones,
    "GutrFechaEmision": gutrFechaEmision,
    "GutrFechaTraslado": gutrFechaTraslado,
    "GuirFechaRegistro": guirFechaRegistro,
    "GutrFecCreacion": gutrFecCreacion,
    "GutrUsrCreacion": gutrUsrCreacion,
    "GutrFecModificacion": gutrFecModificacion,
    "GutrUsrModificacion": gutrUsrModificacion,
    "GutrMotivoAnulacion": gutrMotivoAnulacion,
    "CodigoAnterior": codigoAnterior,
    "EstadoSunatFk": estadoSunatFk,
    "GutrTicketSunat": gutrTicketSunat,
    "GutrCodigoValidacionSunat": gutrCodigoValidacionSunat,
    "GutrCodigoHash": gutrCodigoHash,
    "Detalle": detalle != null ? List<dynamic>.from(detalle!.map((x) => x.toJson())): null,
  };
}

class GuiasElectronicasDetalleModel {
  String? gudeId;
  String? empresasFk;
  String? guiaTransportistasElectronicaFk;
  String? productosFk;
  String? tipoProductoFk;
  String? tipoProductoUnidadMedidaFk;
  String? gudeItem;
  String? gudeProductoDescripcion;
  String? gudeCantidad;
  String? gudePrecioUnitario;
  String? gudePesoUnitario;
  String? gudeMontoTotal;
  String? gudePesoTotal;
  String? gudeFecCreacion;
  String? gudeUsrCreacion;
  String? gudeFecModificacion;
  String? gudeUsrModificacion;
  String? subProductoFk;

  GuiasElectronicasDetalleModel({
    this.gudeId,
    this.empresasFk,
    this.guiaTransportistasElectronicaFk,
    this.productosFk,
    this.tipoProductoFk,
    this.tipoProductoUnidadMedidaFk,
    this.gudeItem,
    this.gudeProductoDescripcion,
    this.gudeCantidad,
    this.gudePrecioUnitario,
    this.gudePesoUnitario,
    this.gudeMontoTotal,
    this.gudePesoTotal,
    this.gudeFecCreacion,
    this.gudeUsrCreacion,
    this.gudeFecModificacion,
    this.gudeUsrModificacion,
    this.subProductoFk,
  });

  factory GuiasElectronicasDetalleModel.fromJson(Map<String, dynamic> json) => GuiasElectronicasDetalleModel(
    gudeId: json["GudeId"],
    empresasFk: json["EmpresasFk"],
    guiaTransportistasElectronicaFk: json["GuiaTransportistasElectronicaFk"],
    productosFk: json["ProductosFk"],
    tipoProductoFk: json["TipoProductoFk"],
    tipoProductoUnidadMedidaFk: json["TipoProductoUnidadMedidaFk"],
    gudeItem: json["GudeItem"],
    gudeProductoDescripcion: json["GudeProductoDescripcion"],
    gudeCantidad: json["GudeCantidad"],
    gudePrecioUnitario: json["GudePrecioUnitario"],
    gudePesoUnitario: json["GudePesoUnitario"],
    gudeMontoTotal: json["GudeMontoTotal"],
    gudePesoTotal: json["GudePesoTotal"],
    gudeFecCreacion: json["GudeFecCreacion"],
    gudeUsrCreacion: json["GudeUsrCreacion"],
    gudeFecModificacion: json["GudeFecModificacion"],
    gudeUsrModificacion: json["GudeUsrModificacion"],
    subProductoFk: json["SubProductoFk"],
  );

  Map<String, dynamic> toJson() => {
    "GudeId": gudeId,
    "EmpresasFk": empresasFk,
    "GuiaTransportistasElectronicaFk": guiaTransportistasElectronicaFk,
    "ProductosFk": productosFk,
    "TipoProductoFk": tipoProductoFk,
    "TipoProductoUnidadMedidaFk": tipoProductoUnidadMedidaFk,
    "GudeItem": gudeItem,
    "GudeProductoDescripcion": gudeProductoDescripcion,
    "GudeCantidad": gudeCantidad,
    "GudePrecioUnitario": gudePrecioUnitario,
    "GudePesoUnitario": gudePesoUnitario,
    "GudeMontoTotal": gudeMontoTotal,
    "GudePesoTotal": gudePesoTotal,
    "GudeFecCreacion": gudeFecCreacion,
    "GudeUsrCreacion": gudeUsrCreacion,
    "GudeFecModificacion": gudeFecModificacion,
    "GudeUsrModificacion": gudeUsrModificacion,
    "SubProductoFk": subProductoFk,
  };
}


class ImpresionOnlineGuiaElectronicaModel {
  String? cabClienteDesc;
  String? cabClienteDoc;
  String? cabConductorDesc;
  String? cabConductorDoc;
  String? cabDestinatarioDesc;
  String? cabDestinatarioDoc;
  String? cabEmpresa;
  String? cabEmpresaRuc;
  String? cabFechaEmision;
  String? cabFechaTraslado;
  String? cabGuiaNumero;
  String? cabGuiaRemision;
  String? cabGuiaSerie;
  String? cabObservaciones;
  String? cabPesoBruto;
  String? cabPlacaPrincipal;
  String? cabPlacaSecundaria;
  String? cabPuntoLlegada;
  String? cabPuntoPartida;
  String? cabQrSunat;
  String? cabRemitenteDesc;
  String? cabRemitenteDoc;
  String? cabTipoDocumento;
  String? cabUnidadMedida;
  List<Detalle>? detalle;
  String? id;
  String? idGuia;

  ImpresionOnlineGuiaElectronicaModel({
    this.cabClienteDesc,
    this.cabClienteDoc,
    this.cabConductorDesc,
    this.cabConductorDoc,
    this.cabDestinatarioDesc,
    this.cabDestinatarioDoc,
    this.cabEmpresa,
    this.cabEmpresaRuc,
    this.cabFechaEmision,
    this.cabFechaTraslado,
    this.cabGuiaNumero,
    this.cabGuiaRemision,
    this.cabGuiaSerie,
    this.cabObservaciones,
    this.cabPesoBruto,
    this.cabPlacaPrincipal,
    this.cabPlacaSecundaria,
    this.cabPuntoLlegada,
    this.cabPuntoPartida,
    this.cabQrSunat,
    this.cabRemitenteDesc,
    this.cabRemitenteDoc,
    this.cabTipoDocumento,
    this.cabUnidadMedida,
    this.detalle,
    this.id,
    this.idGuia,
  });

  factory ImpresionOnlineGuiaElectronicaModel.fromJson(Map<String, dynamic> json) => ImpresionOnlineGuiaElectronicaModel(
    cabClienteDesc: json["CabClienteDesc"],
    cabClienteDoc: json["CabClienteDoc"],
    cabConductorDesc: json["CabConductorDesc"],
    cabConductorDoc: json["CabConductorDoc"],
    cabDestinatarioDesc: json["CabDestinatarioDesc"],
    cabDestinatarioDoc: json["CabDestinatarioDoc"],
    cabEmpresa: json["CabEmpresa"],
    cabEmpresaRuc: json["CabEmpresaRuc"],
    cabFechaEmision: json["CabFechaEmision"],
    cabFechaTraslado: json["CabFechaTraslado"],
    cabGuiaNumero: json["CabGuiaNumero"],
    cabGuiaRemision: json["CabGuiaRemision"],
    cabGuiaSerie: json["CabGuiaSerie"],
    cabObservaciones: json["CabObservaciones"],
    cabPesoBruto: json["CabPesoBruto"],
    cabPlacaPrincipal: json["CabPlacaPrincipal"],
    cabPlacaSecundaria: json["CabPlacaSecundaria"],
    cabPuntoLlegada: json["CabPuntoLlegada"],
    cabPuntoPartida: json["CabPuntoPartida"],
    cabQrSunat: json["CabQrSunat"],
    cabRemitenteDesc: json["CabRemitenteDesc"],
    cabRemitenteDoc: json["CabRemitenteDoc"],
    cabTipoDocumento: json["CabTipoDocumento"],
    cabUnidadMedida: json["CabUnidadMedida"],
    detalle: List<Detalle>.from(json["Detalle"]?.map((x) => Detalle.fromJson(x))),
    id: json["id"],
    idGuia: json["idGuia"],
  );

  Map<String, dynamic> toJson() => {
    "CabClienteDesc": cabClienteDesc,
    "CabClienteDoc": cabClienteDoc,
    "CabConductorDesc": cabConductorDesc,
    "CabConductorDoc": cabConductorDoc,
    "CabDestinatarioDesc": cabDestinatarioDesc,
    "CabDestinatarioDoc": cabDestinatarioDoc,
    "CabEmpresa": cabEmpresa,
    "CabEmpresaRuc": cabEmpresaRuc,
    "CabFechaEmision": cabFechaEmision,
    "CabFechaTraslado": cabFechaTraslado,
    "CabGuiaNumero": cabGuiaNumero,
    "CabGuiaRemision": cabGuiaRemision,
    "CabGuiaSerie": cabGuiaSerie,
    "CabObservaciones": cabObservaciones,
    "CabPesoBruto": cabPesoBruto,
    "CabPlacaPrincipal": cabPlacaPrincipal,
    "CabPlacaSecundaria": cabPlacaSecundaria,
    "CabPuntoLlegada": cabPuntoLlegada,
    "CabPuntoPartida": cabPuntoPartida,
    "CabQrSunat": cabQrSunat,
    "CabRemitenteDesc": cabRemitenteDesc,
    "CabRemitenteDoc": cabRemitenteDoc,
    "CabTipoDocumento": cabTipoDocumento,
    "CabUnidadMedida": cabUnidadMedida,
    "Detalle":detalle != null ? List<dynamic>.from(detalle!.map((x) => x.toJson())): null,
    "id": id,
    "idGuia": idGuia,
  };
}

class Detalle {
  String detCantidad;
  String detProductoDescripcion;
  String detUnidadMedida;
  String guiaFk;

  Detalle({
    required this.detCantidad,
    required this.detProductoDescripcion,
    required this.detUnidadMedida,
    required this.guiaFk,
  });

  factory Detalle.fromJson(Map<String, dynamic> json) => Detalle(
    detCantidad: json["DetCantidad"],
    detProductoDescripcion: json["DetProductoDescripcion"],
    detUnidadMedida: json["DetUnidadMedida"],
    guiaFk: json["GuiaFK"],
  );

  Map<String, dynamic> toJson() => {
    "DetCantidad": detCantidad,
    "DetProductoDescripcion": detProductoDescripcion,
    "DetUnidadMedida": detUnidadMedida,
    "GuiaFK": guiaFk,
  };
}
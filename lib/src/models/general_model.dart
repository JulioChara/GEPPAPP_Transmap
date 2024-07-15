

class IdsModel {
  IdsModel({
    this.idC,
    this.idD,
    this.usuario,
  });

  String? idC;
  String? idD;
  String? usuario;

  factory IdsModel.fromJson(Map<String, dynamic> json) => IdsModel(
    idC: json["idC"],
    idD: json["idD"],
    usuario: json["usuario"],
  );

  Map<String, dynamic> toJson() => {
    "idC": idC,
    "idD": idD,
    "usuario": usuario,
  };
}



class TestClassModel {
  String? mensaje;
  String? resultado;
  String? id;

  TestClassModel({
    this.mensaje,
    this.resultado,
    this.id,
  });

  factory TestClassModel.fromJson(Map<String, dynamic> json) => TestClassModel(
    mensaje: json["mensaje"],
    resultado: json["resultado"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "mensaje": mensaje,
    "resultado": resultado,
    "id": id,
  };
}



class CronogramaModel {
  String? diferencialFechas;
  String? diferencialHoy;
  String? empleado;
  String? estado;
  String? fechaCreacion;
  String? fechaFinal;
  String? fechaInicial;
  String? id;

  CronogramaModel({
    this.diferencialFechas,
    this.diferencialHoy,
    this.empleado,
    this.estado,
    this.fechaCreacion,
    this.fechaFinal,
    this.fechaInicial,
    this.id,
  });

  factory CronogramaModel.fromJson(Map<String, dynamic> json) => CronogramaModel(
    diferencialFechas: json["DiferencialFechas"],
    diferencialHoy: json["DiferencialHoy"],
    empleado: json["Empleado"],
    estado: json["Estado"],
    fechaCreacion: json["FechaCreacion"],
    fechaFinal: json["FechaFinal"],
    fechaInicial: json["FechaInicial"],
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "DiferencialFechas": diferencialFechas,
    "DiferencialHoy": diferencialHoy,
    "Empleado": empleado,
    "Estado": estado,
    "FechaCreacion": fechaCreacion,
    "FechaFinal": fechaFinal,
    "FechaInicial": fechaInicial,
    "Id": id,
  };
}



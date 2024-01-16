

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


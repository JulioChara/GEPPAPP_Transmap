
import 'dart:convert';

LoginTiposModel loginTiposModelFromJson(String str) => LoginTiposModel.fromJson(json.decode(str));

String loginTiposModelToJson(LoginTiposModel data) => json.encode(data.toJson());

class LoginTiposModel {
    String? chId;
    String? chUsuario;
    String? estado;
    String? fechaCreacion;
    String? placaFk;
    String? placaFkDesc;
    String? usuarioCreacion;
    String? vehiculoFk;
    String? vehiculoFkDesc;
    List<Map<String, String?>>? detalle;

    LoginTiposModel({
        this.chId,
        this.chUsuario,
        this.detalle,
        this.estado,
        this.fechaCreacion,
        this.placaFk,
        this.placaFkDesc,
        this.usuarioCreacion,
        this.vehiculoFk,
        this.vehiculoFkDesc,
    });

    factory LoginTiposModel.fromJson(Map<String, dynamic> json) => LoginTiposModel(
        chId: json["ChId"],
        chUsuario: json["ChUsuario"],
        detalle: List<Map<String, String?>>.from(json["Detalle"]?.map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
        estado: json["Estado"],
        fechaCreacion: json["FechaCreacion"],
        placaFk: json["PlacaFk"],
        placaFkDesc: json["PlacaFkDesc"],
        usuarioCreacion: json["UsuarioCreacion"],
        vehiculoFk: json["VehiculoFk"],
        vehiculoFkDesc: json["VehiculoFkDesc"],
    );

    Map<String, dynamic> toJson() => {
        "ChId": chId,
        "ChUsuario": chUsuario,
        "Detalle": List<dynamic>.from(detalle!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        "Estado": estado,
        "FechaCreacion": fechaCreacion,
        "PlacaFk": placaFk,
        "PlacaFkDesc": placaFkDesc,
        "UsuarioCreacion": usuarioCreacion,
        "VehiculoFk": vehiculoFk,
        "VehiculoFkDesc": vehiculoFkDesc,
    };
}

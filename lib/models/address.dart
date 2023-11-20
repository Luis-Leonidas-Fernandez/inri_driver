// To parse this JSON data, do
//
//     final addressResp = addressRespFromMap(jsonString);

import 'dart:convert';


class Address {
    
    bool? ok;
    String? msg;
    String? id;
    String? nombre;
    String? email;
    bool? online;
    bool? estado;
    List<double>? ubicacion;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? idDriver;
    Map<String, dynamic>? cupon;

    Address({
        
        this.ok,
        this.msg,
        this.id,
        this.nombre,
        this.email,
        this.online,
        this.estado,
        this.ubicacion,
        this.createdAt,
        this.updatedAt,
        this.idDriver,
        this.cupon
    });
   

    String toJson() => json.encode(toMap());

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        ok: json["ok"]?? false,
        msg: json["msg"]?? '',
        id: json["_id"]?? '',
        nombre: json["nombre"]?? '',
        email: json["email"]?? '',
        online: json["online"]?? false,
        estado: json["estado"]?? false,
        cupon: json["cupon"] == null ? null : Map.from(json["cupon"]).map((k, v) => MapEntry<String, dynamic>(k, v)),
        ubicacion: json["ubicacion"] == null ? null : List<double>.from(json["ubicacion"].map((x) => x.toDouble())),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        idDriver: json["idDriver"]??'',
    );

    Map<String, dynamic> toMap() => {
        "ok": ok,
        "msg": msg,
        "_id": id,
        "nombre": nombre,
        "email": email,
        "online": online,
        "estado": estado,
         "cupon": Map.from(cupon!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "ubicacion": List<dynamic>.from(ubicacion!.map((x) => x)),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "idDriver": idDriver,
    };
}





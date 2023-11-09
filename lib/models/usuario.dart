// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);


import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        required this.email,
        required this.nombre,
        required this.apellido,
        required this.nacimiento,
        required this.domicilio,
        required this.vehiculo,
        required this.modelo,
        required this.patente,
        required this.licencia,
        required this.id,
    });

    String email;
    String nombre;
    String apellido;
    String nacimiento;
    String domicilio;
    String vehiculo;
    String modelo;
    String patente;
    String licencia;
    String id;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        email: json["email"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        nacimiento: json["nacimiento"],
        domicilio: json["domicilio"],
        vehiculo: json["vehiculo"],
        modelo: json["modelo"],
        patente: json["patente"],
        licencia: json["licencia"],
        id: json["_id"]?? [''],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "nombre": nombre,
        "apellido": apellido,
        "nacimiento": nacimiento,
        "domicilio": domicilio,
        "vehiculo": vehiculo,
        "modelo": modelo,
        "patente": patente,
        "licencia": licencia,
        "id": id,
    };
}

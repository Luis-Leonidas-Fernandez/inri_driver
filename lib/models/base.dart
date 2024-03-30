
import 'dart:convert';

class BaseModel {
    String? zona;
    String? base;

    BaseModel({
        this.zona,
        this.base,
    });

    //factory BaseModel.fromJson(String str) => BaseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        zona: json["zona"]??"",
        base: json["base"]??"",
    );

    Map<String, dynamic> toMap() => {
        "zona": zona,
        "base": base,
    };
}

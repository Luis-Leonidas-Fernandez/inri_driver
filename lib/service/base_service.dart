import 'dart:convert';

import 'package:inri_driver/global/environment.dart';
import 'package:inri_driver/models/base.dart';
import 'package:inri_driver/service/storage_service.dart';
import 'package:http/http.dart' as http;

class BaseService {

  late BaseModel baseSelected;
  final storage = StorageService.instance;


  Future<bool> addDriverToBase(BaseModel? baseSelected) async {

    final token  = await StorageService.instance.getTokenUser();
    final idUser = await StorageService.instance.getId();    
    
    
    final zona = baseSelected?.zona ?? "";
    final base = baseSelected?.base ?? "";
    final Map<String, String> data = {'zona': zona, 'base': base};

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8',
      'x-token': token.toString()
    };
    

    final resp = await http.put(Uri.parse('${Environment.apiUrl}/base/add-driver-to-base/$idUser'),
    headers: headers, body: json.encode(data));

    if (resp.statusCode == 200) {
     

      return true;
    } else {
      return false;
    }
  }
















}
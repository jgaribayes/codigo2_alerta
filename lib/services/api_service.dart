import 'dart:convert';
import 'dart:io';

import 'package:codigo2_alerta/models/citizen_model.dart';
import 'package:codigo2_alerta/models/incident_model.dart';
import 'package:codigo2_alerta/models/incident_register_model.dart';

import 'package:codigo2_alerta/models/incidente_type_model.dart';
import 'package:codigo2_alerta/models/news_model.dart';
import 'package:codigo2_alerta/models/user_model.dart';
import 'package:codigo2_alerta/utilis/constants.dart';

import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

import '../utilis/sp_global.dart';

class ApiService {


  final SPGlobal _prefs = SPGlobal();


  Future<UserModel?> login(String dni, String password) async {
    Uri _url = Uri.parse("$pathProduction/login/");
    http.Response response = await http.post(
      _url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "username": dni,
          "password": password,
        },
      ),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      UserModel userModel = UserModel.fromJson(myMap["user"]);
      _prefs.token = myMap["access"];
      return userModel;
    }
    return null;
  }

  Future<List<CitizenModel>> getCitizen() async {
    Uri _url = Uri.parse("$pathProduction/ciudadanos/");
    http.Response response = await http.get(_url);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      List list = myMap["data"];
      List<CitizenModel> citizenList =
      list.map((e) => CitizenModel.fromJson(e)).toList();
      return citizenList;
    }
    return [];
  }

  Future<List<IncidentTypeModel>> getIncidentType() async {
    Uri _url = Uri.parse("$pathProduction/incidentes/tipos/");
    http.Response response = await http.get(_url);
    if (response.statusCode == 200) {
      List list = json.decode(response.body);
      List<IncidentTypeModel> incidentTypeList =
      list.map((e) => IncidentTypeModel.fromJson(e)).toList();
      return incidentTypeList;
    }
    return [];
  }

  Future<List<IncidentModel>> getIncident() async {
    Uri _url = Uri.parse("$pathProduction/incidentes/");
    http.Response response = await http.get(_url);
    if (response.statusCode == 200) {
      List listData = json.decode(response.body);
      List<IncidentModel> incidentList =
      listData.map((e) => IncidentModel.fromJson(e)).toList();
      return incidentList;
    }
    return [];
  }

  Future<bool> registerIncident(IncidentRegisterModel model) async {
    Uri _url = Uri.parse("$pathProduction/incidentes/crear/");
    http.Response response = await http.post(
      _url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Token ${_prefs.token}",
      },
      body: json.encode(
        {
          "latitud": model.latitude,
          "longitud": model.longitude,
          "tipoIncidente": model.incidentTypeId,
          "estado": model.status
        },
      ),
    );
    // if(response.statusCode == 201){
    //   return true;
    // }
    // return false;
    return response.statusCode == 201;
  }


  Future<NewsModel?> registerNews(NewsModel model) async {

    Uri _url = Uri.parse("$pathProduction/noticias/");
    http.MultipartRequest request = http.MultipartRequest("POST", _url);
    List<String> mimeType = mime(model.imagen)!.split("/");
    http.MultipartFile file = await http.MultipartFile.fromPath(
      "imagen",
      model.imagen,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );
    request.fields["titulo"] = model.titulo;
    request.fields["link"] = model.link;
    request.fields["fecha"] = "2022-11-18";
    request.files.add(file);
    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);
    if(response.statusCode == 201){
      Map<String,dynamic> myMap = json.decode(response.body);
      NewsModel newsModel = NewsModel.fromJson(myMap);
      print(newsModel);
      return newsModel;
    }
    return null;
  }

  Future<List<NewsModel>> getNoticias() async {
    Uri _url = Uri.parse("$pathProduction/noticias/");
    http.Response response = await http.get(_url);
    if (response.statusCode == 200) {
      List listData = json.decode(response.body);
      List<NewsModel> noticiaList =
      listData.map((e) => NewsModel.fromJson(e)).toList();
      // print(response.statusCode);
      // print(noticiaList);
      return noticiaList;
    }
    return [];
  }


}
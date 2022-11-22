
import 'package:codigo2_alerta/models/incidente_type_model.dart';

class IncidentModel {
  IncidentModel({
    required this.id,
    required this.tipoIncidente,
    required this.longitud,
    required this.latitud,
    required this.fecha,
    required this.hora,
    required this.fechaCreacion,
    required this.datosCiudadano,
    required this.estado,
    required this.tipoOrigen,
  });

  int id;
  IncidentTypeModel tipoIncidente;
  double longitud;
  double latitud;
  String fecha;
  String hora;
  String fechaCreacion;
  DatosCiudadano datosCiudadano;
  String estado;
  String tipoOrigen;


  factory IncidentModel.fromJson(Map<String, dynamic> json) => IncidentModel(
    id: json["id"],
    tipoIncidente: IncidentTypeModel.fromJson(json["tipoIncidente"]),
    longitud: json["longitud"].toDouble(),
    latitud: json["latitud"].toDouble(),
    fecha: json["fecha"],
    hora: json["hora"],
    fechaCreacion: json["fechaCreacion"],
    datosCiudadano: DatosCiudadano.fromJson(json["datosCiudadano"]),
    estado: json["estado"],
    tipoOrigen: json["tipoOrigen"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tipoIncidente": tipoIncidente.toJson(),
    "longitud": longitud,
    "latitud": latitud,
    "fecha": fecha,
    "hora": hora,
    "fechaCreacion": fechaCreacion,
    "datosCiudadano": datosCiudadano.toJson(),
    "estado": estado,
    "tipoOrigen": tipoOrigen,
  };
}



class DatosCiudadano {
  DatosCiudadano({
    required this.nombres,
    required this.dni,
    required this.telefono,
  });

  String nombres;
  String dni;
  String telefono;

  factory DatosCiudadano.fromJson(Map<String, dynamic> json) => DatosCiudadano(
    nombres: json["nombres"],
    dni: json["dni"],
    telefono: json["telefono"],
  );

  Map<String, dynamic> toJson() => {
    "nombres": nombres,
    "dni": dni,
    "telefono": telefono,
  };
}
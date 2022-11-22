class CitizenModel {
  CitizenModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.dni,
    required this.rate,
    required this.status,
  });

  int id;
  String fullName;
  String phone;
  String address;
  String dni;
  int rate;
  String status;

  factory CitizenModel.fromJson(Map<String, dynamic> json) => CitizenModel(
    id: json["id"],
    fullName: json["nombreCompleto"] ?? "-",
    phone: json["telefono"],
    address: json["direccion"],
    dni: json["dni"],
    rate: json["calificacion"],
    status: json["estado"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombreCompleto": fullName,
    "telefono": phone,
    "direccion": address,
    "dni": dni,
    "calificacion": rate,
    "estado": status,
  };
}
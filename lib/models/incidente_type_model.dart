class IncidentTypeModel {
  IncidentTypeModel({
    required this.id,
    required this.value,
    required this.text,
    required this.title,
    required this.area,
    required this.level,
  });

  int id;
  int value;
  String text;
  String title;
  String area;
  String level;

  factory IncidentTypeModel.fromJson(Map<String, dynamic> json) => IncidentTypeModel(
    id: json["id"],
    value: json["value"],
    text: json["text"],
    title: json["titulo"],
    area: json["area"],
    level: json["nivel"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "text": text,
    "titulo": title,
    "area": area,
    "nivel": level,
  };
}
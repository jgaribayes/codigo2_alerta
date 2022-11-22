import 'package:flutter/material.dart';


const String pathProduction = "http://alertahunter.herokuapp.com/API";

enum InputTypeEnum{
  text,
  dni,
  telefono,
}
Map<InputTypeEnum, TextInputType> inputTypeMap = {
  InputTypeEnum.text : TextInputType.text,
  InputTypeEnum.dni : TextInputType.number,
  InputTypeEnum.telefono : TextInputType.number,
};
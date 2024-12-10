import 'dart:convert';
import 'dart:io';

import 'package:json_application/example01/user.dart';

void main() async {
  File jsonFile = File('lib/example01/user.json');
  String contents = await jsonFile.readAsString();
  
  // 역직렬화 과정 : JSON 문자열 -> Map -> 객체
  Map<String, dynamic> jsonData = jsonDecode(contents);
  User user = User.fromJson(jsonData);
  
  print(user);  
}
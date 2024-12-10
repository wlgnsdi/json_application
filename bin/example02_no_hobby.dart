import 'dart:convert';
import 'dart:io';

import 'package:json_application/example02_no_hobby/user.dart';


void main() async {
  File jsonFile = File('lib/example02_no_hobby/user_no_hobby.json');
  String contents = await jsonFile.readAsString();
  
  // 역직렬화 과정 : JSON 문자열 -> Map -> 객체
  Map<String, dynamic> jsonData = jsonDecode(contents);
  User user = User.fromJson(jsonData);
  
  print(user);  
}
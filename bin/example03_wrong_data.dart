import 'dart:convert';
import 'dart:io';

import 'package:json_application/example03_wrong_data/user.dart';

void main() async {
  File jsonFile = File('lib/example03_wrong_data/user_wrong_data.json');
  String contents = await jsonFile.readAsString();
  
  // 1. 잘못된 age 데이터가 들어왔을때 에러 발생
  wrongRun(contents);

  // 2. 잘못된 age 데이터가 들어왔을때 예외 처리 작업
  // rightRun(jsonFile);
}

/// 에러 발생 케이스
void wrongRun(String contents) {
  // 역직렬화 과정 : JSON 문자열 -> Map -> 객체
  Map<String, dynamic> jsonData = jsonDecode(contents);
  User user = User.fromJson(jsonData);
 
  print(user);
}

/// 예외 처리 케이스
void rightRun(String contents) {
  try {
    // 역직렬화 과정 : JSON 문자열 -> Map -> 객체
    Map<String, dynamic> jsonData = jsonDecode(contents);
    User user = User.fromJson(jsonData);

    print(user);
  } catch (e) {
    print('예외 발생: $e');
    var user = User(name: 'Unknow', age: 0, hobbies: []);
    print(user.toString());
  }
}

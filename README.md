# JSON 공부하기
JSON Application은 JSON 데이터를 활용한 Dart 프로젝트입니다. 이 프로젝트에서는 JSON 직렬화(Serialization) 및 역직렬화(Deserialization)의 구현, 그리고 JSON 데이터를 처리하는 다양한 예제를 다룹니다.


    json_application
    │
    ├── bin
    │   ├── example01.dart
    │   ├── example02_no_hobby.dart
    │   ├── example03_wrong_data.dart
    │   └── example04_serializable.dart
    │
    ├── lib
    │   ├── example01
    │   │      ├── user.dart
    │   │      └── user.json
    │   │
    │   ├── example02_no_hobby
    │   │      ├── user.dart
    │   │      └── user_no_hobby.json    
    │   │
    │   ├── example03_wrong_data
    │   │      ├── user.dart
    │   │      └── user_wrong_data.json    
    │   │
    │   └── example04_serializable
    │          ├── user.dart
    │          ├── user.g.dart
    │          └── user.json    
    │   
    ├── test
    │   └── user_test.dart파일
    └── README.md
&nbsp;
## example01
기본적인 JSON 데이터를 역직렬화를 통해서 객체로 만드는 방법 예제 코드입니다.  

### 역직렬화
```Dart
String contents = "JSON 문자열";
// 역직렬화 과정 : JSON 문자열 -> Map -> 객체

Map<String, dynamic> jsonData = jsonDecode(contents);
User user = User.fromJson(jsonData);
```
### JSON 데이터
```JSON
{
    "name": "John Doe",
    "age": 30,
    "hobbies": ["reading", "coding", "traveling"]
}
```

### 모델 클래스
```Dart
class User {
  final String name;
  final int age;
  final List<String> hobbies;

  User({
    required this.name,
    required this.age,
    required this.hobbies
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      age: json['age'] as int,
      hobbies: (json['hobbies'] as List<dynamic>)
                    .map((e) => e as String)
                    .toList()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name' : name,
      'age' : age,
      'hobbies' : hobbies
    };
  }
}

```
### 터미널
```bash
Name : John Doe, Age : 30, Hobbies : [reading, coding, traveling]
```
&nbsp;

## example02
약속된 데이터가 전부 들어오지 않았을때에 대한 예제코드 입니다.

### 역직렬화
```Dart
String contents = "JSON 문자열";
// 역직렬화 과정 : JSON 문자열 -> Map -> 객체

Map<String, dynamic> jsonData = jsonDecode(contents);
User user = User.fromJson(jsonData);
```
### JSON 데이터
```JSON
{
    "name": "John Doe",
    "age": 30
}
```

### 모델 클래스
```Dart
class User {
  final String name;
  final int age;
  final List<String> hobbies;

  User({required this.name, required this.age, required this.hobbies});

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      name: json?['name'] as String? ?? 'Unkown',
      age: json?['age'] as int? ?? 0,
      hobbies: (json?['hobbies'] as List<dynamic>? ?? [])
          .map((e) => e as String)
          .toList(),
    );
  }
  ...
}
```
### 터미널
```bash
Name : John Doe, Age : 30, Hobbies : []
```

## example03
약속되지 않은 잘못된 타입의 데이터가 들어왔을 경우에 대한 예제코드 입니다.

### 에러 발생 - Bad Case
```Dart
String contents = "JSON 문자열";

// 1. 잘못된 age 데이터가 들어왔을때 에러 발생
Map<String, dynamic> jsonData = jsonDecode(contents);
User user = User.fromJson(jsonData);
```
### 예외 처리 - Good Case
```Dart
try {
    Map<String, dynamic> jsonData = jsonDecode(contents);
    User user = User.fromJson(jsonData);  // 에러 발생

    print(user);
  } catch (e) {
    print('예외 발생: $e');
  }
```

### JSON 데이터
```JSON
{
    "name": "John Doe",
    "age": "30"
}
```

### 모델 클래스
```Dart
class User {
  final String name;
  final int age;
  final List<String> hobbies;

  User({required this.name, required this.age, required this.hobbies});

  factory User.fromJson(Map<String, dynamic> json) {
  
    return User(
      name: json['name'] as String? ?? 'Unkown',
      age: json['age'] as int? ?? 0,
      hobbies: (json['hobbies'] as List<dynamic>? ?? [])
          .map((e) => e as String)
          .toList(),
    );
  }

  ...
}

```
### 터미널 - Bad Case
```bash
Unhandled exception:
type 'String' is not a subtype of type 'int?' in type cast
#0      new User.fromJson (package:json_application/example03_wrong_data/user.dart:12:24)
#1      wrongRun (file:///Users/jihoon/StudioProjects/tutor/json_application/bin/example03_wrong_data.dart:21:20)
#2      main (file:///Users/jihoon/StudioProjects/tutor/json_application/bin/example03_wrong_data.dart:11:3)
<asynchronous suspension>
```

### 터미널 - Good Case
```bash
Name : Unknow, Age : 0, Hobbies : []
```
&nbsp;

## example04
[json_serializable](https://pub.dev/packages/json_serializable) 패키지를 활용해서 손쉽게 JSON 모델 클래스 구성하는 예제 코드입니다.
### 역직렬화
```Dart
  String contents = "JSON 문자열";

  Map<String, dynamic> jsonData = jsonDecode(contents);
  User user = User.fromJson(jsonData);
  print(user);
```

### JSON
```JSON
{
    "name": "John Doe",
    "age": 30,
    "hobbies": [
        "reading",
        "coding",
        "traveling"
    ]
}
```

### 모델 클래스
```Dart
part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final int age;
  final List<String> hobbies;

  User({required this.name, required this.age, required this.hobbies});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### 터미널
```bash
Name : John Doe, Age : 30, Hobbies : [reading, coding, traveling]
```
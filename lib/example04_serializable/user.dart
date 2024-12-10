
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

/// flutter pub run build_runner build
@JsonSerializable()
class User {
  final String name;
  final int age;
  final List<String> hobbies;

  User({required this.name, required this.age, required this.hobbies});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'Name : $name, Age : $age, Hobbies : ${hobbies.toList().toString()}';
  }
}

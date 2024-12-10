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

  Map<String, dynamic> toJson() {
    return {'name': name, 'age': age, 'hobbies': hobbies};
  }

  @override
  String toString() {
    return 'Name : $name, Age : $age, Hobbies : ${hobbies.toList().toString()}';
  }
}

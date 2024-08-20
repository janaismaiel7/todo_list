class Myuser {
  static const String collecationName = 'users';
  String name;
  String email;
  String id;
  Myuser({required this.id, required this.email, required this.name});
  //json to object
  Myuser.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'] as String,
          name: data['name'] as String,
          email: data['email'] as String,
        );

  //object to json
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

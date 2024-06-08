class Admin {
  int id;
  late String username;
  late String password;

  Admin({required this.id, required this.username, required this.password, } );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }
   // Add this factory method
  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map['id'],
      username: map['username'],
      password: map['password'],
    );
  }
}

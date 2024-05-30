class Admin {
  int? id;
  late String username;
  late String password;

  Admin({this.id, required this.username, required this.password,} );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }
}

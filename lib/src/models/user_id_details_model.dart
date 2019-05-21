class UserDetailsbyID {
  String id;
  String username;
  String fullname;
  String tipe_user;
  String password;
  String email;
  String contact;

  UserDetailsbyID(String id, String username, String fullname, String tipe_user, String password, String email, String contact) {
    id = id;
    username = username;
    fullname = fullname;
    tipe_user = tipe_user;
    password = password;
    email = email;
    contact = contact;
  }

  UserDetailsbyID.fromJson(Map json)
    : id = json['id'],
      username = json['username'],
      fullname = json['fullname'],
      tipe_user = json['tipe_user'],
      password = json['password'],
      email = json['email'],
      contact = json['contact'];

  Map toJson() {
    return {
      'id': id,
      'username': username,
      'fullname': fullname,
      'tipe_user': tipe_user,
      'password': password,
      'email': email,
      'contact': contact
    };
  }
}
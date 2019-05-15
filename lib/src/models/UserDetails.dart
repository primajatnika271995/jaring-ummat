class UserDetails {
  String id_user;
  String email;
  String fullname;
  String contact;
  String profile_picture;
  String path_file;

  UserDetailskeykey(String id, String email, String fullname, String contact, String profile_picture, String path_file) {
    this.id_user = id;
    this.email = email;
    this.fullname = fullname;
    this.contact = contact;
    this.profile_picture = profile_picture;
    this.path_file = path_file;
  }

  UserDetails.fromJson(Map json)
      : id_user = json["id_user"],
        email = json["email"],
        fullname = json["fullname"],
        contact = json["contact"],
  path_file = json["file_path"],
        profile_picture = json["content"];

  Map toJson() {
    return {
      'id_user': id_user,
      'email': email,
      'fullname': fullname,
      'contact': contact,
      'file_path': path_file,
      'content': profile_picture
    };
  }
}

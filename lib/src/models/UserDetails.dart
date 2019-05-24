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


class FacebookUserDetails {
  String name;
  String first_name;
  String last_name;
  String email;
  String id;

  FacebookUserDetails(String name, String first, String last, String email, String id) {
    this.name = name;
    this.first_name = first;
    this.last_name = last;
    this.email = email;
    this.id = id;
  }

  FacebookUserDetails.fromJson(Map json)
    : name = json['name'],
      first_name = json['first_name'],
      last_name = json['last_name'],
      email = json['email'],
      id = json['id'];

  Map toJson() {
    return {
      'name': name,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'id': id
    };
  }
}

class GoogleDetails {
  final String providerDetails;
  final String username;
  final String phtoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  GoogleDetails(this.providerDetails, this.userEmail, this.phtoUrl,
      this.username, this.providerData);
}

class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}
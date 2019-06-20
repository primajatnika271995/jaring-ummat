// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'dart:convert';

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  String userId;
  String email;
  String fullname;
  String contact;
  List<ImgProfile> imgProfile;

  UserDetails({
    this.userId,
    this.email,
    this.fullname,
    this.contact,
    this.imgProfile,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => new UserDetails(
    userId: json["userId"],
    email: json["email"],
    fullname: json["fullname"],
    contact: json["contact"],
    imgProfile: new List<ImgProfile>.from(json["imgProfile"].map((x) => ImgProfile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "email": email,
    "fullname": fullname,
    "contact": contact,
    "imgProfile": new List<dynamic>.from(imgProfile.map((x) => x.toJson())),
  };
}

class ImgProfile {
  String id;
  dynamic thumbnailUrl;
  dynamic videoUrl;
  String imgUrl;
  int createdDate;
  dynamic createdBy;

  ImgProfile({
    this.id,
    this.thumbnailUrl,
    this.videoUrl,
    this.imgUrl,
    this.createdDate,
    this.createdBy,
  });

  factory ImgProfile.fromJson(Map<String, dynamic> json) => new ImgProfile(
    id: json["id"],
    thumbnailUrl: json["thumbnailUrl"],
    videoUrl: json["videoUrl"],
    imgUrl: json["imgUrl"],
    createdDate: json["createdDate"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "thumbnailUrl": thumbnailUrl,
    "videoUrl": videoUrl,
    "imgUrl": imgUrl,
    "createdDate": createdDate,
    "createdBy": createdBy,
  };
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
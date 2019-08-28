// To parse this JSON data, do
//
//     final muzakkiUserDetails = muzakkiUserDetailsFromJson(jsonString);

import 'dart:convert';

MuzakkiUserDetails muzakkiUserDetailsFromJson(String str) => MuzakkiUserDetails.fromJson(json.decode(str));

String muzakkiUserDetailsToJson(MuzakkiUserDetails data) => json.encode(data.toJson());

class MuzakkiUserDetails {
    String userId;
    String email;
    String fullname;
    String contact;
    List<ImgProfile> imgProfile;

    MuzakkiUserDetails({
        this.userId,
        this.email,
        this.fullname,
        this.contact,
        this.imgProfile,
    });

    factory MuzakkiUserDetails.fromJson(Map<String, dynamic> json) => new MuzakkiUserDetails(
        userId: json["userId"] == null ? null : json["userId"],
        email: json["email"] == null ? null : json["email"],
        fullname: json["fullname"] == null ? null : json["fullname"],
        contact: json["contact"] == null ? null : json["contact"],
        imgProfile: json["imgProfile"] == null ? null : new List<ImgProfile>.from(json["imgProfile"].map((x) => ImgProfile.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "email": email == null ? null : email,
        "fullname": fullname == null ? null : fullname,
        "contact": contact == null ? null : contact,
        "imgProfile": imgProfile == null ? null : new List<dynamic>.from(imgProfile.map((x) => x.toJson())),
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
        id: json["id"] == null ? null : json["id"],
        thumbnailUrl: json["thumbnailUrl"],
        videoUrl: json["videoUrl"],
        imgUrl: json["imgUrl"] == null ? null : json["imgUrl"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        createdBy: json["createdBy"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "thumbnailUrl": thumbnailUrl,
        "videoUrl": videoUrl,
        "imgUrl": imgUrl == null ? null : imgUrl,
        "createdDate": createdDate == null ? null : createdDate,
        "createdBy": createdBy,
    };
}

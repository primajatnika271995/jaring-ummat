// To parse this JSON data, do
//
//     final bookmarkModel = bookmarkModelFromJson(jsonString);

import 'dart:convert';

BookmarkModel bookmarkModelFromJson(String str) => BookmarkModel.fromJson(json.decode(str));

String bookmarkModelToJson(BookmarkModel data) => json.encode(data.toJson());

class BookmarkModel {
  List<ListProgram> listProgram;
  List<ListBerita> listBerita;

  BookmarkModel({
    this.listProgram,
    this.listBerita,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) => BookmarkModel(
    listProgram: json["listProgram"] == null ? null : List<ListProgram>.from(json["listProgram"].map((x) => ListProgram.fromJson(x))),
    listBerita: json["listBerita"] == null ? null : List<ListBerita>.from(json["listBerita"].map((x) => ListBerita.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listProgram": listProgram == null ? null : List<dynamic>.from(listProgram.map((x) => x.toJson())),
    "listBerita": listBerita == null ? null : List<dynamic>.from(listBerita.map((x) => x.toJson())),
  };
}

class ListBerita {
  String idUser;
  String username;
  String idBerita;
  bool likeThis;
  bool bookmarkThis;
  String titleBerita;
  String descriptionBerita;
  String categoryBerita;
  List<ImageContent> imageContent;
  int createdDate;
  String createdBy;
  int totalLikes;
  int totalComment;

  ListBerita({
    this.idUser,
    this.username,
    this.idBerita,
    this.likeThis,
    this.bookmarkThis,
    this.titleBerita,
    this.descriptionBerita,
    this.categoryBerita,
    this.imageContent,
    this.createdDate,
    this.createdBy,
    this.totalLikes,
    this.totalComment,
  });

  factory ListBerita.fromJson(Map<String, dynamic> json) => ListBerita(
    idUser: json["idUser"] == null ? null : json["idUser"],
    username: json["username"] == null ? null : json["username"],
    idBerita: json["idBerita"] == null ? null : json["idBerita"],
    likeThis: json["likeThis"] == null ? null : json["likeThis"],
    bookmarkThis: json["bookmarkThis"] == null ? null : json["bookmarkThis"],
    titleBerita: json["titleBerita"] == null ? null : json["titleBerita"],
    descriptionBerita: json["descriptionBerita"] == null ? null : json["descriptionBerita"],
    categoryBerita: json["categoryBerita"] == null ? null : json["categoryBerita"],
    imageContent: json["imageContent"] == null ? null : List<ImageContent>.from(json["imageContent"].map((x) => ImageContent.fromJson(x))),
    createdDate: json["createdDate"] == null ? null : json["createdDate"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    totalLikes: json["totalLikes"] == null ? null : json["totalLikes"],
    totalComment: json["totalComment"] == null ? null : json["totalComment"],
  );

  Map<String, dynamic> toJson() => {
    "idUser": idUser == null ? null : idUser,
    "username": username == null ? null : username,
    "idBerita": idBerita == null ? null : idBerita,
    "likeThis": likeThis == null ? null : likeThis,
    "bookmarkThis": bookmarkThis == null ? null : bookmarkThis,
    "titleBerita": titleBerita == null ? null : titleBerita,
    "descriptionBerita": descriptionBerita == null ? null : descriptionBerita,
    "categoryBerita": categoryBerita == null ? null : categoryBerita,
    "imageContent": imageContent == null ? null : List<dynamic>.from(imageContent.map((x) => x.toJson())),
    "createdDate": createdDate == null ? null : createdDate,
    "createdBy": createdBy == null ? null : createdBy,
    "totalLikes": totalLikes == null ? null : totalLikes,
    "totalComment": totalComment == null ? null : totalComment,
  };
}

class ImageContent {
  String id;
  String idUser;
  String resourceType;
  String urlType;
  String url;
  int createdDate;
  String createdBy;
  String urlThumbnail;
  String publicId;
  String formatFile;

  ImageContent({
    this.id,
    this.idUser,
    this.resourceType,
    this.urlType,
    this.url,
    this.createdDate,
    this.createdBy,
    this.urlThumbnail,
    this.publicId,
    this.formatFile,
  });

  factory ImageContent.fromJson(Map<String, dynamic> json) => ImageContent(
    id: json["id"] == null ? null : json["id"],
    idUser: json["idUser"] == null ? null : json["idUser"],
    resourceType: json["resourceType"] == null ? null : json["resourceType"],
    urlType: json["urlType"] == null ? null : json["urlType"],
    url: json["url"] == null ? null : json["url"],
    createdDate: json["createdDate"] == null ? null : json["createdDate"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    urlThumbnail: json["urlThumbnail"] == null ? null : json["urlThumbnail"],
    publicId: json["publicId"] == null ? null : json["publicId"],
    formatFile: json["formatFile"] == null ? null : json["formatFile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "idUser": idUser == null ? null : idUser,
    "resourceType": resourceType == null ? null : resourceType,
    "urlType": urlType == null ? null : urlType,
    "url": url == null ? null : url,
    "createdDate": createdDate == null ? null : createdDate,
    "createdBy": createdBy == null ? null : createdBy,
    "urlThumbnail": urlThumbnail == null ? null : urlThumbnail,
    "publicId": publicId == null ? null : publicId,
    "formatFile": formatFile == null ? null : formatFile,
  };
}

class ListProgram {
  User user;
  dynamic idLembagaAmal;
  dynamic username;
  dynamic idProgram;
  bool userLikeThis;
  bool bookmarkThis;
  dynamic titleProgram;
  dynamic descriptionProgram;
  dynamic categoryProgram;
  dynamic totalDonation;
  dynamic targetDonation;
  dynamic endDate;
  dynamic totalLikes;
  dynamic totalComments;
  List<ImageContent> imageContent;
  dynamic createdBy;
  dynamic createdDate;
  bool btnKirimDonasi;

  ListProgram({
    this.user,
    this.idLembagaAmal,
    this.username,
    this.idProgram,
    this.userLikeThis,
    this.bookmarkThis,
    this.titleProgram,
    this.descriptionProgram,
    this.categoryProgram,
    this.totalDonation,
    this.targetDonation,
    this.endDate,
    this.totalLikes,
    this.totalComments,
    this.imageContent,
    this.createdBy,
    this.createdDate,
    this.btnKirimDonasi,
  });

  factory ListProgram.fromJson(Map<String, dynamic> json) => ListProgram(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    idLembagaAmal: json["idLembagaAmal"] == null ? null : json["idLembagaAmal"],
    username: json["username"] == null ? null : json["username"],
    idProgram: json["idProgram"] == null ? null : json["idProgram"],
    userLikeThis: json["userLikeThis"] == null ? null : json["userLikeThis"],
    bookmarkThis: json["bookmarkThis"] == null ? null : json["bookmarkThis"],
    titleProgram: json["titleProgram"] == null ? null : json["titleProgram"],
    descriptionProgram: json["descriptionProgram"] == null ? null : json["descriptionProgram"],
    categoryProgram: json["categoryProgram"] == null ? null : json["categoryProgram"],
    totalDonation: json["totalDonation"] == null ? null : json["totalDonation"],
    targetDonation: json["targetDonation"] == null ? null : json["targetDonation"],
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    totalLikes: json["totalLikes"] == null ? null : json["totalLikes"],
    totalComments: json["totalComments"] == null ? null : json["totalComments"],
    imageContent: json["imageContent"] == null ? null : List<ImageContent>.from(json["imageContent"].map((x) => ImageContent.fromJson(x))),
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdDate: json["createdDate"] == null ? null : json["createdDate"],
    btnKirimDonasi: json["btnKirimDonasi"] == null ? null : json["btnKirimDonasi"],
  );

  Map<String, dynamic> toJson() => {
    "user": user == null ? null : user.toJson(),
    "idLembagaAmal": idLembagaAmal == null ? null : idLembagaAmal,
    "username": username == null ? null : username,
    "idProgram": idProgram == null ? null : idProgram,
    "userLikeThis": userLikeThis == null ? null : userLikeThis,
    "bookmarkThis": bookmarkThis == null ? null : bookmarkThis,
    "titleProgram": titleProgram == null ? null : titleProgram,
    "descriptionProgram": descriptionProgram == null ? null : descriptionProgram,
    "categoryProgram": categoryProgram == null ? null : categoryProgram,
    "totalDonation": totalDonation == null ? null : totalDonation,
    "targetDonation": targetDonation == null ? null : targetDonation,
    "endDate": endDate == null ? null : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "totalLikes": totalLikes == null ? null : totalLikes,
    "totalComments": totalComments == null ? null : totalComments,
    "imageContent": imageContent == null ? null : List<dynamic>.from(imageContent.map((x) => x.toJson())),
    "createdBy": createdBy == null ? null : createdBy,
    "createdDate": createdDate == null ? null : createdDate,
    "btnKirimDonasi": btnKirimDonasi == null ? null : btnKirimDonasi,
  };
}

class User {
  String userId;
  String email;
  String fullname;
  String contact;
  String alamat;
  String kotaTinggal;
  dynamic longitudeTinggal;
  dynamic latitudeTinggal;
  String kotaLahir;
  dynamic longitudeLahir;
  dynamic latitudeLahir;
  String lokasiAmal;
  String kabupaten;
  String provinsi;
  dynamic tanggalLahir;
  String tipeAkun;
  String imageUrl;
  dynamic kabupatenLahir;
  dynamic provinsiLahir;
  int followingCount;

  User({
    this.userId,
    this.email,
    this.fullname,
    this.contact,
    this.alamat,
    this.kotaTinggal,
    this.longitudeTinggal,
    this.latitudeTinggal,
    this.kotaLahir,
    this.longitudeLahir,
    this.latitudeLahir,
    this.lokasiAmal,
    this.kabupaten,
    this.provinsi,
    this.tanggalLahir,
    this.tipeAkun,
    this.imageUrl,
    this.kabupatenLahir,
    this.provinsiLahir,
    this.followingCount,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["userId"] == null ? null : json["userId"],
    email: json["email"] == null ? null : json["email"],
    fullname: json["fullname"] == null ? null : json["fullname"],
    contact: json["contact"] == null ? null : json["contact"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    kotaTinggal: json["kotaTinggal"] == null ? null : json["kotaTinggal"],
    longitudeTinggal: json["longitudeTinggal"],
    latitudeTinggal: json["latitudeTinggal"],
    kotaLahir: json["kotaLahir"] == null ? null : json["kotaLahir"],
    longitudeLahir: json["longitudeLahir"],
    latitudeLahir: json["latitudeLahir"],
    lokasiAmal: json["lokasiAmal"] == null ? null : json["lokasiAmal"],
    kabupaten: json["kabupaten"] == null ? null : json["kabupaten"],
    provinsi: json["provinsi"] == null ? null : json["provinsi"],
    tanggalLahir: json["tanggalLahir"],
    tipeAkun: json["tipeAkun"] == null ? null : json["tipeAkun"],
    imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
    kabupatenLahir: json["kabupatenLahir"],
    provinsiLahir: json["provinsiLahir"],
    followingCount: json["followingCount"] == null ? null : json["followingCount"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId == null ? null : userId,
    "email": email == null ? null : email,
    "fullname": fullname == null ? null : fullname,
    "contact": contact == null ? null : contact,
    "alamat": alamat == null ? null : alamat,
    "kotaTinggal": kotaTinggal == null ? null : kotaTinggal,
    "longitudeTinggal": longitudeTinggal,
    "latitudeTinggal": latitudeTinggal,
    "kotaLahir": kotaLahir == null ? null : kotaLahir,
    "longitudeLahir": longitudeLahir,
    "latitudeLahir": latitudeLahir,
    "lokasiAmal": lokasiAmal == null ? null : lokasiAmal,
    "kabupaten": kabupaten == null ? null : kabupaten,
    "provinsi": provinsi == null ? null : provinsi,
    "tanggalLahir": tanggalLahir,
    "tipeAkun": tipeAkun == null ? null : tipeAkun,
    "imageUrl": imageUrl == null ? null : imageUrl,
    "kabupatenLahir": kabupatenLahir,
    "provinsiLahir": provinsiLahir,
    "followingCount": followingCount == null ? null : followingCount,
  };
}

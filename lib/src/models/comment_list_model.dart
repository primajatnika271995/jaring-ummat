class CommentList {
  String idUser;
  String fullname;
  String title;
  String komentar;
  int createdDate;

  CommentList(String idUser, String fullname, String title, String komentar, int createdDate) {
    idUser = idUser;
    fullname = fullname;
    title = title;
    komentar = komentar;
    createdDate = createdDate;
  }

  CommentList.fromJson(Map json)
    : idUser = json['idUser'],
      fullname = json['fullname'],
      title = json['title'],
      komentar = json['komentar'],
      createdDate = json['createdDate'];

  Map toJson() {
    return {
      'idUser': idUser,
      'fullname': fullname,
      'title': title,
      'komentar': komentar,
      'createdDate': createdDate
    };
  }
}
class CommentList {
  String idUser;
  String title;
  String komentar;
  int createdDate;

  CommentList(String idUser, String title, String komentar, int createdDate) {
    idUser = idUser;
    title = title;
    komentar = komentar;
    createdDate = createdDate;
  }

  CommentList.fromJson(Map json)
    : idUser = json['idUser'],
      title = json['title'],
      komentar = json['komentar'],
      createdDate = json['createdDate'];

  Map toJson() {
    return {
      'idUser': idUser,
      'title': title,
      'komentar': komentar,
      'createdDate': createdDate
    };
  }
}
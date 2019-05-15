class NewsModel {
  String id;
  String idUser;
  String title;
  String description;
  List<dynamic> imageContent;
  String imageProfile;
  String createdBy;
  int createdDate;

  NewsModel(
      String id,
      String idUser,
      String title,
      String imageProfile,
      String description,
      List<dynamic> imageContent,
      String createdBy,
      int createdDate) {
    this.id = id;
    this.idUser = idUser;
    this.title = title;
    this.imageProfile = imageProfile;
    this.description = description;
    this.imageContent = imageContent;
    this.createdBy = createdBy;
    this.createdDate = createdDate;
  }

  NewsModel.fromJson(Map json)
      : id = json["id"],
        idUser = json["idUser"],
        title = json["title"],
        imageProfile = json["imageProfile"],
        description = json["description"],
        imageContent = json["imageContent"],
        createdBy = json["createdBy"],
        createdDate = json["createdDate"];

  Map toJson() {
    return {
      'id': id,
      'idUser': idUser,
      'title': title,
      'imageProfile': imageProfile,
      'description': description,
      'imageContent': imageContent,
      'createdBy': createdBy,
      'createdDate': createdDate
    };
  }
}

class ProgramAmalModel {
  String id;
  String idUser;
  String titleProgram;
  String descriptionProgram;
  double totalDonasi;
  List<dynamic> imageContent;
  double targetDonasi;
  String endDonasi;
  String createdBy;
  int createdDate;

  ProgramAmalModel(
      String id,
      String idUser,
      String titleProgram,
      String descriptionProgram,
      double totalDonasi,
      List<dynamic> imageContent,
      double targetDonasi,
      String endDonasi,
      String createdBy,
      int createdDate) {
    this.id = id;
    this.idUser = idUser;
    this.titleProgram = titleProgram;
    this.descriptionProgram = descriptionProgram;
    this.totalDonasi = totalDonasi;
    this.imageContent = imageContent;
    this.targetDonasi = targetDonasi;
    this.endDonasi = endDonasi;
    this.createdBy = createdBy;
    this.createdDate = createdDate;
  }

  ProgramAmalModel.fromJson(Map json)
      : id = json['id'],
        idUser = json['idUser'],
        titleProgram = json['titleProgram'],
        descriptionProgram = json['descriptionProgram'],
        totalDonasi = json['totalDonasi'],
        imageContent = json['imageContent'],
        targetDonasi = json['targetDonasi'],
        endDonasi = json['endDonasi'],
        createdBy = json['createdBy'],
        createdDate = json['createdDate'];

  Map toJSON() {
    return {
      "id": id,
      "idUser": idUser,
      "titleProgram": titleProgram,
      "descriptionProgram": descriptionProgram,
      "totalDonasi": totalDonasi,
      "imageContent": imageContent,
      "targetDonasi": targetDonasi,
      "endDonasi": endDonasi,
      "createdDate": createdDate,
      "createdBy": createdBy
    };
  }
}

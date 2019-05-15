class ProgramAmalModel {
  final String id;
  final String idUser;
  final String titleProgram;
  final String descriptionProgram;
  final double totalDonasi;
  final double targetDonasi;
  final String endDonasi;
  final String createdBy;
  final int createdDate;

  ProgramAmalModel(
      {this.id,
        this.idUser,
        this.titleProgram,
        this.descriptionProgram,
        this.totalDonasi,
        this.targetDonasi,
        this.endDonasi,
        this.createdBy,
        this.createdDate});

  ProgramAmalModel.fromJson(Map json)
      : id = json['id'],
        idUser = json['idUser'],
        titleProgram = json['titleProgram'],
        descriptionProgram = json['descriptionProgram'],
        totalDonasi = json['totalDonasi'],
        targetDonasi = json['targetDonasi'],
        endDonasi = json['endDonasi'],
        createdBy = json['createdBy'],
        createdDate = json['createdDate'];


  Map<String, dynamic> toJSON() => {
    "id": id,
    "idUser": idUser,
    "titleProgram": titleProgram,
    "descriptionProgram": descriptionProgram,
    "totalDonasi": totalDonasi,
    "targetDonasi": targetDonasi,
    "endDonasi": endDonasi,
    "createdDate": createdDate,
    "createdBy": createdBy
  };
}

class PostRegistration {
  String fullname;
  String tipe_user;
  String username;
  String email;
  String password;
  String contact;

  PostRegistration({this.fullname, this.tipe_user, this.username, this.email, this.password, this.contact});
}

class PostProgramAmal {
  String idUser;
  String titleProgram;
  String category;
  String descriptionProgram;
  String totalDonasi;
  String targetDonasi;
  String endDonasi;
  String createdBy;

  PostProgramAmal({this.idUser, this.titleProgram, this.category, this.descriptionProgram, this.totalDonasi, this.targetDonasi, this.endDonasi, this.createdBy});
}
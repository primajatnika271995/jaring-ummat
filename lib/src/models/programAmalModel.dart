import 'package:equatable/equatable.dart';

class ProgramAmal extends Equatable {
    final String id;
    final String idUser;
    final String idUserLike;
    final String titleProgram;
    final String category;
    final String endDonasi;
    final double targetDonasi;
    final double totalDonasi;
    final String descriptionProgram;
    final List<dynamic> imageContent;
    final int createdDate;
    final String createdBy;
    final int totalComment;
    final int totalLikes;

    ProgramAmal({
        this.id,
        this.idUser,
        this.idUserLike,
        this.titleProgram,
        this.category,
        this.endDonasi,
        this.targetDonasi,
        this.totalDonasi,
        this.descriptionProgram,
        this.imageContent,
        this.createdDate,
        this.createdBy,
        this.totalComment,
        this.totalLikes,
    }) : super([id, idUser, idUserLike, titleProgram, category, endDonasi, targetDonasi, totalDonasi, descriptionProgram, imageContent, createdDate, createdBy, totalComment, totalLikes]);

  @override
  String toString() => 'Post { id: $id }';
}
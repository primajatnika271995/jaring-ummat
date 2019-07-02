import 'package:equatable/equatable.dart';

class Berita extends Equatable {
  final String id;
  final String idUser;
  final String idUserLike; 
  final String title;
  final String category;
  final String description;
  final List<dynamic> imageContent;
  final int createdDate;
  final String createdBy;
  final int totalComment;
  int totalLikes;

  Berita({this.id, 
        this.idUser, 
        this.idUserLike, 
        this.title, 
        this.category, 
        this.description, 
        this.imageContent, 
        this.createdDate,
        this.createdBy,
        this.totalComment,
        this.totalLikes}) : super([id, idUser, idUserLike, title, category, description, imageContent, createdDate, createdBy, totalComment, totalLikes]);

  @override
  String toString() => 'Post { id: $id }';
}
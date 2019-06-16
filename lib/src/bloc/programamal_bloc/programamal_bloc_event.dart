import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProgramamalBlocEvent extends Equatable {}

class Fetch extends ProgramamalBlocEvent {

  @override
  String toString() => 'Fetch';
}
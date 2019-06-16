import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BeritaEvent extends Equatable {}

class Fetch extends BeritaEvent {

  @override
  String toString() => 'Fetch';
}

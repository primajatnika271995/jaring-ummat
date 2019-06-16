import 'package:equatable/equatable.dart';
import 'package:flutter_jaring_ummat/src/models/programAmalModel.dart';

abstract class ProgramamalBlocState extends Equatable {
  ProgramamalBlocState([List props = const []]) : super(props);
}

class ProgramAmalUninitialized extends ProgramamalBlocState {
  @override
  String toString() => 'PostUninitialized';
}

class ProgramAmalError extends ProgramamalBlocState {
  @override
  String toString() => 'ProgramAmalError';
}

class ProgramAmalLoaded extends ProgramamalBlocState {
  final List<ProgramAmal> programAmal;
  final bool hasReachedMax;

  ProgramAmalLoaded({
    this.programAmal,
    this.hasReachedMax,
  }) : super([programAmal, hasReachedMax]);

  ProgramAmalLoaded copyWith({
    List<ProgramAmal> programAmal,
    bool hasReachedMax,
  }) {
    return ProgramAmalLoaded(
      programAmal: programAmal ?? this.programAmal,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() => 'PostLoaded { programAmal: ${programAmal.length}, hasReachedMax: $hasReachedMax }';
}

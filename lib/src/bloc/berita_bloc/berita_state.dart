import 'package:equatable/equatable.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';

abstract class BeritaState extends Equatable {
  BeritaState([List props = const []]) : super(props);
}

class BeritaUninitialized extends BeritaState {
  @override
  String toString() => 'PostUninitialized';
}

class BeritaError extends BeritaState {
  @override
  String toString() => 'BeritaError';
}

class BeritaLoaded extends BeritaState {
  final List<Berita> berita;
  final bool hasReachedMax;

  BeritaLoaded({
    this.berita,
    this.hasReachedMax,
  }) : super([berita, hasReachedMax]);

  BeritaLoaded copyWith({
    List<Berita> berita,
    bool hasReachedMax,
  }) {
    return BeritaLoaded(
      berita: berita ?? this.berita,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() => 'PostLoaded { berita: ${berita.length}, hasReachedMax: $hasReachedMax }';
}

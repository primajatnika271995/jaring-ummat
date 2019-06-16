import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita_content.dart';
import 'package:flutter_jaring_ummat/src/bloc/berita_bloc/bloc.dart';

import 'bottom_loader.dart';

class BeritaContainer extends StatefulWidget {
  @override
  _BeritaContainerState createState() => _BeritaContainerState();
}

class _BeritaContainerState extends State<BeritaContainer> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  BeritaBloc _beritaBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _beritaBloc = BlocProvider.of<BeritaBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _beritaBloc,
      builder: (BuildContext context, BeritaState state) {
        if (state is BeritaUninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is BeritaError) {
          return Center(
            child: Text('failed to fetch berita'),
          );
        }
        if (state is BeritaLoaded) {
          if (state.berita.isEmpty) {
            return Center(
              child: Text('No Content Available'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.berita.length
                  ? BottomLoader()
                  : BeritaContent(berita: state.berita[index]);
            }, 
            itemCount: state.hasReachedMax
                  ? state.berita.length
                  : state.berita.length + 1,
            controller: _scrollController,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _beritaBloc.dispatch(Fetch());
    }
  }
}
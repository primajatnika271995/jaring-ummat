import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jaring_ummat/src/bloc/programamal_bloc/bloc.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/bottom_loader.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal_content.dart';

class ProgramAmalContainer extends StatefulWidget {
  @override
  _ProgramAmalContainerState createState() => _ProgramAmalContainerState();
}

class _ProgramAmalContainerState extends State<ProgramAmalContainer> {

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  ProgramamalBlocBloc _programAmalBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _programAmalBloc = BlocProvider.of<ProgramamalBlocBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _programAmalBloc,
      builder: (BuildContext context, ProgramamalBlocState state) {
      if (state is ProgramAmalUninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProgramAmalError) {
          return Center(
            child: Text('failed to fetch Program Amal'),
          );
        }
        if (state is ProgramAmalLoaded) {
          if (state.programAmal.isEmpty) {
            return Center(
              child: Text('No Content Available'),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              print(state.programAmal[index].titleProgram);
              return index >= state.programAmal.length
                  ? BottomLoader()
                  : ProgramAmalContent(programAmal: state.programAmal[index]);
            }, 
            itemCount: state.hasReachedMax
                  ? state.programAmal.length
                  : state.programAmal.length + 1,
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
      _programAmalBloc.dispatch(Fetch());
    }
  }
}
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_recomendations/providers/single_movie_provider.dart';

import 'swipe_state.dart';

part 'swipe_event.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(SwipeLoading());

  @override
  Stream<SwipeState> mapEventToState(
    SwipeEvent event,
  ) async* {
    if (event is LoadMoviesEvent) {
      yield* _mapLoadUsersToState(event);
    }
    if (event is SwipeLeftEvent) {
      yield* _mapSwipeLeftEventToState(event, state);
    }
    if (event is SwipeRightEvent) {
      yield* _mapSwipeRightEventToState(event, state);
    }
  }

  Stream<SwipeState> _mapLoadUsersToState(
    LoadMoviesEvent event,
  ) async* {
    yield SwipeLoaded(movies: event.movies);
  }

  Stream<SwipeState> _mapSwipeLeftEventToState(
    SwipeLeftEvent event,
    SwipeState state,
  ) async* {
    if (state is SwipeLoaded) {
      try {
        yield SwipeLoaded(movies: List.from(state.movies)..remove(event.movie));
      } catch (_) {}
    }
  }

  Stream<SwipeState> _mapSwipeRightEventToState(
    SwipeRightEvent event,
    SwipeState state,
  ) async* {
    if (state is SwipeLoaded) {
      try {
        yield SwipeLoaded(movies: List.from(state.movies)..remove(event.movie));
      } catch (_) {}
    }
  }
}

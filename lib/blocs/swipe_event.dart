part of 'swipe_block.dart';

abstract class SwipeEvent extends Equatable {
  const SwipeEvent();

  @override
  List<Object> get props => [];
}

class LoadMoviesEvent extends SwipeEvent {
  final List<Movie> movies;

  LoadMoviesEvent({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}

class SwipeLeftEvent extends SwipeEvent {
  final Movie movie;

  SwipeLeftEvent({
    required this.movie,
  });

  @override
  List<Object> get props => [movie];
}

class SwipeRightEvent extends SwipeEvent {
  final Movie movie;

  SwipeRightEvent({
    required this.movie,
  });

  @override
  List<Object> get props => [movie];
}

import 'package:equatable/equatable.dart';
import '../providers/single_movie_provider.dart';

abstract class SwipeState extends Equatable {
  const SwipeState();

  @override
  List<Object> get props => [];
}

class SwipeLoading extends SwipeState {}

class SwipeLoaded extends SwipeState {
  final List<Movie> movies;

  SwipeLoaded({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}

class SwipeError extends SwipeState {}

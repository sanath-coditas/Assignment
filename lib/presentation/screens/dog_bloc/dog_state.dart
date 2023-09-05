part of 'dog_bloc.dart';


sealed class DogState {}

final class DogInitial extends DogState {}

final class DogLoading extends DogState {}

final class DogSuccess extends DogState {
  final String imageUrl;
  DogSuccess({required this.imageUrl});
}

final class DogFailure extends DogState {}

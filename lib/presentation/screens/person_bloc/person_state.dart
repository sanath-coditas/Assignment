part of 'person_bloc.dart';

sealed class PersonState {}

final class PersonInitial extends PersonState {}

final class PersonLoading extends PersonState {}

final class PersonSuccess extends PersonState {
  final PersonModel personModel;
  PersonSuccess({required this.personModel});
}

final class PersonFailure extends PersonState {}

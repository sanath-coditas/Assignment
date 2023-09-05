import 'dart:convert';

import 'package:fininfocom_assessment/data/models/person_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final http.Client _client = http.Client();
  PersonBloc() : super(PersonInitial()) {
    on<PersonEvent>((event, emit) {});
    on<GetPerson>((event, emit) async {
      emit(PersonLoading());
      try {
        final response =
            await _client.get(Uri.parse('https://randomuser.me/api/'));
        if (response.statusCode == 200) {
          emit(
            PersonSuccess(
              personModel:
                  PersonModel.fromJson(jsonDecode(response.body)["results"][0]),
            ),
          );
        } else {
          emit(PersonFailure());
        }
      } catch (e) {
        emit(PersonFailure());
      }
    });
  }
}

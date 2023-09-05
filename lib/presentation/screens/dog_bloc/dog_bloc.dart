import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'dog_event.dart';
part 'dog_state.dart';

class DogBloc extends Bloc<DogEvent, DogState> {
  final http.Client _client = http.Client();
  DogBloc() : super(DogInitial()) {
    on<DogEvent>((event, emit) {});
    on<GetImageEvent>((event, emit) async {
      emit(DogLoading());
      try {
        final response = await _client
            .get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
        if (response.statusCode == 200) {
          emit(DogSuccess(imageUrl: jsonDecode(response.body)['message']));
        }
      } catch (e) {
        emit(DogFailure());
      }
    });
  }
}

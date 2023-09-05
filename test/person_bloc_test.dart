import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:fininfocom_assessment/data/models/person_model.dart';
import 'package:fininfocom_assessment/presentation/screens/person_bloc/person_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([http.Client])
void main() {
  group('PersonBloc', () {
    late PersonBloc personBloc;
    late MockClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockClient(
        (request) async {
          return await Future.delayed(Duration.zero);
        },
      );
      personBloc = PersonBloc();
      
    });

    tearDown(() {
      personBloc.close();
    });

    test('initial state is PersonInitial', () {
      expect(personBloc.state, equals(PersonInitial()));
    });

    blocTest<PersonBloc, PersonState>(
      'emits [PersonLoading, PersonSuccess] when GetPerson is added successfully',
      build: () {
        when(mockHttpClient.get(Uri.parse('https://randomuser.me/api/')))
            .thenAnswer((_) async => http.Response(
                  jsonEncode({
                    'results': [PersonModel]
                  }),
                  200,
                ));
        return personBloc;
      },
      act: (bloc) => bloc.add(GetPerson()),
      expect: () => [
        PersonLoading(),
        PersonSuccess(
          personModel: PersonModel(
              Name('title', 'first', 'last'),
              Location('city', 'state', 'country'),
              'email',
              DateOfBirth('date'),
              Registered('date'),
              Picture('large')),
        ),
      ],
    );

    blocTest<PersonBloc, PersonState>(
      'emits [PersonLoading, PersonFailure] when GetPerson fails',
      build: () {
        when(mockHttpClient.get(Uri.parse('https://randomuser.me/api/')))
            .thenThrow(Exception('An error occurred'));
        return personBloc;
      },
      act: (bloc) => bloc.add(GetPerson()),
      expect: () => [
        PersonLoading(),
        PersonFailure(),
      ],
    );
  });
}

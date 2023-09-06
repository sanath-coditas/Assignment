import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:fininfocom_assessment/presentation/screens/person_bloc/person_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'person_bloc_test.mocks.dart' as mocks;

@GenerateMocks([http.Client])
void main() {
  group('PersonBloc', () {
    late PersonBloc personBloc;
    late mocks.MockClient mockHttpClient;

    setUp(() {
      mockHttpClient = mocks.MockClient();
      personBloc = PersonBloc();
    });

    tearDown(() {
      personBloc.close();
    });

    test('initial state is PersonInitial', () {
      expect(personBloc.state, isA<PersonInitial>());
    });

    blocTest<PersonBloc, PersonState>(
      'emits [PersonLoading,PersonSuccess] when GetPerson is Successful',
      build: () {
        when(mockHttpClient.get(Uri.parse('https://randomuser.me/api/')))
            .thenAnswer((_) async {
          return http.Response(
            jsonEncode({
              'results': [""]
            }),
            200,
          );
        });
        return personBloc;
      },
      act: (bloc) => bloc.add(GetPerson()),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<PersonLoading>(),
        isA<PersonSuccess>(),
      ],
    );

    blocTest<PersonBloc, PersonState>(
      'emits [PersonLoading, PersonFailure] when GetPerson fails',
      build: () {
        when(mockHttpClient.get(Uri.parse('https://randomuser.me/api/')))
            .thenThrow(
          (realInvocation) async => http.Response('body', 400),
        );
        return personBloc;
      },
      act: (bloc) => bloc.add(GetPerson()),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<PersonLoading>(),
        isA<PersonSuccess>(),
      ],
    );
  });
}

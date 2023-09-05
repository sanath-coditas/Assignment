import 'package:fininfocom_assessment/data/models/person_model.dart';
import 'package:fininfocom_assessment/presentation/screens/person_bloc/person_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => PersonBloc(),
        child: BlocBuilder<PersonBloc, PersonState>(
          builder: (context, state) {
            if (state is PersonInitial) {
              context.read<PersonBloc>().add(GetPerson());
            }
            if (state is PersonLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PersonSuccess) {
              return PersonDetailsWidget(personModel: state.personModel);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class PersonDetailsWidget extends StatelessWidget {
  const PersonDetailsWidget({
    super.key,
    required this.personModel,
  });
  final PersonModel personModel;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(11),
                ),
                border: const Border(),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    personModel.picture.large,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text('Name: ${personModel.name.first}'),
          Text('City: ${personModel.location.city}'),
          Text('Email: ${personModel.email}'),
          Text('DOB: ${convertTZStringToDDMMYYYY(personModel.dob.date)}'),
          Text(
              'Registerd days: ${getNumberOfDaysFromTZFormatString(personModel.registered.date)} days'),
        ],
      ),
    );
  }
}

String convertTZStringToDDMMYYYY(String tzString) {
  try {
    final tzFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final dateTime = tzFormat.parse(tzString);

    final ddMMYYYYFormat = DateFormat('dd-MM-yyyy');
    return ddMMYYYYFormat.format(dateTime);
  } catch (e) {
    return ''; // or return an error message
  }
}

int getNumberOfDaysFromTZFormatString(String tzFormatString) {
  try {
    final parsedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(tzFormatString);

    final difference = DateTime.now().difference(parsedDate);

    final numberOfDays = difference.inDays;

    return numberOfDays;
  } catch (e) {
    return 0;
  }
}

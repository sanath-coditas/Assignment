import 'package:fininfocom_assessment/presentation/screens/dog_bloc/dog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogImageScreen extends StatefulWidget {
  const DogImageScreen({super.key});

  @override
  State<DogImageScreen> createState() => _DogImageScreenState();
}

class _DogImageScreenState extends State<DogImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => DogBloc(),
        child: BlocBuilder<DogBloc, DogState>(
          builder: (context, state) {
            if (state is DogInitial) {
              context.read<DogBloc>().add(GetImageEvent());
            }
            if (state is DogLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DogSuccess) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.read<DogBloc>().add(GetImageEvent());
                      },
                      child: const Text('Refresh')),
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
                            state.imageUrl,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is DogFailure) {
              return const Center(child: Text('Something went Wrong!'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

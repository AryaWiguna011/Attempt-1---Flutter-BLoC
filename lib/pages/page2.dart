import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/page_bloc.dart';
import '../bloc/page_state.dart';
import '../bloc/page_event.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Pengurangan'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: BlocBuilder<PageBloc, PageState>(
          builder: (context, state) {
            if (state is PageUpdatedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Halaman Pengurangan',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Counter: ${state.counter}',
                    style: const TextStyle(fontSize: 32, color: Colors.orange),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: state.counter > 0
                        ? () {
                            // Implementasi pengurangan dengan mengurangi counter
                            // Kami akan reset dan kemudian update dengan counter - 1
                            int newCounter = state.counter - 1;
                            // Add events untuk mengurangi
                            context.read<PageBloc>().add(ResetEvent());
                            for (int i = 0; i < newCounter; i++) {
                              context.read<PageBloc>().add(
                                IncrementCounterEvent(),
                              );
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                    ),
                    child: const Text(
                      'Kurangi (-)',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/page3');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      'Ke Halaman Perkalian',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      'Kembali',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              );
            }
            return const Text('Loading...');
          },
        ),
      ),
    );
  }
}

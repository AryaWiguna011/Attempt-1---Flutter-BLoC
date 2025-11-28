import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/page_bloc.dart';
import 'bloc/page_event.dart';
import 'pages/page1.dart';
import 'pages/page2.dart';
import 'pages/page3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageBloc()..add(UpdateTextEvent('')),
      child: MaterialApp(
        title: 'Three Page BLoC App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const Page1(),
        routes: {
          '/page1': (context) => const Page1(),
          '/page2': (context) => const Page2(),
          '/page3': (context) => const Page3(),
        },
      ),
    );
  }
}

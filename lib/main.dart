import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/book_bloc.dart';
import 'pages/home_page.dart';

void main() => runApp(const BookClubApp());

class BookClubApp extends StatelessWidget {
  const BookClubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Club',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      builder: (context, child) => ColoredBox(
        color: Colors.grey.shade300,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 412),
            child: child,
          ),
        ),
      ),
      home: BlocProvider(
        create: (_) => BookBloc(),
        child: const HomePage(),
      ),
    );
  }
}

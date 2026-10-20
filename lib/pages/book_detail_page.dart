import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/book_bloc.dart';
import '../bloc/book_event.dart';
import '../models/book.dart';
import '../widgets/book_info.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    // The detail page is a state, not a route, so the system back button
    // is routed to the same event as the AppBar back button.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.read<BookBloc>().add(BackToList());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.read<BookBloc>().add(BackToList()),
          ),
          title: const Text('Book Detail'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle_outlined),
              onPressed: () {},
            ),
          ],
        ),
        body: BookInfo(book: book),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../models/book.dart';
import 'book_image.dart';

/// Widget 2: displays the book's image, title, author and description.
class BookInfo extends StatelessWidget {
  final Book book;

  const BookInfo({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookImage(book: book, width: 150, height: 225),
          const SizedBox(height: 20),
          Text(book.title, style: textTheme.headlineSmall),
          const SizedBox(height: 6),
          Text(
            book.author,
            style: textTheme.titleMedium?.copyWith(color: Colors.grey.shade700),
          ),
          const SizedBox(height: 16),
          Text(book.description, style: textTheme.bodyLarge),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../models/book.dart';

const double kCoverWidth = 100;
const double kCoverHeight = 150;

/// Widget 1: displays only the book's image.
class BookImage extends StatelessWidget {
  final Book book;
  final double width;
  final double height;

  const BookImage({
    super.key,
    required this.book,
    this.width = kCoverWidth,
    this.height = kCoverHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.network(
        book.imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: width,
          height: height,
          color: Colors.grey.shade300,
          child: const Icon(Icons.menu_book, color: Colors.grey),
        ),
      ),
    );
  }
}

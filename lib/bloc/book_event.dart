import '../models/book.dart';

abstract class BookEvent {}

class LoadBooks extends BookEvent {}

class SortByTitle extends BookEvent {}

class SortByAuthor extends BookEvent {}

class SelectBook extends BookEvent {
  final Book book;
  SelectBook(this.book);
}

class BackToList extends BookEvent {}

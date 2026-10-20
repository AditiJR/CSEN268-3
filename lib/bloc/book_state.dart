import 'package:equatable/equatable.dart';

import '../models/book.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object?> get props => [];
}

/// Shown while the list is being sorted. Emitting this between two list
/// states guarantees they are never equal back to back, so Equatable
/// can't swallow the rebuild.
class BookLoading extends BookState {
  const BookLoading();
}

class BookListState extends BookState {
  final List<Book> books;
  final SortType sortType;

  const BookListState(this.books, this.sortType);

  @override
  List<Object?> get props => [books, sortType];
}

class BookDetailState extends BookState {
  final Book book;

  const BookDetailState(this.book);

  @override
  List<Object?> get props => [book];
}

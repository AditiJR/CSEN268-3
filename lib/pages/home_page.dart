import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/book_bloc.dart';
import '../bloc/book_event.dart';
import '../bloc/book_state.dart';
import '../models/book.dart';
import '../widgets/book_image.dart';
import '../widgets/shimmer_list.dart';
import 'book_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state is BookDetailState) {
          return BookDetailPage(book: state.book);
        }
        final bloc = context.read<BookBloc>();
        final isLoading = state is! BookListState;
        final sortType = state is BookListState ? state.sortType : bloc.sortType;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
            title: const Text('Book Club Home'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.account_circle_outlined),
                onPressed: () {},
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SortRow(
                  sortType: sortType,
                  enabled: !isLoading,
                  onAuthor: () => bloc.add(SortByAuthor()),
                  onTitle: () => bloc.add(SortByTitle()),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text('Books', style: TextStyle(fontSize: 20)),
                ),
                if (state is BookListState)
                  _BookRow(books: state.books)
                else
                  const ShimmerList(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SortRow extends StatelessWidget {
  final SortType sortType;
  final bool enabled;
  final VoidCallback onAuthor;
  final VoidCallback onTitle;

  const _SortRow({
    required this.sortType,
    required this.enabled,
    required this.onAuthor,
    required this.onTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Text('Sort by'),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Author'),
            selected: sortType == SortType.author,
            onSelected: enabled ? (_) => onAuthor() : null,
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Title'),
            selected: sortType == SortType.title,
            onSelected: enabled ? (_) => onTitle() : null,
          ),
        ],
      ),
    );
  }
}

class _BookRow extends StatelessWidget {
  final List<Book> books;

  const _BookRow({required this.books});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BookBloc>();
    return SizedBox(
      height: kCoverHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: books.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) => GestureDetector(
          onTap: () => bloc.add(SelectBook(books[i])),
          child: BookImage(
            book: books[i],
            width: kCoverWidth,
            height: kCoverHeight,
          ),
        ),
      ),
    );
  }
}

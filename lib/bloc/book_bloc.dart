import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/book.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  // Starts empty, filled in init().
  List<Book> books = [];
  SortType sortType = SortType.author;

  BookBloc() : super(const BookLoading()) {
    on<LoadBooks>(_onLoadBooks);
    on<SortByTitle>((event, emit) => _onSort(SortType.title, emit));
    on<SortByAuthor>((event, emit) => _onSort(SortType.author, emit));
    on<SelectBook>((event, emit) => emit(BookDetailState(event.book)));
    on<BackToList>((event, emit) => emit(_listState()));

    add(LoadBooks());
  }

  /// Fills the book list.
  void init() {
    books = const [
      Book(
        title: 'Of Mice and Men',
        author: 'John Steinbeck',
        description:
            'Two migrant farm workers, George and Lennie, travel California '
            'during the Great Depression, holding on to a shared dream of '
            'owning a piece of land. Lennie\'s strength and innocence put that '
            'dream at risk.',
        imageUrl:
            'https://covers.openlibrary.org/b/isbn/9780140177398-L.jpg?default=false',
      ),
      Book(
        title: 'The Invisible Life of Addie LaRue',
        author: 'V.E. Schwab',
        description:
            'In 1714 France, Addie makes a bargain to live forever, but the '
            'price is that everyone she meets forgets her. Three centuries '
            'later, a young man in a New York bookshop remembers her name.',
        imageUrl:
            'https://covers.openlibrary.org/b/isbn/9780765387561-L.jpg?default=false',
      ),
      Book(
        title: 'Brave New World',
        author: 'Aldous Huxley',
        description:
            'In the World State, nobody is born the old way. Babies are '
            'grown in bottles, sorted into castes from Alpha to Epsilon, '
            'and conditioned from infancy to love the life they have been '
            'given. Families, marriage and even the words "mother" and '
            '"father" are considered obscene.\n\n'
            'Happiness is the official goal of society, and it is '
            'delivered on schedule. Citizens have constant entertainment, '
            'effortless relationships and a drug called soma that smooths '
            'over any bad feeling before it can take root. Pain, doubt and '
            'solitude have been engineered out of daily life.\n\n'
            'Bernard Marx is an Alpha who never quite fits in. He is '
            'smaller than his caste is supposed to be, and he feels '
            'uneasy in a world that expects him to be satisfied. On a '
            'trip to a reservation far outside the city, he meets John, a '
            'young man raised among people who still live, love and '
            'suffer the old way.\n\n'
            'Bernard brings John back to London, where the Savage becomes '
            'a celebrity and a curiosity. But John is horrified by what he '
            'sees: shallow pleasures, no history and no real feeling. His '
            'clash with the World State forces everyone around him to '
            'ask what a person gives up in exchange for comfort.\n\n'
            'Published in 1932, the novel imagines a future that does not '
            'rule by fear, but by distraction and pleasure. It asks '
            'whether freedom, art, truth and love are worth having if '
            'they come with discomfort, and who gets to decide the '
            'answer.',
        imageUrl:
            'https://covers.openlibrary.org/b/isbn/9780060850524-L.jpg?default=false',
      ),
      Book(
        title: 'Klara and the Sun',
        author: 'Kazuo Ishiguro',
        description:
            'Klara is an Artificial Friend who watches the world from a '
            'store window, hoping to be chosen by a child. Once she goes '
            'home with a sick girl named Josie, she learns what it means to '
            'love and to be loyal.',
        imageUrl:
            'https://covers.openlibrary.org/b/isbn/9780593318171-L.jpg?default=false',
      ),
      Book(
        title: 'A Short Stay in Hell',
        author: 'Steven L. Peck',
        description:
            'Soren Johansson dies and finds himself in an afterlife where '
            'he must find one particular book in a library of every possible '
            'book, a search that could take longer than the universe has '
            'existed.',
        imageUrl:
            'https://covers.openlibrary.org/b/isbn/9780983748427-L.jpg?default=false',
      ),
      Book(
        title: 'Fahrenheit 451',
        author: 'Ray Bradbury',
        description:
            'In a future where books are banned and burned, fireman Guy '
            'Montag begins to question his job and the world around him '
            'after he secretly starts reading.',
        imageUrl:
            'https://covers.openlibrary.org/b/isbn/9781451673319-L.jpg?default=false',
      ),
    ];
    _sort(SortType.author);
  }

  Future<void> _onLoadBooks(LoadBooks event, Emitter<BookState> emit) async {
    init();
    emit(_listState());
  }

  Future<void> _onSort(SortType type, Emitter<BookState> emit) async {
    // Loading state first (the "shimmer"), so the same list state emitted
    // afterwards is not dropped by Equatable.
    emit(const BookLoading());
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _sort(type);
    emit(_listState());
  }

  void _sort(SortType type) {
    sortType = type;
    books = List.of(books)
      ..sort((a, b) => type == SortType.title
          ? a.title.toLowerCase().compareTo(b.title.toLowerCase())
          : a.author.toLowerCase().compareTo(b.author.toLowerCase()));
  }

  BookListState _listState() => BookListState(List.of(books), sortType);
}

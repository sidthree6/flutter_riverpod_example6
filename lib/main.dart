import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

@immutable
class Film {
  final String id;
  final String title;
  final String description;
  final bool isFavourite;

  const Film({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavourite,
  });

  Film copy({required bool isFavorite}) {
    return Film(
      id: id,
      title: title,
      description: description,
      isFavourite: isFavorite,
    );
  }

  @override
  String toString() {
    return 'Film{id: $id, '
        'title: $title, '
        'description: $description, '
        'isFavourite: $isFavourite}';
  }

  @override
  bool operator ==(covariant Film other) =>
      id == other.id && isFavourite == other.isFavourite;

  @override
  int get hashCode => Object.hashAll([id, isFavourite]);
}

const allFilms = [
  Film(
      id: '1',
      title: 'The Shawshank Redemption',
      description: 'Description for The Shawshank Redemption',
      isFavourite: false),
  Film(
      id: '2',
      title: 'The Godfather',
      description: 'Description for The Godfather',
      isFavourite: false),
  Film(
      id: '3',
      title: 'The Dark Knight',
      description: 'Description for The Dark Knight',
      isFavourite: false),
  Film(
      id: '4',
      title: 'The Godfather: Part II',
      description: 'Description for The Godfather: Part II',
      isFavourite: false),
  Film(
      id: '5',
      title: 'The Lord of the Rings: The Return of the King',
      description:
          'Description for The Lord of the Rings: The Return of the King',
      isFavourite: false),
];

class FilmsNotifier extends StateNotifier<List<Film>> {
  FilmsNotifier() : super(allFilms);

  void update(Film film, bool isFavourite) {
    state = state
        .map(
          (thisFilm) => thisFilm.id == film.id
              ? thisFilm.copy(
                  isFavorite: isFavourite,
                )
              : thisFilm,
        )
        .toList();
  }
}

enum FavouriteStatus {
  all,
  favourite,
  notFavourite,
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
    );
  }
}

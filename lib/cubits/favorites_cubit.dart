import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/database/daos/favorites_dao.dart';
import 'package:notes_app/database/notes_database.dart';

class FavoritesCubit extends Cubit<Set<int>> {
  final FavoritesDAO favoritesDAO;

  StreamSubscription<List<Favorite>>? _favoritesSubscription;

  FavoritesCubit({required this.favoritesDAO}) : super({}) {
    _favoritesSubscription = favoritesDAO.items.listen(
      (favorites) => emit(
        favorites.map((favorite) => favorite.id).toSet(),
      ),
    );
  }

  @override
  Future<void> close() async {
    await _favoritesSubscription?.cancel();

    return super.close();
  }

  void save(int id) => favoritesDAO.save(id);

  void remove(int id) => favoritesDAO.remove(id);
}

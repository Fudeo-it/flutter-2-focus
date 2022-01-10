import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/favorites_cubit.dart';
import 'package:notes_app/cubits/notes/notes_cubit.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        LazyDatabase _openDatabase() => LazyDatabase(() async {
              final dbFolder = await getApplicationDocumentsDirectory();
              final file = File(join(dbFolder.path, 'notes.sqlite'));

              return NativeDatabase(file);
            });

        return NotesDatabase(_openDatabase());
      },
      dispose: (_, NotesDatabase db) => db.close(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FavoritesCubit(
              favoritesDAO: context.read<NotesDatabase>().favoritesDAO,
            ),
          ),
          BlocProvider(
            create: (context) => NotesCubit(
              notesDAO: context.read<NotesDatabase>().notesDAO,
            )
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Notes App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}

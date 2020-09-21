import 'dart:async';

import 'package:flutter/material.dart';

import 'hive.dart';
import 'packup_restore.dart';

class Home2Page extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite Books with Hive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Favorite Books w/ Hive'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.backup),
              onPressed: _createBackup,
            ),
            IconButton(
              icon: Icon(Icons.restore),
              onPressed: _restoreBackup,
            ),
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: hive.favoriteBooks.listenable(),
          builder: (context, Box<String> box, _) {
            return ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, listIndex) {
                return ListTile(
                  title: Text(_books[listIndex]),
                  trailing: IconButton(
                    icon: _getIcon(listIndex),
                    onPressed: () => _onFavoritePress(listIndex),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _getIcon(int index) {
    if (hive.favoriteBooks.containsKey(index)) {
      return Icon(Icons.favorite, color: Colors.red);
    }
    return Icon(Icons.favorite_border);
  }

  void _onFavoritePress(int index) {
    if (hive.favoriteBooks.containsKey(index)) {
      hive.favoriteBooks.delete(index);
      return;
    }
    hive.favoriteBooks.put(index, _books[index]);
  }

  Future<void> _createBackup() async {
    if (hive.favoriteBooks.isEmpty) {
      _showSnackBar('Pick a favorite book.');
      return;
    }

    _showSnackBar('Creating backup...');
    await BackupRestore.backup(
      hive.favoriteBooks.toMap().map((key, value) => MapEntry(key.toString(), value)),
    );
    _showSnackBar('Backup finished.');
  }

  Future<void> _restoreBackup() async {
    _showSnackBar('Restoring backup...');
    final newMap = await BackupRestore.restore();
    if (newMap != null) {
      await hive.favoriteBooks.clear();
      await hive.favoriteBooks.putAll(newMap);
      _showSnackBar('Restoring finished.');
    }
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

const List<String> _books = [
  'Harry Potter',
  'To Kill a Mockingbird',
  'The Hunger Games',
  'The Giver',
  'Brave New World',
  'Unwind',
  'World War Z',
  'The Lord of the Rings',
  'The Hobbit',
  'Moby Dick',
  'War and Peace',
  'Crime and Punishment',
  'The Adventures of Huckleberry Finn',
  'Catch-22',
  'The Sound and the Fury',
  'The Grapes of Wrath',
  'Heart of Darkness',
];

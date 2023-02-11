import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import '../data/dummy_users.dart';

class UsersProvider with ChangeNotifier {
  final Map<String, User> _items = {...dummyUsers};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void create(User user) {
    if (user == null) {
      return;
    }

    final id = Random().nextDouble().toString();

    if (user.id != null &&
        !user.id.trim().isEmpty &&
        !_items.containsKey(user.id)) {
      _items.putIfAbsent(
        id,
        () => User(
            id: id,
            name: user.name,
            email: user.email,
            avatarURL: user.avatarURL),
      );
    }

    notifyListeners();
  }

  void put(User user) {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        !user.id.trim().isEmpty &&
        _items.containsKey(user.id)) {
      _items.update(
          user.id,
          (_) => User(
              id: user.id,
              name: user.name,
              email: user.email,
              avatarURL: user.avatarURL));
    } else {
      final id = Random().nextDouble().toString();

      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarURL: user.avatarURL,
        ),
      );
    }

    notifyListeners();
  }

  void delete(User user) {
    if (user != null && user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
  }
}

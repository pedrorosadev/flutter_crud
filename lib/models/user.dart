import 'package:flutter/material.dart';

class User {
  const User(
      {required this.id,
      required this.name,
      required this.email,
      required this.avatarURL});

  final String id;
  final String email;
  final String name;
  final String avatarURL;
}

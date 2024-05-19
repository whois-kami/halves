import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class UserData extends Equatable {
  final String email;
  final String passWord;
  const UserData({
    required this.email,
    required this.passWord,
  });

  @override
  List<Object?> get props => [email, passWord];
}

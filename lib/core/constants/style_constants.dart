import 'package:flutter/material.dart';

class AppConstants {
  // sign up | login button

  static ButtonStyle elevatedAuthButtonStyle = const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Color(0xFFFF0BA8)),
      foregroundColor: MaterialStatePropertyAll(Colors.white),
      minimumSize: MaterialStatePropertyAll(Size(double.infinity, 40)),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)))));

  // (login | singup) pass input forms

  static InputDecoration passInputDecorationStyle = const InputDecoration(
    filled: true,
    isDense: true,
    contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 12.0),
    hintText: 'Enter Your Password',
    fillColor: Color(0xFFFC98D8),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    errorStyle: TextStyle(
      color: Colors.red,
    ),
  );

  // (login | singup) email input forms

  static InputDecoration emailInputDecorationStyle = const InputDecoration(
    filled: true,
    isDense: true,
    contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 12.0),
    hintText: 'Enter Your Email',
    fillColor: Color(0xFFFC98D8),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    errorStyle: TextStyle(
      color: Colors.red,
    ),
  );

  // singup confirm pass input form

  static InputDecoration confirmInputDecorationStyle = const InputDecoration(
    filled: true,
    isDense: true,
    contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 12.0),
    hintText: 'Confirm Your Password',
    fillColor: Color(0xFFFC98D8),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    errorStyle: TextStyle(
      color: Colors.red,
    ),
  );

  // Signup / login textbuttons

  static TextStyle logSigTextButton =
      const TextStyle(letterSpacing: 1, color: Color(0xFFFF08A7));
}

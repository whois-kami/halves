import 'package:flutter/material.dart';

class AppStyleConstants {
  // sign up | login button

  static ButtonStyle elevatedAuthButtonStyle = const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Color(0xFFFF0BA8)),
      foregroundColor: MaterialStatePropertyAll(Colors.white),
      minimumSize: MaterialStatePropertyAll(Size(double.infinity, 40)),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)))));

  // (login | singup) pass input forms

  static InputDecoration passInputDecorationStyle = InputDecoration(
    isDense: true,
    contentPadding:
        const EdgeInsets.symmetric(vertical: 11.0, horizontal: 12.0),
    hintText: 'Enter Your Password',
    hintStyle: TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontSize: 16,
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFD00A6)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFD00A6)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFD00A6)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFD00A6)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFD00A6)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    errorStyle: const TextStyle(
      color: Colors.red,
    ),
  );

  // (login | singup) email input forms

  static InputDecoration emailInputDecorationStyle = InputDecoration(
    isDense: true,
    contentPadding:
        const EdgeInsets.symmetric(vertical: 11.0, horizontal: 12.0),
    hintText: 'Enter Your Email',
    hintStyle: TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontSize: 16,
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFD00A6)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFD00A6)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFD00A6)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFD00A6)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFD00A6)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    errorStyle: const TextStyle(
      color: Colors.red,
    ),
  );

  // singup confirm pass input form

  static InputDecoration confirmInputDecorationStyle = InputDecoration(
    isDense: true,
    contentPadding:
        const EdgeInsets.symmetric(vertical: 11.0, horizontal: 12.0),
    hintText: 'Confirm Your Password',
    hintStyle: TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontSize: 16,
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFD00A6)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFD00A6)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFD00A6)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFD00A6)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFD00A6)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    errorStyle: const TextStyle(
      color: Colors.red,
    ),
  );

  // Signup / login textbuttons

  static TextStyle logSigTextButton =
      const TextStyle(letterSpacing: 1, color: Color(0xFFFF08A7));

  
}

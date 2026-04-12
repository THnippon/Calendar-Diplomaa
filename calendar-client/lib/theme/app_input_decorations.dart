import 'package:flutter/material.dart';

class AppInputDecorations {
  const AppInputDecorations._();

  static InputDecoration authInput({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  })
  {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Color(0xFFE8E8F0)),
    );

    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(
        prefixIcon,
        color: Color(0xFF8E8E9D),
      ),
      suffixIcon: suffixIcon,
      filled: true, //Проверить
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: const BorderSide(
        color: Color(0xFF5B3DF5),
        width: 1.5,
      ),
      ),
      errorBorder: border.copyWith(
        borderSide: const BorderSide(
          color: Colors.redAccent
          ),
      ),
      focusedErrorBorder: border.copyWith(
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.5,
        ),
      ),
      errorMaxLines: 4,
      );
  }
}
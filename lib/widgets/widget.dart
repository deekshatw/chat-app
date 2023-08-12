import 'package:flutter/material.dart';

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.white54,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white54,
      ),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
  );
}

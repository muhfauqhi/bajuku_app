import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: const Color(0xFFCCCCCC), width: 2.0)
    ),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: const Color(0xFF3F4D55), width: 2.0)
    ),
    labelStyle: TextStyle(
      letterSpacing: 1.0,
      color: const Color(0xFF3F4D55),
    ),
  );
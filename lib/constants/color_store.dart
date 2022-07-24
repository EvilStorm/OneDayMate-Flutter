import 'package:flutter/material.dart';

class ColorStore {
  static const primaryColor = Color(0xFFF56E22);
  static const textDismissColor = Color(0xFF999999);
  static const successColor = Color(0xFF2374ED);
  static const errorColor = Color(0xFFED2F23);
  static const unSelected = Color(0xFF999999);

  static const color65 = Color(0xFF656565);
  static const color43 = Color(0xFF434343);
  static const color89 = Color(0xFF898989);
  static const colorD6 = Color(0xFFD6D6D6);
  static const colorAF = Color(0xFFAFAFAF);
  static const colorF0 = Color(0xFFF0F0F0);
  static const colorF6 = Color(0xFFF6F6F6);

  static Color materiStateType1(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected,
    };
    if (states.any(interactiveStates.contains)) {
      return ColorStore.primaryColor;
    }
    return Colors.grey;
  }
}

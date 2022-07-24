import 'package:flutter/material.dart';

class ColorStore {
  static const primaryColor = Color(0xFFF56E22);
  static const textDismissColor = Color(0xFF999999);
  static const successColor = Color(0xFF2374ED);
  static const errorColor = Color(0xFFED2F23);
  static const unSelected = Color(0xFF999999);
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

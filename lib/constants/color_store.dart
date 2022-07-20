import 'package:flutter/material.dart';

class ColorStore {
  static const primaryColor = Color(0xFFF56E22);
  static const textDismissColor = Color(0xFF999999);

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

import 'package:flutter/material.dart';

Color customColor({String? date}) {
  switch (date) {
    case 'Today':
      return Colors.orange;
    case 'Yesterday':
      return Colors.blue;
    case 'Tomorrow':
      return Colors.green;

    default:
      return Colors.black;
  }
}

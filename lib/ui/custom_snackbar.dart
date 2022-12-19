import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  final String text;
  final Duration barDuration;
  final String buttonLabel;
  final VoidCallback? onPressedAction;

  CustomSnackBar({
    Key? key,
    required this.text,
    this.barDuration = const Duration(seconds: 2),
    this.buttonLabel = 'OK',
    this.onPressedAction,
  }) : super(
            key: key,
            content: Text(text),
            duration: barDuration,
            action: SnackBarAction(
                label: buttonLabel,
                onPressed: () {
                  if (onPressedAction != null) {
                    onPressedAction();
                  }
                }));
}

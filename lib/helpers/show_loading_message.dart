import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context) {
  //Android
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Wait a moment'),
          content: Text('Calculating route'),
        );
      },
    );
  } else if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Wait a moment'),
          content: CupertinoActivityIndicator(),
        );
      },
    );
  }
}

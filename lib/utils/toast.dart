import 'package:flutter/material.dart';

class ToastUtils {
  static void showToast({
    required BuildContext context,
    required String message,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    int durationSeconds = 3,
  }) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: durationSeconds),
        action: SnackBarAction(
          label: 'OK',
          textColor: textColor,
          onPressed: scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }
}

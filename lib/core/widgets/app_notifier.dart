import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sparktech_agency_task/core/constants/colors.dart';

enum MessageType { success, error, info, warning }

class AppNotifier {
  static Color _getBackgroundColor(MessageType type) {
    switch (type) {
      case MessageType.success:
        return AppColors.success;
      case MessageType.error:
        return AppColors.error;
      case MessageType.info:
        return AppColors.info;
      case MessageType.warning:
        return AppColors.warning;
    }
  }

  static void showToast(String message, {MessageType type = MessageType.info}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: _getBackgroundColor(type),
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }
}

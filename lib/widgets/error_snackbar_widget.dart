import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorSnackbarWidget {
  static void showSnackbar({required String title, required List<String> messages}) {
    
      Get.snackbar(
        "",
        "",
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 1500),
        isDismissible: true,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.colorScheme.primaryContainer,
        titleText: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 118, 0, 0),
            ),
          ),
        ),
        messageText: Center(
          child: Text(
            messages.join('\n'),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        overlayBlur: 0.5,
      );
  }
}

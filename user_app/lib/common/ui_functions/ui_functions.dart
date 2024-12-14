import 'package:flutter/material.dart';
import 'package:user_app/config/theme/app_color.dart';

Future errorPopup({required BuildContext ctx, String? head, String? body}) {
  return showDialog(
    context: ctx,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.secondary,
      title: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 60,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            head ?? "Something went wrong",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ),
      content: Text(
        body ?? "Something went wrong",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'OK',
            style: TextStyle(
              fontSize: 16,
              color: Colors.green,
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}

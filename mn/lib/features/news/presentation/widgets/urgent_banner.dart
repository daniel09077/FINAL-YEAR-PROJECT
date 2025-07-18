import 'package:flutter/material.dart';

class UrgentBanner extends StatelessWidget {
  final String message;
  final VoidCallback onTap;

  const UrgentBanner({
    super.key,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      backgroundColor: Colors.red.shade100,
      leading: const Icon(Icons.notification_important, color: Colors.red),
      content: GestureDetector(
        onTap: onTap,
        child: Text(
          message,
          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
        ),
      ),
      actions: const [],
    );
  }
}

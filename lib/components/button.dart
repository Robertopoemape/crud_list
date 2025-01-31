import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    required this.onPressed,
    required this.label,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    super.key,
  });

  final VoidCallback onPressed;
  final String label;
  final EdgeInsets contentPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: contentPadding,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

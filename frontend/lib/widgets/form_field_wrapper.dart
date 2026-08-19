import 'package:flutter/material.dart';

class FormFieldWrapper extends StatelessWidget {
  final String label;
  final Widget child;

  const FormFieldWrapper({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF4F4850),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 7),
        child,
      ],
    );
  }
}

import 'package:flutter/material.dart';

BoxDecoration cardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14),
    border: Border.all(color: const Color(0xFFF0E7EF), width: 1),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withAlpha(10),
        blurRadius: 30,
        offset: const Offset(0, 5),
      ),
    ],
  );
}

BoxDecoration bottomLineDecoration() {
  return const BoxDecoration(
    border: Border(bottom: BorderSide(color: Color(0xFFE6DEE5))),
  );
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AuthService {
  static const String baseUrl =
      'http://127.0.0.1:8001/api/auth';

  // ============================================================
  // REGISTER
  // ============================================================

  static Future<Map<String, dynamic>> register({
    required String fullName,
    required String username,
    required String email,
    required String password,
    required DateTime birthDate,
    required TimeOfDay birthTime,
    required String birthPlace,
  }) async {
    final body = {
      'full_name': fullName.trim(),
      'username': username.trim(),
      'email': email.trim(),
      'password': password,
      'birth_date': _formatDate(
        birthDate,
      ),
      'birth_time': _formatTime(
        birthTime,
      ),
      'birth_place': birthPlace.trim(),
    };

    final response = await http.post(
      Uri.parse(
        '$baseUrl/register',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(
        body,
      ),
    );

    final decoded = _decodeResponse(
      response,
    );

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw AuthException(
        _extractError(
          decoded,
        ),
      );
    }

    return decoded;
  }

  // ============================================================
  // LOGIN - CORREO O USERNAME
  // ============================================================

  static Future<Map<String, dynamic>> login({
    required String identifier,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(
        '$baseUrl/login',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(
        {
          'identifier': identifier.trim(),
          'password': password,
        },
      ),
    );

    debugPrint(
      'LOGIN STATUS: ${response.statusCode}',
    );

    debugPrint(
      'LOGIN BODY: ${response.body}',
    );

    final decoded = _decodeResponse(
      response,
    );

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw AuthException(
        _extractError(
          decoded,
        ),
      );
    }

    return decoded;
  }

  // ============================================================
  // HELPERS
  // ============================================================

  static String _formatDate(
    DateTime date,
  ) {
    final year =
        date.year
            .toString()
            .padLeft(
              4,
              '0',
            );

    final month =
        date.month
            .toString()
            .padLeft(
              2,
              '0',
            );

    final day =
        date.day
            .toString()
            .padLeft(
              2,
              '0',
            );

    return '$year-$month-$day';
  }

  static String _formatTime(
    TimeOfDay time,
  ) {
    final hour =
        time.hour
            .toString()
            .padLeft(
              2,
              '0',
            );

    final minute =
        time.minute
            .toString()
            .padLeft(
              2,
              '0',
            );

    return '$hour:$minute:00';
  }

  static Map<String, dynamic> _decodeResponse(
    http.Response response,
  ) {
    if (response.body.isEmpty) {
      return {};
    }

    try {
      final decoded = jsonDecode(
        response.body,
      );

      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      return {
        'data': decoded,
      };
    } catch (_) {
      throw AuthException(
        'El servidor devolvió una respuesta inválida.',
      );
    }
  }

  static String _extractError(
    Map<String, dynamic> response,
  ) {
    final detail = response['detail'];

    if (detail is String) {
      return detail;
    }

    if (detail is Map) {
      final message = detail['message'];

      if (message != null) {
        return message.toString();
      }
    }

    if (detail is List &&
        detail.isNotEmpty) {
      final first = detail.first;

      if (first is Map &&
          first['msg'] != null) {
        return first['msg'].toString();
      }
    }

    return 'No fue posible completar la solicitud.';
  }
}


class AuthException implements Exception {
  final String message;

  AuthException(
    this.message,
  );

  @override
  String toString() {
    return message;
  }
}
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum AuthErrorCode {
  network,
  timeout,
  invalidResponse,
  requestFailed,
}

class AuthException implements Exception {
  final AuthErrorCode code;
  final String? backendDetail;

  const AuthException(
    this.code, {
    this.backendDetail,
  });

  @override
  String toString() {
    return backendDetail ?? code.name;
  }
}

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

    return _post(
      '$baseUrl/register',
      body,
    );
  }

  // ============================================================
  // LOGIN - CORREO O USERNAME
  // ============================================================

  static Future<Map<String, dynamic>> login({
    required String identifier,
    required String password,
  }) async {
    return _post(
      '$baseUrl/login',
      {
        'identifier': identifier.trim(),
        'password': password,
      },
    );
  }

  // ============================================================
  // LOGOUT
  // ============================================================
  //
  // Actualmente Sacred autentica contra FastAPI y este servicio
  // NO mantiene un cliente Supabase ni una sesión persistente
  // propia en Flutter.
  //
  // Por eso aquí no corresponde llamar:
  //
  // supabase.auth.signOut()
  //
  // El logout actual consiste en eliminar las pantallas privadas
  // del Navigator desde AccountProfileScreen.
  //
  // Si más adelante guardamos access_token / refresh_token
  // localmente, este método será también el lugar donde limpiarlos.
  // ============================================================

  static Future<void> logout() async {
    return;
  }

  // ============================================================
  // HELPERS
  // ============================================================

  static Future<Map<String, dynamic>> _post(
    String url,
    Map<String, dynamic> body,
  ) async {
    late final http.Response response;

    try {
      response = await http
          .post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(
            const Duration(seconds: 30),
          );
    } on TimeoutException {
      throw const AuthException(
        AuthErrorCode.timeout,
      );
    } catch (_) {
      throw const AuthException(
        AuthErrorCode.network,
      );
    }

    debugPrint(
      'AUTH STATUS: ${response.statusCode}',
    );

    debugPrint(
      'AUTH BODY: ${response.body}',
    );

    final decoded = _decodeResponse(
      response,
    );

    if (
        response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw AuthException(
        AuthErrorCode.requestFailed,
        backendDetail: _extractError(
          decoded,
        ),
      );
    }

    return decoded;
  }

  static String _formatDate(
    DateTime date,
  ) {
    final year =
        date.year.toString().padLeft(
              4,
              '0',
            );

    final month =
        date.month.toString().padLeft(
              2,
              '0',
            );

    final day =
        date.day.toString().padLeft(
              2,
              '0',
            );

    return '$year-$month-$day';
  }

  static String _formatTime(
    TimeOfDay time,
  ) {
    final hour =
        time.hour.toString().padLeft(
              2,
              '0',
            );

    final minute =
        time.minute.toString().padLeft(
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

      if (decoded
          is Map<String, dynamic>) {
        return decoded;
      }

      return {
        'data': decoded,
      };
    } catch (_) {
      throw const AuthException(
        AuthErrorCode.invalidResponse,
      );
    }
  }

  // devuelve el detail que mandó el backend, o null si no hay
  // ninguno usable. no se traduce: es contenido del backend.
  static String? _extractError(
    Map<String, dynamic> response,
  ) {
    final detail =
        response['detail'];

    if (detail is String) {
      return detail;
    }

    if (detail is Map) {
      final message =
          detail['message'];

      if (message != null) {
        return message.toString();
      }
    }

    if (
        detail is List &&
        detail.isNotEmpty) {
      final first =
          detail.first;

      if (
          first is Map &&
          first['msg'] != null) {
        return first['msg']
            .toString();
      }
    }

    return null;
  }
}
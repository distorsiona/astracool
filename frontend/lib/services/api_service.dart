import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/birth_data_model.dart';
import '../models/zodiac_profile_model.dart';


class ApiException implements Exception {
  final String message;

  const ApiException(this.message);

  @override
  String toString() {
    return message;
  }
}

class ApiService {
  static Future<ZodiacProfileModel>
      getAstraProfile({
    required BirthDataModel birthData,
  }) async {
    final Uri uri = Uri.parse(
      ApiConfig.astraProfileAnalysis,
    );

    try {
      final response = await http
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(
              birthData.toJson(),
            ),
          )
          .timeout(
            const Duration(seconds: 30),
          );

      if (response.statusCode < 200 ||
          response.statusCode >= 300) {
        throw ApiException(
          _extractError(response),
        );
      }

      final dynamic decoded =
          jsonDecode(response.body);

      if (decoded is! Map<String, dynamic>) {
        throw const ApiException(
          'La API devolvió un formato inesperado.',
        );
      }

      return ZodiacProfileModel.fromAstraJson(
        decoded,
      );
    } catch (error) {
      if (error is ApiException) {
        rethrow;
      }

      throw ApiException(
        'No fue posible conectar con Astra API: $error',
      );
    }
  }

  static String _extractError(
    http.Response response,
  ) {
    try {
      final dynamic decoded =
          jsonDecode(response.body);

      if (decoded is Map<String, dynamic>) {
        final detail = decoded['detail'];

        if (detail != null) {
          return detail.toString();
        }
      }
    } catch (_) {}

    return 'Error ${response.statusCode} al consultar Astra API.';
  }

  // ============================================================
  // PERFIL REAL DEL USUARIO
  // ============================================================

  static Future<ZodiacProfileModel> getProfile({
    required String userId,
  }) async {
    final Uri uri = Uri.parse(
      '${ApiConfig.profile}/$userId',
    );

    final http.Response response;

    try {
      response = await http
          .get(
            uri,
            headers: {
              'Accept': 'application/json',
            },
          )
          .timeout(
            const Duration(seconds: 30),
          );
    } catch (error) {
      throw ApiException(
        'No fue posible conectar con el backend: $error',
      );
    }

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw ApiException(
        _extractError(response),
      );
    }

    final dynamic decoded =
        jsonDecode(response.body);

    if (decoded is! Map<String, dynamic>) {
      throw const ApiException(
        'El backend devolvió un perfil con formato inesperado.',
      );
    }

    return ZodiacProfileModel.fromJson(
      decoded,
    );
  }
}
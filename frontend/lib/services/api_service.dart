import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/birth_data_model.dart';
import '../models/zodiac_profile_model.dart';
import '../models/natal_chart_model.dart';
import '../models/today_model.dart';
import '../models/house_model.dart';
import '../models/house_detail_model.dart';
import '../models/account_profile_model.dart';

// ============================================================
// error personalizado para las llamadas a la api
//
// "code" identifica el tipo de error (para mostrar un mensaje
// localizado genérico), y "backendDetail" guarda el mensaje que
// FastAPI haya mandado en su campo "detail", si lo hay.
//
// backendDetail viene tal cual del backend: NO se traduce en
// Flutter, porque es contenido que no controlamos acá.
// ============================================================

enum ApiErrorCode {
  network,
  timeout,
  invalidResponse,
  requestFailed,
}

class ApiException implements Exception {
  final ApiErrorCode code;
  final String? backendDetail;

  const ApiException(
    this.code, {
    this.backendDetail,
  });

  @override
  String toString() {
    return backendDetail ?? code.name;
  }
}

// ============================================================
// servicio principal para comunicarse con el backend
// ============================================================

class ApiService {
  // ==========================================================
  // análisis astrológico usando datos de nacimiento
  // ==========================================================

  static Future<ZodiacProfileModel> getAstraProfile({
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
            const Duration(
              seconds: 30,
            ),
          );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException(
          ApiErrorCode.requestFailed,
          backendDetail: _extractErrorDetail(response),
        );
      }

      final dynamic decoded = jsonDecode(
        response.body,
      );

      if (decoded is! Map<String, dynamic>) {
        throw const ApiException(
          ApiErrorCode.invalidResponse,
        );
      }

      return ZodiacProfileModel.fromAstraJson(
        decoded,
      );
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException(ApiErrorCode.timeout);
    } on FormatException {
      throw const ApiException(ApiErrorCode.invalidResponse);
    } catch (_) {
      throw const ApiException(ApiErrorCode.network);
    }
  }

  // ==========================================================
  // perfil real del usuario
  // ==========================================================

  static Future<ZodiacProfileModel> getProfile({
    required String userId,
  }) async {
    final Uri uri = Uri.parse(
      '${ApiConfig.profile}/$userId',
    );

    try {
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(
          seconds: 30,
        ),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException(
          ApiErrorCode.requestFailed,
          backendDetail: _extractErrorDetail(response),
        );
      }

      final dynamic decoded = jsonDecode(
        response.body,
      );

      if (decoded is! Map<String, dynamic>) {
        throw const ApiException(
          ApiErrorCode.invalidResponse,
        );
      }

      return ZodiacProfileModel.fromJson(
        decoded,
      );
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException(ApiErrorCode.timeout);
    } on FormatException {
      throw const ApiException(ApiErrorCode.invalidResponse);
    } catch (_) {
      throw const ApiException(ApiErrorCode.network);
    }
  }

  // ==========================================================
  // carta natal completa del usuario
  // ==========================================================

  static Future<NatalChartModel> getChart({
    required String userId,
    required String language,
  }) async {
    final Uri uri = Uri.parse(
      '${ApiConfig.baseUrl}'
      '/api/chart/'
      '$userId',
    ).replace(queryParameters: {'lang': language});

    try {
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(
          seconds: 30,
        ),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException(
          ApiErrorCode.requestFailed,
          backendDetail: _extractErrorDetail(response),
        );
      }

      final dynamic decoded = jsonDecode(
        response.body,
      );

      if (decoded is! Map<String, dynamic>) {
        throw const ApiException(
          ApiErrorCode.invalidResponse,
        );
      }

      return NatalChartModel.fromJson(
        decoded,
      );
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException(ApiErrorCode.timeout);
    } on FormatException {
      throw const ApiException(ApiErrorCode.invalidResponse);
    } catch (_) {
      throw const ApiException(ApiErrorCode.network);
    }
  }

  // ==========================================================
  // detalle de una casa específica
  //
  // usa:
  //
  // userId
  // chartId
  // houseNumber
  //
  // ejemplo:
  //
  // /api/chart/user/chart/houses/1
  // ==========================================================

  static Future<ChartHouse> getChartHouse({
    required String userId,
    required String chartId,
    required int houseNumber,
  }) async {
    final Uri uri = Uri.parse(
      '${ApiConfig.baseUrl}'
      '/api/chart/'
      '$userId/'
      '$chartId/'
      'houses/'
      '$houseNumber',
    );

    try {
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(
          seconds: 30,
        ),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException(
          ApiErrorCode.requestFailed,
          backendDetail: _extractErrorDetail(response),
        );
      }

      final dynamic decoded = jsonDecode(
        response.body,
      );

      if (decoded is! Map<String, dynamic>) {
        throw const ApiException(
          ApiErrorCode.invalidResponse,
        );
      }

      final dynamic houseJson = decoded['house'];

      if (houseJson is! Map) {
        throw const ApiException(
          ApiErrorCode.invalidResponse,
        );
      }

      return ChartHouse.fromJson(
        Map<String, dynamic>.from(
          houseJson,
        ),
      );
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException(ApiErrorCode.timeout);
    } on FormatException {
      throw const ApiException(ApiErrorCode.invalidResponse);
    } catch (_) {
      throw const ApiException(ApiErrorCode.network);
    }
  }

  // ==========================================================
  // energía astrológica de hoy
  // ==========================================================

  static Future<TodayModel> getToday({
    required String userId,
  }) async {
    final Uri uri = Uri.parse(
      '${ApiConfig.baseUrl}'
      '/api/today/'
      '$userId',
    );

    try {
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(
          seconds: 30,
        ),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException(
          ApiErrorCode.requestFailed,
          backendDetail: _extractErrorDetail(response),
        );
      }

      final dynamic decoded = jsonDecode(
        response.body,
      );

      if (decoded is! Map<String, dynamic>) {
        throw const ApiException(
          ApiErrorCode.invalidResponse,
        );
      }

      return TodayModel.fromJson(
        decoded,
      );
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException(ApiErrorCode.timeout);
    } on FormatException {
      throw const ApiException(ApiErrorCode.invalidResponse);
    } catch (_) {
      throw const ApiException(ApiErrorCode.network);
    }
  }

  // ==========================================================
  // obtener el detail que manda fastapi en sus errores
  //
  // normalmente fastapi responde algo como:
  //
  // {
  //   "detail": "mensaje del error"
  // }
  //
  // si no hay un detail usable, devolvemos null: la UI mostrará
  // en ese caso un mensaje localizado genérico.
  // ==========================================================

  static String? _extractErrorDetail(
    http.Response response,
  ) {
    try {
      final dynamic decoded = jsonDecode(
        response.body,
      );

      if (decoded is Map<String, dynamic>) {
        final dynamic detail = decoded['detail'];

        if (detail != null) {
          return detail.toString();
        }
      }
    } catch (_) {
      // si la respuesta no era json,
      // no hay detail que extraer.
    }

    return null;
  }

  Future<HousesResponseModel> getHouses(
    String userId, {
    required String language,
  }) async {
    final uri = Uri.parse(
      ApiConfig.houses(userId, lang: language),
    );

    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          ApiErrorCode.requestFailed,
          backendDetail: _extractErrorDetail(response),
        );
      }

      final decoded = jsonDecode(
        response.body,
      );

      if (decoded is! Map<String, dynamic>) {
        throw const ApiException(
          ApiErrorCode.invalidResponse,
        );
      }

      return HousesResponseModel.fromJson(
        decoded,
      );
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException(ApiErrorCode.timeout);
    } on FormatException {
      throw const ApiException(ApiErrorCode.invalidResponse);
    } catch (_) {
      throw const ApiException(ApiErrorCode.network);
    }
  }

  Future<HouseDetailModel> getHouseDetail(
    String userId,
    int houseNumber, {
    required String language,
  }) async {
    final uri = Uri.parse(
      ApiConfig.houseDetail(
        userId,
        houseNumber,
        lang: language,
      ),
    );

    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          ApiErrorCode.requestFailed,
          backendDetail: _extractErrorDetail(response),
        );
      }

      final decoded = jsonDecode(response.body);

      if (decoded is! Map<String, dynamic>) {
        throw const ApiException(
          ApiErrorCode.invalidResponse,
        );
      }

      return HouseDetailModel.fromJson(decoded);
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException(ApiErrorCode.timeout);
    } on FormatException {
      throw const ApiException(ApiErrorCode.invalidResponse);
    } catch (_) {
      throw const ApiException(ApiErrorCode.network);
    }
  }

  Future<AccountProfileModel> getAccountProfile(
    String userId,
  ) async {
    final uri = Uri.parse(
      ApiConfig.accountProfile(userId),
    );

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ).timeout(
      const Duration(seconds: 15),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Error loading account profile: '
        '${response.statusCode} ${response.body}',
      );
    }

    final decoded = jsonDecode(
      response.body,
    );

    if (decoded is! Map<String, dynamic>) {
      throw Exception(
        'Invalid account profile response.',
      );
    }

    return AccountProfileModel.fromJson(
      decoded,
    );
  }

  Future<AccountProfileUpdateModel> updateAccountProfile({
    required String userId,
    required String displayName,
    required String username,
  }) async {
    final uri = Uri.parse(
      ApiConfig.accountProfile(userId),
    );

    final response = await http
        .patch(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            'display_name': displayName,
            'username': username,
          }),
        )
        .timeout(
          const Duration(seconds: 15),
        );

    dynamic decoded;

    try {
      decoded = jsonDecode(response.body);
    } catch (_) {
      decoded = null;
    }

    if (response.statusCode != 200) {
      String message = 'Could not update profile.';

      if (decoded is Map<String, dynamic>) {
        final detail = decoded['detail'];

        if (detail != null) {
          message = detail.toString();
        }
      }

      throw Exception(message);
    }

    if (decoded is! Map<String, dynamic>) {
      throw Exception(
        'Invalid account profile update response.',
      );
    }

    return AccountProfileUpdateModel.fromJson(
      decoded,
    );
  }
}

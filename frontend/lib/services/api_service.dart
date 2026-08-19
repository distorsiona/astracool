import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/birth_data_model.dart';
import '../models/zodiac_profile_model.dart';
import '../models/natal_chart_model.dart';
import '../models/today_model.dart';
import '../models/house_model.dart';
import '../models/house_detail_model.dart';


// ============================================================
// error personalizado para las llamadas a la api
//
// así todas las pantallas reciben errores
// con mensajes entendibles y consistentes.
// ============================================================

class ApiException implements Exception {
  final String message;

  const ApiException(
    this.message,
  );

  @override
  String toString() {
    return message;
  }
}


// ============================================================
// servicio principal para comunicarse con el backend
// ============================================================

class ApiService {

  // ==========================================================
  // análisis astrológico usando datos de nacimiento
  // ==========================================================

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
              'Content-Type':
                  'application/json',
              'Accept':
                  'application/json',
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

      if (
          response.statusCode < 200 ||
          response.statusCode >= 300) {
        throw ApiException(
          _extractError(
            response,
          ),
        );
      }

      final dynamic decoded =
          jsonDecode(
        response.body,
      );

      if (decoded
          is! Map<String, dynamic>) {
        throw const ApiException(
          'La API devolvió un formato inesperado.',
        );
      }

      return ZodiacProfileModel
          .fromAstraJson(
        decoded,
      );
    } catch (error) {
      if (error
          is ApiException) {
        rethrow;
      }

      throw ApiException(
        'No fue posible conectar con Astra API: $error',
      );
    }
  }


  // ==========================================================
  // perfil real del usuario
  // ==========================================================

  static Future<ZodiacProfileModel>
      getProfile({
    required String userId,
  }) async {
    final Uri uri = Uri.parse(
      '${ApiConfig.profile}/$userId',
    );

    try {
      final response = await http
          .get(
            uri,
            headers: {
              'Accept':
                  'application/json',
            },
          )
          .timeout(
            const Duration(
              seconds: 30,
            ),
          );

      if (
          response.statusCode < 200 ||
          response.statusCode >= 300) {
        throw ApiException(
          _extractError(
            response,
          ),
        );
      }

      final dynamic decoded =
          jsonDecode(
        response.body,
      );

      if (decoded
          is! Map<String, dynamic>) {
        throw const ApiException(
          'El backend devolvió un perfil con formato inesperado.',
        );
      }

      return ZodiacProfileModel
          .fromJson(
        decoded,
      );
    } catch (error) {
      if (error
          is ApiException) {
        rethrow;
      }

      throw ApiException(
        'No fue posible conectar con el backend: $error',
      );
    }
  }


  // ==========================================================
  // carta natal completa del usuario
  // ==========================================================

  static Future<NatalChartModel>
      getChart({
    required String userId,
  }) async {
    final Uri uri = Uri.parse(
      '${ApiConfig.baseUrl}'
      '/api/chart/'
      '$userId',
    );

    try {
      final response = await http
          .get(
            uri,
            headers: {
              'Accept':
                  'application/json',
            },
          )
          .timeout(
            const Duration(
              seconds: 30,
            ),
          );

      if (
          response.statusCode < 200 ||
          response.statusCode >= 300) {
        throw ApiException(
          _extractError(
            response,
          ),
        );
      }

      final dynamic decoded =
          jsonDecode(
        response.body,
      );

      if (decoded
          is! Map<String, dynamic>) {
        throw const ApiException(
          'El backend devolvió una carta natal inválida.',
        );
      }

      return NatalChartModel
          .fromJson(
        decoded,
      );
    } catch (error) {
      if (error
          is ApiException) {
        rethrow;
      }

      throw ApiException(
        'No fue posible conectar con la carta natal: $error',
      );
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

  static Future<ChartHouse>
      getChartHouse({
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
      final response = await http
          .get(
            uri,
            headers: {
              'Accept':
                  'application/json',
            },
          )
          .timeout(
            const Duration(
              seconds: 30,
            ),
          );

      if (
          response.statusCode < 200 ||
          response.statusCode >= 300) {
        throw ApiException(
          _extractError(
            response,
          ),
        );
      }

      final dynamic decoded =
          jsonDecode(
        response.body,
      );

      if (decoded
          is! Map<String, dynamic>) {
        throw const ApiException(
          'El backend devolvió una casa con formato inesperado.',
        );
      }

      final dynamic houseJson =
          decoded['house'];

      if (houseJson is! Map) {
        throw const ApiException(
          'La API no entregó información válida para esta casa.',
        );
      }

      return ChartHouse.fromJson(
        Map<String, dynamic>.from(
          houseJson,
        ),
      );
    } catch (error) {
      if (error
          is ApiException) {
        rethrow;
      }

      throw ApiException(
        'No fue posible cargar la casa $houseNumber: $error',
      );
    }
  }


  // ==========================================================
  // energía astrológica de hoy
  // ==========================================================

  static Future<TodayModel>
      getToday({
    required String userId,
  }) async {
    final Uri uri = Uri.parse(
      '${ApiConfig.baseUrl}'
      '/api/today/'
      '$userId',
    );

    try {
      final response = await http
          .get(
            uri,
            headers: {
              'Accept':
                  'application/json',
            },
          )
          .timeout(
            const Duration(
              seconds: 30,
            ),
          );

      if (
          response.statusCode < 200 ||
          response.statusCode >= 300) {
        throw ApiException(
          _extractError(
            response,
          ),
        );
      }

      final dynamic decoded =
          jsonDecode(
        response.body,
      );

      if (decoded
          is! Map<String, dynamic>) {
        throw const ApiException(
          'El servidor devolvió datos inválidos.',
        );
      }

      return TodayModel.fromJson(
        decoded,
      );
    } catch (error) {
      if (error
          is ApiException) {
        rethrow;
      }

      throw ApiException(
        'No fue posible cargar tu energía de hoy: $error',
      );
    }
  }


  // ==========================================================
  // obtener el mensaje real de error que manda fastapi
  //
  // normalmente fastapi responde algo como:
  //
  // {
  //   "detail": "mensaje del error"
  // }
  //
  // esta función intenta recuperar ese detail.
  // ==========================================================

  static String _extractError(
    http.Response response,
  ) {
    try {
      final dynamic decoded =
          jsonDecode(
        response.body,
      );

      if (decoded
          is Map<String, dynamic>) {
        final dynamic detail =
            decoded['detail'];

        if (detail != null) {
          return detail
              .toString();
        }
      }
    } catch (_) {
      // si la respuesta no era json
      // simplemente usamos el mensaje
      // general que está más abajo.
    }

    return (
      'Error ${response.statusCode} '
      'al consultar Astra API.'
    );
  }

    Future<HousesResponseModel> getHouses(
    String userId,
  ) async {
    final uri = Uri.parse(
      ApiConfig.houses(userId),
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
        'Error loading houses: '
        '${response.statusCode} ${response.body}',
      );
    }

    final decoded = jsonDecode(
      response.body,
    );

    if (decoded is! Map<String, dynamic>) {
      throw Exception(
        'Invalid houses response.',
      );
    }

    return HousesResponseModel.fromJson(
      decoded,
    );
  }

    Future<HouseDetailModel> getHouseDetail(
    String userId,
    int houseNumber,
  ) async {
    final uri = Uri.parse(
      ApiConfig.houseDetail(
        userId,
        houseNumber,
      ),
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
        'Error loading house detail: '
        '${response.statusCode} ${response.body}',
      );
    }

    final decoded = jsonDecode(response.body);

    if (decoded is! Map<String, dynamic>) {
      throw Exception(
        'Invalid house detail response.',
      );
    }

    return HouseDetailModel.fromJson(decoded);
  }
}
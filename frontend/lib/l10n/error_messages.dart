import 'package:flutter/widgets.dart';

import '../services/api_service.dart';
import '../services/auth_service.dart';
import 'generated/app_localizations.dart';

// convierte cualquier error capturado en las pantallas en un
// mensaje que se le puede mostrar al usuario.
//
// si el backend mandó un "detail" propio, se muestra tal cual
// (no se traduce: es contenido que no controlamos). si no,
// se usa un mensaje genérico localizado según el "code".
String describeError(BuildContext context, Object error) {
  final l10n = AppLocalizations.of(context)!;

  if (error is ApiException) {
    final detail = error.backendDetail;

    if (detail != null && detail.trim().isNotEmpty) {
      return detail;
    }

    switch (error.code) {
      case ApiErrorCode.network:
        return l10n.errorNetwork;
      case ApiErrorCode.timeout:
        return l10n.errorTimeout;
      case ApiErrorCode.invalidResponse:
        return l10n.errorInvalidResponse;
      case ApiErrorCode.requestFailed:
        return l10n.errorGeneric;
    }
  }

  if (error is AuthException) {
    final detail = error.backendDetail;

    if (detail != null && detail.trim().isNotEmpty) {
      return detail;
    }

    switch (error.code) {
      case AuthErrorCode.network:
        return l10n.errorNetwork;
      case AuthErrorCode.timeout:
        return l10n.errorTimeout;
      case AuthErrorCode.invalidResponse:
        return l10n.errorInvalidResponse;
      case AuthErrorCode.requestFailed:
        return l10n.errorGeneric;
    }
  }

  return l10n.errorGeneric;
}

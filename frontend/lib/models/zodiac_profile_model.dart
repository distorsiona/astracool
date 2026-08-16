enum ZodiacElement {
  fire,
  earth,
  air,
  water,
}

enum ZodiacModality {
  cardinal,
  fixed,
  mutable,
}

class BigThreeItem {
  final String label;
  final String sign;
  final double degree;
  final String symbol;
  final int? house;

  const BigThreeItem({
    required this.label,
    required this.sign,
    required this.degree,
    required this.symbol,
    this.house,
  });

  String get formattedDegree {
    return '${degree.toStringAsFixed(2)}°';
  }
}

class ZodiacProfileModel {
  final String? id;
  final String? displayName;
  final String? username;

  final String sign;

  final ZodiacElement element;
  final ZodiacModality modality;

  final String rulingPlanet;
  final String symbol;

  final BigThreeItem sun;
  final BigThreeItem moon;
  final BigThreeItem rising;

  const ZodiacProfileModel({
    this.id,
    this.displayName,
    this.username,
    required this.sign,
    required this.element,
    required this.modality,
    required this.rulingPlanet,
    required this.symbol,
    required this.sun,
    required this.moon,
    required this.rising,
  });

  // ============================================================
  // RANGO DE FECHAS DEL SIGNO
  // ============================================================

  String get dateRange {
    switch (sign.toLowerCase()) {
      case 'aries':
        return '21 mar - 19 apr';

      case 'taurus':
        return '20 apr - 20 may';

      case 'gemini':
        return '21 may - 20 jun';

      case 'cancer':
        return '21 jun - 22 jul';

      case 'leo':
        return '23 jul - 22 aug';

      case 'virgo':
        return '23 aug - 22 sep';

      case 'libra':
        return '23 sep - 22 oct';

      case 'scorpio':
        return '23 oct - 21 nov';

      case 'sagittarius':
        return '22 nov - 21 dec';

      case 'capricorn':
        return '22 dec - 19 jan';

      case 'aquarius':
        return '20 jan - 18 feb';

      case 'pisces':
        return '19 feb - 20 mar';

      default:
        return '';
    }
  }

  // ============================================================
  // PARSER DESDE ASTRA API
  // ============================================================

  factory ZodiacProfileModel.fromAstraJson(
    Map<String, dynamic> json,
  ) {
    final dynamic rawBigThree = json['big_three'];
    final dynamic rawZodiac = json['zodiac'];

    if (rawBigThree is! Map) {
      throw const FormatException(
        'Astra API no entregó "big_three" correctamente.',
      );
    }

    if (rawZodiac is! Map) {
      throw const FormatException(
        'Astra API no entregó "zodiac" correctamente.',
      );
    }

    final Map<String, dynamic> bigThree =
        Map<String, dynamic>.from(rawBigThree);

    final Map<String, dynamic> zodiac =
        Map<String, dynamic>.from(rawZodiac);

    final String sign =
        zodiac['sign']?.toString().trim() ?? '';

    return ZodiacProfileModel(
      sign: sign,

      element: _elementFromString(
        zodiac['element']?.toString(),
      ),

      modality: _modalityFromString(
        zodiac['modality']?.toString(),
      ),

      rulingPlanet:
          zodiac['ruling_planet']?.toString().trim() ?? '',

      symbol: _symbolForSign(sign),

      sun: _bigThreeFromJson(
        label: 'Sun',
        symbol: '☉',
        data: bigThree['sun'],
      ),

      moon: _bigThreeFromJson(
        label: 'Moon',
        symbol: '☾',
        data: bigThree['moon'],
      ),

      rising: _bigThreeFromJson(
        label: 'Rising',
        symbol: '↑',
        data: bigThree['rising'],
      ),
    );
  }

  // ============================================================
  // PARSER DESDE GET /api/profile/{user_id}
  // ============================================================

  factory ZodiacProfileModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final String sign =
        json['sign']?.toString().trim() ?? '';

    return ZodiacProfileModel(
      id: json['id']?.toString(),
      displayName: json['display_name']?.toString(),
      username: json['username']?.toString(),

      sign: sign,

      element: _elementFromString(
        json['element']?.toString(),
      ),

      modality: _modalityFromString(
        json['modality']?.toString(),
      ),

      rulingPlanet:
          json['ruling_planet']?.toString().trim() ?? '',

      symbol: _symbolForSign(sign),

      sun: _bigThreeFromJson(
        label: 'Sun',
        symbol: '☉',
        data: json['sun'],
      ),

      moon: _bigThreeFromJson(
        label: 'Moon',
        symbol: '☾',
        data: json['moon'],
      ),

      rising: _bigThreeFromJson(
        label: 'Rising',
        symbol: '↑',
        data: json['rising'],
      ),
    );
  }

  // ============================================================
  // BIG THREE
  // ============================================================

  static BigThreeItem _bigThreeFromJson({
    required String label,
    required String symbol,
    required dynamic data,
  }) {
    if (data is! Map) {
      throw FormatException(
        'Astra API no entregó correctamente "$label".',
      );
    }

    final Map<String, dynamic> item =
        Map<String, dynamic>.from(data);

    return BigThreeItem(
      label: label,
      symbol: symbol,

      sign:
          item['sign']?.toString().trim() ?? '',

      degree:
          (item['degree'] as num?)?.toDouble() ?? 0.0,

      house:
          (item['house'] as num?)?.toInt(),
    );
  }

  // ============================================================
  // ELEMENTO
  // ============================================================

  static ZodiacElement _elementFromString(
    String? value,
  ) {
    switch (value?.toLowerCase().trim()) {
      case 'fire':
        return ZodiacElement.fire;

      case 'earth':
        return ZodiacElement.earth;

      case 'air':
        return ZodiacElement.air;

      case 'water':
        return ZodiacElement.water;

      default:
        return ZodiacElement.water;
    }
  }

  // ============================================================
  // MODALIDAD
  // ============================================================

  static ZodiacModality _modalityFromString(
    String? value,
  ) {
    switch (value?.toLowerCase().trim()) {
      case 'cardinal':
        return ZodiacModality.cardinal;

      case 'fixed':
        return ZodiacModality.fixed;

      case 'mutable':
        return ZodiacModality.mutable;

      default:
        return ZodiacModality.fixed;
    }
  }

  // ============================================================
  // SÍMBOLO
  // ============================================================

  static String _symbolForSign(
    String sign,
  ) {
    switch (sign.toLowerCase().trim()) {
      case 'aries':
        return '♈';

      case 'taurus':
        return '♉';

      case 'gemini':
        return '♊';

      case 'cancer':
        return '♋';

      case 'leo':
        return '♌';

      case 'virgo':
        return '♍';

      case 'libra':
        return '♎';

      case 'scorpio':
        return '♏';

      case 'sagittarius':
        return '♐';

      case 'capricorn':
        return '♑';

      case 'aquarius':
        return '♒';

      case 'pisces':
        return '♓';

      default:
        return '';
    }
  }
}
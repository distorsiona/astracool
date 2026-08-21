class NatalChartModel {
  final ChartProfile profile;
  final NatalChartData chart;

  const NatalChartModel({
    required this.profile,
    required this.chart,
  });

  factory NatalChartModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return NatalChartModel(
      profile: ChartProfile.fromJson(
        _map(json['profile']),
      ),
      chart: NatalChartData.fromJson(
        _map(json['chart']),
      ),
    );
  }
}

// ============================================================
// profile
//
// información general de la persona dueña de la carta
// ============================================================

class ChartProfile {
  final String id;
  final String displayName;
  final String username;

  final String sign;
  final String element;
  final String modality;
  final String rulingPlanet;

  const ChartProfile({
    required this.id,
    required this.displayName,
    required this.username,
    required this.sign,
    required this.element,
    required this.modality,
    required this.rulingPlanet,
  });

  factory ChartProfile.fromJson(
    Map<String, dynamic> json,
  ) {
    return ChartProfile(
      id: json['id']?.toString() ?? '',
      displayName: json['display_name']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      sign: json['sign']?.toString() ?? '',
      element: json['element']?.toString() ?? '',
      modality: json['modality']?.toString() ?? '',
      rulingPlanet: json['ruling_planet']?.toString() ?? '',
    );
  }
}

// ============================================================
// chart
//
// contiene toda la información de la carta natal
// ============================================================

class NatalChartData {
  final String id;

  final BigThreeData bigThree;

  final List<ChartPlanet> planets;
  final List<ChartHouse> houses;
  final List<ChartAspect> aspects;
  final List<ChartAspect> dominantAspects;

  // las casas que el backend calculó
  // como más importantes para esta persona
  final List<FeaturedHouse> featuredHouses;

  // patrones generales de la carta
  //
  // por ahora el backend puede no enviarlos,
  // por eso simplemente quedará como lista vacía
  final List<ChartPattern> dominantPatterns;

  // resumen general de la carta
  //
  // también puede venir vacío por ahora
  final String overview;

  final String? wheelUrl;
  final String? generatedAt;
  final String? updatedAt;

  const NatalChartData({
    required this.id,
    required this.bigThree,
    required this.planets,
    required this.houses,
    required this.aspects,
    required this.dominantAspects,
    required this.featuredHouses,
    required this.dominantPatterns,
    required this.overview,
    this.wheelUrl,
    this.generatedAt,
    this.updatedAt,
  });

  factory NatalChartData.fromJson(
    Map<String, dynamic> json,
  ) {
    return NatalChartData(
      id: json['id']?.toString() ?? '',
      bigThree: BigThreeData.fromJson(
        _map(json['big_three']),
      ),
      planets: _list(json['planets'])
          .map(
            (item) => ChartPlanet.fromJson(
              _map(item),
            ),
          )
          .toList(),
      houses: _list(json['houses'])
          .map(
            (item) => ChartHouse.fromJson(
              _map(item),
            ),
          )
          .toList(),
      aspects: _list(json['aspects'])
          .map(
            (item) => ChartAspect.fromJson(
              _map(item),
            ),
          )
          .toList(),
      dominantAspects: _list(
        json['dominant_aspects'],
      )
          .map(
            (item) => ChartAspect.fromJson(
              _map(item),
            ),
          )
          .toList(),
      featuredHouses: _list(
        json['featured_houses'],
      )
          .map(
            (item) => FeaturedHouse.fromJson(
              _map(item),
            ),
          )
          .toList(),
      dominantPatterns: _list(
        json['dominant_patterns'],
      )
          .map(
            (item) => ChartPattern.fromJson(
              _map(item),
            ),
          )
          .toList(),
      overview: json['overview']?.toString() ?? '',
      wheelUrl: json['wheel_url']?.toString(),
      generatedAt: json['generated_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
}

// ============================================================
// big three
//
// sol + luna + ascendente
// ============================================================

class BigThreeData {
  final ChartPlacement sun;
  final ChartPlacement moon;
  final ChartPlacement rising;

  const BigThreeData({
    required this.sun,
    required this.moon,
    required this.rising,
  });

  factory BigThreeData.fromJson(
    Map<String, dynamic> json,
  ) {
    return BigThreeData(
      sun: ChartPlacement.fromJson(
        _map(json['sun']),
      ),
      moon: ChartPlacement.fromJson(
        _map(json['moon']),
      ),
      rising: ChartPlacement.fromJson(
        _map(json['rising']),
      ),
    );
  }
}

// ============================================================
// placement
//
// posición básica de un planeta o punto
// ============================================================

class ChartPlacement {
  final String planet;
  final String sign;

  final double degree;
  final int? house;

  final bool retrograde;

  const ChartPlacement({
    required this.planet,
    required this.sign,
    required this.degree,
    required this.house,
    required this.retrograde,
  });

  factory ChartPlacement.fromJson(
    Map<String, dynamic> json,
  ) {
    return ChartPlacement(
      planet: json['planet']?.toString() ?? '',
      sign: json['sign']?.toString() ?? '',
      degree: _double(
        json['degree'],
      ),
      house: _nullableInt(
        json['house'],
      ),
      retrograde: _bool(
        json['retrograde'],
      ),
    );
  }
}

// ============================================================
// planet
//
// planeta dentro de la carta
// ============================================================

class ChartPlanet {
  final String planet;
  final String sign;

  final double degree;
  final int? house;

  final bool retrograde;

  // datos que pueden venir después
  // cuando agreguemos interpretaciones
  final String meaning;
  final String signInterpretation;
  final String houseInterpretation;
  final String interpretation;

  const ChartPlanet({
    required this.planet,
    required this.sign,
    required this.degree,
    required this.house,
    required this.retrograde,
    required this.meaning,
    required this.signInterpretation,
    required this.houseInterpretation,
    required this.interpretation,
  });

  factory ChartPlanet.fromJson(
    Map<String, dynamic> json,
  ) {
    return ChartPlanet(
      planet: json['planet']?.toString() ?? json['name']?.toString() ?? '',
      sign: json['sign']?.toString() ?? '',
      degree: _double(
        json['degree'] ?? json['norm_degree'],
      ),
      house: _nullableInt(
        json['house'],
      ),
      retrograde: _bool(
        json['retrograde'] ?? json['is_retro'],
      ),
      meaning: json['meaning']?.toString() ?? '',
      signInterpretation: json['sign_interpretation']?.toString() ?? '',
      houseInterpretation: json['house_interpretation']?.toString() ?? '',
      interpretation: json['interpretation']?.toString() ?? '',
    );
  }
}

// ============================================================
// house
//
// representa una de las 12 casas.
//
// ahora además del signo y grado también contiene:
// regente, planetas, intensidad y aspectos.
// ============================================================

class ChartHouse {
  final int number;

  final String sign;
  final double degree;

  final String title;
  final String subtitle;

  final String ruler;

  final String meaning;
  final String interpretation;

  final double strengthScore;
  final String strengthLabel;

  final List<String> themes;

  final List<ChartPlanet> planets;

  final List<HouseInfluence> supportiveInfluences;
  final List<HouseInfluence> challengingInfluences;

  final HouseRulerPlacement? rulerPlacement;

  const ChartHouse({
    required this.number,
    required this.sign,
    required this.degree,
    required this.title,
    required this.subtitle,
    required this.ruler,
    required this.meaning,
    required this.interpretation,
    required this.strengthScore,
    required this.strengthLabel,
    required this.themes,
    required this.planets,
    required this.supportiveInfluences,
    required this.challengingInfluences,
    required this.rulerPlacement,
  });

  factory ChartHouse.fromJson(
    Map<String, dynamic> json,
  ) {
    return ChartHouse(
      number: _int(
        json['house'] ?? json['number'],
      ),
      sign: json['sign']?.toString() ?? '',
      degree: _double(
        json['degree'],
      ),
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      ruler: json['ruler']?.toString() ?? '',
      meaning: json['meaning']?.toString() ?? '',
      interpretation: json['interpretation']?.toString() ?? '',
      strengthScore: _double(
        json['strength_score'],
      ),
      strengthLabel: json['strength_label']?.toString() ?? '',
      themes: _stringList(
        json['themes'],
      ),
      planets: _list(
        json['planets'],
      )
          .map(
            (item) => ChartPlanet.fromJson(
              _map(item),
            ),
          )
          .toList(),
      supportiveInfluences: _list(
        json['supportive_influences'],
      )
          .map(
            (item) => HouseInfluence.fromJson(
              _map(item),
            ),
          )
          .toList(),
      challengingInfluences: _list(
        json['challenging_influences'],
      )
          .map(
            (item) => HouseInfluence.fromJson(
              _map(item),
            ),
          )
          .toList(),
      rulerPlacement: json['ruler_placement'] == null
          ? null
          : HouseRulerPlacement.fromJson(
              _map(
                json['ruler_placement'],
              ),
            ),
    );
  }
}

// ============================================================
// featured house
//
// estas son las casas que el backend considera
// más activas o importantes para esta carta.
//
// ojo:
// planets ahora son objetos ChartPlanet,
// no textos.
// ============================================================

class FeaturedHouse {
  final int number;

  final String sign;
  final double degree;

  final String title;
  final String subtitle;

  final String ruler;

  final double strengthScore;
  final String strengthLabel;

  final List<String> themes;

  final List<ChartPlanet> planets;

  final List<HouseInfluence> supportiveInfluences;
  final List<HouseInfluence> challengingInfluences;

  final HouseRulerPlacement? rulerPlacement;

  final String meaning;
  final String interpretation;

  const FeaturedHouse({
    required this.number,
    required this.sign,
    required this.degree,
    required this.title,
    required this.subtitle,
    required this.ruler,
    required this.strengthScore,
    required this.strengthLabel,
    required this.themes,
    required this.planets,
    required this.supportiveInfluences,
    required this.challengingInfluences,
    required this.rulerPlacement,
    required this.meaning,
    required this.interpretation,
  });

  factory FeaturedHouse.fromJson(
    Map<String, dynamic> json,
  ) {
    return FeaturedHouse(
      number: _int(
        json['house'] ?? json['number'],
      ),

      sign: json['sign']?.toString() ?? '',

      degree: _double(
        json['degree'],
      ),

      title: json['title']?.toString() ?? '',

      subtitle: json['subtitle']?.toString() ?? '',

      ruler: json['ruler']?.toString() ?? '',

      strengthScore: _double(
        json['strength_score'],
      ),

      strengthLabel: json['strength_label']?.toString() ?? '',

      themes: _stringList(
        json['themes'],
      ),

      // el backend devuelve planetas completos
      // dentro de cada featured house
      planets: _list(
        json['planets'],
      )
          .map(
            (item) => ChartPlanet.fromJson(
              _map(item),
            ),
          )
          .toList(),

      supportiveInfluences: _list(
        json['supportive_influences'],
      )
          .map(
            (item) => HouseInfluence.fromJson(
              _map(item),
            ),
          )
          .toList(),

      challengingInfluences: _list(
        json['challenging_influences'],
      )
          .map(
            (item) => HouseInfluence.fromJson(
              _map(item),
            ),
          )
          .toList(),

      rulerPlacement: json['ruler_placement'] == null
          ? null
          : HouseRulerPlacement.fromJson(
              _map(
                json['ruler_placement'],
              ),
            ),

      meaning: json['meaning']?.toString() ?? '',

      interpretation: json['interpretation']?.toString() ?? '',
    );
  }
}

// ============================================================
// posición del regente de una casa
//
// ejemplo:
//
// casa 1 en virgo
// virgo está regido por mercury
//
// acá guardamos dónde está mercury dentro de la carta.
// ============================================================

class HouseRulerPlacement {
  final String planet;
  final String sign;

  final double degree;
  final int? house;

  final bool retrograde;

  final String interpretation;

  const HouseRulerPlacement({
    required this.planet,
    required this.sign,
    required this.degree,
    required this.house,
    required this.retrograde,
    required this.interpretation,
  });

  factory HouseRulerPlacement.fromJson(
    Map<String, dynamic> json,
  ) {
    return HouseRulerPlacement(
      planet: json['planet']?.toString() ?? '',
      sign: json['sign']?.toString() ?? '',
      degree: _double(
        json['degree'],
      ),
      house: _nullableInt(
        json['house'],
      ),
      retrograde: _bool(
        json['retrograde'],
      ),
      interpretation: json['interpretation']?.toString() ?? '',
    );
  }
}

// ============================================================
// influencia sobre una casa
//
// representa un aspecto que toca un planeta
// ubicado dentro de esa casa.
// ============================================================

class HouseInfluence {
  final String first;
  final String second;
  final String type;

  final double orb;

  // supportive, challenging o neutral
  final String nature;

  // very strong, strong, moderate o wide
  final String strength;

  final String interpretation;

  const HouseInfluence({
    required this.first,
    required this.second,
    required this.type,
    required this.orb,
    required this.nature,
    required this.strength,
    required this.interpretation,
  });

  factory HouseInfluence.fromJson(
    Map<String, dynamic> json,
  ) {
    return HouseInfluence(
      first: json['first']?.toString() ?? '',
      second: json['second']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      orb: _double(
        json['orb'],
      ),
      nature: json['nature']?.toString() ?? '',
      strength: json['strength']?.toString() ?? '',
      interpretation: json['interpretation']?.toString() ?? '',
    );
  }
}

// ============================================================
// aspect
//
// relación entre dos planetas o puntos de la carta.
// ============================================================

class ChartAspect {
  final String first;
  final String second;
  final String type;

  final double orb;
  final double? diff;

  final String nature;
  final String strength;
  final String interpretation;

  const ChartAspect({
    required this.first,
    required this.second,
    required this.type,
    required this.orb,
    this.diff,
    required this.nature,
    required this.strength,
    required this.interpretation,
  });

  factory ChartAspect.fromJson(
    Map<String, dynamic> json,
  ) {
    return ChartAspect(
      first: json['first']?.toString() ??
          json['aspecting_planet']?.toString() ??
          '',
      second: json['second']?.toString() ??
          json['aspected_planet']?.toString() ??
          '',
      type: json['type']?.toString() ?? '',
      orb: _double(
        json['orb'],
      ),
      diff: json['diff'] == null
          ? null
          : _double(
              json['diff'],
            ),
      nature: json['nature']?.toString() ?? '',
      strength: json['strength']?.toString() ?? '',
      interpretation: json['interpretation']?.toString() ?? '',
    );
  }
}

// ============================================================
// dominant pattern
//
// lo dejamos preparado para cuando agreguemos
// patrones generales de la carta.
// ============================================================

class ChartPattern {
  final String id;
  final String title;
  final String type;

  final String strength;

  final List<String> objects;
  final List<String> themes;

  final String interpretation;

  const ChartPattern({
    required this.id,
    required this.title,
    required this.type,
    required this.strength,
    required this.objects,
    required this.themes,
    required this.interpretation,
  });

  factory ChartPattern.fromJson(
    Map<String, dynamic> json,
  ) {
    return ChartPattern(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      strength: json['strength']?.toString() ?? '',
      objects: _stringList(
        json['objects'],
      ),
      themes: _stringList(
        json['themes'],
      ),
      interpretation: json['interpretation']?.toString() ?? '',
    );
  }
}

// ============================================================
// mostrar grados
//
// la api mantiene el grado como decimal porque sirve
// mejor para hacer cálculos.
//
// acá lo transformamos solamente para mostrarlo.
//
// ejemplo:
//
// 1.7667
// pasa a
// 1°46'
//
// 16.43529
// pasa a
// 16°26'
// ============================================================

String formatAstrologyDegree(
  double decimalDegree,
) {
  var degree = decimalDegree.floor();

  var minutes = ((decimalDegree - degree) * 60).round();

  // puede pasar que al redondear
  // terminemos temporalmente con 60 minutos.
  //
  // en ese caso sumamos un grado
  // y volvemos los minutos a 00.
  if (minutes == 60) {
    degree += 1;
    minutes = 0;
  }

  return ("$degree°"
      "${minutes.toString().padLeft(2, '0')}'");
}

// ============================================================
// helpers para leer el json
//
// estas funciones evitan que la app se caiga
// si algún campo viene vacío o con otro tipo.
// ============================================================

Map<String, dynamic> _map(
  dynamic value,
) {
  if (value is Map<String, dynamic>) {
    return value;
  }

  if (value is Map) {
    return Map<String, dynamic>.from(
      value,
    );
  }

  return {};
}

List<dynamic> _list(
  dynamic value,
) {
  if (value is List) {
    return value;
  }

  return const [];
}

List<String> _stringList(
  dynamic value,
) {
  if (value is! List) {
    return const [];
  }

  return value
      .map(
        (item) => item.toString(),
      )
      .toList();
}

double _double(
  dynamic value,
) {
  if (value is num) {
    return value.toDouble();
  }

  return double.tryParse(
        value?.toString() ?? '',
      ) ??
      0;
}

int _int(
  dynamic value,
) {
  if (value is num) {
    return value.toInt();
  }

  return int.tryParse(
        value?.toString() ?? '',
      ) ??
      0;
}

int? _nullableInt(
  dynamic value,
) {
  if (value == null) {
    return null;
  }

  if (value is num) {
    return value.toInt();
  }

  return int.tryParse(
    value.toString(),
  );
}

bool _bool(
  dynamic value,
) {
  if (value is bool) {
    return value;
  }

  return value?.toString().toLowerCase() == 'true';
}

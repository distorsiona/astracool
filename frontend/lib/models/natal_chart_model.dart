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
// PROFILE
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
      id:
          json['id']?.toString() ?? '',

      displayName:
          json['display_name']
              ?.toString() ??
          '',

      username:
          json['username']
              ?.toString() ??
          '',

      sign:
          json['sign']
              ?.toString() ??
          '',

      element:
          json['element']
              ?.toString() ??
          '',

      modality:
          json['modality']
              ?.toString() ??
          '',

      rulingPlanet:
          json['ruling_planet']
              ?.toString() ??
          '',
    );
  }
}


// ============================================================
// CHART
// ============================================================

class NatalChartData {
  final String id;

  final BigThreeData bigThree;

  final List<ChartPlanet> planets;
  final List<ChartHouse> houses;
  final List<ChartAspect> aspects;
  final List<ChartAspect> dominantAspects;

  final String? wheelUrl;
  final String? generatedAt;

  const NatalChartData({
    required this.id,
    required this.bigThree,
    required this.planets,
    required this.houses,
    required this.aspects,
    required this.dominantAspects,
    this.wheelUrl,
    this.generatedAt,
  });

  factory NatalChartData.fromJson(
    Map<String, dynamic> json,
  ) {
    return NatalChartData(
      id:
          json['id']?.toString() ?? '',

      bigThree:
          BigThreeData.fromJson(
        _map(json['big_three']),
      ),

      planets:
          _list(json['planets'])
              .map(
                (item) =>
                    ChartPlanet.fromJson(
                  _map(item),
                ),
              )
              .toList(),

      houses:
          _list(json['houses'])
              .map(
                (item) =>
                    ChartHouse.fromJson(
                  _map(item),
                ),
              )
              .toList(),

      aspects:
          _list(json['aspects'])
              .map(
                (item) =>
                    ChartAspect.fromJson(
                  _map(item),
                ),
              )
              .toList(),

      dominantAspects:
          _list(
            json['dominant_aspects'],
          )
              .map(
                (item) =>
                    ChartAspect.fromJson(
                  _map(item),
                ),
              )
              .toList(),

      wheelUrl:
          json['wheel_url']
              ?.toString(),

      generatedAt:
          json['generated_at']
              ?.toString(),
    );
  }
}


// ============================================================
// BIG THREE
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
      sun:
          ChartPlacement.fromJson(
        _map(json['sun']),
      ),

      moon:
          ChartPlacement.fromJson(
        _map(json['moon']),
      ),

      rising:
          ChartPlacement.fromJson(
        _map(json['rising']),
      ),
    );
  }
}


// ============================================================
// PLACEMENT
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
      planet:
          json['planet']
              ?.toString() ??
          '',

      sign:
          json['sign']
              ?.toString() ??
          '',

      degree:
          _double(
            json['degree'],
          ),

      house:
          _nullableInt(
            json['house'],
          ),

      retrograde:
          _bool(
            json['retrograde'],
          ),
    );
  }
}


// ============================================================
// PLANET
// ============================================================

class ChartPlanet {
  final String planet;
  final String sign;

  final double degree;
  final int? house;

  final bool retrograde;

  const ChartPlanet({
    required this.planet,
    required this.sign,
    required this.degree,
    required this.house,
    required this.retrograde,
  });

  factory ChartPlanet.fromJson(
    Map<String, dynamic> json,
  ) {
    return ChartPlanet(
      planet:
          json['planet']
              ?.toString() ??
          json['name']
              ?.toString() ??
          '',

      sign:
          json['sign']
              ?.toString() ??
          '',

      degree:
          _double(
            json['degree'] ??
            json['norm_degree'],
          ),

      house:
          _nullableInt(
            json['house'],
          ),

      retrograde:
          _bool(
            json['retrograde'] ??
            json['is_retro'],
          ),
    );
  }
}


// ============================================================
// HOUSE
// ============================================================

class ChartHouse {
  final int number;
  final String sign;
  final double degree;

  const ChartHouse({
    required this.number,
    required this.sign,
    required this.degree,
  });

  factory ChartHouse.fromJson(
    Map<String, dynamic> json,
  ) {
    return ChartHouse(
      number:
          _int(
        json['house'] ??
        json['number'],
      ),

      sign:
          json['sign']
              ?.toString() ??
          '',

      degree:
          _double(
        json['degree'],
      ),
    );
  }
}


// ============================================================
// ASPECT
// ============================================================

class ChartAspect {
  final String first;
  final String second;
  final String type;

  final double orb;
  final double? diff;

  const ChartAspect({
    required this.first,
    required this.second,
    required this.type,
    required this.orb,
    this.diff,
  });

  factory ChartAspect.fromJson(
    Map<String, dynamic> json,
  ) {
    return ChartAspect(
      first:
          json['first']
              ?.toString() ??
          json['aspecting_planet']
              ?.toString() ??
          '',

      second:
          json['second']
              ?.toString() ??
          json['aspected_planet']
              ?.toString() ??
          '',

      type:
          json['type']
              ?.toString() ??
          '',

      orb:
          _double(
        json['orb'],
      ),

      diff:
          json['diff'] == null
              ? null
              : _double(
                  json['diff'],
                ),
    );
  }
}


// ============================================================
// JSON HELPERS
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

  return value
          ?.toString()
          .toLowerCase() ==
      'true';
}
class HousePlanetModel {
  final String name;
  final String symbol;
  final String? sign;
  final double? degree;
  final String? formattedDegree;
  final bool isRetrograde;

  const HousePlanetModel({
    required this.name,
    required this.symbol,
    this.sign,
    this.degree,
    this.formattedDegree,
    required this.isRetrograde,
  });

  factory HousePlanetModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return HousePlanetModel(
      name: json['name'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '•',
      sign: json['sign'] as String?,
      degree: (json['degree'] as num?)?.toDouble(),
      formattedDegree: json['formatted_degree'] as String?,
      isRetrograde: json['is_retrograde'] as bool? ?? false,
    );
  }
}

class HouseActivityModel {
  final int score;
  final String level;

  const HouseActivityModel({
    required this.score,
    required this.level,
  });

  factory HouseActivityModel.fromJson(Map<String, dynamic> json) {
    return HouseActivityModel(
      score: json['score'] as int? ?? 0,
      level: json['level'] as String? ?? 'LOW',
    );
  }
}

class HouseModel {
  final int house;
  final String roman;

  final String title;
  final String subtitle;

  final String sign;

  final double degree;
  final String formattedDegree;

  final String ruler;

  final List<HousePlanetModel> planets;
  final List<String> keywords;

  final HouseActivityModel activity;

  const HouseModel({
    required this.house,
    required this.roman,
    required this.title,
    required this.subtitle,
    required this.sign,
    required this.degree,
    required this.formattedDegree,
    required this.ruler,
    required this.planets,
    required this.keywords,
    required this.activity,
  });

  factory HouseModel.fromJson(Map<String, dynamic> json) {
    final planetsJson = json['planets'] as List<dynamic>? ?? const [];

    final keywordsJson = json['keywords'] as List<dynamic>? ?? const [];

    return HouseModel(
      house: json['house'] as int? ?? 0,
      roman: json['roman'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      sign: json['sign'] as String? ?? '',
      degree: (json['degree'] as num?)?.toDouble() ?? 0.0,
      formattedDegree: json['formatted_degree'] as String? ?? '',
      ruler: json['ruler'] as String? ?? '',
      planets: planetsJson
          .map(
            (item) => HousePlanetModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
      keywords: keywordsJson.map((item) => item.toString()).toList(),
      activity: HouseActivityModel.fromJson(
        json['activity'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }
}

class HousesResponseModel {
  final String userId;
  final List<HouseModel> houses;

  const HousesResponseModel({
    required this.userId,
    required this.houses,
  });

  factory HousesResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final housesJson = json['houses'] as List<dynamic>? ?? const [];

    return HousesResponseModel(
      userId: json['user_id'] as String? ?? '',
      houses: housesJson
          .map(
            (item) => HouseModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}

import 'house_model.dart';

class RulerPlacementModel {
  final String planet;
  final String symbol;
  final String? sign;
  final int? house;
  final double? degree;
  final String? formattedDegree;
  final bool isRetrograde;

  const RulerPlacementModel({
    required this.planet,
    required this.symbol,
    this.sign,
    this.house,
    this.degree,
    this.formattedDegree,
    required this.isRetrograde,
  });

  factory RulerPlacementModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return RulerPlacementModel(
      planet: json['planet'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '•',
      sign: json['sign'] as String?,
      house: (json['house'] as num?)?.toInt(),
      degree: (json['degree'] as num?)?.toDouble(),
      formattedDegree: json['formatted_degree'] as String?,
      isRetrograde: json['is_retrograde'] as bool? ?? false,
    );
  }
}

class PlanetInfluenceModel {
  final String planet;
  final String symbol;
  final String title;
  final String interpretation;

  const PlanetInfluenceModel({
    required this.planet,
    required this.symbol,
    required this.title,
    required this.interpretation,
  });

  factory PlanetInfluenceModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return PlanetInfluenceModel(
      planet: json['planet'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '•',
      title: json['title'] as String? ?? '',
      interpretation: json['interpretation'] as String? ?? '',
    );
  }
}

class HouseInterpretationModel {
  final String summary;

  final String signTitle;
  final String signInterpretation;

  final String rulerTitle;
  final String rulerInterpretation;

  final List<PlanetInfluenceModel> planetInfluences;
  final List<String> howThisMayShowUp;

  const HouseInterpretationModel({
    required this.summary,
    required this.signTitle,
    required this.signInterpretation,
    required this.rulerTitle,
    required this.rulerInterpretation,
    required this.planetInfluences,
    required this.howThisMayShowUp,
  });

  factory HouseInterpretationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final influences = json['planet_influences'] as List<dynamic>? ?? const [];

    final showUp = json['how_this_may_show_up'] as List<dynamic>? ?? const [];

    return HouseInterpretationModel(
      summary: json['summary'] as String? ?? '',
      signTitle: json['sign_title'] as String? ?? '',
      signInterpretation: json['sign_interpretation'] as String? ?? '',
      rulerTitle: json['ruler_title'] as String? ?? '',
      rulerInterpretation: json['ruler_interpretation'] as String? ?? '',
      planetInfluences: influences
          .whereType<Map<String, dynamic>>()
          .map(PlanetInfluenceModel.fromJson)
          .toList(),
      howThisMayShowUp: showUp.map((item) => item.toString()).toList(),
    );
  }
}

class HouseDetailModel {
  final String userId;

  final HouseModel house;

  final RulerPlacementModel? rulerPlacement;

  final HouseInterpretationModel interpretation;

  const HouseDetailModel({
    required this.userId,
    required this.house,
    required this.rulerPlacement,
    required this.interpretation,
  });

  factory HouseDetailModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rulerJson = json['ruler_placement'];

    return HouseDetailModel(
      userId: json['user_id'] as String? ?? '',
      house: HouseModel.fromJson(
        json['house'] as Map<String, dynamic>? ?? const {},
      ),
      rulerPlacement: rulerJson is Map<String, dynamic>
          ? RulerPlacementModel.fromJson(rulerJson)
          : null,
      interpretation: HouseInterpretationModel.fromJson(
        json['interpretation'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }
}

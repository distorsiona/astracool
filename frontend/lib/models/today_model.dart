class TodayModel {
  final String date;
  final String moonSign;
  final String moonSubtitle;

  final String interpretation;
  final String quote;

  final TodayBigThree bigThree;

  final List<TodayTransit> transits;
  final List<TodayHouse> affectedHouses;
  final List<TodayTheme> themes;

  final String focus;
  final String luckyTime;
  final String luckyColor;

  const TodayModel({
    required this.date,
    required this.moonSign,
    required this.moonSubtitle,
    required this.interpretation,
    required this.quote,
    required this.bigThree,
    required this.transits,
    required this.affectedHouses,
    required this.themes,
    required this.focus,
    required this.luckyTime,
    required this.luckyColor,
  });

  factory TodayModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TodayModel(
      date: json['date']?.toString() ?? '',
      moonSign:
          json['moon_sign']?.toString() ?? '',
      moonSubtitle:
          json['moon_subtitle']?.toString() ?? '',
      interpretation:
          json['interpretation']?.toString() ?? '',
      quote:
          json['quote']?.toString() ?? '',

      bigThree: TodayBigThree.fromJson(
        _map(json['big_three']),
      ),

      transits: _list(json['transits'])
          .map(
            (item) => TodayTransit.fromJson(
              _map(item),
            ),
          )
          .toList(),

      affectedHouses:
          _list(json['affected_houses'])
              .map(
                (item) => TodayHouse.fromJson(
                  _map(item),
                ),
              )
              .toList(),

      themes: _list(json['themes'])
          .map(
            (item) => TodayTheme.fromJson(
              _map(item),
            ),
          )
          .toList(),

      focus:
          json['focus']?.toString() ?? '',
      luckyTime:
          json['lucky_time']?.toString() ?? '',
      luckyColor:
          json['lucky_color']?.toString() ?? '',
    );
  }
}


// ============================================================
// BIG THREE
// ============================================================

class TodayBigThree {
  final String sun;
  final String moon;
  final String rising;

  const TodayBigThree({
    required this.sun,
    required this.moon,
    required this.rising,
  });

  factory TodayBigThree.fromJson(
    Map<String, dynamic> json,
  ) {
    return TodayBigThree(
      sun: json['sun']?.toString() ?? '',
      moon: json['moon']?.toString() ?? '',
      rising:
          json['rising']?.toString() ?? '',
    );
  }
}


// ============================================================
// TRANSITS
// ============================================================

class TodayTransit {
  final String first;
  final String aspect;
  final String second;

  final String title;
  final String description;
  final String status;

  const TodayTransit({
    required this.first,
    required this.aspect,
    required this.second,
    required this.title,
    required this.description,
    required this.status,
  });

  factory TodayTransit.fromJson(
    Map<String, dynamic> json,
  ) {
    return TodayTransit(
      first:
          json['first']?.toString() ?? '',
      aspect:
          json['aspect']?.toString() ?? '',
      second:
          json['second']?.toString() ?? '',
      title:
          json['title']?.toString() ?? '',
      description:
          json['description']?.toString() ?? '',
      status:
          json['status']?.toString() ?? '',
    );
  }
}


// ============================================================
// HOUSE
// ============================================================

class TodayHouse {
  final int number;
  final String title;
  final String subtitle;
  final String description;

  const TodayHouse({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  factory TodayHouse.fromJson(
    Map<String, dynamic> json,
  ) {
    return TodayHouse(
      number:
          (json['number'] as num?)?.toInt() ?? 0,
      title:
          json['title']?.toString() ?? '',
      subtitle:
          json['subtitle']?.toString() ?? '',
      description:
          json['description']?.toString() ?? '',
    );
  }
}


// ============================================================
// THEME
// ============================================================

class TodayTheme {
  final String name;
  final int value;

  const TodayTheme({
    required this.name,
    required this.value,
  });

  factory TodayTheme.fromJson(
    Map<String, dynamic> json,
  ) {
    return TodayTheme(
      name:
          json['name']?.toString() ?? '',
      value:
          (json['value'] as num?)?.toInt() ?? 0,
    );
  }
}


// ============================================================
// HELPERS
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
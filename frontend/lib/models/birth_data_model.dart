class BirthDataModel {
  final int day;
  final int month;
  final int year;

  final int hour;
  final int minute;

  final double lat;
  final double lon;

  final double timezone;

  final String houseType;
  final bool isAsteroids;

  const BirthDataModel({
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.minute,
    required this.lat,
    required this.lon,
    required this.timezone,
    this.houseType = 'placidus',
    this.isAsteroids = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'month': month,
      'year': year,
      'hour': hour,
      'minute': minute,
      'lat': lat,
      'lon': lon,
      'timezone': timezone,
      'house_type': houseType,
      'is_asteroids': isAsteroids,
    };
  }
}
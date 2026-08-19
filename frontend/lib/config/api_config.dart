class ApiConfig {
  static const String baseUrl = 'http://127.0.0.1:8001';

  static const String astraProfileAnalysis =
      '$baseUrl/api/astra/profile-analysis';

  static const String profile =
      '$baseUrl/api/profile';

  static String houses(String userId) =>
      '$baseUrl/api/houses/$userId';

  static String houseDetail(
    String userId,
    int houseNumber,
  ) =>
      '$baseUrl/api/houses/$userId/$houseNumber';
}
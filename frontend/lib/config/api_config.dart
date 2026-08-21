class ApiConfig {
  static const String baseUrl = 'http://127.0.0.1:8001';

  static const String astraProfileAnalysis =
      '$baseUrl/api/astra/profile-analysis';

  static const String profile = '$baseUrl/api/profile';

  static String houses(String userId, {String? lang}) {
    final uri = Uri.parse('$baseUrl/api/houses/$userId');

    if (lang == null) {
      return uri.toString();
    }

    return uri.replace(queryParameters: {'lang': lang}).toString();
  }

  static String houseDetail(
    String userId,
    int houseNumber, {
    String? lang,
  }) {
    final uri = Uri.parse(
      '$baseUrl/api/houses/$userId/$houseNumber',
    );

    if (lang == null) {
      return uri.toString();
    }

    return uri.replace(queryParameters: {'lang': lang}).toString();
  }

  static String accountProfile(String userId) =>
      '$baseUrl/api/account-profile/$userId';
}

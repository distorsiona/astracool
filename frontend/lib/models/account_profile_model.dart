class BirthInformationModel {
  final String? birthDate;
  final String? birthTime;
  final String? birthPlace;

  const BirthInformationModel({
    this.birthDate,
    this.birthTime,
    this.birthPlace,
  });

  factory BirthInformationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return BirthInformationModel(
      birthDate: json['birth_date'] as String?,
      birthTime: json['birth_time'] as String?,
      birthPlace: json['birth_place'] as String?,
    );
  }
}

class AccountInformationModel {
  final String? email;
  final String? username;
  final String? memberSince;

  const AccountInformationModel({
    this.email,
    this.username,
    this.memberSince,
  });

  factory AccountInformationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AccountInformationModel(
      email: json['email'] as String?,
      username: json['username'] as String?,
      memberSince: json['member_since'] as String?,
    );
  }
}

class AccountPreferencesModel {
  final String language;
  final String theme;
  final bool notificationsEnabled;

  const AccountPreferencesModel({
    required this.language,
    required this.theme,
    required this.notificationsEnabled,
  });

  factory AccountPreferencesModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AccountPreferencesModel(
      language: json['language'] as String? ?? 'en',
      theme: json['theme'] as String? ?? 'light',
      notificationsEnabled:
          json['notifications_enabled'] as bool? ?? true,
    );
  }
}

class AccountProfileModel {
  final String userId;

  final String displayName;
  final String initials;
  final String? zodiacSign;

  final BirthInformationModel birth;
  final AccountInformationModel account;
  final AccountPreferencesModel preferences;

  const AccountProfileModel({
    required this.userId,
    required this.displayName,
    required this.initials,
    required this.zodiacSign,
    required this.birth,
    required this.account,
    required this.preferences,
  });

  factory AccountProfileModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AccountProfileModel(
      userId: json['user_id'] as String? ?? '',
      displayName: json['display_name'] as String? ?? '',
      initials: json['initials'] as String? ?? '',
      zodiacSign: json['zodiac_sign'] as String?,
      birth: BirthInformationModel.fromJson(
        json['birth'] as Map<String, dynamic>? ?? const {},
      ),
      account: AccountInformationModel.fromJson(
        json['account'] as Map<String, dynamic>? ?? const {},
      ),
      preferences: AccountPreferencesModel.fromJson(
        json['preferences'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }
}

class AccountProfileUpdateModel {
  final String message;
  final String displayName;
  final String initials;
  final String username;

  const AccountProfileUpdateModel({
    required this.message,
    required this.displayName,
    required this.initials,
    required this.username,
  });

  factory AccountProfileUpdateModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AccountProfileUpdateModel(
      message: json['message'] as String? ?? '',
      displayName: json['display_name'] as String? ?? '',
      initials: json['initials'] as String? ?? '',
      username: json['username'] as String? ?? '',
    );
  }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/generated/app_localizations.dart';
import '../l10n/locale_controller.dart';
import '../models/account_profile_model.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../theme/zodiac_theme.dart';
import '../widgets/astrology_top_navigation.dart';

import 'chart_screen.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'today_screen.dart';

import 'account_profile/widgets/account_information_card.dart';
import 'account_profile/widgets/birth_information_card.dart';
import 'account_profile/widgets/preferences_card.dart';
import 'account_profile/widgets/profile_identity_card.dart';
import 'account_profile/widgets/profile_privacy_banner.dart';
import 'account_profile/widgets/profile_quote_card.dart';
import 'account_profile/widgets/support_card.dart';

class AccountProfileScreen extends StatefulWidget {
  final String userId;
  final String? zodiacSign;

  const AccountProfileScreen({
    super.key,
    required this.userId,
    this.zodiacSign,
  });

  @override
  State<AccountProfileScreen> createState() =>
      _AccountProfileScreenState();
}

class _AccountProfileScreenState
    extends State<AccountProfileScreen> {
  final ApiService _apiService = ApiService();

  AccountProfileModel? _accountProfile;

  bool _loading = true;
  Object? _loadError;

  @override
  void initState() {
    super.initState();
    _loadAccountProfile();
  }

  // ============================================================
  // API
  // ============================================================

  Future<void> _loadAccountProfile() async {
    setState(() {
      _loading = true;
      _loadError = null;
    });

    try {
      final result = await _apiService.getAccountProfile(
        widget.userId,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _accountProfile = result;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _loadError = error;
        _loading = false;
      });
    }
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  void _goToToday() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => TodayScreen(
          userId: widget.userId,
        ),
      ),
    );
  }

  void _goToChart() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ChartScreen(
          userId: widget.userId,
        ),
      ),
    );
  }

  void _goToProfile() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(
          userId: widget.userId,
        ),
      ),
    );
  }

  // ============================================================
  // EDIT PROFILE
  // ============================================================

  Future<void> _showEditProfileDialog() async {
    final data = _accountProfile;

    if (data == null) {
      return;
    }

    final l10n = AppLocalizations.of(context)!;

    final displayNameController = TextEditingController(
      text: data.displayName,
    );

    final usernameController = TextEditingController(
      text: data.account.username ?? '',
    );

    final emailController = TextEditingController(
      text: data.account.email ?? '',
    );

    final sign =
        data.zodiacSign ??
        widget.zodiacSign ??
        'Virgo';

    final accentColor = ZodiacTheme.colorForSign(
      sign,
    );

    bool saving = false;
    String? dialogError;

    final updated = await showDialog<bool>(
      context: context,
      barrierDismissible: !saving,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (
            dialogContext,
            setDialogState,
          ) {
            Future<void> save() async {
              final displayName =
                  displayNameController.text.trim();

              final username =
                  usernameController.text
                      .trim()
                      .toLowerCase();

              if (displayName.isEmpty) {
                setDialogState(() {
                  dialogError = l10n.nameEmptyError;
                });

                return;
              }

              if (username.length < 3) {
                setDialogState(() {
                  dialogError =
                      l10n.usernameMinLengthValidationError;
                });

                return;
              }

              if (username.contains(' ')) {
                setDialogState(() {
                  dialogError = l10n.usernameNoSpacesError;
                });

                return;
              }

              setDialogState(() {
                saving = true;
                dialogError = null;
              });

              try {
                await _apiService.updateAccountProfile(
                  userId: widget.userId,
                  displayName: displayName,
                  username: username,
                );

                if (!dialogContext.mounted) {
                  return;
                }

                Navigator.pop(
                  dialogContext,
                  true,
                );
              } catch (error) {
                if (!dialogContext.mounted) {
                  return;
                }

                var message = error.toString();

                if (message.startsWith('Exception: ')) {
                  message = message.substring(
                    'Exception: '.length,
                  );
                }

                setDialogState(() {
                  saving = false;
                  dialogError = message;
                });
              }
            }

            return AlertDialog(
              backgroundColor:
                  const Color(0xFFF9F7F4),

              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(22),
              ),

              titlePadding:
                  const EdgeInsets.fromLTRB(
                24,
                24,
                24,
                0,
              ),

              contentPadding:
                  const EdgeInsets.fromLTRB(
                24,
                20,
                24,
                8,
              ),

              actionsPadding:
                  const EdgeInsets.fromLTRB(
                20,
                8,
                20,
                20,
              ),

              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.editProfileTitle,
                      style: TextStyle(
                        color: accentColor,
                        fontFamily: 'serif',
                        fontSize: 24,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: saving
                        ? null
                        : () {
                            Navigator.pop(
                              dialogContext,
                              false,
                            );
                          },
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),

              content: SizedBox(
                width: 440,
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.editProfileDescription,
                      style: const TextStyle(
                        color:
                            Color(0xFF817780),
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 22),

                    TextField(
                      controller:
                          displayNameController,
                      enabled: !saving,
                      textCapitalization:
                          TextCapitalization.words,
                      decoration:
                          _inputDecoration(
                        label: l10n.displayNameLabel,
                        icon:
                            Icons.badge_outlined,
                        accentColor:
                            accentColor,
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller:
                          usernameController,
                      enabled: !saving,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration:
                          _inputDecoration(
                        label: l10n.fieldUsernameLabel,
                        icon:
                            Icons.alternate_email,
                        accentColor:
                            accentColor,
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller:
                          emailController,
                      enabled: !saving,
                      keyboardType:
                          TextInputType.emailAddress,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration:
                          _inputDecoration(
                        label: Localizations.localeOf(context)
                                    .languageCode ==
                                'es'
                            ? 'Correo electrónico'
                            : 'Email',
                        icon:
                            Icons.email_outlined,
                        accentColor:
                            accentColor,
                      ),
                    ),

                    if (dialogError != null) ...[
                      const SizedBox(height: 16),

                      Container(
                        padding:
                            const EdgeInsets.all(
                          12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFFFECEA,
                          ),
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons
                                  .error_outline,
                              color: Color(
                                0xFFD94F45,
                              ),
                              size: 18,
                            ),

                            const SizedBox(
                              width: 9,
                            ),

                            Expanded(
                              child: Text(
                                dialogError!,
                                style:
                                    const TextStyle(
                                  color:
                                      Color(
                                    0xFFA23B34,
                                  ),
                                  fontSize: 11.5,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: saving
                      ? null
                      : () {
                          Navigator.pop(
                            dialogContext,
                            false,
                          );
                        },
                  child: Text(
                    l10n.cancelButton,
                  ),
                ),

                FilledButton(
                  onPressed:
                      saving ? null : save,
                  style:
                      FilledButton.styleFrom(
                    backgroundColor:
                        accentColor,
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 22,
                      vertical: 14,
                    ),
                  ),
                  child: saving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          l10n.saveChangesButton,
                        ),
                ),
              ],
            );
          },
        );
      },
    );

    displayNameController.dispose();
    usernameController.dispose();
    emailController.dispose();

    if (updated == true && mounted) {
      await _loadAccountProfile();

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!
                .profileUpdatedMessage,
          ),
        ),
      );
    }
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    required Color accentColor,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        icon,
        color: accentColor,
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE4DEDA),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide: BorderSide(
          color: accentColor,
          width: 1.5,
        ),
      ),
    );
  }

  // ============================================================
  // LANGUAGE
  // ============================================================

  void _showLanguageSelector(
    Color accentColor,
  ) {
    final currentLanguage =
        Localizations.localeOf(context)
            .languageCode;

    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          child: Container(
            margin: const EdgeInsets.all(14),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F7F4),
              borderRadius:
                  BorderRadius.circular(22),
              border: Border.all(
                color:
                    accentColor.withAlpha(30),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.languageLabel,
                  style: TextStyle(
                    color: accentColor,
                    fontFamily: 'serif',
                    fontSize: 22,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 18),

                _LanguageOption(
                  title: l10n.languageEnglish,
                  selected:
                      currentLanguage == 'en',
                  accentColor: accentColor,
                  onTap: () async {
                    await LocaleScope.of(
                      context,
                    ).setLocale(
                      const Locale('en'),
                    );

                    if (sheetContext.mounted) {
                      Navigator.pop(
                        sheetContext,
                      );
                    }
                  },
                ),

                const SizedBox(height: 10),

                _LanguageOption(
                  title: l10n.languageSpanish,
                  selected:
                      currentLanguage == 'es',
                  accentColor: accentColor,
                  onTap: () async {
                    await LocaleScope.of(
                      context,
                    ).setLocale(
                      const Locale('es'),
                    );

                    if (sheetContext.mounted) {
                      Navigator.pop(
                        sheetContext,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // PLACEHOLDER ACTIONS
  // ============================================================

  void _onThemeTap() {
    _showComingSoon(
      AppLocalizations.of(context)!
          .themeSettingsTitle,
    );
  }

  void _onNotificationsTap() {
    _showComingSoon(
      AppLocalizations.of(context)!
          .notificationSettingsTitle,
    );
  }

  void _onHelpTap() {
    _showComingSoon(
      AppLocalizations.of(context)!
          .helpSupportTitle,
    );
  }

  void _onAboutTap() {
    final data = _accountProfile;

    final accentColor =
        ZodiacTheme.colorForSign(
      data?.zodiacSign ??
          widget.zodiacSign ??
          'Virgo',
    );

    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor:
              const Color(0xFFF9F7F4),
          title: Text(
            'Sacred',
            style: TextStyle(
              color: accentColor,
              fontFamily: 'serif',
            ),
          ),
          content: Text(
            l10n.aboutSacredDescription,
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(
                dialogContext,
              ),
              child: Text(
                l10n.closeButton,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showComingSoon(
    String title,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          '$title — '
          '${AppLocalizations.of(context)!.comingSoonSuffix}',
        ),
      ),
    );
  }

  Future<void> _onLogout() async {
    final l10n = AppLocalizations.of(context)!;
    final language = Localizations.localeOf(context).languageCode;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF9F7F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            l10n.logoutButton,
            style: const TextStyle(
              fontFamily: 'serif',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            language == 'es'
                ? '¿Seguro que quieres cerrar sesión?'
                : 'Are you sure you want to log out?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: Text(
                l10n.cancelButton,
              ),
            ),
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              icon: const Icon(
                Icons.logout,
                size: 18,
              ),
              label: Text(
                l10n.logoutButton,
              ),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFD94F45),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    try {
      await AuthService.logout();

      if (!mounted) {
        return;
      }

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
        (route) => false,
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            language == 'es'
                ? 'No fue posible cerrar sesión. Inténtalo nuevamente.'
                : 'Could not log out. Please try again.',
          ),
        ),
      );
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return _buildLoading();
    }

    if (_loadError != null) {
      return _buildError();
    }

    final data = _accountProfile;

    if (data == null) {
      return _buildError();
    }

    final sign =
        data.zodiacSign ??
        widget.zodiacSign ??
        'Virgo';

    final accentColor =
        ZodiacTheme.colorForSign(sign);

    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F1EE),
      body: SafeArea(
        child: Column(
          children: [
            AstrologyTopNavigation(
              activeSection:
                  AstrologySection.account,
              accentColor: accentColor,
              onToday: _goToToday,
              onChart: _goToChart,
              onWeek: () {},
              onProfile: _goToProfile,
              onAccountProfile: () {},
            ),

            Expanded(
              child: LayoutBuilder(
                builder: (
                  context,
                  constraints,
                ) {
                  final width =
                      constraints.maxWidth;

                  final isMobile =
                      width < 650;

                  final isTablet =
                      width >= 650 &&
                      width < 1100;

                  final horizontalPadding =
                      isMobile
                          ? 14.0
                          : isTablet
                              ? 28.0
                              : 46.0;

                  final topPadding =
                      isMobile ? 22.0 : 36.0;

                  return RefreshIndicator(
                    onRefresh:
                        _loadAccountProfile,
                    child:
                        SingleChildScrollView(
                      physics:
                          const AlwaysScrollableScrollPhysics(
                        parent:
                            BouncingScrollPhysics(),
                      ),
                      padding:
                          EdgeInsets.fromLTRB(
                        horizontalPadding,
                        topPadding,
                        horizontalPadding,
                        46,
                      ),
                      child: Center(
                        child:
                            ConstrainedBox(
                          constraints:
                              const BoxConstraints(
                            maxWidth: 1500,
                          ),
                          child: isMobile
                              ? _buildMobile(
                                  data,
                                  accentColor,
                                )
                              : isTablet
                                  ? _buildTablet(
                                      data,
                                      accentColor,
                                    )
                                  : _buildDesktop(
                                      data,
                                      accentColor,
                                    ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile(
    AccountProfileModel data,
    Color accentColor,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [
        _PageHeader(
          accentColor: accentColor,
          compact: true,
          title: AppLocalizations.of(context)!
              .yourProfileTitle,
          subtitle: AppLocalizations.of(context)!
              .manageAccountSubtitle,
        ),

        const SizedBox(height: 22),

        ProfileIdentityCard(
          accentColor: accentColor,
          initials:
              _valueOrDash(data.initials),
          displayName:
              _valueOrDash(data.displayName),
          memberSince:
              _formattedMemberSince(
            data.account.memberSince,
          ),
          onEdit:
              _showEditProfileDialog,
        ),

        const SizedBox(height: 16),

        BirthInformationCard(
          accentColor: accentColor,
          dateOfBirth:
              _formattedBirthDate(
            data.birth.birthDate,
          ),
          timeOfBirth: _valueOrDash(
            data.birth.birthTime,
          ),
          birthPlace: _valueOrDash(
            data.birth.birthPlace,
          ),
        ),

        const SizedBox(height: 16),

        AccountInformationCard(
          accentColor: accentColor,
          email: _valueOrDash(
            data.account.email,
          ),
          username: _valueOrDash(
            data.account.username,
          ),
          memberSince:
              _formattedMemberSince(
            data.account.memberSince,
          ),
        ),

        const SizedBox(height: 16),

        _buildPreferences(
          data,
          accentColor,
        ),

        const SizedBox(height: 16),

        SupportCard(
          accentColor: accentColor,
          onHelpTap: _onHelpTap,
          onAboutTap: _onAboutTap,
        ),

        const SizedBox(height: 16),

        ProfileQuoteCard(
          accentColor: accentColor,
        ),

        const SizedBox(height: 16),

        _LogoutButton(
          onPressed: _onLogout,
        ),

        const SizedBox(height: 16),

        ProfilePrivacyBanner(
          accentColor: accentColor,
        ),
      ],
    );
  }

  // ============================================================
  // TABLET
  // ============================================================

  Widget _buildTablet(
    AccountProfileModel data,
    Color accentColor,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [
        _PageHeader(
          accentColor: accentColor,
          compact: false,
          title: AppLocalizations.of(context)!
              .yourProfileTitle,
          subtitle: AppLocalizations.of(context)!
              .manageAccountSubtitle,
        ),

        const SizedBox(height: 26),

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  ProfileIdentityCard(
                    accentColor:
                        accentColor,
                    initials:
                        _valueOrDash(
                      data.initials,
                    ),
                    displayName:
                        _valueOrDash(
                      data.displayName,
                    ),
                    memberSince:
                        _formattedMemberSince(
                      data.account
                          .memberSince,
                    ),
                    onEdit:
                        _showEditProfileDialog,
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  BirthInformationCard(
                    accentColor:
                        accentColor,
                    dateOfBirth:
                        _formattedBirthDate(
                      data.birth.birthDate,
                    ),
                    timeOfBirth:
                        _valueOrDash(
                      data.birth.birthTime,
                    ),
                    birthPlace:
                        _valueOrDash(
                      data.birth.birthPlace,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                children: [
                  AccountInformationCard(
                    accentColor:
                        accentColor,
                    email:
                        _valueOrDash(
                      data.account.email,
                    ),
                    username:
                        _valueOrDash(
                      data.account.username,
                    ),
                    memberSince:
                        _formattedMemberSince(
                      data.account
                          .memberSince,
                    ),
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  _buildPreferences(
                    data,
                    accentColor,
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  SupportCard(
                    accentColor:
                        accentColor,
                    onHelpTap:
                        _onHelpTap,
                    onAboutTap:
                        _onAboutTap,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        ProfileQuoteCard(
          accentColor: accentColor,
        ),

        const SizedBox(height: 18),

        _LogoutButton(
          onPressed: _onLogout,
        ),

        const SizedBox(height: 18),

        ProfilePrivacyBanner(
          accentColor: accentColor,
        ),
      ],
    );
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _buildDesktop(
    AccountProfileModel data,
    Color accentColor,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [
        _PageHeader(
          accentColor: accentColor,
          compact: false,
          title: AppLocalizations.of(context)!
              .yourProfileTitle,
          subtitle: AppLocalizations.of(context)!
              .manageAccountSubtitle,
        ),

        const SizedBox(height: 28),

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 34,
              child: Column(
                children: [
                  ProfileIdentityCard(
                    accentColor:
                        accentColor,
                    initials:
                        _valueOrDash(
                      data.initials,
                    ),
                    displayName:
                        _valueOrDash(
                      data.displayName,
                    ),
                    memberSince:
                        _formattedMemberSince(
                      data.account
                          .memberSince,
                    ),
                    onEdit:
                        _showEditProfileDialog,
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  BirthInformationCard(
                    accentColor:
                        accentColor,
                    dateOfBirth:
                        _formattedBirthDate(
                      data.birth.birthDate,
                    ),
                    timeOfBirth:
                        _valueOrDash(
                      data.birth.birthTime,
                    ),
                    birthPlace:
                        _valueOrDash(
                      data.birth.birthPlace,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 22),

            Expanded(
              flex: 34,
              child: Column(
                children: [
                  AccountInformationCard(
                    accentColor:
                        accentColor,
                    email:
                        _valueOrDash(
                      data.account.email,
                    ),
                    username:
                        _valueOrDash(
                      data.account.username,
                    ),
                    memberSince:
                        _formattedMemberSince(
                      data.account
                          .memberSince,
                    ),
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  _buildPreferences(
                    data,
                    accentColor,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 22),

            Expanded(
              flex: 32,
              child: Column(
                children: [
                  SupportCard(
                    accentColor:
                        accentColor,
                    onHelpTap:
                        _onHelpTap,
                    onAboutTap:
                        _onAboutTap,
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  ProfileQuoteCard(
                    accentColor:
                        accentColor,
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  _LogoutButton(
                    onPressed:
                        _onLogout,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 26),

        ProfilePrivacyBanner(
          accentColor: accentColor,
        ),
      ],
    );
  }

  // ============================================================
  // PREFERENCES
  // ============================================================

  Widget _buildPreferences(
    AccountProfileModel data,
    Color accentColor,
  ) {
    final currentLanguage =
        Localizations.localeOf(context)
            .languageCode;

    final l10n = AppLocalizations.of(context)!;

    final languageValueLabel =
        currentLanguage == 'es'
            ? l10n.languageSpanish
            : l10n.languageEnglish;

    final themeValueLabel =
        data.preferences.theme
                    .toLowerCase() ==
                'dark'
            ? l10n.themeDark
            : l10n.themeLight;

    return PreferencesCard(
      accentColor: accentColor,
      language: languageValueLabel,
      theme: themeValueLabel,
      notificationsEnabled:
          data.preferences
              .notificationsEnabled,
      onLanguageTap: () {
        _showLanguageSelector(
          accentColor,
        );
      },
      onThemeTap: _onThemeTap,
      onNotificationsTap:
          _onNotificationsTap,
    );
  }

  // ============================================================
  // FORMATTING
  // ============================================================

  String _valueOrDash(
    String? value,
  ) {
    if (value == null ||
        value.trim().isEmpty) {
      return '—';
    }

    return value.trim();
  }

  String _formattedBirthDate(
    String? raw,
  ) {
    if (raw == null ||
        raw.trim().isEmpty) {
      return '—';
    }

    try {
      final date =
          DateTime.parse(raw);

      final language =
          Localizations.localeOf(
        context,
      ).languageCode;

      if (language == 'es') {
        return DateFormat(
          "d 'de' MMMM 'de' y",
          'es',
        ).format(date);
      }

      return DateFormat(
        'MMM d, y',
        'en',
      ).format(date);
    } catch (_) {
      return raw;
    }
  }

  String _formattedMemberSince(
    String? raw,
  ) {
    if (raw == null ||
        raw.trim().isEmpty) {
      return '—';
    }

    try {
      final date =
          DateTime.parse(raw);

      final language =
          Localizations.localeOf(
        context,
      ).languageCode;

      if (language == 'es') {
        return DateFormat(
          'MMMM y',
          'es',
        ).format(date);
      }

      return DateFormat(
        'MMMM y',
        'en',
      ).format(date);
    } catch (_) {
      return raw;
    }
  }

  // ============================================================
  // LOADING / ERROR
  // ============================================================

  Widget _buildLoading() {
    final accentColor =
        ZodiacTheme.colorForSign(
      widget.zodiacSign ?? 'Virgo',
    );

    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F1EE),
      body: Center(
        child:
            CircularProgressIndicator(
          color: accentColor,
        ),
      ),
    );
  }

  Widget _buildError() {
    final accentColor =
        ZodiacTheme.colorForSign(
      widget.zodiacSign ?? 'Virgo',
    );

    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F1EE),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.all(24),
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                color: accentColor,
                size: 46,
              ),

              const SizedBox(height: 16),

              Text(
                AppLocalizations.of(context)!
                    .accountLoadError,
                textAlign:
                    TextAlign.center,
              ),

              const SizedBox(height: 20),

              FilledButton(
                onPressed:
                    _loadAccountProfile,
                style:
                    FilledButton.styleFrom(
                  backgroundColor:
                      accentColor,
                ),
                child: Text(
                  AppLocalizations.of(context)!
                      .retry,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================================
// PAGE HEADER
// ================================================================

class _PageHeader extends StatelessWidget {
  final Color accentColor;
  final bool compact;
  final String title;
  final String subtitle;

  const _PageHeader({
    required this.accentColor,
    required this.compact,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            color: accentColor,
            fontSize:
                compact ? 11 : 12,
            letterSpacing: 2.2,
            fontWeight:
                FontWeight.w700,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          subtitle,
          style: TextStyle(
            color:
                const Color(0xFF2C252C),
            fontSize:
                compact ? 24 : 34,
            fontFamily: 'serif',
            fontWeight:
                FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ================================================================
// LANGUAGE
// ================================================================

class _LanguageOption
    extends StatelessWidget {
  final String title;
  final bool selected;
  final Color accentColor;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.selected,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(14),
        child: Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: selected
                ? accentColor.withAlpha(15)
                : Colors.transparent,
            borderRadius:
                BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? accentColor
                  : const Color(
                      0xFFE5E0DC,
                    ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.language,
                color: accentColor,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),

              if (selected)
                Icon(
                  Icons.check_circle,
                  color: accentColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================================
// LOGOUT
// ================================================================

class _LogoutButton
    extends StatelessWidget {
  final VoidCallback onPressed;

  const _LogoutButton({
    required this.onPressed,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(
          Icons.logout,
          size: 18,
        ),
        label: Text(
          AppLocalizations.of(context)!
              .logOutButtonUppercase,
          style: const TextStyle(
            fontWeight:
                FontWeight.w700,
            letterSpacing: .8,
          ),
        ),
        style:
            OutlinedButton.styleFrom(
          foregroundColor:
              const Color(0xFFD94F45),
          side: const BorderSide(
            color:
                Color(0xFFD94F45),
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
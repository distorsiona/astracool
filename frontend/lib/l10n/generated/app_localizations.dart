import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// Button to retry a failed action
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Tooltip for the back button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backTooltip;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Could not connect to the server. Check your connection and try again.'**
  String get errorNetwork;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'The request took too long. Please try again.'**
  String get errorTimeout;

  /// No description provided for @errorInvalidResponse.
  ///
  /// In en, this message translates to:
  /// **'The server returned an unexpected response.'**
  String get errorInvalidResponse;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @loginWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginWelcomeTitle;

  /// No description provided for @loginWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect to your personal cosmos.'**
  String get loginWelcomeSubtitle;

  /// No description provided for @fieldEmailOrUsernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Email or @username'**
  String get fieldEmailOrUsernameLabel;

  /// No description provided for @fieldEmailOrUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email or username'**
  String get fieldEmailOrUsernameHint;

  /// No description provided for @fieldEmailOrUsernameError.
  ///
  /// In en, this message translates to:
  /// **'Enter your email or username'**
  String get fieldEmailOrUsernameError;

  /// No description provided for @fieldPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get fieldPasswordLabel;

  /// No description provided for @fieldPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get fieldPasswordHint;

  /// No description provided for @fieldPasswordRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get fieldPasswordRequiredError;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get loginButton;

  /// No description provided for @noAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccountPrompt;

  /// No description provided for @signUpLink.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpLink;

  /// No description provided for @loginHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Your destiny awaits.'**
  String get loginHeroTitle;

  /// No description provided for @loginHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect with your cosmic essence and discover what the stars have in store for you.'**
  String get loginHeroSubtitle;

  /// No description provided for @registerCreateAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get registerCreateAccountTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your exact birth details for an accurate natal chart.'**
  String get registerSubtitle;

  /// No description provided for @fieldFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fieldFullNameLabel;

  /// No description provided for @fieldFullNameHint.
  ///
  /// In en, this message translates to:
  /// **'E.g. Ana García'**
  String get fieldFullNameHint;

  /// No description provided for @fieldFullNameError.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get fieldFullNameError;

  /// No description provided for @fieldUsernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get fieldUsernameLabel;

  /// No description provided for @fieldUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'username'**
  String get fieldUsernameHint;

  /// No description provided for @fieldUsernameRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Enter a username'**
  String get fieldUsernameRequiredError;

  /// No description provided for @fieldUsernameMinLengthError.
  ///
  /// In en, this message translates to:
  /// **'Minimum 3 characters'**
  String get fieldUsernameMinLengthError;

  /// No description provided for @fieldEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get fieldEmailLabel;

  /// No description provided for @fieldEmailHint.
  ///
  /// In en, this message translates to:
  /// **'you@email.com'**
  String get fieldEmailHint;

  /// No description provided for @fieldEmailRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get fieldEmailRequiredError;

  /// No description provided for @fieldEmailInvalidError.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get fieldEmailInvalidError;

  /// No description provided for @fieldRegisterPasswordRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Enter a password'**
  String get fieldRegisterPasswordRequiredError;

  /// No description provided for @fieldPasswordMinLengthError.
  ///
  /// In en, this message translates to:
  /// **'Must be at least 8 characters'**
  String get fieldPasswordMinLengthError;

  /// No description provided for @fieldBirthDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get fieldBirthDateLabel;

  /// No description provided for @fieldBirthDateHint.
  ///
  /// In en, this message translates to:
  /// **'dd-mm-yyyy'**
  String get fieldBirthDateHint;

  /// No description provided for @fieldBirthDateError.
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get fieldBirthDateError;

  /// No description provided for @fieldBirthTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time of Birth'**
  String get fieldBirthTimeLabel;

  /// No description provided for @fieldBirthTimeHint.
  ///
  /// In en, this message translates to:
  /// **'--:--'**
  String get fieldBirthTimeHint;

  /// No description provided for @fieldBirthTimeError.
  ///
  /// In en, this message translates to:
  /// **'Select a time'**
  String get fieldBirthTimeError;

  /// No description provided for @fieldBirthPlaceLabel.
  ///
  /// In en, this message translates to:
  /// **'Place of Birth'**
  String get fieldBirthPlaceLabel;

  /// No description provided for @fieldBirthPlaceHint.
  ///
  /// In en, this message translates to:
  /// **'City, Country'**
  String get fieldBirthPlaceHint;

  /// No description provided for @fieldBirthPlaceError.
  ///
  /// In en, this message translates to:
  /// **'Enter city and country'**
  String get fieldBirthPlaceError;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Begin Journey'**
  String get registerButton;

  /// No description provided for @alreadyHaveAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccountPrompt;

  /// No description provided for @selectBirthDateMessage.
  ///
  /// In en, this message translates to:
  /// **'Select your date of birth.'**
  String get selectBirthDateMessage;

  /// No description provided for @selectBirthTimeMessage.
  ///
  /// In en, this message translates to:
  /// **'Select your time of birth.'**
  String get selectBirthTimeMessage;

  /// No description provided for @accountCreatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully.'**
  String get accountCreatedMessage;

  /// No description provided for @registerHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Recognize yourself in the cosmos.'**
  String get registerHeroTitle;

  /// No description provided for @registerHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A deep dive into your celestial identity, presented with clarity and modern elegance.'**
  String get registerHeroSubtitle;

  /// No description provided for @todayHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get todayHeroTitle;

  /// No description provided for @todayEnergyTitle.
  ///
  /// In en, this message translates to:
  /// **'YOUR ENERGY TODAY'**
  String get todayEnergyTitle;

  /// No description provided for @moonInSign.
  ///
  /// In en, this message translates to:
  /// **'MOON IN {sign}'**
  String moonInSign(String sign);

  /// No description provided for @bigThreeTitle.
  ///
  /// In en, this message translates to:
  /// **'YOUR BIG THREE'**
  String get bigThreeTitle;

  /// No description provided for @sunLabel.
  ///
  /// In en, this message translates to:
  /// **'SUN'**
  String get sunLabel;

  /// No description provided for @moonLabel.
  ///
  /// In en, this message translates to:
  /// **'MOON'**
  String get moonLabel;

  /// No description provided for @risingLabel.
  ///
  /// In en, this message translates to:
  /// **'RISING'**
  String get risingLabel;

  /// No description provided for @affectedHousesTitle.
  ///
  /// In en, this message translates to:
  /// **'AFFECTED HOUSES'**
  String get affectedHousesTitle;

  /// No description provided for @noActiveHousesMessage.
  ///
  /// In en, this message translates to:
  /// **'No houses are especially activated.'**
  String get noActiveHousesMessage;

  /// No description provided for @todaysThemesTitle.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S THEMES'**
  String get todaysThemesTitle;

  /// No description provided for @todayReflectionNote.
  ///
  /// In en, this message translates to:
  /// **'Your day reflects the interaction between your natal chart and the current sky.'**
  String get todayReflectionNote;

  /// No description provided for @activeTransitsTitle.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE TRANSITS'**
  String get activeTransitsTitle;

  /// No description provided for @noActiveTransitsMessage.
  ///
  /// In en, this message translates to:
  /// **'No notable transits today.'**
  String get noActiveTransitsMessage;

  /// No description provided for @todaysFocusTitle.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S FOCUS'**
  String get todaysFocusTitle;

  /// No description provided for @luckyTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'LUCKY TIME'**
  String get luckyTimeTitle;

  /// No description provided for @luckyColorTitle.
  ///
  /// In en, this message translates to:
  /// **'LUCKY COLOR'**
  String get luckyColorTitle;

  /// No description provided for @todayLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load Today.'**
  String get todayLoadError;

  /// No description provided for @todayMoonSubtitleAries.
  ///
  /// In en, this message translates to:
  /// **'Emotion moves quickly and directly.'**
  String get todayMoonSubtitleAries;

  /// No description provided for @todayMoonSubtitleTaurus.
  ///
  /// In en, this message translates to:
  /// **'A slower rhythm favors stability and grounding.'**
  String get todayMoonSubtitleTaurus;

  /// No description provided for @todayMoonSubtitleGemini.
  ///
  /// In en, this message translates to:
  /// **'Curiosity and communication shape the emotional tone.'**
  String get todayMoonSubtitleGemini;

  /// No description provided for @todayMoonSubtitleCancer.
  ///
  /// In en, this message translates to:
  /// **'Sensitivity, belonging and emotional security come forward.'**
  String get todayMoonSubtitleCancer;

  /// No description provided for @todayMoonSubtitleLeo.
  ///
  /// In en, this message translates to:
  /// **'Expression, warmth and recognition become more noticeable.'**
  String get todayMoonSubtitleLeo;

  /// No description provided for @todayMoonSubtitleVirgo.
  ///
  /// In en, this message translates to:
  /// **'Attention turns toward details, routines and improvement.'**
  String get todayMoonSubtitleVirgo;

  /// No description provided for @todayMoonSubtitleLibra.
  ///
  /// In en, this message translates to:
  /// **'Balance, connection and harmony become more important.'**
  String get todayMoonSubtitleLibra;

  /// No description provided for @todayMoonSubtitleScorpio.
  ///
  /// In en, this message translates to:
  /// **'Emotions deepen and hidden layers may become more visible.'**
  String get todayMoonSubtitleScorpio;

  /// No description provided for @todayMoonSubtitleSagittarius.
  ///
  /// In en, this message translates to:
  /// **'The mood favors movement, perspective and exploration.'**
  String get todayMoonSubtitleSagittarius;

  /// No description provided for @todayMoonSubtitleCapricorn.
  ///
  /// In en, this message translates to:
  /// **'Emotional energy becomes more contained and goal-oriented.'**
  String get todayMoonSubtitleCapricorn;

  /// No description provided for @todayMoonSubtitleAquarius.
  ///
  /// In en, this message translates to:
  /// **'Distance, perspective and unconventional ideas come forward.'**
  String get todayMoonSubtitleAquarius;

  /// No description provided for @todayMoonSubtitlePisces.
  ///
  /// In en, this message translates to:
  /// **'Intuition, imagination and sensitivity are heightened.'**
  String get todayMoonSubtitlePisces;

  /// No description provided for @todayMoonSubtitleDefault.
  ///
  /// In en, this message translates to:
  /// **'Your emotional rhythm for today.'**
  String get todayMoonSubtitleDefault;

  /// No description provided for @todayQuoteAries.
  ///
  /// In en, this message translates to:
  /// **'Move with intention, not only impulse.'**
  String get todayQuoteAries;

  /// No description provided for @todayQuoteTaurus.
  ///
  /// In en, this message translates to:
  /// **'What is steady does not need to be rushed.'**
  String get todayQuoteTaurus;

  /// No description provided for @todayQuoteGemini.
  ///
  /// In en, this message translates to:
  /// **'A new perspective can change the entire conversation.'**
  String get todayQuoteGemini;

  /// No description provided for @todayQuoteCancer.
  ///
  /// In en, this message translates to:
  /// **'Protect what matters without closing yourself off.'**
  String get todayQuoteCancer;

  /// No description provided for @todayQuoteLeo.
  ///
  /// In en, this message translates to:
  /// **'Expression becomes stronger when it comes from sincerity.'**
  String get todayQuoteLeo;

  /// No description provided for @todayQuoteVirgo.
  ///
  /// In en, this message translates to:
  /// **'Small adjustments can change the whole rhythm.'**
  String get todayQuoteVirgo;

  /// No description provided for @todayQuoteLibra.
  ///
  /// In en, this message translates to:
  /// **'Balance is created, not simply found.'**
  String get todayQuoteLibra;

  /// No description provided for @todayQuoteScorpio.
  ///
  /// In en, this message translates to:
  /// **'Depth reveals what the surface cannot.'**
  String get todayQuoteScorpio;

  /// No description provided for @todayQuoteSagittarius.
  ///
  /// In en, this message translates to:
  /// **'Perspective expands when you allow yourself to move.'**
  String get todayQuoteSagittarius;

  /// No description provided for @todayQuoteCapricorn.
  ///
  /// In en, this message translates to:
  /// **'What you build patiently can become lasting.'**
  String get todayQuoteCapricorn;

  /// No description provided for @todayQuoteAquarius.
  ///
  /// In en, this message translates to:
  /// **'Distance can reveal patterns that closeness hides.'**
  String get todayQuoteAquarius;

  /// No description provided for @todayQuotePisces.
  ///
  /// In en, this message translates to:
  /// **'Not everything meaningful needs to be explained immediately.'**
  String get todayQuotePisces;

  /// No description provided for @todayQuoteDefault.
  ///
  /// In en, this message translates to:
  /// **'Notice what the day is asking you to see.'**
  String get todayQuoteDefault;

  /// No description provided for @todayLuckyColorAries.
  ///
  /// In en, this message translates to:
  /// **'Crimson'**
  String get todayLuckyColorAries;

  /// No description provided for @todayLuckyColorTaurus.
  ///
  /// In en, this message translates to:
  /// **'Sage Green'**
  String get todayLuckyColorTaurus;

  /// No description provided for @todayLuckyColorGemini.
  ///
  /// In en, this message translates to:
  /// **'Soft Yellow'**
  String get todayLuckyColorGemini;

  /// No description provided for @todayLuckyColorCancer.
  ///
  /// In en, this message translates to:
  /// **'Pearl'**
  String get todayLuckyColorCancer;

  /// No description provided for @todayLuckyColorLeo.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get todayLuckyColorLeo;

  /// No description provided for @todayLuckyColorVirgo.
  ///
  /// In en, this message translates to:
  /// **'Olive'**
  String get todayLuckyColorVirgo;

  /// No description provided for @todayLuckyColorLibra.
  ///
  /// In en, this message translates to:
  /// **'Rose'**
  String get todayLuckyColorLibra;

  /// No description provided for @todayLuckyColorScorpio.
  ///
  /// In en, this message translates to:
  /// **'Burgundy'**
  String get todayLuckyColorScorpio;

  /// No description provided for @todayLuckyColorSagittarius.
  ///
  /// In en, this message translates to:
  /// **'Indigo'**
  String get todayLuckyColorSagittarius;

  /// No description provided for @todayLuckyColorCapricorn.
  ///
  /// In en, this message translates to:
  /// **'Charcoal'**
  String get todayLuckyColorCapricorn;

  /// No description provided for @todayLuckyColorAquarius.
  ///
  /// In en, this message translates to:
  /// **'Electric Blue'**
  String get todayLuckyColorAquarius;

  /// No description provided for @todayLuckyColorPisces.
  ///
  /// In en, this message translates to:
  /// **'Lavender'**
  String get todayLuckyColorPisces;

  /// No description provided for @todayLuckyColorDefault.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get todayLuckyColorDefault;

  /// No description provided for @todayThemeLove.
  ///
  /// In en, this message translates to:
  /// **'Love'**
  String get todayThemeLove;

  /// No description provided for @todayThemeEnergy.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get todayThemeEnergy;

  /// No description provided for @todayThemeWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get todayThemeWork;

  /// No description provided for @todayThemeEmotions.
  ///
  /// In en, this message translates to:
  /// **'Emotions'**
  String get todayThemeEmotions;

  /// No description provided for @todayHouseTitleTemplate.
  ///
  /// In en, this message translates to:
  /// **'House {roman}'**
  String todayHouseTitleTemplate(String roman);

  /// No description provided for @todayHouseSubtitle1.
  ///
  /// In en, this message translates to:
  /// **'Self & identity'**
  String get todayHouseSubtitle1;

  /// No description provided for @todayHouseDescription1.
  ///
  /// In en, this message translates to:
  /// **'Identity, appearance, beginnings and the way you approach life.'**
  String get todayHouseDescription1;

  /// No description provided for @todayHouseSubtitle2.
  ///
  /// In en, this message translates to:
  /// **'Values & resources'**
  String get todayHouseSubtitle2;

  /// No description provided for @todayHouseDescription2.
  ///
  /// In en, this message translates to:
  /// **'Money, resources, possessions and personal values.'**
  String get todayHouseDescription2;

  /// No description provided for @todayHouseSubtitle3.
  ///
  /// In en, this message translates to:
  /// **'Communication'**
  String get todayHouseSubtitle3;

  /// No description provided for @todayHouseDescription3.
  ///
  /// In en, this message translates to:
  /// **'Communication, learning, ideas and your immediate environment.'**
  String get todayHouseDescription3;

  /// No description provided for @todayHouseSubtitle4.
  ///
  /// In en, this message translates to:
  /// **'Home & roots'**
  String get todayHouseSubtitle4;

  /// No description provided for @todayHouseDescription4.
  ///
  /// In en, this message translates to:
  /// **'Home, family, roots and your private emotional foundation.'**
  String get todayHouseDescription4;

  /// No description provided for @todayHouseSubtitle5.
  ///
  /// In en, this message translates to:
  /// **'Creativity & pleasure'**
  String get todayHouseSubtitle5;

  /// No description provided for @todayHouseDescription5.
  ///
  /// In en, this message translates to:
  /// **'Creativity, romance, pleasure and personal expression.'**
  String get todayHouseDescription5;

  /// No description provided for @todayHouseSubtitle6.
  ///
  /// In en, this message translates to:
  /// **'Routine & wellbeing'**
  String get todayHouseSubtitle6;

  /// No description provided for @todayHouseDescription6.
  ///
  /// In en, this message translates to:
  /// **'Daily routines, work, health and practical responsibilities.'**
  String get todayHouseDescription6;

  /// No description provided for @todayHouseSubtitle7.
  ///
  /// In en, this message translates to:
  /// **'Relationships'**
  String get todayHouseSubtitle7;

  /// No description provided for @todayHouseDescription7.
  ///
  /// In en, this message translates to:
  /// **'Partnerships, relationships and important one-to-one bonds.'**
  String get todayHouseDescription7;

  /// No description provided for @todayHouseSubtitle8.
  ///
  /// In en, this message translates to:
  /// **'Transformation'**
  String get todayHouseSubtitle8;

  /// No description provided for @todayHouseDescription8.
  ///
  /// In en, this message translates to:
  /// **'Intimacy, transformation, shared resources and deep emotional change.'**
  String get todayHouseDescription8;

  /// No description provided for @todayHouseSubtitle9.
  ///
  /// In en, this message translates to:
  /// **'Beliefs & exploration'**
  String get todayHouseSubtitle9;

  /// No description provided for @todayHouseDescription9.
  ///
  /// In en, this message translates to:
  /// **'Beliefs, higher learning, travel and expansion of perspective.'**
  String get todayHouseDescription9;

  /// No description provided for @todayHouseSubtitle10.
  ///
  /// In en, this message translates to:
  /// **'Career & direction'**
  String get todayHouseSubtitle10;

  /// No description provided for @todayHouseDescription10.
  ///
  /// In en, this message translates to:
  /// **'Career, reputation, ambition and your public direction.'**
  String get todayHouseDescription10;

  /// No description provided for @todayHouseSubtitle11.
  ///
  /// In en, this message translates to:
  /// **'Friends & community'**
  String get todayHouseSubtitle11;

  /// No description provided for @todayHouseDescription11.
  ///
  /// In en, this message translates to:
  /// **'Friendships, communities, future plans and collective goals.'**
  String get todayHouseDescription11;

  /// No description provided for @todayHouseSubtitle12.
  ///
  /// In en, this message translates to:
  /// **'Inner world'**
  String get todayHouseSubtitle12;

  /// No description provided for @todayHouseDescription12.
  ///
  /// In en, this message translates to:
  /// **'Rest, intuition, subconscious patterns and your private inner world.'**
  String get todayHouseDescription12;

  /// No description provided for @todayTransitTitleTemplate.
  ///
  /// In en, this message translates to:
  /// **'{first} {aspect} natal {second}'**
  String todayTransitTitleTemplate(String first, String aspect, String second);

  /// No description provided for @todayTransitDescriptionTemplate.
  ///
  /// In en, this message translates to:
  /// **'{first} is interacting with your natal {second}. {tone}'**
  String todayTransitDescriptionTemplate(
      String first, String second, String tone);

  /// No description provided for @todayTransitToneTrine.
  ///
  /// In en, this message translates to:
  /// **'This creates a smoother flow between both energies.'**
  String get todayTransitToneTrine;

  /// No description provided for @todayTransitToneSextile.
  ///
  /// In en, this message translates to:
  /// **'This opens an opportunity to use both energies constructively.'**
  String get todayTransitToneSextile;

  /// No description provided for @todayTransitToneSquare.
  ///
  /// In en, this message translates to:
  /// **'This can create friction that asks for adjustment and awareness.'**
  String get todayTransitToneSquare;

  /// No description provided for @todayTransitToneOpposition.
  ///
  /// In en, this message translates to:
  /// **'This highlights a polarity that may require balance.'**
  String get todayTransitToneOpposition;

  /// No description provided for @todayTransitToneConjunction.
  ///
  /// In en, this message translates to:
  /// **'These energies become strongly combined and more noticeable.'**
  String get todayTransitToneConjunction;

  /// No description provided for @todayTransitToneDefault.
  ///
  /// In en, this message translates to:
  /// **'This interaction is currently active in your natal chart.'**
  String get todayTransitToneDefault;

  /// No description provided for @todayTransitStatusExactToday.
  ///
  /// In en, this message translates to:
  /// **'Exact today'**
  String get todayTransitStatusExactToday;

  /// No description provided for @todayTransitStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get todayTransitStatusActive;

  /// No description provided for @todayTransitStatusActiveExact.
  ///
  /// In en, this message translates to:
  /// **'Active · exact {date}'**
  String todayTransitStatusActiveExact(String date);

  /// No description provided for @todayFocusTemplate.
  ///
  /// In en, this message translates to:
  /// **'Notice how {first} {aspect} your natal {second} shows up in your choices today.'**
  String todayFocusTemplate(String first, String aspect, String second);

  /// No description provided for @todayFocusDefault.
  ///
  /// In en, this message translates to:
  /// **'Observe your rhythm and avoid forcing unnecessary decisions.'**
  String get todayFocusDefault;

  /// No description provided for @todayInterpretationHouseClause.
  ///
  /// In en, this message translates to:
  /// **'Your {houseTitle} ({houseSubtitle}) is especially activated.'**
  String todayInterpretationHouseClause(
      String houseTitle, String houseSubtitle);

  /// No description provided for @todayInterpretationMoonIntroExact.
  ///
  /// In en, this message translates to:
  /// **'With the Moon moving through {sign}, today\'s emotional tone emphasizes the qualities of that sign.'**
  String todayInterpretationMoonIntroExact(String sign);

  /// No description provided for @todayInterpretationMainPattern.
  ///
  /// In en, this message translates to:
  /// **'A major pattern today is {title}.'**
  String todayInterpretationMainPattern(String title);

  /// No description provided for @todayInterpretationSecondPattern.
  ///
  /// In en, this message translates to:
  /// **'Another exact influence is {title}.'**
  String todayInterpretationSecondPattern(String title);

  /// No description provided for @todayInterpretationClosing.
  ///
  /// In en, this message translates to:
  /// **'Notice how these energies appear in your decisions, reactions and relationships rather than treating them as isolated events.'**
  String get todayInterpretationClosing;

  /// No description provided for @todayInterpretationMoonIntroActive.
  ///
  /// In en, this message translates to:
  /// **'With the Moon moving through {sign}, your emotional rhythm reflects the themes of that sign.'**
  String todayInterpretationMoonIntroActive(String sign);

  /// No description provided for @todayInterpretationStrongestPattern.
  ///
  /// In en, this message translates to:
  /// **'One of the strongest active patterns around your chart is {title}.'**
  String todayInterpretationStrongestPattern(String title);

  /// No description provided for @todayInterpretationQuietWithMoon.
  ///
  /// In en, this message translates to:
  /// **'The Moon is moving through {sign}. The sky is relatively quiet around your natal chart today, making this a useful day to observe your emotional rhythm without forcing major movement.'**
  String todayInterpretationQuietWithMoon(String sign);

  /// No description provided for @todayInterpretationQuietNoMoon.
  ///
  /// In en, this message translates to:
  /// **'The sky is relatively quiet around your natal chart today. Observe your natural rhythm rather than forcing unnecessary movement.'**
  String get todayInterpretationQuietNoMoon;

  /// No description provided for @celestialBlueprintTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Celestial Blueprint'**
  String get celestialBlueprintTitle;

  /// No description provided for @elementLabel.
  ///
  /// In en, this message translates to:
  /// **'ELEMENT'**
  String get elementLabel;

  /// No description provided for @rulingPlanetLabel.
  ///
  /// In en, this message translates to:
  /// **'RULING PLANET'**
  String get rulingPlanetLabel;

  /// No description provided for @modalityLabel.
  ///
  /// In en, this message translates to:
  /// **'MODALITY'**
  String get modalityLabel;

  /// No description provided for @mostActiveHousesTitle.
  ///
  /// In en, this message translates to:
  /// **'YOUR MOST ACTIVE HOUSES'**
  String get mostActiveHousesTitle;

  /// No description provided for @viewAllHouses.
  ///
  /// In en, this message translates to:
  /// **'View all houses'**
  String get viewAllHouses;

  /// No description provided for @houseFallbackTitle.
  ///
  /// In en, this message translates to:
  /// **'HOUSE {number}'**
  String houseFallbackTitle(int number);

  /// No description provided for @houseTitle1.
  ///
  /// In en, this message translates to:
  /// **'House of Self'**
  String get houseTitle1;

  /// No description provided for @houseSubtitle1.
  ///
  /// In en, this message translates to:
  /// **'Identity, appearance & first impressions'**
  String get houseSubtitle1;

  /// No description provided for @houseTitle2.
  ///
  /// In en, this message translates to:
  /// **'House of Values'**
  String get houseTitle2;

  /// No description provided for @houseSubtitle2.
  ///
  /// In en, this message translates to:
  /// **'Money, possessions & self-worth'**
  String get houseSubtitle2;

  /// No description provided for @houseTitle3.
  ///
  /// In en, this message translates to:
  /// **'House of Communication'**
  String get houseTitle3;

  /// No description provided for @houseSubtitle3.
  ///
  /// In en, this message translates to:
  /// **'Thinking, learning & communication'**
  String get houseSubtitle3;

  /// No description provided for @houseTitle4.
  ///
  /// In en, this message translates to:
  /// **'House of Home'**
  String get houseTitle4;

  /// No description provided for @houseSubtitle4.
  ///
  /// In en, this message translates to:
  /// **'Roots, family & emotional foundations'**
  String get houseSubtitle4;

  /// No description provided for @houseTitle5.
  ///
  /// In en, this message translates to:
  /// **'House of Creativity'**
  String get houseTitle5;

  /// No description provided for @houseSubtitle5.
  ///
  /// In en, this message translates to:
  /// **'Expression, romance & pleasure'**
  String get houseSubtitle5;

  /// No description provided for @houseTitle6.
  ///
  /// In en, this message translates to:
  /// **'House of Daily Life'**
  String get houseTitle6;

  /// No description provided for @houseSubtitle6.
  ///
  /// In en, this message translates to:
  /// **'Routine, work & well-being'**
  String get houseSubtitle6;

  /// No description provided for @houseTitle7.
  ///
  /// In en, this message translates to:
  /// **'House of Relationships'**
  String get houseTitle7;

  /// No description provided for @houseSubtitle7.
  ///
  /// In en, this message translates to:
  /// **'Partnerships, commitment & the other'**
  String get houseSubtitle7;

  /// No description provided for @houseTitle8.
  ///
  /// In en, this message translates to:
  /// **'House of Transformation'**
  String get houseTitle8;

  /// No description provided for @houseSubtitle8.
  ///
  /// In en, this message translates to:
  /// **'Intimacy, trust & shared resources'**
  String get houseSubtitle8;

  /// No description provided for @houseTitle9.
  ///
  /// In en, this message translates to:
  /// **'House of Expansion'**
  String get houseTitle9;

  /// No description provided for @houseSubtitle9.
  ///
  /// In en, this message translates to:
  /// **'Beliefs, travel & higher learning'**
  String get houseSubtitle9;

  /// No description provided for @houseTitle10.
  ///
  /// In en, this message translates to:
  /// **'House of Career'**
  String get houseTitle10;

  /// No description provided for @houseSubtitle10.
  ///
  /// In en, this message translates to:
  /// **'Purpose, reputation & public life'**
  String get houseSubtitle10;

  /// No description provided for @houseTitle11.
  ///
  /// In en, this message translates to:
  /// **'House of Community'**
  String get houseTitle11;

  /// No description provided for @houseSubtitle11.
  ///
  /// In en, this message translates to:
  /// **'Friendships, networks & future goals'**
  String get houseSubtitle11;

  /// No description provided for @houseTitle12.
  ///
  /// In en, this message translates to:
  /// **'House of the Inner World'**
  String get houseTitle12;

  /// No description provided for @houseSubtitle12.
  ///
  /// In en, this message translates to:
  /// **'Subconscious, solitude & hidden emotions'**
  String get houseSubtitle12;

  /// No description provided for @houseKeywordIdentity.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get houseKeywordIdentity;

  /// No description provided for @houseKeywordAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get houseKeywordAppearance;

  /// No description provided for @houseKeywordFirstImpressions.
  ///
  /// In en, this message translates to:
  /// **'First impressions'**
  String get houseKeywordFirstImpressions;

  /// No description provided for @houseKeywordMoney.
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get houseKeywordMoney;

  /// No description provided for @houseKeywordValues.
  ///
  /// In en, this message translates to:
  /// **'Values'**
  String get houseKeywordValues;

  /// No description provided for @houseKeywordSelfWorth.
  ///
  /// In en, this message translates to:
  /// **'Self-worth'**
  String get houseKeywordSelfWorth;

  /// No description provided for @houseKeywordCommunication.
  ///
  /// In en, this message translates to:
  /// **'Communication'**
  String get houseKeywordCommunication;

  /// No description provided for @houseKeywordLearning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get houseKeywordLearning;

  /// No description provided for @houseKeywordThinking.
  ///
  /// In en, this message translates to:
  /// **'Thinking'**
  String get houseKeywordThinking;

  /// No description provided for @houseKeywordSiblings.
  ///
  /// In en, this message translates to:
  /// **'Siblings'**
  String get houseKeywordSiblings;

  /// No description provided for @houseKeywordHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get houseKeywordHome;

  /// No description provided for @houseKeywordFamily.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get houseKeywordFamily;

  /// No description provided for @houseKeywordRoots.
  ///
  /// In en, this message translates to:
  /// **'Roots'**
  String get houseKeywordRoots;

  /// No description provided for @houseKeywordCreativity.
  ///
  /// In en, this message translates to:
  /// **'Creativity'**
  String get houseKeywordCreativity;

  /// No description provided for @houseKeywordRomance.
  ///
  /// In en, this message translates to:
  /// **'Romance'**
  String get houseKeywordRomance;

  /// No description provided for @houseKeywordPleasure.
  ///
  /// In en, this message translates to:
  /// **'Pleasure'**
  String get houseKeywordPleasure;

  /// No description provided for @houseKeywordRoutine.
  ///
  /// In en, this message translates to:
  /// **'Routine'**
  String get houseKeywordRoutine;

  /// No description provided for @houseKeywordWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get houseKeywordWork;

  /// No description provided for @houseKeywordWellbeing.
  ///
  /// In en, this message translates to:
  /// **'Well-being'**
  String get houseKeywordWellbeing;

  /// No description provided for @houseKeywordRelationships.
  ///
  /// In en, this message translates to:
  /// **'Relationships'**
  String get houseKeywordRelationships;

  /// No description provided for @houseKeywordPartnerships.
  ///
  /// In en, this message translates to:
  /// **'Partnerships'**
  String get houseKeywordPartnerships;

  /// No description provided for @houseKeywordCommitment.
  ///
  /// In en, this message translates to:
  /// **'Commitment'**
  String get houseKeywordCommitment;

  /// No description provided for @houseKeywordIntimacy.
  ///
  /// In en, this message translates to:
  /// **'Intimacy'**
  String get houseKeywordIntimacy;

  /// No description provided for @houseKeywordTrust.
  ///
  /// In en, this message translates to:
  /// **'Trust'**
  String get houseKeywordTrust;

  /// No description provided for @houseKeywordTransformation.
  ///
  /// In en, this message translates to:
  /// **'Transformation'**
  String get houseKeywordTransformation;

  /// No description provided for @houseKeywordSharedResources.
  ///
  /// In en, this message translates to:
  /// **'Shared resources'**
  String get houseKeywordSharedResources;

  /// No description provided for @houseKeywordBeliefs.
  ///
  /// In en, this message translates to:
  /// **'Beliefs'**
  String get houseKeywordBeliefs;

  /// No description provided for @houseKeywordTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get houseKeywordTravel;

  /// No description provided for @houseKeywordHigherLearning.
  ///
  /// In en, this message translates to:
  /// **'Higher learning'**
  String get houseKeywordHigherLearning;

  /// No description provided for @houseKeywordCareer.
  ///
  /// In en, this message translates to:
  /// **'Career'**
  String get houseKeywordCareer;

  /// No description provided for @houseKeywordReputation.
  ///
  /// In en, this message translates to:
  /// **'Reputation'**
  String get houseKeywordReputation;

  /// No description provided for @houseKeywordPurpose.
  ///
  /// In en, this message translates to:
  /// **'Purpose'**
  String get houseKeywordPurpose;

  /// No description provided for @houseKeywordFriendships.
  ///
  /// In en, this message translates to:
  /// **'Friendships'**
  String get houseKeywordFriendships;

  /// No description provided for @houseKeywordFriends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get houseKeywordFriends;

  /// No description provided for @houseKeywordCommunity.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get houseKeywordCommunity;

  /// No description provided for @houseKeywordFutureGoals.
  ///
  /// In en, this message translates to:
  /// **'Future goals'**
  String get houseKeywordFutureGoals;

  /// No description provided for @houseKeywordGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get houseKeywordGoals;

  /// No description provided for @houseKeywordInnerWorld.
  ///
  /// In en, this message translates to:
  /// **'Inner world'**
  String get houseKeywordInnerWorld;

  /// No description provided for @houseKeywordSubconscious.
  ///
  /// In en, this message translates to:
  /// **'Subconscious'**
  String get houseKeywordSubconscious;

  /// No description provided for @houseKeywordSolitude.
  ///
  /// In en, this message translates to:
  /// **'Solitude'**
  String get houseKeywordSolitude;

  /// No description provided for @rulerWithName.
  ///
  /// In en, this message translates to:
  /// **'Ruler · {planet}'**
  String rulerWithName(String planet);

  /// No description provided for @rulerUnknown.
  ///
  /// In en, this message translates to:
  /// **'Ruler · —'**
  String get rulerUnknown;

  /// No description provided for @planetsTitle.
  ///
  /// In en, this message translates to:
  /// **'PLANETS'**
  String get planetsTitle;

  /// No description provided for @noPlanetDataMessage.
  ///
  /// In en, this message translates to:
  /// **'No planetary data available.'**
  String get noPlanetDataMessage;

  /// No description provided for @houseNumberInline.
  ///
  /// In en, this message translates to:
  /// **'House {number}'**
  String houseNumberInline(int number);

  /// No description provided for @noHouseInline.
  ///
  /// In en, this message translates to:
  /// **'No house'**
  String get noHouseInline;

  /// No description provided for @aspectsTitle.
  ///
  /// In en, this message translates to:
  /// **'ASPECTS'**
  String get aspectsTitle;

  /// No description provided for @noAspectsMessage.
  ///
  /// In en, this message translates to:
  /// **'No aspects available.'**
  String get noAspectsMessage;

  /// No description provided for @orbLabel.
  ///
  /// In en, this message translates to:
  /// **'Orb {degree}'**
  String orbLabel(String degree);

  /// No description provided for @chartLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load your natal chart.'**
  String get chartLoadError;

  /// No description provided for @housesTopBarLabel.
  ///
  /// In en, this message translates to:
  /// **'HOUSES'**
  String get housesTopBarLabel;

  /// No description provided for @yourNatalHousesEyebrow.
  ///
  /// In en, this message translates to:
  /// **'YOUR NATAL HOUSES'**
  String get yourNatalHousesEyebrow;

  /// No description provided for @twelveHousesTitle.
  ///
  /// In en, this message translates to:
  /// **'The Twelve Houses'**
  String get twelveHousesTitle;

  /// No description provided for @twelveHousesDescription.
  ///
  /// In en, this message translates to:
  /// **'Each house represents a different area of your life. Its sign, ruling planet, planets inside it and aspects show how that area is expressed in your natal chart.'**
  String get twelveHousesDescription;

  /// No description provided for @couldNotLoadHousesTitle.
  ///
  /// In en, this message translates to:
  /// **'Could not load houses'**
  String get couldNotLoadHousesTitle;

  /// No description provided for @noHouseInfoMessage.
  ///
  /// In en, this message translates to:
  /// **'No house information is available.'**
  String get noHouseInfoMessage;

  /// No description provided for @noNatalPlanetsMessage.
  ///
  /// In en, this message translates to:
  /// **'No natal planets'**
  String get noNatalPlanetsMessage;

  /// No description provided for @houseTopBarLabel.
  ///
  /// In en, this message translates to:
  /// **'HOUSE {roman}'**
  String houseTopBarLabel(String roman);

  /// No description provided for @whatThisMeansForYouTitle.
  ///
  /// In en, this message translates to:
  /// **'WHAT THIS MEANS FOR YOU'**
  String get whatThisMeansForYouTitle;

  /// No description provided for @planetaryInfluencesTitle.
  ///
  /// In en, this message translates to:
  /// **'PLANETARY INFLUENCES'**
  String get planetaryInfluencesTitle;

  /// No description provided for @howThisMayShowUpTitle.
  ///
  /// In en, this message translates to:
  /// **'HOW THIS MAY SHOW UP'**
  String get howThisMayShowUpTitle;

  /// No description provided for @houseDetailLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load this house.'**
  String get houseDetailLoadError;

  /// No description provided for @whatThisHouseRulesTitle.
  ///
  /// In en, this message translates to:
  /// **'WHAT THIS HOUSE RULES'**
  String get whatThisHouseRulesTitle;

  /// No description provided for @houseRulerTitle.
  ///
  /// In en, this message translates to:
  /// **'HOUSE RULER'**
  String get houseRulerTitle;

  /// No description provided for @noRulerInfoMessage.
  ///
  /// In en, this message translates to:
  /// **'No ruling planet information is available.'**
  String get noRulerInfoMessage;

  /// No description provided for @rulesThisHouse.
  ///
  /// In en, this message translates to:
  /// **'{planet} rules this house.'**
  String rulesThisHouse(String planet);

  /// No description provided for @rulerHouseInline.
  ///
  /// In en, this message translates to:
  /// **'· House {roman}'**
  String rulerHouseInline(String roman);

  /// No description provided for @retrogradeLabel.
  ///
  /// In en, this message translates to:
  /// **'Retrograde'**
  String get retrogradeLabel;

  /// No description provided for @planetsInThisHouseTitle.
  ///
  /// In en, this message translates to:
  /// **'PLANETS IN THIS HOUSE'**
  String get planetsInThisHouseTitle;

  /// No description provided for @noPlanetsInHouseMessage.
  ///
  /// In en, this message translates to:
  /// **'There are no natal planets in this house. This does not mean the house is unimportant. Its sign and ruling planet still describe how this area of life is expressed.'**
  String get noPlanetsInHouseMessage;

  /// No description provided for @influencesTitle.
  ///
  /// In en, this message translates to:
  /// **'INFLUENCES'**
  String get influencesTitle;

  /// No description provided for @supportiveLabel.
  ///
  /// In en, this message translates to:
  /// **'SUPPORTIVE'**
  String get supportiveLabel;

  /// No description provided for @challengingLabel.
  ///
  /// In en, this message translates to:
  /// **'CHALLENGING'**
  String get challengingLabel;

  /// No description provided for @yourHouseTitle.
  ///
  /// In en, this message translates to:
  /// **'YOUR HOUSE {roman}'**
  String yourHouseTitle(String roman);

  /// No description provided for @houseMeaning1.
  ///
  /// In en, this message translates to:
  /// **'The First House represents identity, appearance, first impressions and the instinctive way you approach life.'**
  String get houseMeaning1;

  /// No description provided for @houseMeaning2.
  ///
  /// In en, this message translates to:
  /// **'The Second House represents money, possessions, personal values, security and self-worth.'**
  String get houseMeaning2;

  /// No description provided for @houseMeaning3.
  ///
  /// In en, this message translates to:
  /// **'The Third House represents communication, learning, thinking, siblings and your immediate environment.'**
  String get houseMeaning3;

  /// No description provided for @houseMeaning4.
  ///
  /// In en, this message translates to:
  /// **'The Fourth House represents home, family, roots, privacy and your emotional foundations.'**
  String get houseMeaning4;

  /// No description provided for @houseMeaning5.
  ///
  /// In en, this message translates to:
  /// **'The Fifth House represents creativity, romance, pleasure, self-expression and the things that bring joy.'**
  String get houseMeaning5;

  /// No description provided for @houseMeaning6.
  ///
  /// In en, this message translates to:
  /// **'The Sixth House represents routines, daily work, habits, service and personal well-being.'**
  String get houseMeaning6;

  /// No description provided for @houseMeaning7.
  ///
  /// In en, this message translates to:
  /// **'The Seventh House represents relationships, partnerships, commitment and the way you meet other people as equals.'**
  String get houseMeaning7;

  /// No description provided for @houseMeaning8.
  ///
  /// In en, this message translates to:
  /// **'The Eighth House represents intimacy, trust, shared resources, vulnerability, crisis and transformation.'**
  String get houseMeaning8;

  /// No description provided for @houseMeaning9.
  ///
  /// In en, this message translates to:
  /// **'The Ninth House represents beliefs, philosophy, higher learning, travel and the search for meaning.'**
  String get houseMeaning9;

  /// No description provided for @houseMeaning10.
  ///
  /// In en, this message translates to:
  /// **'The Tenth House represents career, reputation, public life, ambition and the direction you build over time.'**
  String get houseMeaning10;

  /// No description provided for @houseMeaning11.
  ///
  /// In en, this message translates to:
  /// **'The Eleventh House represents friendships, community, networks, collective projects and future goals.'**
  String get houseMeaning11;

  /// No description provided for @houseMeaning12.
  ///
  /// In en, this message translates to:
  /// **'The Twelfth House represents the inner world, solitude, the subconscious, hidden emotions and what is processed privately.'**
  String get houseMeaning12;

  /// No description provided for @houseMeaningDefault.
  ///
  /// In en, this message translates to:
  /// **'This house represents a specific area of life within the natal chart.'**
  String get houseMeaningDefault;

  /// No description provided for @profileLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load profile.'**
  String get profileLoadError;

  /// No description provided for @featureTodayTitle.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get featureTodayTitle;

  /// No description provided for @featureTodayDescription.
  ///
  /// In en, this message translates to:
  /// **'See how today\'s transits are influencing your chart.'**
  String get featureTodayDescription;

  /// No description provided for @featureTodayAction.
  ///
  /// In en, this message translates to:
  /// **'VIEW TODAY'**
  String get featureTodayAction;

  /// No description provided for @featureTransitsTitle.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE TRANSITS'**
  String get featureTransitsTitle;

  /// No description provided for @featureTransitsDescription.
  ///
  /// In en, this message translates to:
  /// **'The most important transits happening right now.'**
  String get featureTransitsDescription;

  /// No description provided for @featureTransitsAction.
  ///
  /// In en, this message translates to:
  /// **'VIEW TRANSITS'**
  String get featureTransitsAction;

  /// No description provided for @featureWeekTitle.
  ///
  /// In en, this message translates to:
  /// **'THIS WEEK'**
  String get featureWeekTitle;

  /// No description provided for @featureWeekDescription.
  ///
  /// In en, this message translates to:
  /// **'Your astrological forecast for the week ahead.'**
  String get featureWeekDescription;

  /// No description provided for @featureWeekAction.
  ///
  /// In en, this message translates to:
  /// **'VIEW WEEK'**
  String get featureWeekAction;

  /// No description provided for @yourChartTitle.
  ///
  /// In en, this message translates to:
  /// **'YOUR CHART'**
  String get yourChartTitle;

  /// No description provided for @yourChartDescription.
  ///
  /// In en, this message translates to:
  /// **'Explore your natal chart, planets, houses and aspects in detail.'**
  String get yourChartDescription;

  /// No description provided for @viewFullChartAction.
  ///
  /// In en, this message translates to:
  /// **'VIEW FULL CHART'**
  String get viewFullChartAction;

  /// No description provided for @languageSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'LANGUAGE'**
  String get languageSectionTitle;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get languageSpanish;

  /// No description provided for @navToday.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get navToday;

  /// No description provided for @navChart.
  ///
  /// In en, this message translates to:
  /// **'CHART'**
  String get navChart;

  /// No description provided for @navWeek.
  ///
  /// In en, this message translates to:
  /// **'WEEK'**
  String get navWeek;

  /// No description provided for @navMe.
  ///
  /// In en, this message translates to:
  /// **'ME'**
  String get navMe;

  /// No description provided for @elementFire.
  ///
  /// In en, this message translates to:
  /// **'Fire'**
  String get elementFire;

  /// No description provided for @elementEarth.
  ///
  /// In en, this message translates to:
  /// **'Earth'**
  String get elementEarth;

  /// No description provided for @elementAir.
  ///
  /// In en, this message translates to:
  /// **'Air'**
  String get elementAir;

  /// No description provided for @elementWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get elementWater;

  /// No description provided for @modalityCardinal.
  ///
  /// In en, this message translates to:
  /// **'Cardinal'**
  String get modalityCardinal;

  /// No description provided for @modalityFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get modalityFixed;

  /// No description provided for @modalityMutable.
  ///
  /// In en, this message translates to:
  /// **'Mutable'**
  String get modalityMutable;

  /// No description provided for @signAries.
  ///
  /// In en, this message translates to:
  /// **'Aries'**
  String get signAries;

  /// No description provided for @signTaurus.
  ///
  /// In en, this message translates to:
  /// **'Taurus'**
  String get signTaurus;

  /// No description provided for @signGemini.
  ///
  /// In en, this message translates to:
  /// **'Gemini'**
  String get signGemini;

  /// No description provided for @signCancer.
  ///
  /// In en, this message translates to:
  /// **'Cancer'**
  String get signCancer;

  /// No description provided for @signLeo.
  ///
  /// In en, this message translates to:
  /// **'Leo'**
  String get signLeo;

  /// No description provided for @signVirgo.
  ///
  /// In en, this message translates to:
  /// **'Virgo'**
  String get signVirgo;

  /// No description provided for @signLibra.
  ///
  /// In en, this message translates to:
  /// **'Libra'**
  String get signLibra;

  /// No description provided for @signScorpio.
  ///
  /// In en, this message translates to:
  /// **'Scorpio'**
  String get signScorpio;

  /// No description provided for @signSagittarius.
  ///
  /// In en, this message translates to:
  /// **'Sagittarius'**
  String get signSagittarius;

  /// No description provided for @signCapricorn.
  ///
  /// In en, this message translates to:
  /// **'Capricorn'**
  String get signCapricorn;

  /// No description provided for @signAquarius.
  ///
  /// In en, this message translates to:
  /// **'Aquarius'**
  String get signAquarius;

  /// No description provided for @signPisces.
  ///
  /// In en, this message translates to:
  /// **'Pisces'**
  String get signPisces;

  /// No description provided for @signDateRangeAries.
  ///
  /// In en, this message translates to:
  /// **'Mar 21 – Apr 19'**
  String get signDateRangeAries;

  /// No description provided for @signDateRangeTaurus.
  ///
  /// In en, this message translates to:
  /// **'Apr 20 – May 20'**
  String get signDateRangeTaurus;

  /// No description provided for @signDateRangeGemini.
  ///
  /// In en, this message translates to:
  /// **'May 21 – Jun 20'**
  String get signDateRangeGemini;

  /// No description provided for @signDateRangeCancer.
  ///
  /// In en, this message translates to:
  /// **'Jun 21 – Jul 22'**
  String get signDateRangeCancer;

  /// No description provided for @signDateRangeLeo.
  ///
  /// In en, this message translates to:
  /// **'Jul 23 – Aug 22'**
  String get signDateRangeLeo;

  /// No description provided for @signDateRangeVirgo.
  ///
  /// In en, this message translates to:
  /// **'Aug 23 – Sep 22'**
  String get signDateRangeVirgo;

  /// No description provided for @signDateRangeLibra.
  ///
  /// In en, this message translates to:
  /// **'Sep 23 – Oct 22'**
  String get signDateRangeLibra;

  /// No description provided for @signDateRangeScorpio.
  ///
  /// In en, this message translates to:
  /// **'Oct 23 – Nov 21'**
  String get signDateRangeScorpio;

  /// No description provided for @signDateRangeSagittarius.
  ///
  /// In en, this message translates to:
  /// **'Nov 22 – Dec 21'**
  String get signDateRangeSagittarius;

  /// No description provided for @signDateRangeCapricorn.
  ///
  /// In en, this message translates to:
  /// **'Dec 22 – Jan 19'**
  String get signDateRangeCapricorn;

  /// No description provided for @signDateRangeAquarius.
  ///
  /// In en, this message translates to:
  /// **'Jan 20 – Feb 18'**
  String get signDateRangeAquarius;

  /// No description provided for @signDateRangePisces.
  ///
  /// In en, this message translates to:
  /// **'Feb 19 – Mar 20'**
  String get signDateRangePisces;

  /// No description provided for @planetSun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get planetSun;

  /// No description provided for @planetMoon.
  ///
  /// In en, this message translates to:
  /// **'Moon'**
  String get planetMoon;

  /// No description provided for @planetMercury.
  ///
  /// In en, this message translates to:
  /// **'Mercury'**
  String get planetMercury;

  /// No description provided for @planetVenus.
  ///
  /// In en, this message translates to:
  /// **'Venus'**
  String get planetVenus;

  /// No description provided for @planetMars.
  ///
  /// In en, this message translates to:
  /// **'Mars'**
  String get planetMars;

  /// No description provided for @planetJupiter.
  ///
  /// In en, this message translates to:
  /// **'Jupiter'**
  String get planetJupiter;

  /// No description provided for @planetSaturn.
  ///
  /// In en, this message translates to:
  /// **'Saturn'**
  String get planetSaturn;

  /// No description provided for @planetUranus.
  ///
  /// In en, this message translates to:
  /// **'Uranus'**
  String get planetUranus;

  /// No description provided for @planetNeptune.
  ///
  /// In en, this message translates to:
  /// **'Neptune'**
  String get planetNeptune;

  /// No description provided for @planetPluto.
  ///
  /// In en, this message translates to:
  /// **'Pluto'**
  String get planetPluto;

  /// No description provided for @planetNorthNode.
  ///
  /// In en, this message translates to:
  /// **'North Node'**
  String get planetNorthNode;

  /// No description provided for @planetChiron.
  ///
  /// In en, this message translates to:
  /// **'Chiron'**
  String get planetChiron;

  /// No description provided for @planetPartOfFortune.
  ///
  /// In en, this message translates to:
  /// **'Part of Fortune'**
  String get planetPartOfFortune;

  /// No description provided for @planetLilith.
  ///
  /// In en, this message translates to:
  /// **'Lilith'**
  String get planetLilith;

  /// No description provided for @planetAscendant.
  ///
  /// In en, this message translates to:
  /// **'Ascendant'**
  String get planetAscendant;

  /// No description provided for @planetMidheaven.
  ///
  /// In en, this message translates to:
  /// **'Midheaven'**
  String get planetMidheaven;

  /// No description provided for @aspectConjunction.
  ///
  /// In en, this message translates to:
  /// **'conjunction'**
  String get aspectConjunction;

  /// No description provided for @aspectOpposition.
  ///
  /// In en, this message translates to:
  /// **'opposition'**
  String get aspectOpposition;

  /// No description provided for @aspectSquare.
  ///
  /// In en, this message translates to:
  /// **'square'**
  String get aspectSquare;

  /// No description provided for @aspectTrine.
  ///
  /// In en, this message translates to:
  /// **'trine'**
  String get aspectTrine;

  /// No description provided for @aspectSextile.
  ///
  /// In en, this message translates to:
  /// **'sextile'**
  String get aspectSextile;

  /// No description provided for @levelVeryHigh.
  ///
  /// In en, this message translates to:
  /// **'VERY HIGH'**
  String get levelVeryHigh;

  /// No description provided for @levelHigh.
  ///
  /// In en, this message translates to:
  /// **'HIGH'**
  String get levelHigh;

  /// No description provided for @levelMedium.
  ///
  /// In en, this message translates to:
  /// **'MEDIUM'**
  String get levelMedium;

  /// No description provided for @levelLow.
  ///
  /// In en, this message translates to:
  /// **'LOW'**
  String get levelLow;

  /// No description provided for @strengthVeryStrong.
  ///
  /// In en, this message translates to:
  /// **'Very Strong'**
  String get strengthVeryStrong;

  /// No description provided for @strengthStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get strengthStrong;

  /// No description provided for @strengthModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get strengthModerate;

  /// No description provided for @strengthWide.
  ///
  /// In en, this message translates to:
  /// **'Wide'**
  String get strengthWide;

  /// No description provided for @yourProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Profile'**
  String get yourProfileTitle;

  /// No description provided for @manageAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your account and preferences.'**
  String get manageAccountSubtitle;

  /// No description provided for @accountLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load your account.'**
  String get accountLoadError;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfileTitle;

  /// No description provided for @editProfileDescription.
  ///
  /// In en, this message translates to:
  /// **'You can change your display name and username. Your birth information cannot be edited here.'**
  String get editProfileDescription;

  /// No description provided for @displayNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get displayNameLabel;

  /// No description provided for @nameEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Name cannot be empty.'**
  String get nameEmptyError;

  /// No description provided for @usernameMinLengthValidationError.
  ///
  /// In en, this message translates to:
  /// **'Username must contain at least 3 characters.'**
  String get usernameMinLengthValidationError;

  /// No description provided for @usernameNoSpacesError.
  ///
  /// In en, this message translates to:
  /// **'Username cannot contain spaces.'**
  String get usernameNoSpacesError;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @saveChangesButton.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChangesButton;

  /// No description provided for @profileUpdatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully.'**
  String get profileUpdatedMessage;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @themeLabel.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeLabel;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @notificationsLabel.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsLabel;

  /// No description provided for @onLabel.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get onLabel;

  /// No description provided for @offLabel.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get offLabel;

  /// No description provided for @themeSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme settings'**
  String get themeSettingsTitle;

  /// No description provided for @notificationSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification settings'**
  String get notificationSettingsTitle;

  /// No description provided for @helpSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupportTitle;

  /// No description provided for @aboutSacredTitle.
  ///
  /// In en, this message translates to:
  /// **'About Sacred'**
  String get aboutSacredTitle;

  /// No description provided for @aboutSacredDescription.
  ///
  /// In en, this message translates to:
  /// **'Sacred is an astrology and self-discovery experience.'**
  String get aboutSacredDescription;

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// No description provided for @comingSoonSuffix.
  ///
  /// In en, this message translates to:
  /// **'coming soon'**
  String get comingSoonSuffix;

  /// No description provided for @logoutButton.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutButton;

  /// No description provided for @logOutButtonUppercase.
  ///
  /// In en, this message translates to:
  /// **'LOG OUT'**
  String get logOutButtonUppercase;

  /// No description provided for @birthInformationTitle.
  ///
  /// In en, this message translates to:
  /// **'BIRTH INFORMATION'**
  String get birthInformationTitle;

  /// No description provided for @birthInformationNote.
  ///
  /// In en, this message translates to:
  /// **'This information is part of your natal chart and cannot be edited yet.'**
  String get birthInformationNote;

  /// No description provided for @birthPlaceLabel.
  ///
  /// In en, this message translates to:
  /// **'Birth Place'**
  String get birthPlaceLabel;

  /// No description provided for @accountSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get accountSectionTitle;

  /// No description provided for @memberSinceLabel.
  ///
  /// In en, this message translates to:
  /// **'Member since'**
  String get memberSinceLabel;

  /// No description provided for @memberSinceWithDate.
  ///
  /// In en, this message translates to:
  /// **'Member since {date}'**
  String memberSinceWithDate(String date);

  /// No description provided for @preferencesSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES'**
  String get preferencesSectionTitle;

  /// No description provided for @supportSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'SUPPORT'**
  String get supportSectionTitle;

  /// No description provided for @quoteLine1.
  ///
  /// In en, this message translates to:
  /// **'The cosmos is not outside of you.'**
  String get quoteLine1;

  /// No description provided for @quoteLine2.
  ///
  /// In en, this message translates to:
  /// **'Look within; everything you seek is already there.'**
  String get quoteLine2;

  /// No description provided for @privacyBannerText.
  ///
  /// In en, this message translates to:
  /// **'Your privacy and security are important to us. We never share your personal information.'**
  String get privacyBannerText;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

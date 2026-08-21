// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get retry => 'Retry';

  @override
  String get backTooltip => 'Back';

  @override
  String get errorNetwork =>
      'Could not connect to the server. Check your connection and try again.';

  @override
  String get errorTimeout => 'The request took too long. Please try again.';

  @override
  String get errorInvalidResponse =>
      'The server returned an unexpected response.';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get loginWelcomeTitle => 'Welcome back';

  @override
  String get loginWelcomeSubtitle => 'Connect to your personal cosmos.';

  @override
  String get fieldEmailOrUsernameLabel => 'Email or @username';

  @override
  String get fieldEmailOrUsernameHint => 'Enter your email or username';

  @override
  String get fieldEmailOrUsernameError => 'Enter your email or username';

  @override
  String get fieldPasswordLabel => 'Password';

  @override
  String get fieldPasswordHint => 'Password';

  @override
  String get fieldPasswordRequiredError => 'Enter your password';

  @override
  String get forgotPassword => 'Forgot your password?';

  @override
  String get loginButton => 'Log In';

  @override
  String get noAccountPrompt => 'Don\'t have an account?';

  @override
  String get signUpLink => 'Sign Up';

  @override
  String get loginHeroTitle => 'Your destiny awaits.';

  @override
  String get loginHeroSubtitle =>
      'Connect with your cosmic essence and discover what the stars have in store for you.';

  @override
  String get registerCreateAccountTitle => 'Create Account';

  @override
  String get registerSubtitle =>
      'Enter your exact birth details for an accurate natal chart.';

  @override
  String get fieldFullNameLabel => 'Full Name';

  @override
  String get fieldFullNameHint => 'E.g. Ana García';

  @override
  String get fieldFullNameError => 'Enter your name';

  @override
  String get fieldUsernameLabel => 'Username';

  @override
  String get fieldUsernameHint => 'username';

  @override
  String get fieldUsernameRequiredError => 'Enter a username';

  @override
  String get fieldUsernameMinLengthError => 'Minimum 3 characters';

  @override
  String get fieldEmailLabel => 'Email';

  @override
  String get fieldEmailHint => 'you@email.com';

  @override
  String get fieldEmailRequiredError => 'Enter your email';

  @override
  String get fieldEmailInvalidError => 'Invalid email';

  @override
  String get fieldRegisterPasswordRequiredError => 'Enter a password';

  @override
  String get fieldPasswordMinLengthError => 'Must be at least 8 characters';

  @override
  String get fieldBirthDateLabel => 'Date of Birth';

  @override
  String get fieldBirthDateHint => 'dd-mm-yyyy';

  @override
  String get fieldBirthDateError => 'Select a date';

  @override
  String get fieldBirthTimeLabel => 'Time of Birth';

  @override
  String get fieldBirthTimeHint => '--:--';

  @override
  String get fieldBirthTimeError => 'Select a time';

  @override
  String get fieldBirthPlaceLabel => 'Place of Birth';

  @override
  String get fieldBirthPlaceHint => 'City, Country';

  @override
  String get fieldBirthPlaceError => 'Enter city and country';

  @override
  String get registerButton => 'Begin Journey';

  @override
  String get alreadyHaveAccountPrompt => 'Already have an account?';

  @override
  String get selectBirthDateMessage => 'Select your date of birth.';

  @override
  String get selectBirthTimeMessage => 'Select your time of birth.';

  @override
  String get accountCreatedMessage => 'Account created successfully.';

  @override
  String get registerHeroTitle => 'Recognize yourself in the cosmos.';

  @override
  String get registerHeroSubtitle =>
      'A deep dive into your celestial identity, presented with clarity and modern elegance.';

  @override
  String get todayHeroTitle => 'TODAY';

  @override
  String get todayEnergyTitle => 'YOUR ENERGY TODAY';

  @override
  String moonInSign(String sign) {
    return 'MOON IN $sign';
  }

  @override
  String get bigThreeTitle => 'YOUR BIG THREE';

  @override
  String get sunLabel => 'SUN';

  @override
  String get moonLabel => 'MOON';

  @override
  String get risingLabel => 'RISING';

  @override
  String get affectedHousesTitle => 'AFFECTED HOUSES';

  @override
  String get noActiveHousesMessage => 'No houses are especially activated.';

  @override
  String get todaysThemesTitle => 'TODAY\'S THEMES';

  @override
  String get todayReflectionNote =>
      'Your day reflects the interaction between your natal chart and the current sky.';

  @override
  String get activeTransitsTitle => 'ACTIVE TRANSITS';

  @override
  String get noActiveTransitsMessage => 'No notable transits today.';

  @override
  String get todaysFocusTitle => 'TODAY\'S FOCUS';

  @override
  String get luckyTimeTitle => 'LUCKY TIME';

  @override
  String get luckyColorTitle => 'LUCKY COLOR';

  @override
  String get todayLoadError => 'Could not load Today.';

  @override
  String get todayMoonSubtitleAries => 'Emotion moves quickly and directly.';

  @override
  String get todayMoonSubtitleTaurus =>
      'A slower rhythm favors stability and grounding.';

  @override
  String get todayMoonSubtitleGemini =>
      'Curiosity and communication shape the emotional tone.';

  @override
  String get todayMoonSubtitleCancer =>
      'Sensitivity, belonging and emotional security come forward.';

  @override
  String get todayMoonSubtitleLeo =>
      'Expression, warmth and recognition become more noticeable.';

  @override
  String get todayMoonSubtitleVirgo =>
      'Attention turns toward details, routines and improvement.';

  @override
  String get todayMoonSubtitleLibra =>
      'Balance, connection and harmony become more important.';

  @override
  String get todayMoonSubtitleScorpio =>
      'Emotions deepen and hidden layers may become more visible.';

  @override
  String get todayMoonSubtitleSagittarius =>
      'The mood favors movement, perspective and exploration.';

  @override
  String get todayMoonSubtitleCapricorn =>
      'Emotional energy becomes more contained and goal-oriented.';

  @override
  String get todayMoonSubtitleAquarius =>
      'Distance, perspective and unconventional ideas come forward.';

  @override
  String get todayMoonSubtitlePisces =>
      'Intuition, imagination and sensitivity are heightened.';

  @override
  String get todayMoonSubtitleDefault => 'Your emotional rhythm for today.';

  @override
  String get todayQuoteAries => 'Move with intention, not only impulse.';

  @override
  String get todayQuoteTaurus => 'What is steady does not need to be rushed.';

  @override
  String get todayQuoteGemini =>
      'A new perspective can change the entire conversation.';

  @override
  String get todayQuoteCancer =>
      'Protect what matters without closing yourself off.';

  @override
  String get todayQuoteLeo =>
      'Expression becomes stronger when it comes from sincerity.';

  @override
  String get todayQuoteVirgo =>
      'Small adjustments can change the whole rhythm.';

  @override
  String get todayQuoteLibra => 'Balance is created, not simply found.';

  @override
  String get todayQuoteScorpio => 'Depth reveals what the surface cannot.';

  @override
  String get todayQuoteSagittarius =>
      'Perspective expands when you allow yourself to move.';

  @override
  String get todayQuoteCapricorn =>
      'What you build patiently can become lasting.';

  @override
  String get todayQuoteAquarius =>
      'Distance can reveal patterns that closeness hides.';

  @override
  String get todayQuotePisces =>
      'Not everything meaningful needs to be explained immediately.';

  @override
  String get todayQuoteDefault => 'Notice what the day is asking you to see.';

  @override
  String get todayLuckyColorAries => 'Crimson';

  @override
  String get todayLuckyColorTaurus => 'Sage Green';

  @override
  String get todayLuckyColorGemini => 'Soft Yellow';

  @override
  String get todayLuckyColorCancer => 'Pearl';

  @override
  String get todayLuckyColorLeo => 'Gold';

  @override
  String get todayLuckyColorVirgo => 'Olive';

  @override
  String get todayLuckyColorLibra => 'Rose';

  @override
  String get todayLuckyColorScorpio => 'Burgundy';

  @override
  String get todayLuckyColorSagittarius => 'Indigo';

  @override
  String get todayLuckyColorCapricorn => 'Charcoal';

  @override
  String get todayLuckyColorAquarius => 'Electric Blue';

  @override
  String get todayLuckyColorPisces => 'Lavender';

  @override
  String get todayLuckyColorDefault => 'Neutral';

  @override
  String get todayThemeLove => 'Love';

  @override
  String get todayThemeEnergy => 'Energy';

  @override
  String get todayThemeWork => 'Work';

  @override
  String get todayThemeEmotions => 'Emotions';

  @override
  String todayHouseTitleTemplate(String roman) {
    return 'House $roman';
  }

  @override
  String get todayHouseSubtitle1 => 'Self & identity';

  @override
  String get todayHouseDescription1 =>
      'Identity, appearance, beginnings and the way you approach life.';

  @override
  String get todayHouseSubtitle2 => 'Values & resources';

  @override
  String get todayHouseDescription2 =>
      'Money, resources, possessions and personal values.';

  @override
  String get todayHouseSubtitle3 => 'Communication';

  @override
  String get todayHouseDescription3 =>
      'Communication, learning, ideas and your immediate environment.';

  @override
  String get todayHouseSubtitle4 => 'Home & roots';

  @override
  String get todayHouseDescription4 =>
      'Home, family, roots and your private emotional foundation.';

  @override
  String get todayHouseSubtitle5 => 'Creativity & pleasure';

  @override
  String get todayHouseDescription5 =>
      'Creativity, romance, pleasure and personal expression.';

  @override
  String get todayHouseSubtitle6 => 'Routine & wellbeing';

  @override
  String get todayHouseDescription6 =>
      'Daily routines, work, health and practical responsibilities.';

  @override
  String get todayHouseSubtitle7 => 'Relationships';

  @override
  String get todayHouseDescription7 =>
      'Partnerships, relationships and important one-to-one bonds.';

  @override
  String get todayHouseSubtitle8 => 'Transformation';

  @override
  String get todayHouseDescription8 =>
      'Intimacy, transformation, shared resources and deep emotional change.';

  @override
  String get todayHouseSubtitle9 => 'Beliefs & exploration';

  @override
  String get todayHouseDescription9 =>
      'Beliefs, higher learning, travel and expansion of perspective.';

  @override
  String get todayHouseSubtitle10 => 'Career & direction';

  @override
  String get todayHouseDescription10 =>
      'Career, reputation, ambition and your public direction.';

  @override
  String get todayHouseSubtitle11 => 'Friends & community';

  @override
  String get todayHouseDescription11 =>
      'Friendships, communities, future plans and collective goals.';

  @override
  String get todayHouseSubtitle12 => 'Inner world';

  @override
  String get todayHouseDescription12 =>
      'Rest, intuition, subconscious patterns and your private inner world.';

  @override
  String todayTransitTitleTemplate(String first, String aspect, String second) {
    return '$first $aspect natal $second';
  }

  @override
  String todayTransitDescriptionTemplate(
      String first, String second, String tone) {
    return '$first is interacting with your natal $second. $tone';
  }

  @override
  String get todayTransitToneTrine =>
      'This creates a smoother flow between both energies.';

  @override
  String get todayTransitToneSextile =>
      'This opens an opportunity to use both energies constructively.';

  @override
  String get todayTransitToneSquare =>
      'This can create friction that asks for adjustment and awareness.';

  @override
  String get todayTransitToneOpposition =>
      'This highlights a polarity that may require balance.';

  @override
  String get todayTransitToneConjunction =>
      'These energies become strongly combined and more noticeable.';

  @override
  String get todayTransitToneDefault =>
      'This interaction is currently active in your natal chart.';

  @override
  String get todayTransitStatusExactToday => 'Exact today';

  @override
  String get todayTransitStatusActive => 'Active';

  @override
  String todayTransitStatusActiveExact(String date) {
    return 'Active · exact $date';
  }

  @override
  String todayFocusTemplate(String first, String aspect, String second) {
    return 'Notice how $first $aspect your natal $second shows up in your choices today.';
  }

  @override
  String get todayFocusDefault =>
      'Observe your rhythm and avoid forcing unnecessary decisions.';

  @override
  String todayInterpretationHouseClause(
      String houseTitle, String houseSubtitle) {
    return 'Your $houseTitle ($houseSubtitle) is especially activated.';
  }

  @override
  String todayInterpretationMoonIntroExact(String sign) {
    return 'With the Moon moving through $sign, today\'s emotional tone emphasizes the qualities of that sign.';
  }

  @override
  String todayInterpretationMainPattern(String title) {
    return 'A major pattern today is $title.';
  }

  @override
  String todayInterpretationSecondPattern(String title) {
    return 'Another exact influence is $title.';
  }

  @override
  String get todayInterpretationClosing =>
      'Notice how these energies appear in your decisions, reactions and relationships rather than treating them as isolated events.';

  @override
  String todayInterpretationMoonIntroActive(String sign) {
    return 'With the Moon moving through $sign, your emotional rhythm reflects the themes of that sign.';
  }

  @override
  String todayInterpretationStrongestPattern(String title) {
    return 'One of the strongest active patterns around your chart is $title.';
  }

  @override
  String todayInterpretationQuietWithMoon(String sign) {
    return 'The Moon is moving through $sign. The sky is relatively quiet around your natal chart today, making this a useful day to observe your emotional rhythm without forcing major movement.';
  }

  @override
  String get todayInterpretationQuietNoMoon =>
      'The sky is relatively quiet around your natal chart today. Observe your natural rhythm rather than forcing unnecessary movement.';

  @override
  String get celestialBlueprintTitle => 'Your Celestial Blueprint';

  @override
  String get elementLabel => 'ELEMENT';

  @override
  String get rulingPlanetLabel => 'RULING PLANET';

  @override
  String get modalityLabel => 'MODALITY';

  @override
  String get mostActiveHousesTitle => 'YOUR MOST ACTIVE HOUSES';

  @override
  String get viewAllHouses => 'View all houses';

  @override
  String houseFallbackTitle(int number) {
    return 'HOUSE $number';
  }

  @override
  String get houseTitle1 => 'House of Self';

  @override
  String get houseSubtitle1 => 'Identity, appearance & first impressions';

  @override
  String get houseTitle2 => 'House of Values';

  @override
  String get houseSubtitle2 => 'Money, possessions & self-worth';

  @override
  String get houseTitle3 => 'House of Communication';

  @override
  String get houseSubtitle3 => 'Thinking, learning & communication';

  @override
  String get houseTitle4 => 'House of Home';

  @override
  String get houseSubtitle4 => 'Roots, family & emotional foundations';

  @override
  String get houseTitle5 => 'House of Creativity';

  @override
  String get houseSubtitle5 => 'Expression, romance & pleasure';

  @override
  String get houseTitle6 => 'House of Daily Life';

  @override
  String get houseSubtitle6 => 'Routine, work & well-being';

  @override
  String get houseTitle7 => 'House of Relationships';

  @override
  String get houseSubtitle7 => 'Partnerships, commitment & the other';

  @override
  String get houseTitle8 => 'House of Transformation';

  @override
  String get houseSubtitle8 => 'Intimacy, trust & shared resources';

  @override
  String get houseTitle9 => 'House of Expansion';

  @override
  String get houseSubtitle9 => 'Beliefs, travel & higher learning';

  @override
  String get houseTitle10 => 'House of Career';

  @override
  String get houseSubtitle10 => 'Purpose, reputation & public life';

  @override
  String get houseTitle11 => 'House of Community';

  @override
  String get houseSubtitle11 => 'Friendships, networks & future goals';

  @override
  String get houseTitle12 => 'House of the Inner World';

  @override
  String get houseSubtitle12 => 'Subconscious, solitude & hidden emotions';

  @override
  String get houseKeywordIdentity => 'Identity';

  @override
  String get houseKeywordAppearance => 'Appearance';

  @override
  String get houseKeywordFirstImpressions => 'First impressions';

  @override
  String get houseKeywordMoney => 'Money';

  @override
  String get houseKeywordValues => 'Values';

  @override
  String get houseKeywordSelfWorth => 'Self-worth';

  @override
  String get houseKeywordCommunication => 'Communication';

  @override
  String get houseKeywordLearning => 'Learning';

  @override
  String get houseKeywordThinking => 'Thinking';

  @override
  String get houseKeywordSiblings => 'Siblings';

  @override
  String get houseKeywordHome => 'Home';

  @override
  String get houseKeywordFamily => 'Family';

  @override
  String get houseKeywordRoots => 'Roots';

  @override
  String get houseKeywordCreativity => 'Creativity';

  @override
  String get houseKeywordRomance => 'Romance';

  @override
  String get houseKeywordPleasure => 'Pleasure';

  @override
  String get houseKeywordRoutine => 'Routine';

  @override
  String get houseKeywordWork => 'Work';

  @override
  String get houseKeywordWellbeing => 'Well-being';

  @override
  String get houseKeywordRelationships => 'Relationships';

  @override
  String get houseKeywordPartnerships => 'Partnerships';

  @override
  String get houseKeywordCommitment => 'Commitment';

  @override
  String get houseKeywordIntimacy => 'Intimacy';

  @override
  String get houseKeywordTrust => 'Trust';

  @override
  String get houseKeywordTransformation => 'Transformation';

  @override
  String get houseKeywordSharedResources => 'Shared resources';

  @override
  String get houseKeywordBeliefs => 'Beliefs';

  @override
  String get houseKeywordTravel => 'Travel';

  @override
  String get houseKeywordHigherLearning => 'Higher learning';

  @override
  String get houseKeywordCareer => 'Career';

  @override
  String get houseKeywordReputation => 'Reputation';

  @override
  String get houseKeywordPurpose => 'Purpose';

  @override
  String get houseKeywordFriendships => 'Friendships';

  @override
  String get houseKeywordFriends => 'Friends';

  @override
  String get houseKeywordCommunity => 'Community';

  @override
  String get houseKeywordFutureGoals => 'Future goals';

  @override
  String get houseKeywordGoals => 'Goals';

  @override
  String get houseKeywordInnerWorld => 'Inner world';

  @override
  String get houseKeywordSubconscious => 'Subconscious';

  @override
  String get houseKeywordSolitude => 'Solitude';

  @override
  String rulerWithName(String planet) {
    return 'Ruler · $planet';
  }

  @override
  String get rulerUnknown => 'Ruler · —';

  @override
  String get planetsTitle => 'PLANETS';

  @override
  String get noPlanetDataMessage => 'No planetary data available.';

  @override
  String houseNumberInline(int number) {
    return 'House $number';
  }

  @override
  String get noHouseInline => 'No house';

  @override
  String get aspectsTitle => 'ASPECTS';

  @override
  String get noAspectsMessage => 'No aspects available.';

  @override
  String orbLabel(String degree) {
    return 'Orb $degree';
  }

  @override
  String get chartLoadError => 'Could not load your natal chart.';

  @override
  String get housesTopBarLabel => 'HOUSES';

  @override
  String get yourNatalHousesEyebrow => 'YOUR NATAL HOUSES';

  @override
  String get twelveHousesTitle => 'The Twelve Houses';

  @override
  String get twelveHousesDescription =>
      'Each house represents a different area of your life. Its sign, ruling planet, planets inside it and aspects show how that area is expressed in your natal chart.';

  @override
  String get couldNotLoadHousesTitle => 'Could not load houses';

  @override
  String get noHouseInfoMessage => 'No house information is available.';

  @override
  String get noNatalPlanetsMessage => 'No natal planets';

  @override
  String houseTopBarLabel(String roman) {
    return 'HOUSE $roman';
  }

  @override
  String get whatThisMeansForYouTitle => 'WHAT THIS MEANS FOR YOU';

  @override
  String get planetaryInfluencesTitle => 'PLANETARY INFLUENCES';

  @override
  String get howThisMayShowUpTitle => 'HOW THIS MAY SHOW UP';

  @override
  String get houseDetailLoadError => 'Could not load this house.';

  @override
  String get whatThisHouseRulesTitle => 'WHAT THIS HOUSE RULES';

  @override
  String get houseRulerTitle => 'HOUSE RULER';

  @override
  String get noRulerInfoMessage => 'No ruling planet information is available.';

  @override
  String rulesThisHouse(String planet) {
    return '$planet rules this house.';
  }

  @override
  String rulerHouseInline(String roman) {
    return '· House $roman';
  }

  @override
  String get retrogradeLabel => 'Retrograde';

  @override
  String get planetsInThisHouseTitle => 'PLANETS IN THIS HOUSE';

  @override
  String get noPlanetsInHouseMessage =>
      'There are no natal planets in this house. This does not mean the house is unimportant. Its sign and ruling planet still describe how this area of life is expressed.';

  @override
  String get influencesTitle => 'INFLUENCES';

  @override
  String get supportiveLabel => 'SUPPORTIVE';

  @override
  String get challengingLabel => 'CHALLENGING';

  @override
  String yourHouseTitle(String roman) {
    return 'YOUR HOUSE $roman';
  }

  @override
  String get houseMeaning1 =>
      'The First House represents identity, appearance, first impressions and the instinctive way you approach life.';

  @override
  String get houseMeaning2 =>
      'The Second House represents money, possessions, personal values, security and self-worth.';

  @override
  String get houseMeaning3 =>
      'The Third House represents communication, learning, thinking, siblings and your immediate environment.';

  @override
  String get houseMeaning4 =>
      'The Fourth House represents home, family, roots, privacy and your emotional foundations.';

  @override
  String get houseMeaning5 =>
      'The Fifth House represents creativity, romance, pleasure, self-expression and the things that bring joy.';

  @override
  String get houseMeaning6 =>
      'The Sixth House represents routines, daily work, habits, service and personal well-being.';

  @override
  String get houseMeaning7 =>
      'The Seventh House represents relationships, partnerships, commitment and the way you meet other people as equals.';

  @override
  String get houseMeaning8 =>
      'The Eighth House represents intimacy, trust, shared resources, vulnerability, crisis and transformation.';

  @override
  String get houseMeaning9 =>
      'The Ninth House represents beliefs, philosophy, higher learning, travel and the search for meaning.';

  @override
  String get houseMeaning10 =>
      'The Tenth House represents career, reputation, public life, ambition and the direction you build over time.';

  @override
  String get houseMeaning11 =>
      'The Eleventh House represents friendships, community, networks, collective projects and future goals.';

  @override
  String get houseMeaning12 =>
      'The Twelfth House represents the inner world, solitude, the subconscious, hidden emotions and what is processed privately.';

  @override
  String get houseMeaningDefault =>
      'This house represents a specific area of life within the natal chart.';

  @override
  String get profileLoadError => 'Could not load profile.';

  @override
  String get featureTodayTitle => 'TODAY';

  @override
  String get featureTodayDescription =>
      'See how today\'s transits are influencing your chart.';

  @override
  String get featureTodayAction => 'VIEW TODAY';

  @override
  String get featureTransitsTitle => 'ACTIVE TRANSITS';

  @override
  String get featureTransitsDescription =>
      'The most important transits happening right now.';

  @override
  String get featureTransitsAction => 'VIEW TRANSITS';

  @override
  String get featureWeekTitle => 'THIS WEEK';

  @override
  String get featureWeekDescription =>
      'Your astrological forecast for the week ahead.';

  @override
  String get featureWeekAction => 'VIEW WEEK';

  @override
  String get yourChartTitle => 'YOUR CHART';

  @override
  String get yourChartDescription =>
      'Explore your natal chart, planets, houses and aspects in detail.';

  @override
  String get viewFullChartAction => 'VIEW FULL CHART';

  @override
  String get languageSectionTitle => 'LANGUAGE';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Español';

  @override
  String get navToday => 'TODAY';

  @override
  String get navChart => 'CHART';

  @override
  String get navWeek => 'WEEK';

  @override
  String get navMe => 'ME';

  @override
  String get elementFire => 'Fire';

  @override
  String get elementEarth => 'Earth';

  @override
  String get elementAir => 'Air';

  @override
  String get elementWater => 'Water';

  @override
  String get modalityCardinal => 'Cardinal';

  @override
  String get modalityFixed => 'Fixed';

  @override
  String get modalityMutable => 'Mutable';

  @override
  String get signAries => 'Aries';

  @override
  String get signTaurus => 'Taurus';

  @override
  String get signGemini => 'Gemini';

  @override
  String get signCancer => 'Cancer';

  @override
  String get signLeo => 'Leo';

  @override
  String get signVirgo => 'Virgo';

  @override
  String get signLibra => 'Libra';

  @override
  String get signScorpio => 'Scorpio';

  @override
  String get signSagittarius => 'Sagittarius';

  @override
  String get signCapricorn => 'Capricorn';

  @override
  String get signAquarius => 'Aquarius';

  @override
  String get signPisces => 'Pisces';

  @override
  String get signDateRangeAries => 'Mar 21 – Apr 19';

  @override
  String get signDateRangeTaurus => 'Apr 20 – May 20';

  @override
  String get signDateRangeGemini => 'May 21 – Jun 20';

  @override
  String get signDateRangeCancer => 'Jun 21 – Jul 22';

  @override
  String get signDateRangeLeo => 'Jul 23 – Aug 22';

  @override
  String get signDateRangeVirgo => 'Aug 23 – Sep 22';

  @override
  String get signDateRangeLibra => 'Sep 23 – Oct 22';

  @override
  String get signDateRangeScorpio => 'Oct 23 – Nov 21';

  @override
  String get signDateRangeSagittarius => 'Nov 22 – Dec 21';

  @override
  String get signDateRangeCapricorn => 'Dec 22 – Jan 19';

  @override
  String get signDateRangeAquarius => 'Jan 20 – Feb 18';

  @override
  String get signDateRangePisces => 'Feb 19 – Mar 20';

  @override
  String get planetSun => 'Sun';

  @override
  String get planetMoon => 'Moon';

  @override
  String get planetMercury => 'Mercury';

  @override
  String get planetVenus => 'Venus';

  @override
  String get planetMars => 'Mars';

  @override
  String get planetJupiter => 'Jupiter';

  @override
  String get planetSaturn => 'Saturn';

  @override
  String get planetUranus => 'Uranus';

  @override
  String get planetNeptune => 'Neptune';

  @override
  String get planetPluto => 'Pluto';

  @override
  String get planetNorthNode => 'North Node';

  @override
  String get planetChiron => 'Chiron';

  @override
  String get planetPartOfFortune => 'Part of Fortune';

  @override
  String get planetLilith => 'Lilith';

  @override
  String get planetAscendant => 'Ascendant';

  @override
  String get planetMidheaven => 'Midheaven';

  @override
  String get aspectConjunction => 'conjunction';

  @override
  String get aspectOpposition => 'opposition';

  @override
  String get aspectSquare => 'square';

  @override
  String get aspectTrine => 'trine';

  @override
  String get aspectSextile => 'sextile';

  @override
  String get levelVeryHigh => 'VERY HIGH';

  @override
  String get levelHigh => 'HIGH';

  @override
  String get levelMedium => 'MEDIUM';

  @override
  String get levelLow => 'LOW';

  @override
  String get strengthVeryStrong => 'Very Strong';

  @override
  String get strengthStrong => 'Strong';

  @override
  String get strengthModerate => 'Moderate';

  @override
  String get strengthWide => 'Wide';

  @override
  String get yourProfileTitle => 'Your Profile';

  @override
  String get manageAccountSubtitle => 'Manage your account and preferences.';

  @override
  String get accountLoadError => 'Could not load your account.';

  @override
  String get editProfileTitle => 'Edit profile';

  @override
  String get editProfileDescription =>
      'You can change your display name and username. Your birth information cannot be edited here.';

  @override
  String get displayNameLabel => 'Display name';

  @override
  String get nameEmptyError => 'Name cannot be empty.';

  @override
  String get usernameMinLengthValidationError =>
      'Username must contain at least 3 characters.';

  @override
  String get usernameNoSpacesError => 'Username cannot contain spaces.';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get saveChangesButton => 'Save changes';

  @override
  String get profileUpdatedMessage => 'Profile updated successfully.';

  @override
  String get languageLabel => 'Language';

  @override
  String get themeLabel => 'Theme';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeLight => 'Light';

  @override
  String get notificationsLabel => 'Notifications';

  @override
  String get onLabel => 'On';

  @override
  String get offLabel => 'Off';

  @override
  String get themeSettingsTitle => 'Theme settings';

  @override
  String get notificationSettingsTitle => 'Notification settings';

  @override
  String get helpSupportTitle => 'Help & Support';

  @override
  String get aboutSacredTitle => 'About Sacred';

  @override
  String get aboutSacredDescription =>
      'Sacred is an astrology and self-discovery experience.';

  @override
  String get closeButton => 'Close';

  @override
  String get comingSoonSuffix => 'coming soon';

  @override
  String get logoutButton => 'Logout';

  @override
  String get logOutButtonUppercase => 'LOG OUT';

  @override
  String get birthInformationTitle => 'BIRTH INFORMATION';

  @override
  String get birthInformationNote =>
      'This information is part of your natal chart and cannot be edited yet.';

  @override
  String get birthPlaceLabel => 'Birth Place';

  @override
  String get accountSectionTitle => 'ACCOUNT';

  @override
  String get memberSinceLabel => 'Member since';

  @override
  String memberSinceWithDate(String date) {
    return 'Member since $date';
  }

  @override
  String get preferencesSectionTitle => 'PREFERENCES';

  @override
  String get supportSectionTitle => 'SUPPORT';

  @override
  String get quoteLine1 => 'The cosmos is not outside of you.';

  @override
  String get quoteLine2 => 'Look within; everything you seek is already there.';

  @override
  String get privacyBannerText =>
      'Your privacy and security are important to us. We never share your personal information.';
}

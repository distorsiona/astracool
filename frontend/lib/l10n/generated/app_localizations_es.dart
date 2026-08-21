// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get retry => 'Reintentar';

  @override
  String get backTooltip => 'Atrás';

  @override
  String get errorNetwork =>
      'No se pudo conectar con el servidor. Revisa tu conexión e inténtalo de nuevo.';

  @override
  String get errorTimeout =>
      'La solicitud tardó demasiado. Inténtalo de nuevo.';

  @override
  String get errorInvalidResponse =>
      'El servidor devolvió una respuesta inesperada.';

  @override
  String get errorGeneric => 'Algo salió mal. Inténtalo de nuevo.';

  @override
  String get loginWelcomeTitle => 'Bienvenido de nuevo';

  @override
  String get loginWelcomeSubtitle => 'Conéctate a tu cosmos personal.';

  @override
  String get fieldEmailOrUsernameLabel => 'Correo o @usuario';

  @override
  String get fieldEmailOrUsernameHint => 'Introduce tu correo o usuario';

  @override
  String get fieldEmailOrUsernameError => 'Ingresa tu correo o usuario';

  @override
  String get fieldPasswordLabel => 'Contraseña';

  @override
  String get fieldPasswordHint => 'Contraseña';

  @override
  String get fieldPasswordRequiredError => 'Ingresa tu contraseña';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get loginButton => 'Iniciar Sesión';

  @override
  String get noAccountPrompt => '¿No tienes una cuenta?';

  @override
  String get signUpLink => 'Regístrate';

  @override
  String get loginHeroTitle => 'Tu destino te espera.';

  @override
  String get loginHeroSubtitle =>
      'Conecta con tu esencia cósmica y descubre lo que los astros tienen preparado para ti.';

  @override
  String get registerCreateAccountTitle => 'Crear Cuenta';

  @override
  String get registerSubtitle =>
      'Ingresa tus datos exactos de nacimiento para una carta astral precisa.';

  @override
  String get fieldFullNameLabel => 'Nombre Completo';

  @override
  String get fieldFullNameHint => 'Ej. Ana García';

  @override
  String get fieldFullNameError => 'Ingresa tu nombre';

  @override
  String get fieldUsernameLabel => 'Nombre de Usuario';

  @override
  String get fieldUsernameHint => 'usuario';

  @override
  String get fieldUsernameRequiredError => 'Ingresa un usuario';

  @override
  String get fieldUsernameMinLengthError => 'Mínimo 3 caracteres';

  @override
  String get fieldEmailLabel => 'Correo Electrónico';

  @override
  String get fieldEmailHint => 'tu@correo.com';

  @override
  String get fieldEmailRequiredError => 'Ingresa tu correo';

  @override
  String get fieldEmailInvalidError => 'Correo no válido';

  @override
  String get fieldRegisterPasswordRequiredError => 'Ingresa una contraseña';

  @override
  String get fieldPasswordMinLengthError => 'Debe tener al menos 8 caracteres';

  @override
  String get fieldBirthDateLabel => 'Fecha de Nacimiento';

  @override
  String get fieldBirthDateHint => 'dd-mm-aaaa';

  @override
  String get fieldBirthDateError => 'Selecciona fecha';

  @override
  String get fieldBirthTimeLabel => 'Hora de Nacimiento';

  @override
  String get fieldBirthTimeHint => '--:--';

  @override
  String get fieldBirthTimeError => 'Selecciona hora';

  @override
  String get fieldBirthPlaceLabel => 'Lugar de Nacimiento';

  @override
  String get fieldBirthPlaceHint => 'Ciudad, País';

  @override
  String get fieldBirthPlaceError => 'Ingresa ciudad y país';

  @override
  String get registerButton => 'Comenzar Viaje';

  @override
  String get alreadyHaveAccountPrompt => '¿Ya tienes una cuenta?';

  @override
  String get selectBirthDateMessage => 'Selecciona tu fecha de nacimiento.';

  @override
  String get selectBirthTimeMessage => 'Selecciona tu hora de nacimiento.';

  @override
  String get accountCreatedMessage => 'Cuenta creada correctamente.';

  @override
  String get registerHeroTitle => 'Reconoce en lo cósmico.';

  @override
  String get registerHeroSubtitle =>
      'Una inmersión profunda en tu identidad celestial, presentada con claridad y elegancia moderna.';

  @override
  String get todayHeroTitle => 'HOY';

  @override
  String get todayEnergyTitle => 'TU ENERGÍA DE HOY';

  @override
  String moonInSign(String sign) {
    return 'LUNA EN $sign';
  }

  @override
  String get bigThreeTitle => 'TUS TRES GRANDES';

  @override
  String get sunLabel => 'SOL';

  @override
  String get moonLabel => 'LUNA';

  @override
  String get risingLabel => 'ASCENDENTE';

  @override
  String get affectedHousesTitle => 'CASAS AFECTADAS';

  @override
  String get noActiveHousesMessage => 'No hay casas especialmente activadas.';

  @override
  String get todaysThemesTitle => 'TEMAS DE HOY';

  @override
  String get todayReflectionNote =>
      'Tu día refleja la interacción entre tu carta natal y el cielo actual.';

  @override
  String get activeTransitsTitle => 'TRÁNSITOS ACTIVOS';

  @override
  String get noActiveTransitsMessage => 'No hay tránsitos destacados hoy.';

  @override
  String get todaysFocusTitle => 'ENFOQUE DE HOY';

  @override
  String get luckyTimeTitle => 'HORA DE LA SUERTE';

  @override
  String get luckyColorTitle => 'COLOR DE LA SUERTE';

  @override
  String get todayLoadError => 'No fue posible cargar Hoy.';

  @override
  String get todayMoonSubtitleAries =>
      'La emoción se mueve rápida y directamente.';

  @override
  String get todayMoonSubtitleTaurus =>
      'Un ritmo más lento favorece la estabilidad y el arraigo.';

  @override
  String get todayMoonSubtitleGemini =>
      'La curiosidad y la comunicación marcan el tono emocional.';

  @override
  String get todayMoonSubtitleCancer =>
      'La sensibilidad, el sentido de pertenencia y la seguridad emocional se hacen presentes.';

  @override
  String get todayMoonSubtitleLeo =>
      'La expresión, la calidez y el reconocimiento se vuelven más notorios.';

  @override
  String get todayMoonSubtitleVirgo =>
      'La atención se dirige hacia los detalles, las rutinas y la mejora.';

  @override
  String get todayMoonSubtitleLibra =>
      'El equilibrio, la conexión y la armonía cobran más importancia.';

  @override
  String get todayMoonSubtitleScorpio =>
      'Las emociones se profundizan y pueden hacerse visibles capas ocultas.';

  @override
  String get todayMoonSubtitleSagittarius =>
      'El ánimo favorece el movimiento, la perspectiva y la exploración.';

  @override
  String get todayMoonSubtitleCapricorn =>
      'La energía emocional se vuelve más contenida y orientada a metas.';

  @override
  String get todayMoonSubtitleAquarius =>
      'La distancia, la perspectiva y las ideas poco convencionales salen a la luz.';

  @override
  String get todayMoonSubtitlePisces =>
      'La intuición, la imaginación y la sensibilidad se intensifican.';

  @override
  String get todayMoonSubtitleDefault => 'Tu ritmo emocional de hoy.';

  @override
  String get todayQuoteAries => 'Muévete con intención, no solo con impulso.';

  @override
  String get todayQuoteTaurus => 'Lo que es estable no necesita apresurarse.';

  @override
  String get todayQuoteGemini =>
      'Una nueva perspectiva puede cambiar toda la conversación.';

  @override
  String get todayQuoteCancer =>
      'Protege lo que importa sin cerrarte por completo.';

  @override
  String get todayQuoteLeo =>
      'La expresión se vuelve más fuerte cuando nace de la sinceridad.';

  @override
  String get todayQuoteVirgo =>
      'Pequeños ajustes pueden cambiar todo el ritmo.';

  @override
  String get todayQuoteLibra =>
      'El equilibrio se crea, no simplemente se encuentra.';

  @override
  String get todayQuoteScorpio =>
      'La profundidad revela lo que la superficie no puede.';

  @override
  String get todayQuoteSagittarius =>
      'La perspectiva se expande cuando te permites moverte.';

  @override
  String get todayQuoteCapricorn =>
      'Lo que construyes con paciencia puede perdurar.';

  @override
  String get todayQuoteAquarius =>
      'La distancia puede revelar patrones que la cercanía oculta.';

  @override
  String get todayQuotePisces =>
      'No todo lo importante necesita explicarse de inmediato.';

  @override
  String get todayQuoteDefault => 'Observa qué te está pidiendo ver el día.';

  @override
  String get todayLuckyColorAries => 'Carmesí';

  @override
  String get todayLuckyColorTaurus => 'Verde Salvia';

  @override
  String get todayLuckyColorGemini => 'Amarillo Suave';

  @override
  String get todayLuckyColorCancer => 'Perla';

  @override
  String get todayLuckyColorLeo => 'Dorado';

  @override
  String get todayLuckyColorVirgo => 'Oliva';

  @override
  String get todayLuckyColorLibra => 'Rosa';

  @override
  String get todayLuckyColorScorpio => 'Borgoña';

  @override
  String get todayLuckyColorSagittarius => 'Índigo';

  @override
  String get todayLuckyColorCapricorn => 'Carbón';

  @override
  String get todayLuckyColorAquarius => 'Azul Eléctrico';

  @override
  String get todayLuckyColorPisces => 'Lavanda';

  @override
  String get todayLuckyColorDefault => 'Neutro';

  @override
  String get todayThemeLove => 'Amor';

  @override
  String get todayThemeEnergy => 'Energía';

  @override
  String get todayThemeWork => 'Trabajo';

  @override
  String get todayThemeEmotions => 'Emociones';

  @override
  String todayHouseTitleTemplate(String roman) {
    return 'Casa $roman';
  }

  @override
  String get todayHouseSubtitle1 => 'El yo y la identidad';

  @override
  String get todayHouseDescription1 =>
      'Identidad, apariencia, comienzos y la forma en que enfrentas la vida.';

  @override
  String get todayHouseSubtitle2 => 'Valores y recursos';

  @override
  String get todayHouseDescription2 =>
      'Dinero, recursos, posesiones y valores personales.';

  @override
  String get todayHouseSubtitle3 => 'Comunicación';

  @override
  String get todayHouseDescription3 =>
      'Comunicación, aprendizaje, ideas y tu entorno inmediato.';

  @override
  String get todayHouseSubtitle4 => 'Hogar y raíces';

  @override
  String get todayHouseDescription4 =>
      'Hogar, familia, raíces y tu base emocional privada.';

  @override
  String get todayHouseSubtitle5 => 'Creatividad y placer';

  @override
  String get todayHouseDescription5 =>
      'Creatividad, romance, placer y expresión personal.';

  @override
  String get todayHouseSubtitle6 => 'Rutina y bienestar';

  @override
  String get todayHouseDescription6 =>
      'Rutinas diarias, trabajo, salud y responsabilidades prácticas.';

  @override
  String get todayHouseSubtitle7 => 'Relaciones';

  @override
  String get todayHouseDescription7 =>
      'Asociaciones, relaciones y vínculos importantes de igual a igual.';

  @override
  String get todayHouseSubtitle8 => 'Transformación';

  @override
  String get todayHouseDescription8 =>
      'Intimidad, transformación, recursos compartidos y cambio emocional profundo.';

  @override
  String get todayHouseSubtitle9 => 'Creencias y exploración';

  @override
  String get todayHouseDescription9 =>
      'Creencias, aprendizaje superior, viajes y expansión de perspectiva.';

  @override
  String get todayHouseSubtitle10 => 'Carrera y dirección';

  @override
  String get todayHouseDescription10 =>
      'Carrera, reputación, ambición y tu rumbo público.';

  @override
  String get todayHouseSubtitle11 => 'Amistades y comunidad';

  @override
  String get todayHouseDescription11 =>
      'Amistades, comunidades, planes futuros y metas colectivas.';

  @override
  String get todayHouseSubtitle12 => 'Mundo interior';

  @override
  String get todayHouseDescription12 =>
      'Descanso, intuición, patrones subconscientes y tu mundo interior privado.';

  @override
  String todayTransitTitleTemplate(String first, String aspect, String second) {
    return '$first en $aspect con tu $second natal';
  }

  @override
  String todayTransitDescriptionTemplate(
      String first, String second, String tone) {
    return '$first está interactuando con tu $second natal. $tone';
  }

  @override
  String get todayTransitToneTrine =>
      'Esto crea un flujo más armonioso entre ambas energías.';

  @override
  String get todayTransitToneSextile =>
      'Esto abre una oportunidad para usar ambas energías de forma constructiva.';

  @override
  String get todayTransitToneSquare =>
      'Esto puede generar fricción que pide ajuste y atención.';

  @override
  String get todayTransitToneOpposition =>
      'Esto resalta una polaridad que puede requerir equilibrio.';

  @override
  String get todayTransitToneConjunction =>
      'Estas energías se combinan con fuerza y se vuelven más notorias.';

  @override
  String get todayTransitToneDefault =>
      'Esta interacción está activa actualmente en tu carta natal.';

  @override
  String get todayTransitStatusExactToday => 'Exacto hoy';

  @override
  String get todayTransitStatusActive => 'Activo';

  @override
  String todayTransitStatusActiveExact(String date) {
    return 'Activo · exacto $date';
  }

  @override
  String todayFocusTemplate(String first, String aspect, String second) {
    return 'Observa cómo $first en $aspect con tu $second natal se refleja en tus decisiones de hoy.';
  }

  @override
  String get todayFocusDefault =>
      'Observa tu ritmo y evita forzar decisiones innecesarias.';

  @override
  String todayInterpretationHouseClause(
      String houseTitle, String houseSubtitle) {
    return 'Tu $houseTitle ($houseSubtitle) está especialmente activada.';
  }

  @override
  String todayInterpretationMoonIntroExact(String sign) {
    return 'Con la Luna transitando por $sign, el tono emocional de hoy resalta las cualidades de ese signo.';
  }

  @override
  String todayInterpretationMainPattern(String title) {
    return 'Un patrón importante de hoy es $title.';
  }

  @override
  String todayInterpretationSecondPattern(String title) {
    return 'Otra influencia exacta es $title.';
  }

  @override
  String get todayInterpretationClosing =>
      'Observa cómo estas energías aparecen en tus decisiones, reacciones y relaciones, en lugar de tratarlas como hechos aislados.';

  @override
  String todayInterpretationMoonIntroActive(String sign) {
    return 'Con la Luna transitando por $sign, tu ritmo emocional refleja los temas de ese signo.';
  }

  @override
  String todayInterpretationStrongestPattern(String title) {
    return 'Uno de los patrones activos más fuertes en tu carta es $title.';
  }

  @override
  String todayInterpretationQuietWithMoon(String sign) {
    return 'La Luna está transitando por $sign. El cielo está relativamente tranquilo alrededor de tu carta natal hoy, lo que hace de este un buen día para observar tu ritmo emocional sin forzar grandes movimientos.';
  }

  @override
  String get todayInterpretationQuietNoMoon =>
      'El cielo está relativamente tranquilo alrededor de tu carta natal hoy. Observa tu ritmo natural en lugar de forzar movimientos innecesarios.';

  @override
  String get celestialBlueprintTitle => 'Tu Mapa Celestial';

  @override
  String get elementLabel => 'ELEMENTO';

  @override
  String get rulingPlanetLabel => 'PLANETA REGENTE';

  @override
  String get modalityLabel => 'MODALIDAD';

  @override
  String get mostActiveHousesTitle => 'TUS CASAS MÁS ACTIVAS';

  @override
  String get viewAllHouses => 'Ver todas las casas';

  @override
  String houseFallbackTitle(int number) {
    return 'CASA $number';
  }

  @override
  String get houseTitle1 => 'Casa del Yo';

  @override
  String get houseSubtitle1 => 'Identidad, apariencia y primeras impresiones';

  @override
  String get houseTitle2 => 'Casa de los Valores';

  @override
  String get houseSubtitle2 => 'Dinero, posesiones y autoestima';

  @override
  String get houseTitle3 => 'Casa de la Comunicación';

  @override
  String get houseSubtitle3 => 'Pensamiento, aprendizaje y comunicación';

  @override
  String get houseTitle4 => 'Casa del Hogar';

  @override
  String get houseSubtitle4 => 'Raíces, familia y bases emocionales';

  @override
  String get houseTitle5 => 'Casa de la Creatividad';

  @override
  String get houseSubtitle5 => 'Expresión, romance y placer';

  @override
  String get houseTitle6 => 'Casa de la Vida Cotidiana';

  @override
  String get houseSubtitle6 => 'Rutina, trabajo y bienestar';

  @override
  String get houseTitle7 => 'Casa de las Relaciones';

  @override
  String get houseSubtitle7 => 'Asociaciones, compromiso y el otro';

  @override
  String get houseTitle8 => 'Casa de la Transformación';

  @override
  String get houseSubtitle8 => 'Intimidad, confianza y recursos compartidos';

  @override
  String get houseTitle9 => 'Casa de la Expansión';

  @override
  String get houseSubtitle9 => 'Creencias, viajes y aprendizaje superior';

  @override
  String get houseTitle10 => 'Casa de la Carrera';

  @override
  String get houseSubtitle10 => 'Propósito, reputación y vida pública';

  @override
  String get houseTitle11 => 'Casa de la Comunidad';

  @override
  String get houseSubtitle11 => 'Amistades, redes y metas futuras';

  @override
  String get houseTitle12 => 'Casa del Mundo Interior';

  @override
  String get houseSubtitle12 => 'Subconsciente, soledad y emociones ocultas';

  @override
  String get houseKeywordIdentity => 'Identidad';

  @override
  String get houseKeywordAppearance => 'Apariencia';

  @override
  String get houseKeywordFirstImpressions => 'Primeras impresiones';

  @override
  String get houseKeywordMoney => 'Dinero';

  @override
  String get houseKeywordValues => 'Valores';

  @override
  String get houseKeywordSelfWorth => 'Autoestima';

  @override
  String get houseKeywordCommunication => 'Comunicación';

  @override
  String get houseKeywordLearning => 'Aprendizaje';

  @override
  String get houseKeywordThinking => 'Pensamiento';

  @override
  String get houseKeywordSiblings => 'Hermanos';

  @override
  String get houseKeywordHome => 'Hogar';

  @override
  String get houseKeywordFamily => 'Familia';

  @override
  String get houseKeywordRoots => 'Raíces';

  @override
  String get houseKeywordCreativity => 'Creatividad';

  @override
  String get houseKeywordRomance => 'Romance';

  @override
  String get houseKeywordPleasure => 'Placer';

  @override
  String get houseKeywordRoutine => 'Rutina';

  @override
  String get houseKeywordWork => 'Trabajo';

  @override
  String get houseKeywordWellbeing => 'Bienestar';

  @override
  String get houseKeywordRelationships => 'Relaciones';

  @override
  String get houseKeywordPartnerships => 'Asociaciones';

  @override
  String get houseKeywordCommitment => 'Compromiso';

  @override
  String get houseKeywordIntimacy => 'Intimidad';

  @override
  String get houseKeywordTrust => 'Confianza';

  @override
  String get houseKeywordTransformation => 'Transformación';

  @override
  String get houseKeywordSharedResources => 'Recursos compartidos';

  @override
  String get houseKeywordBeliefs => 'Creencias';

  @override
  String get houseKeywordTravel => 'Viajes';

  @override
  String get houseKeywordHigherLearning => 'Aprendizaje superior';

  @override
  String get houseKeywordCareer => 'Carrera';

  @override
  String get houseKeywordReputation => 'Reputación';

  @override
  String get houseKeywordPurpose => 'Propósito';

  @override
  String get houseKeywordFriendships => 'Amistades';

  @override
  String get houseKeywordFriends => 'Amigos';

  @override
  String get houseKeywordCommunity => 'Comunidad';

  @override
  String get houseKeywordFutureGoals => 'Metas futuras';

  @override
  String get houseKeywordGoals => 'Metas';

  @override
  String get houseKeywordInnerWorld => 'Mundo interior';

  @override
  String get houseKeywordSubconscious => 'Subconsciente';

  @override
  String get houseKeywordSolitude => 'Soledad';

  @override
  String rulerWithName(String planet) {
    return 'Regente · $planet';
  }

  @override
  String get rulerUnknown => 'Regente · —';

  @override
  String get planetsTitle => 'PLANETAS';

  @override
  String get noPlanetDataMessage => 'No hay datos planetarios disponibles.';

  @override
  String houseNumberInline(int number) {
    return 'Casa $number';
  }

  @override
  String get noHouseInline => 'Sin casa';

  @override
  String get aspectsTitle => 'ASPECTOS';

  @override
  String get noAspectsMessage => 'No hay aspectos disponibles.';

  @override
  String orbLabel(String degree) {
    return 'Orbe $degree';
  }

  @override
  String get chartLoadError => 'No fue posible cargar tu carta natal.';

  @override
  String get housesTopBarLabel => 'CASAS';

  @override
  String get yourNatalHousesEyebrow => 'TUS CASAS NATALES';

  @override
  String get twelveHousesTitle => 'Las Doce Casas';

  @override
  String get twelveHousesDescription =>
      'Cada casa representa un área diferente de tu vida. Su signo, planeta regente, los planetas que contiene y sus aspectos muestran cómo se expresa esa área en tu carta natal.';

  @override
  String get couldNotLoadHousesTitle => 'No se pudieron cargar las casas';

  @override
  String get noHouseInfoMessage => 'No hay información de casas disponible.';

  @override
  String get noNatalPlanetsMessage => 'Sin planetas natales';

  @override
  String houseTopBarLabel(String roman) {
    return 'CASA $roman';
  }

  @override
  String get whatThisMeansForYouTitle => 'QUÉ SIGNIFICA ESTO PARA TI';

  @override
  String get planetaryInfluencesTitle => 'INFLUENCIAS PLANETARIAS';

  @override
  String get howThisMayShowUpTitle => 'CÓMO PUEDE MANIFESTARSE';

  @override
  String get houseDetailLoadError => 'No fue posible cargar esta casa.';

  @override
  String get whatThisHouseRulesTitle => 'QUÉ RIGE ESTA CASA';

  @override
  String get houseRulerTitle => 'REGENTE DE LA CASA';

  @override
  String get noRulerInfoMessage =>
      'No hay información disponible sobre el planeta regente.';

  @override
  String rulesThisHouse(String planet) {
    return '$planet rige esta casa.';
  }

  @override
  String rulerHouseInline(String roman) {
    return '· Casa $roman';
  }

  @override
  String get retrogradeLabel => 'Retrógrado';

  @override
  String get planetsInThisHouseTitle => 'PLANETAS EN ESTA CASA';

  @override
  String get noPlanetsInHouseMessage =>
      'No hay planetas natales en esta casa. Esto no significa que la casa carezca de importancia. Su signo y planeta regente igualmente describen cómo se expresa esta área de tu vida.';

  @override
  String get influencesTitle => 'INFLUENCIAS';

  @override
  String get supportiveLabel => 'DE APOYO';

  @override
  String get challengingLabel => 'DESAFIANTE';

  @override
  String yourHouseTitle(String roman) {
    return 'TU CASA $roman';
  }

  @override
  String get houseMeaning1 =>
      'La Primera Casa representa la identidad, la apariencia, las primeras impresiones y la forma instintiva en que enfrentas la vida.';

  @override
  String get houseMeaning2 =>
      'La Segunda Casa representa el dinero, las posesiones, los valores personales, la seguridad y la autoestima.';

  @override
  String get houseMeaning3 =>
      'La Tercera Casa representa la comunicación, el aprendizaje, el pensamiento, los hermanos y tu entorno inmediato.';

  @override
  String get houseMeaning4 =>
      'La Cuarta Casa representa el hogar, la familia, las raíces, la privacidad y tus bases emocionales.';

  @override
  String get houseMeaning5 =>
      'La Quinta Casa representa la creatividad, el romance, el placer, la autoexpresión y aquello que te trae alegría.';

  @override
  String get houseMeaning6 =>
      'La Sexta Casa representa las rutinas, el trabajo diario, los hábitos, el servicio y el bienestar personal.';

  @override
  String get houseMeaning7 =>
      'La Séptima Casa representa las relaciones, las asociaciones, el compromiso y la forma en que te vinculas con otras personas de igual a igual.';

  @override
  String get houseMeaning8 =>
      'La Octava Casa representa la intimidad, la confianza, los recursos compartidos, la vulnerabilidad, la crisis y la transformación.';

  @override
  String get houseMeaning9 =>
      'La Novena Casa representa las creencias, la filosofía, el aprendizaje superior, los viajes y la búsqueda de sentido.';

  @override
  String get houseMeaning10 =>
      'La Décima Casa representa la carrera, la reputación, la vida pública, la ambición y el rumbo que construyes con el tiempo.';

  @override
  String get houseMeaning11 =>
      'La Undécima Casa representa las amistades, la comunidad, las redes, los proyectos colectivos y las metas futuras.';

  @override
  String get houseMeaning12 =>
      'La Duodécima Casa representa el mundo interior, la soledad, el subconsciente, las emociones ocultas y todo lo que se procesa en privado.';

  @override
  String get houseMeaningDefault =>
      'Esta casa representa un área específica de la vida dentro de la carta natal.';

  @override
  String get profileLoadError => 'No fue posible cargar el perfil.';

  @override
  String get featureTodayTitle => 'HOY';

  @override
  String get featureTodayDescription =>
      'Descubre cómo los tránsitos de hoy influyen en tu carta.';

  @override
  String get featureTodayAction => 'VER HOY';

  @override
  String get featureTransitsTitle => 'TRÁNSITOS ACTIVOS';

  @override
  String get featureTransitsDescription =>
      'Los tránsitos más importantes que están ocurriendo ahora.';

  @override
  String get featureTransitsAction => 'VER TRÁNSITOS';

  @override
  String get featureWeekTitle => 'ESTA SEMANA';

  @override
  String get featureWeekDescription =>
      'Tu pronóstico astrológico para la semana que viene.';

  @override
  String get featureWeekAction => 'VER SEMANA';

  @override
  String get yourChartTitle => 'TU CARTA';

  @override
  String get yourChartDescription =>
      'Explora en detalle tu carta natal, planetas, casas y aspectos.';

  @override
  String get viewFullChartAction => 'VER CARTA COMPLETA';

  @override
  String get languageSectionTitle => 'IDIOMA';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Español';

  @override
  String get navToday => 'HOY';

  @override
  String get navChart => 'CARTA';

  @override
  String get navWeek => 'SEMANA';

  @override
  String get navMe => 'YO';

  @override
  String get elementFire => 'Fuego';

  @override
  String get elementEarth => 'Tierra';

  @override
  String get elementAir => 'Aire';

  @override
  String get elementWater => 'Agua';

  @override
  String get modalityCardinal => 'Cardinal';

  @override
  String get modalityFixed => 'Fijo';

  @override
  String get modalityMutable => 'Mutable';

  @override
  String get signAries => 'Aries';

  @override
  String get signTaurus => 'Tauro';

  @override
  String get signGemini => 'Géminis';

  @override
  String get signCancer => 'Cáncer';

  @override
  String get signLeo => 'Leo';

  @override
  String get signVirgo => 'Virgo';

  @override
  String get signLibra => 'Libra';

  @override
  String get signScorpio => 'Escorpio';

  @override
  String get signSagittarius => 'Sagitario';

  @override
  String get signCapricorn => 'Capricornio';

  @override
  String get signAquarius => 'Acuario';

  @override
  String get signPisces => 'Piscis';

  @override
  String get signDateRangeAries => '21 mar – 19 abr';

  @override
  String get signDateRangeTaurus => '20 abr – 20 may';

  @override
  String get signDateRangeGemini => '21 may – 20 jun';

  @override
  String get signDateRangeCancer => '21 jun – 22 jul';

  @override
  String get signDateRangeLeo => '23 jul – 22 ago';

  @override
  String get signDateRangeVirgo => '23 ago – 22 sep';

  @override
  String get signDateRangeLibra => '23 sep – 22 oct';

  @override
  String get signDateRangeScorpio => '23 oct – 21 nov';

  @override
  String get signDateRangeSagittarius => '22 nov – 21 dic';

  @override
  String get signDateRangeCapricorn => '22 dic – 19 ene';

  @override
  String get signDateRangeAquarius => '20 ene – 18 feb';

  @override
  String get signDateRangePisces => '19 feb – 20 mar';

  @override
  String get planetSun => 'Sol';

  @override
  String get planetMoon => 'Luna';

  @override
  String get planetMercury => 'Mercurio';

  @override
  String get planetVenus => 'Venus';

  @override
  String get planetMars => 'Marte';

  @override
  String get planetJupiter => 'Júpiter';

  @override
  String get planetSaturn => 'Saturno';

  @override
  String get planetUranus => 'Urano';

  @override
  String get planetNeptune => 'Neptuno';

  @override
  String get planetPluto => 'Plutón';

  @override
  String get planetNorthNode => 'Nodo Norte';

  @override
  String get planetChiron => 'Quirón';

  @override
  String get planetPartOfFortune => 'Parte de la Fortuna';

  @override
  String get planetLilith => 'Lilith';

  @override
  String get planetAscendant => 'Ascendente';

  @override
  String get planetMidheaven => 'Medio Cielo';

  @override
  String get aspectConjunction => 'conjunción';

  @override
  String get aspectOpposition => 'oposición';

  @override
  String get aspectSquare => 'cuadratura';

  @override
  String get aspectTrine => 'trígono';

  @override
  String get aspectSextile => 'sextil';

  @override
  String get levelVeryHigh => 'MUY ALTA';

  @override
  String get levelHigh => 'ALTA';

  @override
  String get levelMedium => 'MEDIA';

  @override
  String get levelLow => 'BAJA';

  @override
  String get strengthVeryStrong => 'Muy Fuerte';

  @override
  String get strengthStrong => 'Fuerte';

  @override
  String get strengthModerate => 'Moderado';

  @override
  String get strengthWide => 'Amplio';

  @override
  String get yourProfileTitle => 'Tu perfil';

  @override
  String get manageAccountSubtitle =>
      'Administra tu cuenta y tus preferencias.';

  @override
  String get accountLoadError => 'No fue posible cargar tu cuenta.';

  @override
  String get editProfileTitle => 'Editar perfil';

  @override
  String get editProfileDescription =>
      'Puedes cambiar tu nombre y nombre de usuario. Tus datos de nacimiento no se pueden editar aquí.';

  @override
  String get displayNameLabel => 'Nombre';

  @override
  String get nameEmptyError => 'El nombre no puede estar vacío.';

  @override
  String get usernameMinLengthValidationError =>
      'El nombre de usuario debe tener al menos 3 caracteres.';

  @override
  String get usernameNoSpacesError =>
      'El nombre de usuario no puede contener espacios.';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get saveChangesButton => 'Guardar cambios';

  @override
  String get profileUpdatedMessage => 'Perfil actualizado correctamente.';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeLight => 'Claro';

  @override
  String get notificationsLabel => 'Notificaciones';

  @override
  String get onLabel => 'Activado';

  @override
  String get offLabel => 'Desactivado';

  @override
  String get themeSettingsTitle => 'Configuración de tema';

  @override
  String get notificationSettingsTitle => 'Configuración de notificaciones';

  @override
  String get helpSupportTitle => 'Ayuda y soporte';

  @override
  String get aboutSacredTitle => 'Acerca de Sacred';

  @override
  String get aboutSacredDescription =>
      'Sacred es una experiencia de astrología y autoconocimiento.';

  @override
  String get closeButton => 'Cerrar';

  @override
  String get comingSoonSuffix => 'próximamente';

  @override
  String get logoutButton => 'Cerrar sesión';

  @override
  String get logOutButtonUppercase => 'CERRAR SESIÓN';

  @override
  String get birthInformationTitle => 'INFORMACIÓN DE NACIMIENTO';

  @override
  String get birthInformationNote =>
      'Esta información es parte de tu carta natal y todavía no se puede editar.';

  @override
  String get birthPlaceLabel => 'Lugar de Nacimiento';

  @override
  String get accountSectionTitle => 'CUENTA';

  @override
  String get memberSinceLabel => 'Miembro desde';

  @override
  String memberSinceWithDate(String date) {
    return 'Miembro desde $date';
  }

  @override
  String get preferencesSectionTitle => 'PREFERENCIAS';

  @override
  String get supportSectionTitle => 'SOPORTE';

  @override
  String get quoteLine1 => 'El cosmos no está fuera de ti.';

  @override
  String get quoteLine2 =>
      'Mira hacia adentro; todo lo que buscas ya está ahí.';

  @override
  String get privacyBannerText =>
      'Tu privacidad y seguridad son importantes para nosotros. Nunca compartimos tu información personal.';
}

import 'package:flutter/material.dart';

import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/services/auth_service.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}


class _RegisterScreenState
    extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController =
      TextEditingController();

  final _usernameController =
      TextEditingController();

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  final _birthPlaceController =
      TextEditingController();

  DateTime? _birthDate;
  TimeOfDay? _birthTime;

  bool _obscurePassword = true;
  bool _loading = false;

  static const Color _purple =
      Color(0xFF8E3299);

  static const Color _darkPurple =
      Color(0xFF681D70);

  static const Color _inputBackground =
      Color(0xFFF0D7F2);

  static const Color _background =
      Color(0xFFFFF8FD);


  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _birthPlaceController.dispose();

    super.dispose();
  }


  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (
            context,
            constraints,
          ) {
            final width =
                constraints.maxWidth;

            if (width < 650) {
              return _buildMobile();
            }

            return _buildDesktop();
          },
        ),
      ),
    );
  }

  // ============================================================
  // DESKTOP / TABLET
  // ============================================================

    Widget _buildDesktop() {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 18,
        ),
        child: Column(
          children: [
            _buildTopLogo(),

            const SizedBox(height: 40),

            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1180,
                ),
                child: SizedBox(
                  height: 650,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: _purple.withAlpha(25),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(8),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 46,
                          child: _buildHero(
                            mobile: false,
                          ),
                        ),

                        Expanded(
                          flex: 54,
                          child: SingleChildScrollView(
                            padding: EdgeInsets.zero,
                            child: _buildForm(
                              mobile: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      );
    }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile() {
    return SingleChildScrollView(
      padding:
          const EdgeInsets.fromLTRB(
        16,
        12,
        16,
        30,
      ),
      child: Column(
        children: [
          _buildTopLogo(
            mobile: true,
          ),

          const SizedBox(
            height: 24,
          ),

          Container(
            width:
                double.infinity,
            clipBehavior:
                Clip.antiAlias,
            decoration:
                BoxDecoration(
              color:
                  Colors.white,
              borderRadius:
                  BorderRadius.circular(
                20,
              ),
              border:
                  Border.all(
                color:
                    _purple.withAlpha(
                  25,
                ),
              ),
            ),
            child:
                Column(
              children: [
                _buildHero(
                  mobile:
                      true,
                ),

                _buildForm(
                  mobile:
                      true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LOGO
  // ============================================================

  Widget _buildTopLogo({
    bool mobile = false,
  }) {
    return SizedBox(
      height:
          mobile ? 58 : 70,
      child: Stack(
        alignment:
            Alignment.center,
        children: [
          Align(
            alignment:
                Alignment.centerLeft,
            child:
                Icon(
              Icons
                  .auto_awesome,
              color:
                  _purple,
              size:
                  mobile
                      ? 17
                      : 21,
            ),
          ),

          Text(
            'RIO',
            style:
                TextStyle(
              color:
                  _purple,
              fontFamily:
                  'serif',
              fontSize:
                  mobile
                      ? 30
                      : 40,
              letterSpacing:
                  mobile
                      ? 6
                      : 9,
              fontWeight:
                  FontWeight.w400,
            ),
          ),

          Align(
            alignment:
                Alignment.centerRight,
            child:
                Icon(
              Icons
                  .account_circle_outlined,
              color:
                  _purple,
              size:
                  mobile
                      ? 18
                      : 20,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HERO
  // ============================================================

  Widget _buildHero({
    required bool mobile,
  }) {
    return SizedBox(
      width:
          double.infinity,
      height:
          mobile
              ? 190
              : double.infinity,
      child:
          Stack(
        fit:
            StackFit.expand,
        children: [
          Image.asset(
            'assets/images/login_astral.png',
            fit:
                BoxFit.cover,
            errorBuilder: (
              context,
              error,
              stackTrace,
            ) {
              return Container(
                decoration:
                    const BoxDecoration(
                  gradient:
                      LinearGradient(
                    begin:
                        Alignment.topLeft,
                    end:
                        Alignment.bottomRight,
                    colors: [
                      Color(
                        0xFFE9DAEA,
                      ),
                      Color(
                        0xFFF7EEF6,
                      ),
                      Color(
                        0xFFE2D5E4,
                      ),
                    ],
                  ),
                ),
                child:
                    Center(
                  child:
                      Icon(
                    Icons
                        .blur_circular,
                    color:
                        _purple.withAlpha(
                      80,
                    ),
                    size:
                        mobile
                            ? 110
                            : 230,
                  ),
                ),
              );
            },
          ),

          Container(
            decoration:
                BoxDecoration(
              gradient:
                  LinearGradient(
                begin:
                    Alignment.topCenter,
                end:
                    Alignment.bottomCenter,
                colors: [
                  Colors.white.withAlpha(
                    8,
                  ),
                  const Color(
                    0xFFFBEAF7,
                  ).withAlpha(
                    mobile
                        ? 110
                        : 185,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            left:
                mobile ? 22 : 42,
            right:
                mobile ? 22 : 42,
            bottom:
                mobile ? 20 : 36,
            child:
                Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons
                      .stars_outlined,
                  color:
                      _darkPurple,
                  size:
                      mobile
                          ? 20
                          : 24,
                ),

                SizedBox(
                  height:
                      mobile
                          ? 6
                          : 12,
                ),

                Text(
                  'Reconoce en lo cósmico.',
                  style:
                      TextStyle(
                    color:
                        _darkPurple,
                    fontFamily:
                        'serif',
                    fontSize:
                        mobile
                            ? 22
                            : 28,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                if (!mobile) ...[
                  const SizedBox(
                    height: 10,
                  ),

                  const Text(
                    'Una inmersión profunda en tu identidad celestial, '
                    'presentada con claridad y elegancia moderna.',
                    style:
                        TextStyle(
                      color:
                          Color(
                        0xFF554B55,
                      ),
                      fontSize:
                          14,
                      height:
                          1.6,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FORMULARIO
  // ============================================================

  Widget _buildForm({
    required bool mobile,
  }) {
    return Padding(
      padding:
          EdgeInsets.symmetric(
        horizontal:
            mobile
                ? 24
                : 50,
        vertical:
            mobile
                ? 30
                : 38,
      ),
      child:
          Form(
        key:
            _formKey,
        child:
            Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'Crear Cuenta',
              style:
                  TextStyle(
                color:
                    const Color(
                  0xFF271E28,
                ),
                fontFamily:
                    'serif',
                fontSize:
                    mobile
                        ? 28
                        : 30,
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(
              height:
                  7,
            ),

            const Text(
              'Ingresa tus datos exactos de nacimiento para una carta astral precisa.',
              style:
                  TextStyle(
                color:
                    Color(
                  0xFF675F67,
                ),
                fontSize:
                    12,
              ),
            ),

            SizedBox(
              height:
                  mobile
                      ? 30
                      : 34,
            ),

            if (mobile)
              Column(
                children: [
                  _buildFullNameField(),

                  const SizedBox(
                    height: 18,
                  ),

                  _buildUsernameField(),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child:
                        _buildFullNameField(),
                  ),

                  const SizedBox(
                    width: 18,
                  ),

                  Expanded(
                    child:
                        _buildUsernameField(),
                  ),
                ],
              ),

            const SizedBox(
              height:
                  18,
            ),

            _buildEmailField(),

            const SizedBox(
              height:
                  18,
            ),

            _buildPasswordField(),

            const SizedBox(
              height:
                  24,
            ),

            Divider(
              color:
                  _purple.withAlpha(
                25,
              ),
              height:
                  1,
            ),

            const SizedBox(
              height:
                  22,
            ),

            if (mobile)
              Column(
                children: [
                  _buildBirthDateField(),

                  const SizedBox(
                    height: 18,
                  ),

                  _buildBirthTimeField(),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child:
                        _buildBirthDateField(),
                  ),

                  const SizedBox(
                    width: 18,
                  ),

                  Expanded(
                    child:
                        _buildBirthTimeField(),
                  ),
                ],
              ),

            const SizedBox(
              height:
                  18,
            ),

            _buildBirthPlaceField(),

            const SizedBox(
              height:
                  24,
            ),

            SizedBox(
              width:
                  double.infinity,
              height:
                  48,
              child:
                  FilledButton(
                onPressed:
                    _loading
                        ? null
                        : _register,
                style:
                    FilledButton.styleFrom(
                  backgroundColor:
                      _purple,
                  foregroundColor:
                      Colors.white,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      7,
                    ),
                  ),
                ),
                child:
                    _loading
                        ? const SizedBox(
                            width:
                                20,
                            height:
                                20,
                            child:
                                CircularProgressIndicator(
                              strokeWidth:
                                  2,
                              color:
                                  Colors.white,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Text(
                                'Comenzar Viaje',
                                style:
                                    TextStyle(
                                  fontSize:
                                      12,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),

                              SizedBox(
                                width:
                                    10,
                              ),

                              Icon(
                                Icons.arrow_forward,
                                size:
                                    18,
                              ),
                            ],
                          ),
              ),
            ),

            const SizedBox(
              height:
                  20,
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                const Flexible(
                  child:
                      Text(
                    '¿Ya tienes una cuenta?',
                    style:
                        TextStyle(
                      color:
                          Color(
                        0xFF675F67,
                      ),
                      fontSize:
                          12,
                    ),
                  ),
                ),

                const SizedBox(
                  width:
                      4,
                ),

                TextButton(
                  onPressed:
                      _goToLogin,
                  style:
                      TextButton.styleFrom(
                    padding:
                        EdgeInsets.zero,
                    minimumSize:
                        Size.zero,
                    foregroundColor:
                        _purple,
                  ),
                  child:
                      const Text(
                    'Iniciar Sesión',
                    style:
                        TextStyle(
                      fontSize:
                          12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CAMPOS
  // ============================================================

  Widget _buildFullNameField() {
    return _FormFieldWrapper(
      label:
          'Nombre Completo',
      child:
          TextFormField(
        controller:
            _fullNameController,
        validator:
            (value) {
          if (value == null ||
              value.trim().isEmpty) {
            return 'Ingresa tu nombre';
          }

          return null;
        },
        decoration:
            _inputDecoration(
          hint:
              'Ej. Ana García',
          icon:
              Icons.badge_outlined,
        ),
      ),
    );
  }


  Widget _buildUsernameField() {
    return _FormFieldWrapper(
      label:
          'Nombre de Usuario',
      child:
          TextFormField(
        controller:
            _usernameController,
        validator:
            (value) {
          if (value == null ||
              value.trim().isEmpty) {
            return 'Ingresa un usuario';
          }

          if (value.trim().length < 3) {
            return 'Mínimo 3 caracteres';
          }

          return null;
        },
        decoration:
            _inputDecoration(
          hint:
              'usuario',
          icon:
              Icons.alternate_email,
        ),
      ),
    );
  }


  Widget _buildEmailField() {
    return _FormFieldWrapper(
      label:
          'Correo Electrónico',
      child:
          TextFormField(
        controller:
            _emailController,
        keyboardType:
            TextInputType.emailAddress,
        validator:
            (value) {
          final email =
              value?.trim() ?? '';

          if (email.isEmpty) {
            return 'Ingresa tu correo';
          }

          if (!email.contains('@') ||
              !email.contains('.')) {
            return 'Correo no válido';
          }

          return null;
        },
        decoration:
            _inputDecoration(
          hint:
              'tu@correo.com',
          icon:
              Icons.mail_outline,
        ),
      ),
    );
  }


  Widget _buildPasswordField() {
    return _FormFieldWrapper(
      label:
          'Contraseña',
      child:
          TextFormField(
        controller:
            _passwordController,
        obscureText:
            _obscurePassword,
        validator:
            (value) {
          if (value == null ||
              value.isEmpty) {
            return 'Ingresa una contraseña';
          }

          if (value.length < 8) {
            return 'Debe tener al menos 8 caracteres';
          }

          return null;
        },
        decoration:
            _inputDecoration(
          hint:
              '••••••••',
          icon:
              Icons.lock_outline,
          suffixIcon:
              IconButton(
            onPressed:
                () {
              setState(
                () {
                  _obscurePassword =
                      !_obscurePassword;
                },
              );
            },
            icon:
                Icon(
              _obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color:
                  _darkPurple,
              size:
                  18,
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildBirthDateField() {
    return _FormFieldWrapper(
      label:
          'Fecha de Nacimiento',
      child:
          InkWell(
        onTap:
            _selectBirthDate,
        borderRadius:
            BorderRadius.circular(
          7,
        ),
        child:
            IgnorePointer(
          child:
              TextFormField(
            validator:
                (_) {
              if (_birthDate == null) {
                return 'Selecciona fecha';
              }

              return null;
            },
            decoration:
                _inputDecoration(
              hint:
                  _birthDate == null
                      ? 'dd-mm-aaaa'
                      : _formatDate(
                          _birthDate!,
                        ),
              icon:
                  Icons.calendar_today_outlined,
              suffixIcon:
                  const Icon(
                Icons.calendar_month_outlined,
                size:
                    17,
                color:
                    _darkPurple,
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildBirthTimeField() {
    return _FormFieldWrapper(
      label:
          'Hora de Nacimiento',
      child:
          InkWell(
        onTap:
            _selectBirthTime,
        borderRadius:
            BorderRadius.circular(
          7,
        ),
        child:
            IgnorePointer(
          child:
              TextFormField(
            validator:
                (_) {
              if (_birthTime == null) {
                return 'Selecciona hora';
              }

              return null;
            },
            decoration:
                _inputDecoration(
              hint:
                  _birthTime == null
                      ? '--:--'
                      : _formatTime(
                          _birthTime!,
                        ),
              icon:
                  Icons.schedule_outlined,
              suffixIcon:
                  const Icon(
                Icons.access_time_outlined,
                size:
                    17,
                color:
                    _darkPurple,
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildBirthPlaceField() {
    return _FormFieldWrapper(
      label:
          'Lugar de Nacimiento',
      child:
          TextFormField(
        controller:
            _birthPlaceController,
        validator:
            (value) {
          if (value == null ||
              value.trim().isEmpty) {
            return 'Ingresa ciudad y país';
          }

          return null;
        },
        decoration:
            _inputDecoration(
          hint:
              'Ciudad, País',
          icon:
              Icons.location_on_outlined,
        ),
      ),
    );
  }

  // ============================================================
  // INPUT
  // ============================================================

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText:
          hint,
      hintStyle:
          TextStyle(
        color:
            const Color(
          0xFF776B78,
        ).withAlpha(
          150,
        ),
        fontSize:
            12,
      ),
      prefixIcon:
          Icon(
        icon,
        size:
            17,
        color:
            const Color(
          0xFF756576,
        ),
      ),
      suffixIcon:
          suffixIcon,
      filled:
          true,
      fillColor:
          _inputBackground,
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal:
            14,
        vertical:
            15,
      ),
      border:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          7,
        ),
        borderSide:
            BorderSide.none,
      ),
      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          7,
        ),
        borderSide:
            BorderSide(
          color:
              _purple.withAlpha(
            24,
          ),
        ),
      ),
      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          7,
        ),
        borderSide:
            const BorderSide(
          color:
              _purple,
          width:
              1.2,
        ),
      ),
      errorBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          7,
        ),
        borderSide:
            const BorderSide(
          color:
              Color(
            0xFFB3261E,
          ),
        ),
      ),
      focusedErrorBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          7,
        ),
        borderSide:
            const BorderSide(
          color:
              Color(
            0xFFB3261E,
          ),
          width:
              1.2,
        ),
      ),
    );
  }

  // ============================================================
  // FECHA
  // ============================================================

  Future<void> _selectBirthDate() async {
    final now =
        DateTime.now();

    final selected =
        await showDatePicker(
      context:
          context,
      initialDate:
          DateTime(
        2000,
        1,
        1,
      ),
      firstDate:
          DateTime(
        1900,
      ),
      lastDate:
          now,
    );

    if (selected == null) {
      return;
    }

    setState(
      () {
        _birthDate =
            selected;
      },
    );
  }


  Future<void> _selectBirthTime() async {
    final selected =
        await showTimePicker(
      context:
          context,
      initialTime:
          const TimeOfDay(
        hour:
            12,
        minute:
            0,
      ),
    );

    if (selected == null) {
      return;
    }

    setState(
      () {
        _birthTime =
            selected;
      },
    );
  }


  String _formatDate(
    DateTime date,
  ) {
    final day =
        date.day
            .toString()
            .padLeft(
              2,
              '0',
            );

    final month =
        date.month
            .toString()
            .padLeft(
              2,
              '0',
            );

    return '$day-$month-${date.year}';
  }


  String _formatTime(
    TimeOfDay time,
  ) {
    final hour =
        time.hour
            .toString()
            .padLeft(
              2,
              '0',
            );

    final minute =
        time.minute
            .toString()
            .padLeft(
              2,
              '0',
            );

    return '$hour:$minute';
  }

  // ============================================================
  // REGISTRO REAL
  // ============================================================

  Future<void> _register() async {
    if (_loading) {
      return;
    }

    final formIsValid =
        _formKey.currentState?.validate() ??
            false;

    if (!formIsValid) {
      return;
    }

    if (_birthDate == null) {
      _showMessage(
        'Selecciona tu fecha de nacimiento.',
        isError:
            true,
      );

      return;
    }

    if (_birthTime == null) {
      _showMessage(
        'Selecciona tu hora de nacimiento.',
        isError:
            true,
      );

      return;
    }

    setState(
      () {
        _loading =
            true;
      },
    );

    try {
      debugPrint(
        '===================================',
      );

      debugPrint(
        'INICIANDO REGISTRO ASTRA',
      );

      debugPrint(
        '===================================',
      );

      final response =
          await AuthService.register(
        fullName:
            _fullNameController.text.trim(),

        username:
            _usernameController.text.trim(),

        email:
            _emailController.text.trim(),

        password:
            _passwordController.text,

        birthDate:
            _birthDate!,

        birthTime:
            _birthTime!,

        birthPlace:
            _birthPlaceController.text.trim(),
      );

      debugPrint(
        'REGISTER OK:',
      );

      debugPrint(
        response.toString(),
      );

      final dynamic userData =
          response['user'];

      final String? userId =
          userData is Map
              ? userData['id']?.toString()
              : null;

      if (userId == null ||
          userId.isEmpty) {
        throw AuthException(
          'El backend no devolvió el id del usuario creado.',
        );
      }

      if (!mounted) {
        return;
      }

      _showMessage(
        'Cuenta creada correctamente.',
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ProfileScreen(
            userId: userId,
          ),
        ),
      );
    } on AuthException catch (error) {
      debugPrint(
        'AUTH ERROR: ${error.message}',
      );

      if (!mounted) {
        return;
      }

      _showMessage(
        error.message,
        isError:
            true,
      );
    } catch (error, stackTrace) {
      debugPrint(
        'REGISTER ERROR: $error',
      );

      debugPrintStack(
        stackTrace:
            stackTrace,
      );

      if (!mounted) {
        return;
      }

      _showMessage(
        'No fue posible crear la cuenta.\n$error',
        isError:
            true,
      );
    } finally {
      if (mounted) {
        setState(
          () {
            _loading =
                false;
          },
        );
      }
    }
  }

  // ============================================================
  // MENSAJES
  // ============================================================

  void _showMessage(
    String message, {
    bool isError = false,
  }) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content:
              Text(
            message,
          ),
          backgroundColor:
              isError
                  ? const Color(
                      0xFFB3261E,
                    )
                  : _purple,
        ),
      );
  }

  // ============================================================
  // LOGIN
  // ============================================================

  void _goToLogin() {
    Navigator.pushReplacementNamed(
      context,
      '/login',
    );
  }
}


// ================================================================
// LABEL + FIELD
// ================================================================

class _FormFieldWrapper
    extends StatelessWidget {
  final String label;
  final Widget child;

  const _FormFieldWrapper({
    required this.label,
    required this.child,
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
          label,
          style:
              const TextStyle(
            color:
                Color(
              0xFF4F4850,
            ),
            fontSize:
                11,
            fontWeight:
                FontWeight.w500,
          ),
        ),

        const SizedBox(
          height:
              7,
        ),

        child,
      ],
    );
  }
}
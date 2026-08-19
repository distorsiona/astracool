import 'package:flutter/material.dart';

import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/services/auth_service.dart';

import 'register/helpers/register_date_format.dart';
import 'register/widgets/register_hero.dart';

import '../theme/auth_colors.dart';
import '../theme/auth_input_decoration.dart';
import '../widgets/auth_top_logo.dart';
import '../widgets/form_field_wrapper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _birthPlaceController = TextEditingController();

  DateTime? _birthDate;
  TimeOfDay? _birthTime;

  bool _obscurePassword = true;
  bool _loading = false;

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: authBackground,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

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
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
      child: Column(
        children: [
          const AuthTopLogo(trailingIcon: Icons.account_circle_outlined),
          const SizedBox(height: 40),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: SizedBox(
                height: 650,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: authPurple.withAlpha(25)),
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
                      const Expanded(
                        flex: 46,
                        child: RegisterHero(mobile: false),
                      ),
                      Expanded(
                        flex: 54,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          child: _buildForm(mobile: false),
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
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
      child: Column(
        children: [
          const AuthTopLogo(
            mobile: true,
            trailingIcon: Icons.account_circle_outlined,
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: authPurple.withAlpha(25)),
            ),
            child: Column(
              children: [
                const RegisterHero(mobile: true),
                _buildForm(mobile: true),
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

  Widget _buildForm({required bool mobile}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 24 : 50,
        vertical: mobile ? 30 : 38,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Crear Cuenta',
              style: TextStyle(
                color: const Color(0xFF271E28),
                fontFamily: 'serif',
                fontSize: mobile ? 28 : 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Ingresa tus datos exactos de nacimiento para una carta '
              'astral precisa.',
              style: TextStyle(color: Color(0xFF675F67), fontSize: 12),
            ),
            SizedBox(height: mobile ? 30 : 34),
            if (mobile)
              Column(
                children: [
                  _buildFullNameField(),
                  const SizedBox(height: 18),
                  _buildUsernameField(),
                ],
              )
            else
              Row(
                children: [
                  Expanded(child: _buildFullNameField()),
                  const SizedBox(width: 18),
                  Expanded(child: _buildUsernameField()),
                ],
              ),
            const SizedBox(height: 18),
            _buildEmailField(),
            const SizedBox(height: 18),
            _buildPasswordField(),
            const SizedBox(height: 24),
            Divider(color: authPurple.withAlpha(25), height: 1),
            const SizedBox(height: 22),
            if (mobile)
              Column(
                children: [
                  _buildBirthDateField(),
                  const SizedBox(height: 18),
                  _buildBirthTimeField(),
                ],
              )
            else
              Row(
                children: [
                  Expanded(child: _buildBirthDateField()),
                  const SizedBox(width: 18),
                  Expanded(child: _buildBirthTimeField()),
                ],
              ),
            const SizedBox(height: 18),
            _buildBirthPlaceField(),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: _loading ? null : _register,
                style: FilledButton.styleFrom(
                  backgroundColor: authPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: _loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Comenzar Viaje',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  child: Text(
                    '¿Ya tienes una cuenta?',
                    style: TextStyle(color: Color(0xFF675F67), fontSize: 12),
                  ),
                ),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: _goToLogin,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    foregroundColor: authPurple,
                  ),
                  child: const Text(
                    'Iniciar Sesión',
                    style: TextStyle(fontSize: 12),
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
    return FormFieldWrapper(
      label: 'Nombre Completo',
      child: TextFormField(
        controller: _fullNameController,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Ingresa tu nombre';
          }

          return null;
        },
        decoration: authInputDecoration(
          hint: 'Ej. Ana García',
          icon: Icons.badge_outlined,
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return FormFieldWrapper(
      label: 'Nombre de Usuario',
      child: TextFormField(
        controller: _usernameController,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Ingresa un usuario';
          }

          if (value.trim().length < 3) {
            return 'Mínimo 3 caracteres';
          }

          return null;
        },
        decoration: authInputDecoration(
          hint: 'usuario',
          icon: Icons.alternate_email,
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return FormFieldWrapper(
      label: 'Correo Electrónico',
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          final email = value?.trim() ?? '';

          if (email.isEmpty) {
            return 'Ingresa tu correo';
          }

          if (!email.contains('@') || !email.contains('.')) {
            return 'Correo no válido';
          }

          return null;
        },
        decoration: authInputDecoration(
          hint: 'tu@correo.com',
          icon: Icons.mail_outline,
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return FormFieldWrapper(
      label: 'Contraseña',
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ingresa una contraseña';
          }

          if (value.length < 8) {
            return 'Debe tener al menos 8 caracteres';
          }

          return null;
        },
        decoration: authInputDecoration(
          hint: '••••••••',
          icon: Icons.lock_outline,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: authDarkPurple,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBirthDateField() {
    return FormFieldWrapper(
      label: 'Fecha de Nacimiento',
      child: InkWell(
        onTap: _selectBirthDate,
        borderRadius: BorderRadius.circular(7),
        child: IgnorePointer(
          child: TextFormField(
            validator: (_) {
              if (_birthDate == null) {
                return 'Selecciona fecha';
              }

              return null;
            },
            decoration: authInputDecoration(
              hint: _birthDate == null
                  ? 'dd-mm-aaaa'
                  : formatBirthDate(_birthDate!),
              icon: Icons.calendar_today_outlined,
              suffixIcon: const Icon(
                Icons.calendar_month_outlined,
                size: 17,
                color: authDarkPurple,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBirthTimeField() {
    return FormFieldWrapper(
      label: 'Hora de Nacimiento',
      child: InkWell(
        onTap: _selectBirthTime,
        borderRadius: BorderRadius.circular(7),
        child: IgnorePointer(
          child: TextFormField(
            validator: (_) {
              if (_birthTime == null) {
                return 'Selecciona hora';
              }

              return null;
            },
            decoration: authInputDecoration(
              hint: _birthTime == null ? '--:--' : formatBirthTime(_birthTime!),
              icon: Icons.schedule_outlined,
              suffixIcon: const Icon(
                Icons.access_time_outlined,
                size: 17,
                color: authDarkPurple,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBirthPlaceField() {
    return FormFieldWrapper(
      label: 'Lugar de Nacimiento',
      child: TextFormField(
        controller: _birthPlaceController,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Ingresa ciudad y país';
          }

          return null;
        },
        decoration: authInputDecoration(
          hint: 'Ciudad, País',
          icon: Icons.location_on_outlined,
        ),
      ),
    );
  }

  // ============================================================
  // FECHA
  // ============================================================

  Future<void> _selectBirthDate() async {
    final now = DateTime.now();

    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (selected == null) {
      return;
    }

    setState(() {
      _birthDate = selected;
    });
  }

  Future<void> _selectBirthTime() async {
    final selected = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 0),
    );

    if (selected == null) {
      return;
    }

    setState(() {
      _birthTime = selected;
    });
  }

  // ============================================================
  // REGISTRO REAL
  // ============================================================

  Future<void> _register() async {
    if (_loading) {
      return;
    }

    final formIsValid = _formKey.currentState?.validate() ?? false;

    if (!formIsValid) {
      return;
    }

    if (_birthDate == null) {
      _showMessage('Selecciona tu fecha de nacimiento.', isError: true);

      return;
    }

    if (_birthTime == null) {
      _showMessage('Selecciona tu hora de nacimiento.', isError: true);

      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      debugPrint('===================================');
      debugPrint('INICIANDO REGISTRO SACRED');
      debugPrint('===================================');

      final response = await AuthService.register(
        fullName: _fullNameController.text.trim(),
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        birthDate: _birthDate!,
        birthTime: _birthTime!,
        birthPlace: _birthPlaceController.text.trim(),
      );

      debugPrint('REGISTER OK:');
      debugPrint(response.toString());

      final dynamic userData = response['user'];

      final String? userId =
          userData is Map ? userData['id']?.toString() : null;

      if (userId == null || userId.isEmpty) {
        throw AuthException(
          'El backend no devolvió el id del usuario creado.',
        );
      }

      if (!mounted) {
        return;
      }

      _showMessage('Cuenta creada correctamente.');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ProfileScreen(userId: userId)),
      );
    } on AuthException catch (error) {
      debugPrint('AUTH ERROR: ${error.message}');

      if (!mounted) {
        return;
      }

      _showMessage(error.message, isError: true);
    } catch (error, stackTrace) {
      debugPrint('REGISTER ERROR: $error');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) {
        return;
      }

      _showMessage('No fue posible crear la cuenta.\n$error', isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  // ============================================================
  // MENSAJES
  // ============================================================

  void _showMessage(String message, {bool isError = false}) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? const Color(0xFFB3261E) : authPurple,
        ),
      );
  }

  // ============================================================
  // LOGIN
  // ============================================================

  void _goToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }
}

import 'package:flutter/material.dart';

import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/services/auth_service.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _loading = false;

  static const Color _purple = Color(0xFF8E3299);
  static const Color _darkPurple = Color(0xFF681D70);
  static const Color _inputBackground = Color(0xFFF0D7F2);
  static const Color _background = Color(0xFFFFF8FD);

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
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
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 20,
      ),
      child: Column(
        children: [
          _buildTopLogo(),

          const SizedBox(height: 55),

          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1080,
              ),
              child: Container(
                height: 520,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: _purple.withAlpha(30),
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(8),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 48,
                      child: _buildHero(
                        mobile: false,
                      ),
                    ),

                    Expanded(
                      flex: 52,
                      child: _buildForm(
                        mobile: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        18,
        14,
        18,
        32,
      ),
      child: Column(
        children: [
          _buildTopLogo(
            mobile: true,
          ),

          const SizedBox(height: 28),

          Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _purple.withAlpha(25),
              ),
            ),
            child: Column(
              children: [
                _buildHero(
                  mobile: true,
                ),

                _buildForm(
                  mobile: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ASTRA LOGO
  // ============================================================

  Widget _buildTopLogo({
    bool mobile = false,
  }) {
    return SizedBox(
      height: mobile ? 58 : 70,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.auto_awesome,
              color: _purple,
              size: mobile ? 17 : 21,
            ),
          ),

          Text(
            'RIO',
            style: TextStyle(
              color: _purple,
              fontFamily: 'serif',
              fontSize: mobile ? 30 : 40,
              letterSpacing: mobile ? 6 : 9,
              fontWeight: FontWeight.w400,
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
      width: double.infinity,
      height: mobile ? 190 : double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ===============================================
          // IMAGEN
          // ===============================================

          Image.asset(
            'assets/images/login_astral.png',
            fit: BoxFit.cover,
            errorBuilder: (
              context,
              error,
              stackTrace,
            ) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFE9DAEA),
                      Color(0xFFF7EEF6),
                      Color(0xFFE2D5E4),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.blur_circular,
                    color: _purple.withAlpha(80),
                    size: mobile ? 110 : 230,
                  ),
                ),
              );
            },
          ),

          // CAPA ROSADA
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withAlpha(15),
                  const Color(0xFFFBEAF7).withAlpha(
                    mobile ? 100 : 180,
                  ),
                ],
              ),
            ),
          ),

          // ===============================================
          // TEXTO HERO
          // ===============================================

          Positioned(
            left: mobile ? 22 : 42,
            right: mobile ? 22 : 42,
            bottom: mobile ? 20 : 36,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.stars_outlined,
                  color: _darkPurple,
                  size: mobile ? 20 : 25,
                ),

                SizedBox(
                  height: mobile ? 5 : 12,
                ),

                Text(
                  'Tu destino te espera.',
                  style: TextStyle(
                    color: _darkPurple,
                    fontFamily: 'serif',
                    fontSize: mobile ? 22 : 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                if (!mobile) ...[
                  const SizedBox(height: 10),

                  const Text(
                    'Conecta con tu esencia cósmica y '
                    'descubre lo que los astros tienen preparado para ti.',
                    style: TextStyle(
                      color: Color(0xFF554B55),
                      fontSize: 14,
                      height: 1.6,
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
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 24 : 55,
        vertical: mobile ? 30 : 44,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment:
              mobile ? MainAxisAlignment.start : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido de nuevo',
              style: TextStyle(
                color: const Color(0xFF271E28),
                fontFamily: 'serif',
                fontSize: mobile ? 27 : 31,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              'Conéctate a tu cosmos personal.',
              style: TextStyle(
                color: Color(0xFF675F67),
                fontSize: 13,
              ),
            ),

            SizedBox(
              height: mobile ? 34 : 42,
            ),

            // USUARIO
            const Text(
              'Correo o @username',
              style: TextStyle(
                color: Color(0xFF4F4850),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: _userController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Ingresa tu correo o usuario';
                }

                return null;
              },
              decoration: _inputDecoration(
                hint: 'Introduce tu correo o usuario',
                icon: Icons.person_outline,
              ),
            ),

            const SizedBox(height: 20),

            // CONTRASEÑA
            const Text(
              'Contraseña',
              style: TextStyle(
                color: Color(0xFF4F4850),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa tu contraseña';
                }

                return null;
              },
              decoration: _inputDecoration(
                hint: 'Contraseña',
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
                    size: 19,
                    color: _darkPurple,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _forgotPassword,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  foregroundColor: _darkPurple,
                ),
                child: const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // BOTÓN LOGIN
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: _loading
                    ? null
                    : _login,
                style: FilledButton.styleFrom(
                  backgroundColor: _purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      7,
                    ),
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
                            'Iniciar Sesión',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),

                          SizedBox(width: 12),

                          Icon(
                            Icons.arrow_forward,
                            size: 18,
                          ),
                        ],
                      ),
              ),
            ),

            SizedBox(
              height: mobile ? 25 : 28,
            ),

            // REGISTRO
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  child: Text(
                    '¿No tienes una cuenta?',
                    style: TextStyle(
                      color: Color(0xFF675F67),
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(width: 4),

                TextButton(
                  onPressed: _goToRegister,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    foregroundColor: _purple,
                  ),
                  child: const Text(
                    'Regístrate',
                    style: TextStyle(
                      fontSize: 12,
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
  // INPUT STYLE
  // ============================================================

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: const Color(
          0xFF776B78,
        ).withAlpha(150),
        fontSize: 12,
      ),
      prefixIcon: Icon(
        icon,
        size: 18,
        color: const Color(0xFF756576),
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: _inputBackground,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
          color: _purple.withAlpha(25),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(
          color: _purple,
          width: 1.2,
        ),
      ),
    );
  }

  // ============================================================
  // ACCIONES
  // ============================================================

  Future<void> _login() async {
    if (_loading) {
      return;
    }

    final isValid =
        _formKey.currentState?.validate() ??
            false;

    if (!isValid) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      debugPrint(
        '==============================',
      );

      debugPrint(
        'INICIANDO LOGIN ASTRA',
      );

      debugPrint(
        '==============================',
      );


      final result = await AuthService.login(
        identifier: _userController.text.trim(),
        password: _passwordController.text,
      );

      debugPrint(
        'LOGIN RESPONSE: $result',
      );

      // =========================================================
      // USER
      // =========================================================

      final dynamic rawUser =
          result['user'];

      if (rawUser is! Map) {
        throw Exception(
          'El backend no devolvió el usuario autenticado.',
        );
      }

      final userId =
          rawUser['id']
              ?.toString();

      if (userId == null ||
          userId.isEmpty) {
        throw Exception(
          'El backend no devolvió el ID del usuario.',
        );
      }

      debugPrint(
        'LOGIN OK -> USER ID: $userId',
      );

      if (!mounted) {
        return;
      }

      // =========================================================
      // ABRIR PROFILE SCREEN REAL
      // =========================================================

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (
            context,
          ) {
            return ProfileScreen(
              userId:
                  userId,
            );
          },
        ),
      );
    } on AuthException catch (error) {
      debugPrint(
        'AUTH ERROR: ${error.message}',
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              error.message,
            ),
          ),
        );
    } catch (error, stackTrace) {
      debugPrint(
        'LOGIN ERROR: $error',
      );

      debugPrintStack(
        stackTrace:
            stackTrace,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'No fue posible iniciar sesión.\n$error',
            ),
          ),
        );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  void _forgotPassword() {
    // Próxima pantalla.
  }

  void _goToRegister() {
  Navigator.pushReplacementNamed(
    context,
    '/register',
  );
}
}
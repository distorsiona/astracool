import 'package:flutter/material.dart';

import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/services/auth_service.dart';

import 'login/widgets/login_hero.dart';

import '../l10n/error_messages.dart';
import '../l10n/generated/app_localizations.dart';
import '../theme/auth_colors.dart';
import '../theme/auth_input_decoration.dart';
import '../widgets/auth_top_logo.dart';
import '../widgets/form_field_wrapper.dart';

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

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
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
              return _buildMobile(context);
            }

            return _buildDesktop(context);
          },
        ),
      ),
    );
  }

  // ============================================================
  // DESKTOP / TABLET
  // ============================================================

  Widget _buildDesktop(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        children: [
          const AuthTopLogo(),
          const SizedBox(height: 55),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1080),
              child: Container(
                height: 520,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: authPurple.withAlpha(30)),
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
                    const Expanded(flex: 48, child: LoginHero(mobile: false)),
                    Expanded(
                        flex: 52, child: _buildForm(context, mobile: false)),
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

  Widget _buildMobile(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 32),
      child: Column(
        children: [
          const AuthTopLogo(mobile: true),
          const SizedBox(height: 28),
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
                const LoginHero(mobile: true),
                _buildForm(context, mobile: true),
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

  Widget _buildForm(BuildContext context, {required bool mobile}) {
    final l10n = AppLocalizations.of(context)!;

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
              l10n.loginWelcomeTitle,
              style: TextStyle(
                color: const Color(0xFF271E28),
                fontFamily: 'serif',
                fontSize: mobile ? 27 : 31,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              l10n.loginWelcomeSubtitle,
              style: const TextStyle(color: Color(0xFF675F67), fontSize: 13),
            ),
            SizedBox(height: mobile ? 34 : 42),
            FormFieldWrapper(
              label: l10n.fieldEmailOrUsernameLabel,
              child: TextFormField(
                controller: _userController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.fieldEmailOrUsernameError;
                  }

                  return null;
                },
                decoration: authInputDecoration(
                  hint: l10n.fieldEmailOrUsernameHint,
                  icon: Icons.person_outline,
                ),
              ),
            ),
            const SizedBox(height: 20),
            FormFieldWrapper(
              label: l10n.fieldPasswordLabel,
              child: TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.fieldPasswordRequiredError;
                  }

                  return null;
                },
                decoration: authInputDecoration(
                  hint: l10n.fieldPasswordHint,
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
                      color: authDarkPurple,
                    ),
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
                  foregroundColor: authDarkPurple,
                ),
                child: Text(
                  l10n.forgotPassword,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: _loading ? null : _login,
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
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l10n.loginButton,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
              ),
            ),
            SizedBox(height: mobile ? 25 : 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    l10n.noAccountPrompt,
                    style:
                        const TextStyle(color: Color(0xFF675F67), fontSize: 12),
                  ),
                ),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: _goToRegister,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    foregroundColor: authPurple,
                  ),
                  child: Text(
                    l10n.signUpLink,
                    style: const TextStyle(fontSize: 12),
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
  // ACCIONES
  // ============================================================

  Future<void> _login() async {
    if (_loading) {
      return;
    }

    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      debugPrint('==============================');
      debugPrint('INICIANDO LOGIN SACRED');
      debugPrint('==============================');

      final result = await AuthService.login(
        identifier: _userController.text.trim(),
        password: _passwordController.text,
      );

      debugPrint('LOGIN RESPONSE: $result');

      final dynamic rawUser = result['user'];

      if (rawUser is! Map) {
        throw Exception('El backend no devolvió el usuario autenticado.');
      }

      final userId = rawUser['id']?.toString();

      if (userId == null || userId.isEmpty) {
        throw Exception('El backend no devolvió el ID del usuario.');
      }

      debugPrint('LOGIN OK -> USER ID: $userId');

      if (!mounted) {
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ProfileScreen(userId: userId);
          },
        ),
      );
    } on AuthException catch (error) {
      debugPrint('AUTH ERROR: $error');

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(describeError(context, error))));
    } catch (error, stackTrace) {
      debugPrint('LOGIN ERROR: $error');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(describeError(context, error))),
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
    Navigator.pushReplacementNamed(context, '/register');
  }
}

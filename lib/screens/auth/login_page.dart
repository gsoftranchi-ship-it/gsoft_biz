import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/route_names.dart';
import '../../providers/auth_provider.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  String? _loginError;

  String? _forgotPasswordMessage;
  bool _forgotPasswordSuccess = false;
  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      if (_loginError != null || _forgotPasswordMessage != null) {
        setState(() {
          _loginError = null;
          _forgotPasswordMessage = null;
        });
      }
    });

    _passwordController.addListener(() {
      if (_loginError != null || _forgotPasswordMessage != null) {
        setState(() {
          _loginError = null;
          _forgotPasswordMessage = null;
        });
      }
    });
  }

  @override
  void dispose() {

    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 700;

    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background/dashboard_surface.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff071B33).withValues(alpha: .72),
              ),
              child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 420 : 360,
          ),
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: const Color(0xff1E2530).withValues(alpha: .92),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.border,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 150,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Partner Login',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

                  const SizedBox(height: 32),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Partner ID is required';
                      }

                      final emailRegex = RegExp(
                        r'^[\w.-]+@([\w-]+\.)+[\w-]{2,4}$',
                      );

                      if (!emailRegex.hasMatch(value.trim())) {
                        return 'Please enter your registered Partner ID or email address.';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Partner ID",
                      prefixIcon: const Icon(Icons.badge_outlined),
                      filled: true,
                      fillColor: const Color(0xff2A313A),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: AppColors.border,
                          width: 1.2,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1.8,
                        ),
                      ),


                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.danger,
                          width: 1.5,
                        ),
                      ),

                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.danger,
                          width: 1.8,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }

                      if (value.length < 6) {
                        return 'Minimum 6 characters';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: const Color(0xff2A313A),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: AppColors.border,
                          width: 1.2,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1.8,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.danger,
                          width: 1.5,
                        ),
                      ),

                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.danger,
                          width: 1.8,
                        ),
                      ),
                    ),
                  ),



                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () async {
                        if (_emailController.text.trim().isEmpty) {
                          setState(() {
                            _forgotPasswordSuccess = false;
                            _forgotPasswordMessage =
                            'Please enter your email address first.';
                          });
                          return;
                        }

                        final success = await context
                            .read<AuthProvider>()
                            .sendPasswordResetEmail(
                          email: _emailController.text.trim(),
                        );

                        if (!context.mounted) return;

                        setState(() {
                          _forgotPasswordSuccess = success;

                          _forgotPasswordMessage = success
                              ? 'Password reset email sent successfully.'
                              : context.read<AuthProvider>().failure?.message ??
                              'Unable to send reset email.';
                        });
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Divider(),

                  const SizedBox(height: 12),

                  Text(
                    'New Gym Partner?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteNames.registerPartner,
                      );
                    },
                    icon: const Icon(Icons.app_registration),
                    label: const Text('Register Your Gym'),
                  ),

                  const SizedBox(height: 20),
                  if (_forgotPasswordMessage != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (_forgotPasswordSuccess
                            ? AppColors.success
                            : AppColors.warning)
                            .withValues(alpha: .10),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _forgotPasswordSuccess
                              ? AppColors.success
                              : AppColors.warning,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _forgotPasswordSuccess
                                ? Icons.check_circle_outline
                                : Icons.info_outline,
                            color: _forgotPasswordSuccess
                                ? AppColors.success
                                : AppColors.warning,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _forgotPasswordMessage!,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (_loginError != null)
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.red,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Login Failed',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          Text(_loginError!),

                          const SizedBox(height: 16),

                          Align(
                            alignment: Alignment.centerRight,
                            child: FilledButton.icon(
                              onPressed: () {
                                setState(() {
                                  _loginError = null;
                                });
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Retry'),
                            ),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(
                    height: 55,
                    child: Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        return ElevatedButton(
                          onPressed: authProvider.isLoading
                              ? null
                              : () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            final success = await authProvider.signIn(
                              email: _emailController.text.trim(),
                              password: _passwordController.text,
                            );

                            if (!context.mounted) return;

                            if (success) {
                              Navigator.pushReplacementNamed(
                                context,
                                RouteNames.dashboard,
                              );
                            } else {
                              setState(() {
                                _loginError =
                                    authProvider.failure?.message ??
                                        'Unable to sign in.';
                              });
                            }
                          },
                          child: authProvider.isLoading
                              ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : const Text('LOGIN'),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Version 1.0 Enterprise',
                    textAlign: TextAlign.center,

                  ),
                ],
              ),
            ),
                    ),
                  ),
                ),
              ),
            ),
              ),
            ),
        ),
    );
  }
}

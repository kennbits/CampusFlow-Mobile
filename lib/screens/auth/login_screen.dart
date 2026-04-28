import 'package:flutter/material.dart';
import '../home/home_menu.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  final _formKey =
      GlobalKey<FormState>();

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  bool _loading = false;
  bool _hidePassword = true;

  Future<void> login() async {
    if (!_formKey.currentState!
        .validate()) return;

    setState(() => _loading = true);

    final success =
        await AuthService().login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (!mounted) return;

    setState(() => _loading = false);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const HomeMenu(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text('Login Failed'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF7F8FC),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 18,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 430,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/cf-icon.png',
                        height: 78,
                      ),
                    ),

                    const SizedBox(height: 18),

                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                        children: [
                          TextSpan(
                            text: 'CAMPUS',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'FLOW',
                            style: TextStyle(color: Color(0xFFED1B2F)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'BATANGAS STATE UNIVERSITY',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFED1B2F),
                      ),
                    ),

                    const SizedBox(height: 3),

                    const Text(
                      'The National Engineering University',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Container(
                      padding: const EdgeInsets.all(26),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 25,
                            offset: Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 6),

                            const Text(
                              'Sign in to continue your account',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),

                            const SizedBox(height: 22),

                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                hintText: 'Email or Username',
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                            ),

                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _passwordController,
                              obscureText: _hidePassword,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon:
                                    const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _hidePassword =
                                          !_hidePassword;
                                    });
                                  },
                                  icon: Icon(
                                    _hidePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: Color(0xFFED1B2F),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 6),

                            SizedBox(
                              width: double.infinity,
                              height: 58,
                              child: ElevatedButton(
                                onPressed:
                                    _loading ? null : login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFFED1B2F),
                                  elevation: 8,
                                  shadowColor:
                                      Colors.redAccent,
                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(
                                            18),
                                  ),
                                ),
                                child: _loading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        'SIGN IN',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight:
                                              FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            const Center(
                              child: Text(
                                'Need help? Contact Us',
                                style: TextStyle(
                                  color: Color(0xFF0088CB),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Batangas State University',
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
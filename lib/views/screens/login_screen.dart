import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_textformfield.dart';
import '../../services/auth/auth_service_impl.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter email';
    }
    if (!value.contains('@')) {
      return 'Invalid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter password';
    }
    if (value.length < 6) {
      return 'Minimum 6 characters';
    }
    return null;
  }

void handleLogin() async {
  if (_formKey.currentState!.validate()) {
    try {
      await AuthServiceImpl().login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return; 

      context.go('/home');
    } catch (e) {
      if (!mounted) return; 

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())), 
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
  child: LayoutBuilder(
    builder: (context, constraints) {

      final width = constraints.maxWidth;

      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: Center(
            child: Container(

              // RESPONSIVE WIDTH
              width: width < 600
                  ? width * 0.9
                  : 500,

              padding: const EdgeInsets.all(24),

              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    Text(
                      'Welcome Back',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width < 600 ? 28 : 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 40),

                    CustomTextFormField(
                      controller: emailController,
                      label: 'Email',
                      validator: validateEmail,
                    ),

                    const SizedBox(height: 16),

                    CustomTextFormField(
                      controller: passwordController,
                      label: 'Password',
                      obscureText: true,
                      validator: validatePassword,
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: handleLogin,
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextButton(
                      onPressed: () {
                        context.go('/register');
                      },
                      child: const Text("Go to Register"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  ),
),
    );
  }
}
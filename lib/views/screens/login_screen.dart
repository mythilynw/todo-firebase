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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: handleLogin,
                child: const Text('Login'),
              ),

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
    );
  }
}

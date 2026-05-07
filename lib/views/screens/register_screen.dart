import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_textformfield.dart';
import '../../services/auth/auth_service_impl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter name';
    }
    return null;
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

void handleRegister() async {
  if (_formKey.currentState!.validate()) {
    try {
      await AuthServiceImpl().register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return; 

      context.go('/login');
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
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: nameController,
                label: 'Name',
                validator: validateName,
              ),

              const SizedBox(height: 16),

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
                onPressed: handleRegister,
                child: const Text('Register'),
              ),

              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text("Already have account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../../extensions/extensions.dart';

import '../widgets/custom_textformfield.dart';

class RegisterScreen
    extends ConsumerStatefulWidget {

  const RegisterScreen({
    super.key,
  });

  @override
  ConsumerState<RegisterScreen>
      createState() =>
          _RegisterScreenState();
}

class _RegisterScreenState
    extends ConsumerState<RegisterScreen> {

  final _formKey =
      GlobalKey<FormState>();

  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  @override
  void dispose() {

    nameController.dispose();

    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }

  String? validateName(
    String? value,
  ) {

    if (value == null || value.isEmpty) {
      return 'Enter name';
    }

    return null;
  }

  String? validateEmail(
    String? value,
  ) {

    if (value == null || value.isEmpty) {
      return 'Enter email';
    }

    if (!value.contains('@')) {
      return 'Invalid email';
    }

    return null;
  }

  String? validatePassword(
    String? value,
  ) {

    if (value == null || value.isEmpty) {
      return 'Enter password';
    }

    if (value.length < 6) {
      return 'Minimum 6 characters';
    }

    return null;
  }

  Future<void> handleRegister() async {

    if (_formKey.currentState!.validate()) {

      try {

        await ref.authActions.register(
          name:
              nameController.text.trim(),

          email:
              emailController.text.trim(),

          password:
              passwordController.text
                  .trim(),
        );

        if (!mounted) return;

        context.go('/login');

      } catch (e) {

        if (!mounted) return;

        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final isLoading =
        ref.authLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
        ),
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (
            context,
            constraints,
          ) {

            final width =
                constraints.maxWidth;

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      constraints.maxHeight,
                ),

                child: Center(
                  child: Container(

                    width: width < 600
                        ? width * 0.9
                        : 500,

                    padding:
                        const EdgeInsets.all(
                      24,
                    ),

                    child: Card(
                      elevation: 4,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),
                      ),

                      child: Padding(
                        padding:
                            const EdgeInsets.all(
                          24,
                        ),

                        child: Form(
                          key: _formKey,

                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center,

                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .stretch,

                            children: [

                              Text(
                                'Create Account',

                                textAlign:
                                    TextAlign.center,

                                style: TextStyle(
                                  fontSize:
                                      width < 600
                                          ? 28
                                          : 36,

                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(
                                height: 40,
                              ),

                              CustomTextFormField(
                                controller:
                                    nameController,

                                label: 'Name',

                                validator:
                                    validateName,
                              ),

                              const SizedBox(
                                height: 16,
                              ),

                              CustomTextFormField(
                                controller:
                                    emailController,

                                label:
                                    'Email',

                                validator:
                                    validateEmail,
                              ),

                              const SizedBox(
                                height: 16,
                              ),

                              CustomTextFormField(
                                controller:
                                    passwordController,

                                label:
                                    'Password',

                                obscureText:
                                    true,

                                validator:
                                    validatePassword,
                              ),

                              const SizedBox(
                                height: 24,
                              ),

                              SizedBox(
                                height: 50,

                                child:
                                    ElevatedButton(

                                  onPressed:
                                      isLoading
                                          ? null
                                          : handleRegister,

                                  child:
                                      isLoading
                                          ? const CircularProgressIndicator()
                                          : const Text(
                                              'Register',
                                            ),
                                ),
                              ),

                              const SizedBox(
                                height: 12,
                              ),

                              TextButton(
                                onPressed: () {
                                  context.go(
                                    '/login',
                                  );
                                },

                                child: const Text(
                                  'Already have account? Login',
                                ),
                              ),
                            ],
                          ),
                        ),
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
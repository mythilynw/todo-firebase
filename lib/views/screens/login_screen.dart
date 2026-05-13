import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../viewmodels/auth/auth_viewmodel.dart';
import '../widgets/custom_textformfield.dart';

class LoginScreen
    extends ConsumerStatefulWidget {

  const LoginScreen({
    super.key,
  });

  @override
  ConsumerState<LoginScreen>
      createState() =>
          _LoginScreenState();
}

class _LoginScreenState
    extends ConsumerState<LoginScreen> {

  final _formKey =
      GlobalKey<FormState>();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  @override
  void dispose() {

    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }

  String? validateEmail(
    String? value,
  ) {

    if (value == null ||
        value.isEmpty) {

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

    if (value == null ||
        value.isEmpty) {

      return 'Enter password';
    }

    if (value.length < 6) {

      return 'Minimum 6 characters';
    }

    return null;
  }

  Future<void> handleLogin() async {

    if (_formKey.currentState!
        .validate()) {

      try {

        await ref
            .read(
              authViewModelProvider
                  .notifier,
            )
            .login(

              email:
                  emailController.text
                      .trim(),

              password:
                  passwordController
                      .text
                      .trim(),
            );

        if (!mounted) return;

        context.go('/home');

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
  Widget build(
    BuildContext context,
  ) {

    final isLoading =
        ref.watch(
          authViewModelProvider,
        );

    return Scaffold(

      backgroundColor:
          const Color(0xFFF5F7FB),

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

                    width:
                        width < 600
                            ? width * 0.9
                            : 450,

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

                          const Icon(
                            Icons.lock_outline,
                            size: 80,
                            color: Colors.blue,
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Text(
                            'Welcome Back',

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(
                              fontSize:
                                  width < 600
                                      ? 30
                                      : 38,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          const Text(
                            'Login to continue',

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(
                            height: 40,
                          ),

                          CustomTextFormField(

                            controller:
                                emailController,

                            label: 'Email',

                            validator:
                                validateEmail,
                          ),

                          const SizedBox(
                            height: 18,
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
                            height: 28,
                          ),

                          SizedBox(

                            height: 55,

                            child:
                                ElevatedButton(

                              onPressed:
                                  isLoading
                                      ? null
                                      : handleLogin,

                              style:
                                  ElevatedButton.styleFrom(

                                shape:
                                    RoundedRectangleBorder(

                                  borderRadius:
                                      BorderRadius.circular(
                                    14,
                                  ),
                                ),
                              ),

                              child:
                                  isLoading

                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,

                                          child:
                                              CircularProgressIndicator(
                                            strokeWidth:
                                                2,

                                            color:
                                                Colors.white,
                                          ),
                                        )

                                      : const Text(
                                          'Login',

                                          style:
                                              TextStyle(
                                            fontSize:
                                                18,
                                          ),
                                        ),
                            ),
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          Row(

                            mainAxisAlignment:
                                MainAxisAlignment.center,

                            children: [

                              const Text(
                                'Don’t have an account?',
                              ),

                              TextButton(

                                onPressed: () {

                                  context.go(
                                    '/register',
                                  );
                                },

                                child: const Text(
                                  'Register',
                                ),
                              ),
                            ],
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
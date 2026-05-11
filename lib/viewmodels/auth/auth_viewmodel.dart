import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';

import '../../repositories/auth/auth_repository.dart';

class AuthViewModel
    extends StateNotifier<bool> {
  final AuthRepository authRepository;

  AuthViewModel({
    required this.authRepository,
  }) : super(false);

  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      state = true;

      final user =
          await authRepository.register(
        name: name,
        email: email,
        password: password,
      );

      return user;
    } finally {
      state = false;
    }
  }

  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      state = true;

      final user =
          await authRepository.login(
        email: email,
        password: password,
      );

      return user;
    } finally {
      state = false;
    }
  }

  Future<void> logout() async {
    try {
      state = true;

      await authRepository.logout();
    } finally {
      state = false;
    }
  }
}
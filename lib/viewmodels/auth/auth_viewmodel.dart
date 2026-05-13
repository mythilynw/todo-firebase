import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';

import '../../repositories/app_repository.dart';

// APP REPOSITORY PROVIDER

final appRepositoryProvider =
    Provider<AppRepository>((ref) {

  return AppRepository();
});

// AUTH PROVIDER

final authViewModelProvider =
    StateNotifierProvider<
        AuthViewModel,
        bool>((ref) {

  return AuthViewModel(
    appRepository:
        ref.read(
          appRepositoryProvider,
        ),
  );
});

class AuthViewModel
    extends StateNotifier<bool> {

  final AppRepository
      appRepository;

  AuthViewModel({
    required this.appRepository,
  }) : super(false);

  User? currentUser;

  // REGISTER

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {

    state = true;

    try {

      currentUser =
          await appRepository.auth.register(
        name: name,
        email: email,
        password: password,
      );

    } finally {

      state = false;
    }
  }

  // LOGIN

  Future<void> login({
    required String email,
    required String password,
  }) async {

    state = true;

    try {

      currentUser =
          await appRepository.auth.login(
        email: email,
        password: password,
      );

    } finally {

      state = false;
    }
  }

  // LOGOUT

  Future<void> logout() async {

    state = true;

    try {

      await appRepository.auth.logout();

      currentUser = null;

    } finally {

      state = false;
    }
  }

  // CHECK USER

  Future<void> checkUser() async {

    currentUser =
        await appRepository.auth.currentUser();
  }
}
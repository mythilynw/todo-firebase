import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/auth/auth_repository.dart';

import '../repositories/auth/auth_repository_impl.dart';

import '../services/auth/auth_service.dart';

import '../services/auth/auth_service_impl.dart';

import '../viewmodels/auth/auth_viewmodel.dart';

final authServiceProvider =
    Provider<AuthService>((ref) {
  return AuthServiceImpl();
});

final authRepositoryProvider =
    Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    authService:
        ref.read(authServiceProvider),
  );
});

final authViewModelProvider =
    StateNotifierProvider<
      AuthViewModel,
      bool
    >((ref) {
  return AuthViewModel(
    authRepository:
        ref.read(authRepositoryProvider),
  );
});
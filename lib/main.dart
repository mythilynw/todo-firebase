import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'core/router/app_router.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  // LINUX / WINDOWS / MACOS

  if (Platform.isLinux ||
      Platform.isWindows ||
      Platform.isMacOS) {

    sqfliteFfiInit();

    databaseFactory =
        databaseFactoryFfi;
  }

  runApp(

    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp
    extends StatelessWidget {

  const MyApp({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return MaterialApp.router(

      debugShowCheckedModeBanner:
          false,

      routerConfig:
          appRouter,
    );
  }
}
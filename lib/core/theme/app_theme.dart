import 'package:flutter/material.dart';

class AppColors {
  // azuis
  static const Color noiteArtica  = Color(0xFF0A1628);
  static const Color azulProfundo = Color(0xFF1A3A5C);
  static const Color primary      = Color(0xFF1565C0);
  static const Color azulCeu      = Color(0xFF42A5F5);
  static const Color azulGelo     = Color(0xFF90CAF9);

  // ciano
  static const Color cianoFrio    = Color(0xFF00BCD4);
  static const Color nevoaArtica  = Color(0xFF80DEEA);

  // brancos
  static const Color brancoGelo   = Color(0xFFE3F2FD);
  static const Color brancoPuro   = Color(0xFFF5FBFF);

  // neutro
  static const Color cinzaNeve    = Color(0xFFB0BEC5);

  // status OS
  static const Color statusOpen           = Color(0xFF42A5F5);
  static const Color statusInProgress     = Color(0xFF00BCD4);
  static const Color statusCompleted      = Color(0xFF4CAF50);
  static const Color statusPaymentPending = Color(0xFFF44336);
  static const Color statusCancelled      = Color(0xFFB0BEC5);

  // ativo/inativo
  static const Color active   = Color(0xFF4CAF50);
  static const Color inactive = Color(0xFFF44336);
}

class AppTheme {
  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.brancoPuro,
        ),
        scaffoldBackgroundColor: AppColors.brancoGelo,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.cianoFrio,
          foregroundColor: AppColors.brancoPuro,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.brancoPuro,
          ),
        ),
        useMaterial3: true,
      );

  static ThemeData get dark => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.azulProfundo,
          foregroundColor: AppColors.brancoPuro,
        ),
        scaffoldBackgroundColor: AppColors.noiteArtica,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.cianoFrio,
          foregroundColor: AppColors.brancoPuro,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.azulProfundo,
            foregroundColor: AppColors.brancoPuro,
          ),
        ),
        useMaterial3: true,
      );
}
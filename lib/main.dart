import 'package:coolservice/freatures/clientes/data/repositories/sqlite_client_repository.dart';
import 'package:coolservice/freatures/clientes/presentation/view_model/client_view_model.dart';
import 'package:coolservice/freatures/funcionarios/data/repositories/sqlite_funcionario_repository.dart';
import 'package:coolservice/freatures/funcionarios/presentation/view_model/funcionario_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coolservice/core/app_config/data/preferences_services.dart';
import 'package:coolservice/core/app_config/presentation/viewmodels/app_config_view_model.dart';
import 'package:coolservice/core/theme/app_theme.dart';
import 'package:coolservice/core/splash/presentation/view/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefService = PreferencesService();

  // Instanciando os repositórios uma única vez na memória
  final funcionarioRepository = SQLiteFuncionarioRepository();
  final clienteRepository = SQLiteClientRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppConfigViewModel(prefService)),

        ChangeNotifierProvider(
          create: (_) => FuncionarioViewModel(funcionarioRepository),
        ),

        ChangeNotifierProvider(
          create: (_) => ClientViewModel(clienteRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final configViewModel = context.watch<AppConfigViewModel>();

    return MaterialApp(
      title: 'CoolService',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,

      themeMode: configViewModel.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      home: const SplashPage(),
    );
  }
}

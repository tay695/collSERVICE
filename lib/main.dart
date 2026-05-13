
import 'package:coolservice/presentation/funcionarios/view/funcionario_list_page.dart';
import 'package:coolservice/presentation/funcionarios/view_model/funcionario_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/repositories/sqlite_funcionario_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => SQLiteFuncionarioRepository()),
        ChangeNotifierProvider(
          create: (context) =>
              FuncionarioViewModel(context.read<SQLiteFuncionarioRepository>())
                ..listAll(),
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
    return MaterialApp(
      title: 'CoolService',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FuncionarioListPage(),
    );
  }
}
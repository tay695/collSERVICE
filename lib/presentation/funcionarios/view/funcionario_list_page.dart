import 'package:coolservice/presentation/funcionarios/view_model/funcionario_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coolservice/presentation/funcionarios/view/funcionario_form_page.dart';

class FuncionarioListPage extends StatelessWidget {
  const FuncionarioListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FuncionarioViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Funcionários')),
      body: ListView.builder(
        itemCount: viewModel.funcionarios.length,
        itemBuilder: (context, index) {
          final f = viewModel.funcionarios[index];
          return ListTile(
            title: Text(f.name),
            subtitle: Text(f.role.name),
            trailing: Icon(
              Icons.circle,
              color: f.isActive ? Colors.green : Colors.red,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FuncionarioFormPage()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

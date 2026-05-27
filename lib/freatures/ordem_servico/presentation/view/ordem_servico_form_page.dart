import 'package:coolservice/freatures/funcionarios/presentation/view_model/funcionario_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../clientes/presentation/view_model/client_view_model.dart';
import '../../domain/entidades/ordem_servico.dart';
import '../view_model/ordem_servico_view_model.dart';

class OrdemServicoFormPage extends StatefulWidget {
  const OrdemServicoFormPage({super.key});

  @override
  State<OrdemServicoFormPage> createState() => _OrdemServicoFormPageState();
}

class _OrdemServicoFormPageState extends State<OrdemServicoFormPage> {
  final _formKey = GlobalKey<FormState>();

  String? _clienteSelecionadoId;
  String? _funcionarioSelecionadoId;

  TipoAtendimento _tipoSelecionado = TipoAtendimento.manutencao;
  final OrderStatus _statusSelecionado = OrderStatus.open;
  bool _isExternal = false;

  final _basePriceController = TextEditingController();
  final _kmDistanceController = TextEditingController();
  final _equipamentoController = TextEditingController();
  final _defeitoController = TextEditingController();

  @override
  void dispose() {
    _basePriceController.dispose();
    _kmDistanceController.dispose();
    _equipamentoController.dispose();
    _defeitoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _ = context.watch<OrdemServicoViewModel>();
    final viewModelClientes = context.watch<ClientViewModel>();
    final viewModelFuncionarios = context.watch<FuncionarioViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Nova Ordem de Serviço')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              'Vínculos da Ordem de Serviço',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // DROPDOWN
            DropdownButtonFormField<String>(
              initialValue: _clienteSelecionadoId,
              decoration: const InputDecoration(
                labelText: 'Selecione o Cliente',
                border: OutlineInputBorder(),
              ),
              items: viewModelClientes.clients.map((cliente) {
                return DropdownMenuItem<String>(
                  value: cliente.id,
                  child: Text(cliente.name),
                );
              }).toList(),
              validator: (value) =>
                  value == null ? 'Por favor, selecione um cliente' : null,
              onChanged: (novoClienteId) {
                setState(() => _clienteSelecionadoId = novoClienteId);
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _funcionarioSelecionadoId,
              decoration: const InputDecoration(
                labelText: 'Alocar Funcionário',
                border: OutlineInputBorder(),
              ),
              items: viewModelFuncionarios.funcionarios.map((func) {
                return DropdownMenuItem<String>(
                  value: func.id,
                  child: Text(func.name),
                );
              }).toList(),
              validator: (value) =>
                  value == null ? 'Por favor, aloque um funcionário' : null,
              onChanged: (novoFuncionarioId) {
                setState(() => _funcionarioSelecionadoId = novoFuncionarioId);
              },
            ),

            const Divider(height: 32),
            const Text(
              'Informações Básicas',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Dropdown   Tipo de Atendimento
            DropdownButtonFormField<TipoAtendimento>(
              initialValue: _tipoSelecionado,
              decoration: const InputDecoration(
                labelText: 'Tipo de Atendimento',
                border: OutlineInputBorder(),
              ),
              items: TipoAtendimento.values.map((tipo) {
                return DropdownMenuItem(
                  value: tipo,
                  child: Text(tipo.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (novoTipo) {
                if (novoTipo != null) {
                  setState(() => _tipoSelecionado = novoTipo);
                }
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _basePriceController,
              decoration: const InputDecoration(
                labelText: 'Preço Base do Serviço (R\$)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value!.isEmpty ? 'Insira o valor base' : null,
            ),
            const SizedBox(height: 16),

            SwitchListTile(
              title: const Text('É serviço externo? (Cobrar KM)'),
              value: _isExternal,
              onChanged: (valor) => setState(() => _isExternal = valor),
            ),

            if (_isExternal) ...[
              const SizedBox(height: 8),
              TextFormField(
                controller: _kmDistanceController,
                decoration: const InputDecoration(
                  labelText: 'Distância Total Ida/Volta (KM)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],

            const Divider(height: 32),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // LÓGICA DE SALVAMENTO REAL EM BREVE
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Serviço cadastrado com sucesso!'),
                    ),
                  );
                }
              },
              child: const Text('Salvar Ordem de Serviço'),
            ),
          ],
        ),
      ),
    );
  }
}

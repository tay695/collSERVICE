import 'package:coolservice/core/theme/app_theme.dart';
import 'package:coolservice/freatures/funcionarios/presentation/view_model/funcionario_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../clientes/presentation/view_model/client_view_model.dart';
import '../../domain/entidades/ordem_servico.dart';

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

  InputDecoration _fieldDecoration(String label, {String? prefix}) {
    return InputDecoration(
      labelText: label,
      prefixText: prefix,
      filled: true,
      fillColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.noiteArtica
          : AppColors.brancoPuro,
      labelStyle: const TextStyle(color: AppColors.azulProfundo, fontSize: 13),
      prefixStyle: const TextStyle(
        color: AppColors.azulGelo,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.azulGelo, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.azulGelo, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.inactive, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.inactive, width: 2),
      ),
    );
  }

  Widget _buildSectionCard({
    required String label,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.azulProfundo.withOpacity(0.4)
            : AppColors.brancoPuro,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.azulGelo.withOpacity(0.3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.azulCeu,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModelClientes = context.watch<ClientViewModel>();
    final viewModelFuncionarios = context.watch<FuncionarioViewModel>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Nova Ordem de Serviço')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            //  header
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.azulProfundo, AppColors.primary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.azulCeu.withOpacity(0.18),
                      border: Border.all(
                        color: AppColors.azulGelo.withOpacity(0.4),
                        width: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Abrir ordem de serviço',
                    style: TextStyle(
                      color: AppColors.brancoPuro,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Preencha os dados para criar a OS',
                    style: TextStyle(color: AppColors.azulGelo, fontSize: 13),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _buildSectionCard(
              label: 'Vínculos',
              children: [
                DropdownButtonFormField<String>(
                  value: _clienteSelecionadoId,
                  decoration: _fieldDecoration('Selecione o cliente'),
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
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _funcionarioSelecionadoId,
                  decoration: _fieldDecoration('Alocar funcionário'),
                  items: viewModelFuncionarios.funcionarios.map((func) {
                    return DropdownMenuItem<String>(
                      value: func.id,
                      child: Text(func.name),
                    );
                  }).toList(),
                  validator: (value) =>
                      value == null ? 'Por favor, aloque um funcionário' : null,
                  onChanged: (novoFuncionarioId) {
                    setState(
                      () => _funcionarioSelecionadoId = novoFuncionarioId,
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            _buildSectionCard(
              label: 'Informações básicas',
              children: [
                const Text(
                  'Tipo de atendimento',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.azulProfundo,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: TipoAtendimento.values.map((tipo) {
                    final isSelected = _tipoSelecionado == tipo;
                    return ChoiceChip(
                      label: Text(_getTipoLabel(tipo)),
                      selected: isSelected,
                      onSelected: (_) =>
                          setState(() => _tipoSelecionado = tipo),
                      selectedColor: AppColors.cianoFrio,
                      backgroundColor: isDark
                          ? AppColors.azulProfundo
                          : AppColors.brancoGelo,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? AppColors.brancoPuro
                            : AppColors.azulProfundo,
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.w500
                            : FontWeight.normal,
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.cianoFrio
                            : AppColors.azulGelo,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),

                TextFormField(
                  controller: _basePriceController,
                  decoration: _fieldDecoration(
                    'Preço base do serviço',
                    prefix: 'R\$ ',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Insira o valor base' : null,
                ),
                const SizedBox(height: 8),

                // Switch externo
                Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.noiteArtica
                        : AppColors.brancoGelo,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.azulGelo.withOpacity(0.5),
                    ),
                  ),
                  child: SwitchListTile(
                    title: const Text(
                      'Serviço externo',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.noiteArtica,
                      ),
                    ),
                    subtitle: const Text(
                      'Cobrar deslocamento por KM?',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.cinzaNeve,
                      ),
                    ),
                    value: _isExternal,
                    activeColor: AppColors.cianoFrio,
                    onChanged: (valor) => setState(() => _isExternal = valor),
                  ),
                ),

                if (_isExternal) ...[
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _kmDistanceController,
                    decoration: _fieldDecoration(
                      'Distância total ida/volta (km)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ],
            ),

            const SizedBox(height: 24),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: AppColors.azulCeu, fontSize: 14),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.brancoPuro,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                icon: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // ignore: deprecated_member_use
                    color: AppColors.brancoPuro.withOpacity(0.18),
                  ),
                  child: const Icon(Icons.check_rounded, size: 16),
                ),
                label: const Text(
                  'Salvar ordem de serviço',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Ordem de serviço cadastrada com sucesso!',
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String _getTipoLabel(TipoAtendimento tipo) {
    switch (tipo) {
      case TipoAtendimento.manutencao:
        return 'Manutenção';
      case TipoAtendimento.instalacao:
        return 'Instalação';
      case TipoAtendimento.visitaTecnica:
        return 'Visita técnica';
    }
  }
}

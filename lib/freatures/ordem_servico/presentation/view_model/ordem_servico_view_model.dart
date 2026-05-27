import 'package:coolservice/core/app_config/data/preferences_services.dart';
import 'package:coolservice/freatures/ordem_servico/domain/entidades/ordem_servico.dart';
import 'package:coolservice/freatures/ordem_servico/domain/repositories/i_odem_servico_repository.dart';
import 'package:flutter/material.dart';

class OrdemServicoViewModel extends ChangeNotifier {
  final IOrdemServicoRepository repository;
  final PreferencesService preferencesService;

  double _taxaKm = 1.50;
  double get taxaKm => _taxaKm;

  List<OrdemServico> ordens = [];

  OrdemServicoViewModel(this.repository, this.preferencesService) {
    loadOrdens();
    _loadTaxaKm();
  }

  Future<void> _loadTaxaKm() async {
    _taxaKm = await preferencesService.getKmFee();
    notifyListeners();
  }

  Future<void> loadOrdens() async {
    ordens = await repository.listAll();
    notifyListeners();
  }

  double calcularTotalDinamico({
    required double basePrice,
    required double kmDistance,
    required bool isExternal,
  }) {
    if (!isExternal) return basePrice;

    final taxaDeslocamento = kmDistance * _taxaKm;
    return basePrice + taxaDeslocamento;
  }

  Future<void> saveOrdem(OrdemServico os) async {
    await repository.save(os);
    await loadOrdens();
  }

  Future<List<OrdemServico>> getOrdensDoFuncionario(String employeeId) async {
    return await repository.listByEmployee(employeeId);
  }

  Future<void> updateTaxaKm(double novaTaxa) async {
    _taxaKm = novaTaxa;
    await preferencesService.saveKmFee(novaTaxa);
    notifyListeners();
  }
}

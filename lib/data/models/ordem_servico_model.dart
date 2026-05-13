import 'dart:convert';
import 'package:coolservice/domain/entidades/ordem_servico.dart';

class OrdemServicoModel extends OrdemServico {
  OrdemServicoModel({
    required super.id,
    required super.clientId,
    required super.employeeId,
    super.technicianId,
    required super.status,
    required super.isExternal,
    super.kmDistance,
    super.serviceBasePrice,
    super.kmFee,
    super.totalValue,
    super.observations,
    super.formData,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'employeeId': employeeId,
      'technicianId': technicianId,
      'status': status.name,
      'isExternal': isExternal ? 1 : 0,
      'kmDistance': kmDistance,
      'serviceBasePrice': serviceBasePrice,
      'kmFee': kmFee,
      'totalValue': totalValue,
      'observations': observations,
      'formData': jsonEncode(formData),
    };
  }

  factory OrdemServicoModel.fromMap(Map<String, dynamic> map) {
    return OrdemServicoModel(
      id: map['id'] ?? '',
      clientId: map['clientId'] ?? '',
      employeeId: map['employeeId'] ?? '',
      technicianId: map['technicianId'],
      status: OrderStatus.values.byName(map['status'] ?? 'open'),
      isExternal: map['isExternal'] == 1,
      kmDistance: map['kmDistance'] ?? 0.0,
      serviceBasePrice: map['serviceBasePrice'] ?? 0.0,
      kmFee: map['kmFee'] ?? 0.0,
      totalValue: map['totalValue'] ?? 0.0,
      observations: map['observations'],
      formData: map['formData'] != null
          ? List<String>.from(jsonDecode(map['formData']))
          : [],
    );
  }
}
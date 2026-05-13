enum OrderStatus { open, inProgress, completed, paymentPending, cancelled }

class OrdemServico {
  final String id;
  final String clientId;
  final String employeeId;
  final String? technicianId;
  final OrderStatus status;
  final bool isExternal;
  final double kmDistance;
  final double serviceBasePrice;
  final double kmFee;
  final double totalValue;
  final String? observations;
  final List<String> formData;

  OrdemServico({
    required this.id,
    required this.clientId,
    required this.employeeId,
    this.technicianId,
    required this.status,
    required this.isExternal,
    this.kmDistance = 0.0,
    this.serviceBasePrice = 0.0,
    this.kmFee = 0.0,
    this.totalValue = 0.0,
    this.observations,
    this.formData = const [],
  });

  double calculateTotal() {
    return serviceBasePrice + kmFee;
  }
}

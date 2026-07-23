import 'gym_model.dart';
import 'invoice_item_model.dart';
import 'invoice_model.dart';

///------------------------------------------------------------
/// Invoice Render Data
///
/// UI-only model.
///
/// This model is NOT stored in Firestore.
///
/// It combines all information required to render an invoice
/// for Preview, PDF, Print and Share.
///
/// Multi-Tenant SaaS Ready.
///------------------------------------------------------------
class InvoiceRenderData {
  ///==============================
  /// Tenant
  ///==============================

  final GymModel gym;

  ///==============================
  /// Invoice
  ///==============================

  final InvoiceModel invoice;

  ///==============================
  /// Invoice Items
  ///==============================

  final List<InvoiceItemModel> items;

  const InvoiceRenderData({
    required this.gym,
    required this.invoice,
    required this.items,
  });

  ///==============================
  /// Helpers
  ///==============================

  bool get isPaid =>
      invoice.paymentStatus == PaymentStatus.paid;

  bool get isPartial =>
      invoice.paymentStatus == PaymentStatus.partial;

  bool get isUnpaid =>
      invoice.paymentStatus == PaymentStatus.unpaid;

  bool get isCancelled =>
      invoice.paymentStatus == PaymentStatus.cancelled;

  bool get isRefunded =>
      invoice.paymentStatus == PaymentStatus.refunded;

  int get totalItems => items.length;

  double get totalQuantity =>
      items.fold(
        0.0,
            (sum, item) => sum + item.quantity,
      );

  String get paymentStatusLabel {
    switch (invoice.paymentStatus) {
      case PaymentStatus.paid:
        return 'PAID';

      case PaymentStatus.partial:
        return 'PARTIAL';

      case PaymentStatus.unpaid:
        return 'UNPAID';

      case PaymentStatus.cancelled:
        return 'CANCELLED';

      case PaymentStatus.refunded:
        return 'REFUNDED';
    }
  }
}
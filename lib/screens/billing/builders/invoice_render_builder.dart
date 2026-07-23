import '../../../models/gym_model.dart';
import '../../../models/invoice_item_model.dart';
import '../../../models/invoice_model.dart';
import '../../../models/invoice_render_data.dart';

///------------------------------------------------------------
/// Invoice Render Builder
///
/// Converts production models into a single render model.
///
/// Used by:
/// • Invoice Preview
/// • PDF Generation
/// • Print
/// • Share
///
/// This class contains no UI, Provider, Firestore,
/// or navigation logic.
///------------------------------------------------------------
class InvoiceRenderBuilder {
  const InvoiceRenderBuilder._();

  static InvoiceRenderData build({
    required GymModel gym,
    required InvoiceModel invoice,
    required List<InvoiceItemModel> items,
  }) {
    return InvoiceRenderData(
      gym: gym,
      invoice: invoice,
      items: List<InvoiceItemModel>.unmodifiable(items),
    );
  }
}
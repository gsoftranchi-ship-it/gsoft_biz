import 'package:flutter/foundation.dart';

import '../models/invoice_item_model.dart';
import '../models/product_model.dart';
import '../models/base/audit_info.dart';
import '../models/base/entity_status.dart';
import '../models/base/tenant_info.dart';

class InvoiceBuilderProvider extends ChangeNotifier {
  final List<InvoiceItemModel> _items = [];

  List<InvoiceItemModel> get items =>
      List.unmodifiable(_items);

  double _discount = 0;

  double _taxPercentage = 18;

  double get discount => _discount;

  double get taxPercentage => _taxPercentage;

  //==========================================================
  // Product
  //==========================================================

  void addProduct(ProductModel product) {
    final index = _items.indexWhere(
          (e) => e.referenceId == product.productId,
    );

    if (index >= 0) {
      final existing = _items[index];

      final qty = existing.quantity + 1;

      _items[index] = existing.copyWith(
        quantity: qty,
        lineTotal: qty * existing.unitPrice,
      );
    } else {
      _items.add(
        InvoiceItemModel(
          invoiceItemId: '',
          invoiceId: '',
          itemType: InvoiceItemType.product,
          referenceId: product.productId,
          itemCode: product.productId,
          barcode: '',
          itemName: product.productName,
          description: '',
          hsnSacCode: '',
          unit: product.unit,
          quantity: 1,
          purchasePrice: product.purchasePrice,
          sellingPrice: product.sellingPrice,
          unitPrice: product.sellingPrice,
          discountAmount: 0,
          discountPercentage: 0,
          taxPercentage: _taxPercentage,
          taxAmount: 0,
          lineTotal: product.sellingPrice,
          remarks: '',
          version: 1,
          tenantInfo: const TenantInfo(
            gymId: '',
          ),
          auditInfo: AuditInfo(
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            createdBy: '',
            updatedBy: '',
          ),
          status: EntityStatus.active,
        ),
      );
    }

    notifyListeners();
  }

  //==========================================================
  // Remove
  //==========================================================

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  //==========================================================
  // Qty
  //==========================================================

  void updateQuantity(
      int index,
      double quantity,
      ) {
    final item = _items[index];

    _items[index] = item.copyWith(
      quantity: quantity,
      lineTotal: quantity * item.unitPrice,
    );

    notifyListeners();
  }

  //==========================================================
  // Discount
  //==========================================================

  void updateDiscount(double value) {
    _discount = value;
    notifyListeners();
  }

  //==========================================================
  // Tax
  //==========================================================

  void updateTax(double value) {
    _taxPercentage = value;
    notifyListeners();
  }

  //==========================================================
  // Totals
  //==========================================================

  double get subtotal =>
      _items.fold(
        0,
            (sum, e) => sum + e.lineTotal,
      );

  double get taxableAmount =>
      subtotal - _discount;

  double get taxAmount =>
      taxableAmount * (_taxPercentage / 100);

  double get grandTotal =>
      taxableAmount + taxAmount;

  //==========================================================
  // Clear
  //==========================================================

  void clear() {
    _items.clear();
    _discount = 0;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';

class PurchaseFormController extends ChangeNotifier {
  //==========================
  // SUPPLIER
  //==========================

  final supplierController = TextEditingController();

  final invoiceNumberController = TextEditingController();

  //==========================
  // PRODUCT
  //==========================

  String selectedProduct = '';

  final quantityController =
  TextEditingController(text: '1');

  final purchasePriceController =
  TextEditingController();

  final discountController =
  TextEditingController(text: '0');

  final taxController =
  TextEditingController(text: '0');

  //==========================
  // TOTALS
  //==========================

  final subTotalController =
  TextEditingController();

  final grandTotalController =
  TextEditingController();

  //==========================
  // PURCHASE
  //==========================

  DateTime purchaseDate = DateTime.now();

  String paymentMethod = 'Cash';

  final remarksController =
  TextEditingController();

  //==========================
  // CALCULATE
  //==========================

  void calculateTotals() {
    final qty =
        double.tryParse(quantityController.text) ?? 0;

    final price =
        double.tryParse(purchasePriceController.text) ?? 0;

    final discount =
        double.tryParse(discountController.text) ?? 0;

    final tax =
        double.tryParse(taxController.text) ?? 0;

    final subTotal = qty * price;

    final taxable = subTotal - discount;

    final grandTotal =
        taxable + ((taxable * tax) / 100);

    subTotalController.text =
        subTotal.toStringAsFixed(2);

    grandTotalController.text =
        grandTotal.toStringAsFixed(2);

    notifyListeners();
  }

  void setProduct(String product) {
    selectedProduct = product;
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    paymentMethod = method;
    notifyListeners();
  }

  @override
  void dispose() {
    supplierController.dispose();
    invoiceNumberController.dispose();

    quantityController.dispose();
    purchasePriceController.dispose();
    discountController.dispose();
    taxController.dispose();

    subTotalController.dispose();
    grandTotalController.dispose();

    remarksController.dispose();

    super.dispose();
  }
}
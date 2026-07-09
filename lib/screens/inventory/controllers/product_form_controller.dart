import 'package:flutter/material.dart';

class ProductFormController extends ChangeNotifier {
  //==========================
  // BASIC INFORMATION
  //==========================

  final productNameController = TextEditingController();

  final categoryController = TextEditingController();

  final unitController = TextEditingController(text: 'Nos');

  //==========================
  // PRICING
  //==========================

  final purchasePriceController = TextEditingController();

  final sellingPriceController = TextEditingController();

  //==========================
  // INVENTORY
  //==========================

  final reorderLevelController =
  TextEditingController(text: '0');

  bool isActive = true;

  //==========================
  // STATE
  //==========================

  void setActive(bool value) {
    if (isActive == value) return;

    isActive = value;
    notifyListeners();
  }

  bool validate() {
    return productNameController.text.trim().isNotEmpty &&
        categoryController.text.trim().isNotEmpty;
  }

  void clear() {
    productNameController.clear();
    categoryController.clear();

    unitController.text = 'Nos';

    purchasePriceController.clear();
    sellingPriceController.clear();

    reorderLevelController.text = '0';

    isActive = true;

    notifyListeners();
  }

  @override
  void dispose() {
    productNameController.dispose();
    categoryController.dispose();
    unitController.dispose();

    purchasePriceController.dispose();
    sellingPriceController.dispose();

    reorderLevelController.dispose();

    super.dispose();
  }
}
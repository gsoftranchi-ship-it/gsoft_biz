import 'package:flutter/material.dart';

import '../controllers/product_form_controller.dart';
import '../widgets/product_basic_information_card.dart';
import '../widgets/product_inventory_card.dart';
import '../widgets/product_pricing_card.dart';
import '../widgets/save_product_button.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  late final ProductFormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ProductFormController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ProductBasicInformationCard(
                controller: _controller,
              ),

              ProductPricingCard(
                controller: _controller,
              ),

              ProductInventoryCard(
                controller: _controller,
              ),

              const SizedBox(height: 24),

              SaveProductButton(
                controller: _controller,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
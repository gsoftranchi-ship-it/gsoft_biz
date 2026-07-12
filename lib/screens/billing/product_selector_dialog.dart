import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product_model.dart';
import '../../providers/product_provider.dart';

class ProductSelectorDialog extends StatefulWidget {
  const ProductSelectorDialog({
    super.key,
    this.onSelected,
  });

  final ValueChanged<ProductModel>? onSelected;

  @override
  State<ProductSelectorDialog> createState() =>
      _ProductSelectorDialogState();
}

class _ProductSelectorDialogState
    extends State<ProductSelectorDialog> {

  final TextEditingController _searchController =
  TextEditingController();

  List<ProductModel> _filteredProducts = [];

  @override
  void initState() {
    super.initState();

    _searchController.addListener(_filterProducts);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final provider =
    context.read<ProductProvider>();

    _filteredProducts = provider.products;
  }

  @override
  void dispose() {
    _searchController.removeListener(
      _filterProducts,
    );

    _searchController.dispose();

    super.dispose();
  }

  void _filterProducts() {
    final keyword =
    _searchController.text
        .trim()
        .toLowerCase();

    final provider =
    context.read<ProductProvider>();

    setState(() {
      _filteredProducts =
          provider.products.where((product) {

            return product.productName
                .toLowerCase()
                .contains(keyword) ||

                product.productId
                    .toLowerCase()
                    .contains(keyword);

          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Dialog(
      child: SizedBox(
        width: 700,
        height: 550,
        child: Column(
          children: [

            AppBar(
              automaticallyImplyLeading: false,
              title: const Text(
                'Select Product',
              ),
              actions: [

                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                ),

              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller:
                _searchController,
                decoration:
                const InputDecoration(
                  prefixIcon:
                  Icon(Icons.search),
                  hintText:
                  'Search Product',
                ),
              ),
            ),

            Expanded(
              child: _filteredProducts.isEmpty
                  ? const Center(
                child: Text(
                  'No Products Found',
                ),
              )
                  : ListView.separated(

                itemCount:
                _filteredProducts.length,

                separatorBuilder: (context, index) => const Divider(),


                itemBuilder:
                    (context, index) {

                  final product =
                  _filteredProducts[index];

                  return ListTile(

                    leading:
                    const CircleAvatar(
                      child: Icon(
                        Icons.inventory_2,
                      ),
                    ),

                    title: Text(
                      product.productName,
                    ),

                    subtitle: Text(
                      "${product.categoryId}\n₹${product.sellingPrice.toStringAsFixed(2)}",
                    ),

                    isThreeLine: true,

                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),

                    onTap: () {

                      widget.onSelected
                          ?.call(product);

                      Navigator.pop(context);

                    },

                  );

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
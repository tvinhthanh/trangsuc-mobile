import 'package:flutter/material.dart';
import 'package:jewelry_app/models/product.dart';
import 'package:jewelry_app/core/widget/product/product_item.dart';

class ProductListByCategoryScreen extends StatelessWidget {
  final String category;
  final List<ProductModel> products;

  const ProductListByCategoryScreen({
    super.key,
    required this.category,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final filtered = products.where((p) => p.category == category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Danh mục: $category"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: filtered.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (context, index) {
          return ProductItem(product: filtered[index]);
        },
      ),
    );
  }
}

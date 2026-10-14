import 'package:flutter/material.dart';
import 'package:jewelry_app/models/product.dart';
import 'product_item.dart';

class ProductList extends StatelessWidget {
  final List<ProductModel> products;
  final String type;

  const ProductList({
    super.key,
    required this.products,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    // Lọc sản phẩm theo type
    final filtered = products.where((p) => p.type == type).toList();

    if (filtered.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text("Không có sản phẩm phù hợp."),
      );
    }

    // Chia thành các nhóm 2 sản phẩm
    final pages = <List<ProductModel>>[];
    for (var i = 0; i < filtered.length; i += 2) {
      pages.add(filtered.sublist(
        i,
        (i + 2 < filtered.length) ? i + 2 : filtered.length,
      ));
    }

    return SizedBox(
      height: 280, // đủ để hiển thị 2 item
      child: PageView.builder(
        itemCount: pages.length,
        controller: PageController(viewportFraction: 0.95),
        itemBuilder: (context, pageIndex) {
          final items = pages[pageIndex];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items.map((product) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ProductItem(product: product),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

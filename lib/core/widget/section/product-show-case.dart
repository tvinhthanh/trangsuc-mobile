import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jewelry_app/core/widget/product/product_item.dart';
import 'package:jewelry_app/models/product.dart';

class SectionProductShowcase extends StatelessWidget {
  final String title;
  final String category;
  final String seeMoreRoute;
  final List<ProductModel> allProducts;

  const SectionProductShowcase({
    super.key,
    required this.title,
    required this.category,
    required this.seeMoreRoute,
    required this.allProducts,
  });

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> filtered = allProducts
        .where((product) => product.category == category)
        .toList();

    if (filtered.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + See more
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(seeMoreRoute, extra: filtered);
                },
                child: const Text("Xem thêm",
                    style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Product list horizontal
          SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 160, // đảm bảo mỗi item không tràn
                  child: ProductItem(product: filtered[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

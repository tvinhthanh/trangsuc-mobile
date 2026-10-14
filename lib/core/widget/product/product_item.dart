import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jewelry_app/models/product.dart';

class ProductItem extends StatefulWidget {
  final ProductModel product;

  const ProductItem({super.key, required this.product});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat("#,###", "vi_VN");

    return Container(
      width: 190,
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hình ảnh
          Expanded(
            flex: 7,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset('assets/images/background-product.png', fit: BoxFit.cover),
                      Positioned(
                        right: 0,
                        child: Image.asset('assets/images/background-product-item.png', width: 210),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(widget.product.image, fit: BoxFit.contain),
                      ),
                    ],
                  ),
                ),

                // ❤️ Yêu thích
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() => isFavorite = !isFavorite);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red),
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 16,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),

                // 🛍 Giỏ hàng
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      print("🛍 Sản phẩm '${widget.product.name}' được thêm vào giỏ hàng!");
                      // Hoặc dùng SnackBar:
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Đã thêm ${widget.product.name} vào giỏ hàng")),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black26),
                      ),
                      child: const Icon(Icons.shopping_bag_outlined, size: 16),
                    ),
                  ),
                ),

                // ⭐ Rating
                Positioned(
                  bottom: 0,
                  left: 10,
                  child: Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        widget.product.rating.toString(),
                        style: const TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tên và giá
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₫${currencyFormat.format(widget.product.price)}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jewelry_app/core/widget/image_slider_section.dart';
import 'package:jewelry_app/core/widget/product/product_list.dart';
import 'package:jewelry_app/models/product.dart';
import 'package:jewelry_app/services/product_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<List<ProductModel>> _productsFuture;
  final List<ProductModel> purchasedProducts = [];

  @override
  void initState() {
    super.initState();
    _productsFuture = loadProductsFromJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserInfo(),
              const SizedBox(height: 20),
              _buildMainActions(),
              const SizedBox(height: 24),

              // Slider gợi ý
              ImageSliderSection(
                title: "Có thể bạn sẽ thích",
                imageUrls: [
                  "https://example.com/banner1.jpg",
                  "https://example.com/banner2.jpg",
                  "https://example.com/banner3.jpg",
                ],
                onSeeMore: () {
                  context.push("/suggested");
                },
              ),
              const SizedBox(height: 24),

              // Danh sách sản phẩm gợi ý
              FutureBuilder<List<ProductModel>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Text("Lỗi khi tải sản phẩm");
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text("Không có sản phẩm nào");
                  }
                  return ProductList(
                    products: snapshot.data!,
                    type: 'suggested',
                  );
                },
              ),
              const SizedBox(height: 24),

              // Section sản phẩm đã mua
              _buildSectionTitle(
                "Sản phẩm đã mua",
                onSeeMore: () => context.push("/purchased"),
              ),
              const SizedBox(height: 12),
              // TODO: Thêm SectionPurchasedProducts nếu có

              const SizedBox(height: 24),

              // Menu điều hướng
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileMenuItem(
                      title: "Ưu đãi thành viên",
                      onTap: () => context.push("/member-benefits"),
                    ),
                    ProfileMenuItem(
                      title: "Tài khoản & thẻ thanh toán",
                      onTap: () => context.push("/account-payment"),
                    ),
                    ProfileMenuItem(
                      title: "Thông tin cá nhân",
                      onTap: () => context.push("/personal-info"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Stack(
      children: [
        // Background bo cong với overlay
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          child: Stack(
            children: [
              Image.asset(
                'assets/images/bg-wave.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 180,
              ),
              Container(
                width: double.infinity,
                height: 180,
                color: const Color.fromRGBO(50, 212, 236, 0.6),
              ),
            ],
          ),
        ),

        // Nút back
        Positioned(
          top: 16,
          left: 16,
          child: CircleAvatar(
            backgroundColor: Colors.white54,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
        ),

        // Nút thông báo
        Positioned(
          top: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.white54,
            child: IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ),

        // Avatar + tên + vai trò
        Positioned(
          left: 16,
          bottom: 16,
          child: Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage("assets/images/avatar.png"),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Trần Thị Như Mộng",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Hội viên tiềm năng",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _ActionIcon(icon: Icons.account_balance_wallet, label: "Thanh toán", showBadge: true),
        _ActionIcon(icon: Icons.inventory, label: "Đơn hàng"),
        _ActionIcon(icon: Icons.local_shipping, label: "Vận chuyển", showBadge: true),
        _ActionIcon(icon: Icons.star_border, label: "Đánh giá"),
      ],
    );
  }

  Widget _buildSectionTitle(String title, {required VoidCallback onSeeMore}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: onSeeMore,
          child: const Text("Xem thêm", style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 4,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Cá nhân"),
      ],
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool showBadge;

  const _ActionIcon({required this.icon, required this.label, this.showBadge = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
        if (showBadge)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: const Text("1", style: TextStyle(fontSize: 10, color: Colors.white)),
            ),
          ),
      ],
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItem({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

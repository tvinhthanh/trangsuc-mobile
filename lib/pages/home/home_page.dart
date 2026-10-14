import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jewelry_app/core/widget/category_tab_selector.dart';
import 'package:jewelry_app/core/widget/product/product_list.dart';
import 'package:jewelry_app/core/widget/recommend_banner_section.dart';
import 'package:jewelry_app/core/widget/section/blog-show-case.dart';
import 'package:jewelry_app/core/widget/section/feature-show-case.dart';
import 'package:jewelry_app/core/widget/section/product-show-case.dart';
import 'package:jewelry_app/models/blog.dart';
import 'package:jewelry_app/models/product.dart';
import 'package:jewelry_app/services/blog_service.dart';
import 'package:jewelry_app/services/product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ProductModel>> _productsFuture;
  late Future<List<BlogModel>> _blogsFuture;
  String selectedType = "new";
  bool _popupShown = false;

  @override
  void initState() {
    super.initState();
    _productsFuture = loadProductsFromJson();
      _blogsFuture = loadBlogsFromJson();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_popupShown) {
      _popupShown = true;
      Future.delayed(Duration.zero, _showAdPopup);
    }
  }

  void _showAdPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/ad-banner.png',
                  width: MediaQuery.of(context).size.width * 0.8,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.black54,
                    child: Icon(Icons.close, size: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final categoryTabs = [
    {'label': 'Sản phẩm mới', 'icon': 'assets/icons/new.svg', 'type': 'new'},
    {'label': 'Nhẫn cặp', 'icon': 'assets/icons/couple-ring.svg', 'type': 'couple-ring'},
    {'label': 'Nhẫn', 'icon': 'assets/icons/ring.svg', 'type': 'ring'},
    {'label': 'Vòng cổ', 'icon': 'assets/icons/nack-collar.svg', 'type': 'necklace'},
    {'label': 'Kiềng', 'icon': 'assets/icons/bangle.svg', 'type': 'bangle'},
    {'label': 'Vòng tay', 'icon': 'assets/icons/nack-collar.svg', 'type': 'bracelet'},
    {'label': 'Bông tai', 'icon': 'assets/icons/earrings.svg', 'type': 'earrings'},
    {'label': 'Lắc', 'icon': 'assets/icons/bracelet.svg', 'type': 'lock'},
    {'label': 'Mặt dây chuyền', 'icon': 'assets/icons/pendant.svg', 'type': 'pendant'},
    {'label': 'Charm', 'icon': 'assets/icons/charm.svg', 'type': 'charm'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<List<ProductModel>>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final products = snapshot.data!;
            return ListView(
              padding: EdgeInsets.only(
                bottom: kBottomNavigationBarHeight +
                    MediaQuery.of(context).padding.bottom +
                    16,
              ),
              children: [
                _buildTopSection(),
                const RecommendBannerSection(),
                CategoryTabSelector(
                  tabs: categoryTabs,
                  onTabSelected: (index) {
                    setState(() => selectedType = categoryTabs[index]['type']!);
                  },
                ),
                ProductList(
                  products: products,
                  type: selectedType,
                ),
                SectionProductShowcase(
                  title: "Trang sức thời trang",
                  category: "fashion",
                  seeMoreRoute: "/products/fashion",
                  allProducts: products, // danh sách toàn bộ sản phẩm
                ),
                SectionProductShowcase(
                  title: "Trang sức lễ hội",
                  category: "party",
                  seeMoreRoute: "/products/party",
                  allProducts: products, // danh sách toàn bộ sản phẩm
                ),
                FeatureSection(
                  onSeeMore: () {
                    // Ví dụ: điều hướng sang trang tiện ích tổng hợp
                    context.push("/features");
                  },
                ),
                FutureBuilder<List<BlogModel>>(
                  future: _blogsFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const SizedBox.shrink();
                    final blogs = snapshot.data!;
                    return BlogSection(
                      blogs: blogs,
                      onSeeMore: () => context.push('/blogs'),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: BoxDecoration(
        color: const Color(0xFF4C71F2),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Have a nice day!', style: TextStyle(fontSize: 13, color: Colors.white70)),
                    Text('Trần Thị Như Mộng', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              _buildIconButton(Icons.notifications_none),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Tìm kiếm sản phẩm',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _buildIconButton(Icons.qr_code),
              const SizedBox(width: 8),
              _buildIconButton(Icons.tune),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: const Color(0xFF4C71F2)),
    );
  }
}

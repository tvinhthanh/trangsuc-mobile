import 'package:flutter/material.dart';

class RecommendBannerSection extends StatefulWidget {
  const RecommendBannerSection({super.key});

  @override
  State<RecommendBannerSection> createState() => _RecommendBannerSectionState();
}

class _RecommendBannerSectionState extends State<RecommendBannerSection> {
  // Dùng trang lớn để tạo hiệu ứng loop
  final PageController _controller = PageController(initialPage: 1000);
  int _currentPage = 1000;

  final List<String> banners = [
    'assets/images/qc1.png',
    'assets/images/qc2.png',
    'assets/images/qc3.png',
    'assets/images/qc4.png',
    'assets/images/qc5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tiêu đề
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Có thể bạn sẽ thích", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Xem thêm", style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),

        // Banner
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final actualIndex = index % banners.length;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    banners[actualIndex],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (index) {
            final isActive = _currentPage % banners.length == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 10,
              width: isActive ? 40 : 12,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF4C71F2) : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }),
        ),
      ],
    );
  }
}

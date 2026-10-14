import 'package:flutter/material.dart';

class AdviceListScreen extends StatelessWidget {
  const AdviceListScreen({super.key});

  final List<Map<String, String>> _adviceItems = const [
    {
      'title': 'Tư vấn sản phẩm',
      'code': 'MS:03260',
      'description': 'Hỗ trợ tư vấn mẫu mã mạnh mẽ của các dịch vụ giá...',
      'image': 'https://i.imgur.com/DG7XKHM.png'
    },
    {
      'title': 'Tư vấn thiết kế theo cá nhân',
      'code': 'MS:03260',
      'description': 'Hỗ trợ tư vấn mẫu mã mạnh mẽ của các dịch vụ giá...',
      'image': 'https://i.imgur.com/LzT2IcV.png'
    },
    {
      'title': 'Hỗ trợ đối tác doanh nghiệp',
      'code': 'MS:03260',
      'description': 'Hỗ trợ tư vấn mẫu mã mạnh mẽ của các dịch vụ giá...',
      'image': 'https://i.imgur.com/Kq5hzFG.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FCFF), // Gradient-like light background
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Tư vấn',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        itemCount: _adviceItems.length,
        separatorBuilder: (_, __) => const Divider(indent: 16, endIndent: 16),
        itemBuilder: (context, index) {
          final item = _adviceItems[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item['image']!,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              item['title']!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['code']!,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 2),
                Text(
                  item['description']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
            onTap: () {
              // TODO: Navigate to ChatScreen
            },
          );
        },
      ),
    );
  }
}

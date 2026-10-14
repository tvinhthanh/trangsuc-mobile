import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeatureSection extends StatelessWidget {
  final VoidCallback onSeeMore;

  const FeatureSection({super.key, required this.onSeeMore});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'label': 'Diary',
        'onTap': () {
          debugPrint("Diary tapped");
          context.push("/diary"); // nếu dùng go_router
        },
      },
      {
        'label': 'Sizing',
        'onTap': () {
          debugPrint("Sizing tapped");
        },
      },
      {
        'label': 'Program',
        'onTap': () {
          debugPrint("Program tapped");
        },
      },
      {
        'label': 'Custom',
        'onTap': () {
          debugPrint("Custom tapped");
        },
      },
      {
        'label': 'Gift',
        'onTap': () {
          debugPrint("Gift tapped");
        },
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader("Tiện ích", onSeeMore),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: features.map((item) {
              return GestureDetector(
                onTap: item['onTap'] as VoidCallback,
                child: Column(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.extension, color: Colors.grey), // Placeholder
                    ),
                    const SizedBox(height: 4),
                    Text(item['label'] as String,
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title, VoidCallback onSeeMore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: onSeeMore,
          child: const Text("Xem thêm", style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryTabSelector extends StatefulWidget {
  final List<Map<String, String>> tabs;
  final Function(int index)? onTabSelected;
  final int initialIndex;

  const CategoryTabSelector({
    super.key,
    required this.tabs,
    this.onTabSelected,
    this.initialIndex = 0,
  });

  @override
  State<CategoryTabSelector> createState() => _CategoryTabSelectorState();
}

class _CategoryTabSelectorState extends State<CategoryTabSelector> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: List.generate(widget.tabs.length, (index) {
            final tab = widget.tabs[index];
            final isSelected = index == selectedIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onTabSelected?.call(index);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF4C71F2) : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFF4C71F2), Color(0xFF7BC8FF)],
                              ).createShader(bounds),
                              blendMode: BlendMode.srcIn,
                              child: SvgPicture.asset(tab['icon']!, width: 32, height: 32),
                            )
                          : SvgPicture.asset(
                              tab['icon']!,
                              width: 32,
                              height: 32,
                              color: Colors.grey,
                            ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      tab['label']!,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? const Color(0xFF4C71F2) : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

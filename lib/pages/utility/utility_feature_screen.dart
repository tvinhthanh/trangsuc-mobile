import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Tiện ích",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Body scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sự kiện
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9DB9FF),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                                "assets/images/model-xmas.png",
                                width: 75,
                                height: 75,
                              ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Lễ giáng sinh sắp tới!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        color: Colors.white, size: 14),
                                    SizedBox(width: 4),
                                    Text("12:00 - 16:00",
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.event,
                                        color: Colors.white, size: 14),
                                    SizedBox(width: 4),
                                    Text("24 - 12 - 2024",
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Live Price
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6ACDFF),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Row(
                                  children: [
                                    Icon(Icons.circle,
                                        color: Colors.red, size: 10),
                                    SizedBox(width: 4),
                                    Text(
                                      "Live Price",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "117,500,000 / 3.75g",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "giá này chưa bao gồm các chi phí phụ thu, thuế VAT, công thợ...",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "24K • 999%",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      backgroundColor: Colors.yellow),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/images/gold.png",
                                width: 48,
                                height: 48,
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Price will refresh in 5s",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Section title
                    const Text(
                      "Tiện ích nổi bật",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    // Tiện ích cards
                    _buildFeatureCard("DIARY", "Giới thiệu về tính năng của tiện ích",
                        Colors.pinkAccent, "assets/images/diary.png"),
                    _buildFeatureCard("SIZING", "Giới thiệu về tính năng của tiện ích",
                        Colors.brown.shade100, "assets/images/sizing.png"),
                    _buildFeatureCard("PROGRAM", "Giới thiệu về tính năng của tiện ích",
                        Colors.deepOrange, "assets/images/program.png"),
                    _buildFeatureCard("CUSTOM", "Giới thiệu về tính năng của tiện ích",
                        Colors.grey.shade300, "assets/images/custom.png"),
                    _buildFeatureCard("GIFT", "Giới thiệu về tính năng của tiện ích",
                        Colors.grey.shade300, "assets/images/gift.png"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      String title, String subtitle, Color bgColor, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 90,
      width: 380,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: bgColor,
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(bgColor.withOpacity(0.4), BlendMode.multiply),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(),
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.white)),
        ],
      ),
    );
  }
}

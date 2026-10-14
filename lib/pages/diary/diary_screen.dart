import 'package:flutter/material.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD6E6), // nền hồng pastel
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              _buildHeader(),
              const SizedBox(height: 12),
              _buildBannerCard(),
              const SizedBox(height: 16),
              _buildActionButtons(),
              const SizedBox(height: 24),
              _buildEventTitle(),
              const SizedBox(height: 12),
              _buildEventList(), // danh sách nhật ký cũ
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const CircleAvatar(radius: 28, backgroundImage: AssetImage("assets/images/girl1.png")),
        Column(
          children: [
            const Text("Khánh Vy", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Image.asset("assets/images/heart-ecg.png", height: 100), // ảnh ECG trái tim
            const Text("365 Ngày", style: TextStyle(fontSize: 25, color: Colors.purple)),
          ],
        ),
        const CircleAvatar(radius: 28, backgroundImage: AssetImage("assets/images/girl2.png")),
      ],
    );
  }

  Widget _buildBannerCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset("assets/images/christmas-banner.png"),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _IconWithLabel(icon: Icons.card_giftcard, label: "Chọn quà\ để tặng"),
        _IconWithLabel(icon: Icons.send, label: "Gửi nhật ký\ncho nhau"),
        _IconWithLabel(icon: Icons.event_note, label: "Thêm kỷ niệm\nchung"),
      ],
    );
  }

  Widget _buildEventTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text("Sự kiện đã qua", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildEventList() {
    return Column(
      children: List.generate(3, (index) {
        return _buildDiaryCard(
          avatar: "assets/images/ring.png",
          name: "Trần Thị Như Mộng",
          time: "14 tháng 10 lúc 8:46",
          content: "STT hay sẽ giúp mỗi bài đăng...",
          image: "assets/images/ring.png",
        );
      }),
    );
  }

  Widget _buildDiaryCard({
    required String avatar,
    required String name,
    required String time,
    required String content,
    String? image,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 20, backgroundImage: AssetImage(avatar)),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(content),
            if (image != null) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(image),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 3,
      selectedItemColor: Colors.pinkAccent,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Chat"),
        BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: "Quà"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Yêu thích"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Hồ sơ"),
      ],
    );
  }
}

class _IconWithLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconWithLabel({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon, color: Colors.pinkAccent),
        ),
        const SizedBox(height: 4),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

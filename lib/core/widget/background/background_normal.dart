import 'package:flutter/material.dart';

class WelcomeBackgroundNormal extends StatefulWidget {
  final Widget child;

  const WelcomeBackgroundNormal({
    super.key,
    required this.child,
  });

  @override
  State<WelcomeBackgroundNormal> createState() => _WelcomeBackgroundNormalState();
}

class _WelcomeBackgroundNormalState extends State<WelcomeBackgroundNormal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _color1 = ColorTween(
      begin: const Color(0xFFD0A4F7),
      end: const Color(0xFFA3D7FF),
    ).animate(_controller);

    _color2 = ColorTween(
      begin: const Color(0xFFA3D7FF),
      end: const Color(0xFFD0A4F7),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double intersectionOffset = 190; // 👈 offset thấp hơn

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Stack(
          children: [
            // 1. Sóng nền xanh
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: InvertedWaveClipper(),
                child: Container(
                  height: size.height * 0.7,
                  color: const Color(0xFFA1B6ED),
                ),
              ),
            ),

            // 2. Gradient động cong lên
            ClipPath(
              clipper: BottomOvalClipper(intersectionOffset),
              child: Container(
                height: size.height * 0.7,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_color1.value!, _color2.value!],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
              ),
            ),

            // 3. Hình bán nguyệt trắng phía dưới
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: Size(size.width, size.height * 0.4),
                painter: WhiteCurvePainter(),
              ),
            ),

            // 4. Nội dung chính
            widget.child,
          ],
        );
      },
    );
  }
}

// Gradient bo cong
class BottomOvalClipper extends CustomClipper<Path> {
  final double offset;

  BottomOvalClipper(this.offset);

  @override
  Path getClip(Size size) {
    final path = Path();
    final base = size.height - 60 - offset;

    path.lineTo(0, base);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 80 - offset,
      size.width,
      base,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant BottomOvalClipper oldClipper) =>
      oldClipper.offset != offset;
}

// Sóng nền xanh
class InvertedWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 80);
    path.quadraticBezierTo(
      size.width / 2,
      -60,
      size.width,
      80,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WhiteCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 20); // 👈 Nâng điểm đầu lên một chút

    // Vẽ đường cong cubic nâng hai đầu
    path.cubicTo(
      size.width * 0.25, -size.height * 0.4, // điểm điều khiển trái
      size.width * 0.75, -size.height * 0.4, // điểm điều khiển phải
      size.width, 20,                        // điểm kết thúc cũng nâng lên
    );

    // Đóng phần dưới
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


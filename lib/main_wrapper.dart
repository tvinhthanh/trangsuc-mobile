import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class MainWrapper extends StatelessWidget {
  final Widget child;
  const MainWrapper({super.key, required this.child});

  int _locationToIndex(String location) {
    if (location.startsWith('/home') || location.startsWith('/products/:category') || location.startsWith('/') ) return 0;
    if (location.startsWith('/voiceRoom')|| location.startsWith('/live')|| location.startsWith('/cart')) return 1;
    if (location.startsWith('/utility') || location.startsWith('/diary')) return 2;
    if (location.startsWith('/blog') || location.startsWith('/cart')) return 3;
    if (location.startsWith('/profile') || location.startsWith('/setting')) return 4;
    return 5;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).routeInformationProvider.value.location;
    final currentIndex = _locationToIndex(location);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: child,
        bottomNavigationBar: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom + 35,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/nav_bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Container(
                height: kBottomNavigationBarHeight + 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: _navItem(
                        context,
                        icon: 'cart',
                        label: 'Giỏ hàng',
                        index: 1,
                        selected: currentIndex == 1,
                        onTap: () => context.go('/cart'),
                      ),
                    ),
                    Expanded(
                      child: _navItem(
                        context,
                        icon: 'chat',
                        label: 'Tin nhắn',
                        index: 1,
                        selected: currentIndex == 1,
                        onTap: () => context.go('/chat'),
                      ),
                    ),
                    
                    Expanded(
                      child: _navItem(
                        context,
                        icon: 'home',
                        label: 'Trang chủ',
                        index: 0,
                        selected: currentIndex == 0,
                        onTap: () => context.go('/home'),
                      ),
                    ),
                    Expanded(
                      child: _navItem(
                        context,
                        icon: 'utility',
                        label: 'Tiện ích',
                        index: 3,
                        selected: currentIndex == 3,
                        onTap: () => context.go('/utility'),
                      ),
                    ),
                    Expanded(
                      child: _navItem(
                        context,
                        icon: 'person',
                        label: 'Cá nhân',
                        index: 4,
                        selected: currentIndex == 4,
                        onTap: () => context.go('/profile'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    BuildContext context, {
    required String icon,
    required String label,
    required int index,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/$icon${selected ? "-active" : ""}.svg',
            width: 24,
            height: 24,
          ),
          const SizedBox(height: 4),
          if (selected) // chỉ hiển thị label khi selected == true
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF4D70CC),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

}

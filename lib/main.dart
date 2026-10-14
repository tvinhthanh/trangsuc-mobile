import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:jewelry_app/main_wrapper.dart';
import 'package:jewelry_app/models/product.dart';
import 'package:jewelry_app/pages/auth/auth_page.dart';
import 'package:jewelry_app/pages/cart/cart_page.dart';
import 'package:jewelry_app/pages/chat/advice_list_screen.dart';
import 'package:jewelry_app/pages/chat/chat_screen.dart';
import 'package:jewelry_app/pages/diary/diary_screen.dart';
import 'package:jewelry_app/pages/home/home_page.dart';
import 'package:jewelry_app/pages/product/product_list_by_category_screen.dart';
import 'package:jewelry_app/pages/profile/profile_page.dart';
import 'package:jewelry_app/pages/utility/utility_feature_screen.dart';
import 'package:jewelry_app/pages/welcome/animated_welcome_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load();
  // await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const JewelryApp());
}

class JewelryApp extends StatelessWidget {
  const JewelryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Jewelry App',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/welcome',
  routes: [
    GoRoute(path: '/welcome', builder: (context, state) => const AnimatedWelcomePage()),
    GoRoute(
      path: '/auth',
      pageBuilder: (context, state) {
        final mode = state.uri.queryParameters['mode'] ?? 'login';
        return CustomTransitionPage(
          child: AuthPage(mode: mode),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0); // bắt đầu từ dưới
            const end = Offset.zero; // kết thúc ở vị trí gốc
            final tween = Tween(begin: begin, end: end)
                .chain(CurveTween(curve: Curves.easeOutCubic));
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        );
      },
    ),
    // GoRoute(
    //     path: '/home',
    //     builder: (context, state) => const HomeScreen(),
    //   ),
    // GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
    // GoRoute(path: '/dokiep', builder: (context, state) => const DoKiepScreen()),
    // GoRoute(path: '/createVoiceRoom', builder: (context, state) => const CreateVoiceRoomScreen()),
    // GoRoute(path: '/chat', builder: (context, state) => const ChatScreen()),
    // GoRoute(
    //   path: '/room',
    //   builder: (context, state) {
    //     final roomType = RoomType.type6;
    //     return RoomScreenTemplate(
    //       videoWidget: buildYoutubeVideo(),
    //       seatWidget: SeatWidget(roomType: roomType),
    //       roomType: roomType,
    //     );
    //   },
    // ),
    // GoRoute(path: '/ranking', builder: (context, state) => const RankingScreen()),

    /// ShellRoute có BottomNav
    ShellRoute(
      builder: (context, state, child) => MainWrapper(child: child),
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(path: '/diary', builder: (context, state) => const DiaryScreen()),
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/products/:category',
          builder: (context, state) {
            final category = state.pathParameters['category']!;
            // Nếu bạn lưu danh sách sản phẩm toàn cục:
            final products = state.extra as List<ProductModel>;
            return ProductListByCategoryScreen(
              category: category,
              products: products,
            );
          },
        ),
        GoRoute(path: '/cart', builder: (context, state) => const CartPage()),
        GoRoute(path: '/utility', builder: (context, state) => const FeatureScreen()),
        GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
        GoRoute(path: '/chat', builder: (context, state) => const AdviceListScreen()),
        GoRoute(path: '/chat1', builder: (context, state) => const ChatScreen()),
        GoRoute(path: '/chat2', builder: (context, state) => const AdviceListScreen()),
        GoRoute(path: '/chat3', builder: (context, state) => const AdviceListScreen()),
      ],
    ),
  ],
);

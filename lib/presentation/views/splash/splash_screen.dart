import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicode_test/core/constants/app_session.dart';
import 'package:unicode_test/core/constants/image_constants.dart';
import 'package:unicode_test/core/injector.dart';
import 'package:unicode_test/data_access/cache/cache_helper.dart';
import 'package:unicode_test/core/router.dart';
import 'package:unicode_test/core/theme/styles.dart';
import 'package:unicode_test/presentation/shared_widgets/image_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    getAppRoute();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: ImageView(
                height: 100.r,
                string: ImageConstants.appIcon,
              ),
            ),
            SizedBox(height: 0.02.sh),
            FadeTransition(
              opacity: _animation,
              child: Text('Note App', style: TextStyles.bold_18),
            ),
          ],
        ),
      ),
    );
  }

  void getAppRoute() async {
    AppSession.UID = await injector.get<CacheHelper>().get('UID');

    await Future.delayed(const Duration(seconds: 3));

    if (AppSession.UID.isNotEmpty) {
      unawaited(Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false));
    } else {
      unawaited(Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SchoolBackground extends StatelessWidget {
  final Widget child;

  const SchoolBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: const Color(0xFFF8FAFC),
          ),
        ),

        Positioned.fill(
          child: Center(
            child: Opacity(
              opacity: 0.05,
              child: Image.asset(
                'assets/images/school_logo.jpg',
                width: 850.w,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),

        child,
      ],
    );
  }
}
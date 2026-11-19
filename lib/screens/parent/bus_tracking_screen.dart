import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/school_background.dart';

class BusTrackingScreen extends StatelessWidget {
  const BusTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SchoolBackground(
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.all(22.w),
              children: [
                const _Header(),
              SizedBox(height: 20.h),
              const _StatusCard(),
              SizedBox(height: 18.h),
              const _MapDemo(),
              SizedBox(height: 22.h),
              const _TripSteps(),
              SizedBox(height: 22.h),
                const _DriverCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_rounded, size: 24.sp),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            'تتبع الباص',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0F172A),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: const Color(0xFFFFF7ED),
            child: Icon(
              Icons.directions_bus_rounded,
              color: const Color(0xFFF59E0B),
              size: 30.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الباص قريب من المنزل',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.94),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'وقت الوصول المتوقع: 7 دقائق',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MapDemo extends StatelessWidget {
  const _MapDemo();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mapWidth = constraints.maxWidth;
        final mapHeight = 260.h;

        return Container(
          height: mapHeight,
          padding: EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(color: const Color(0xFFDCEBFF)),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _RoadPainter(),
                ),
              ),

              Positioned(
                right: 8.w,
                bottom: 22.h,
                child: const _MapPoint(
                  icon: Icons.home_rounded,
                  label: 'المنزل',
                  color: Color(0xFF22C55E),
                ),
              ),

              Positioned(
                left: 8.w,
                top: 22.h,
                child: const _MapPoint(
                  icon: Icons.school_rounded,
                  label: 'المدرسة',
                  color: Color(0xFF2563EB),
                ),
              ),

              Positioned(
                right: mapWidth * 0.28,
                bottom: mapHeight * 0.31,
                child: const _StudentMarker(),
              ),

              Positioned(
                left: mapWidth * 0.30,
                top: mapHeight * 0.38,
                child: const _BusMarker(),
              ),

              Positioned(
                right: 10.w,
                top: 10.h,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.92),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.satellite_alt_rounded,
                        color: const Color(0xFF2563EB),
                        size: 16.sp,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        'Live Demo Map',
                        style: TextStyle(
                          color: const Color(0xFF0F172A),
                          fontWeight: FontWeight.w900,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StudentMarker extends StatelessWidget {
  const _StudentMarker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.94, end: 1.06),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeInOut,
          builder: (context, scale, child) {
            return Transform.scale(scale: scale, child: child);
          },
          child: Container(
            width: 54.w,
            height: 54.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.94),
              borderRadius: BorderRadius.circular(22.r),
              border: Border.all(color: const Color(0xFF2563EB), width: 3.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 18.r,
                  offset: Offset(0, 8.h),
                ),
              ],
            ),
            child: Icon(
              Icons.face_rounded,
              color: const Color(0xFF2563EB),
              size: 31.sp,
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFF2563EB),
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: Text(
            'أحمد',
            style: TextStyle(
              color: Colors.white.withOpacity(0.94),
              fontWeight: FontWeight.w900,
              fontSize: 11.sp,
            ),
          ),
        ),
      ],
    );
  }
}

class _BusMarker extends StatelessWidget {
  const _BusMarker();

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -5.w, end: 5.w),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value, -value * 0.4),
          child: child,
        );
      },
      child: Container(
        width: 62.w,
        height: 62.w,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFBEB),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFF59E0B), width: 3.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.13),
              blurRadius: 18.r,
              offset: Offset(0, 8.h),
            ),
          ],
        ),
        child: Icon(
          Icons.directions_bus_filled_rounded,
          color: const Color(0xFFF59E0B),
          size: 34.sp,
        ),
      ),
    );
  }
}

class _MapPoint extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MapPoint({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24.r,
          backgroundColor: Colors.white,
          child: Icon(icon, color: color, size: 23.sp),
        ),
        SizedBox(height: 6.h),
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF0F172A),
            fontWeight: FontWeight.w900,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}

class _TripSteps extends StatelessWidget {
  const _TripSteps();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _TripStep(
          title: 'غادر الباص المدرسة',
          time: '7:05 صباحاً',
          active: true,
          done: true,
          icon: Icons.check_circle_rounded,
        ),
        _TripStep(
          title: 'الباص قريب من المنزل',
          time: 'الآن',
          active: true,
          done: false,
          icon: Icons.near_me_rounded,
        ),
        _TripStep(
          title: 'وصول الطالب',
          time: 'بعد 7 دقائق',
          active: false,
          done: false,
          icon: Icons.home_rounded,
        ),
      ],
    );
  }
}

class _TripStep extends StatelessWidget {
  final String title;
  final String time;
  final bool active;
  final bool done;
  final IconData icon;

  const _TripStep({
    required this.title,
    required this.time,
    required this.active,
    required this.done,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final color = done
        ? const Color(0xFF22C55E)
        : active
            ? const Color(0xFFF59E0B)
            : Colors.black38;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: active || done
              ? color.withOpacity(0.35)
              : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: color.withOpacity(0.12),
            child: Icon(icon, color: color, size: 21.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF0F172A),
                fontWeight: FontWeight.w900,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            time,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _DriverCard extends StatelessWidget {
  const _DriverCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.r,
            backgroundColor: const Color(0xFFEFF6FF),
            child: Icon(
              Icons.person_rounded,
              color: const Color(0xFF2563EB),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'السائق: أبو علي',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF0F172A),
                    fontWeight: FontWeight.w900,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'رقم الباص: B-204',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          SizedBox(
            height: 42.h,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF22C55E),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.call_rounded, size: 17.sp),
              label: Text(
                'اتصال',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final dashPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width - 45, size.height - 55)
      ..quadraticBezierTo(
        size.width * 0.62,
        size.height * 0.66,
        size.width * 0.52,
        size.height * 0.48,
      )
      ..quadraticBezierTo(
        size.width * 0.40,
        size.height * 0.25,
        55,
        58,
      );

    canvas.drawPath(path, roadPaint);
    canvas.drawPath(path, dashPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shared/announcements_screen.dart';
import '../shared/fees_screen.dart';
import 'homework_screen.dart';
import 'bus_tracking_screen.dart';
import 'grades_screen.dart';
import 'attendance_screen.dart';
import '../../widgets/school_background.dart';
class ParentDashboard extends StatelessWidget {
  const ParentDashboard({super.key});

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
              const _ParentHeader(),
              SizedBox(height: 22.h),
              const _StatusCard(),
              SizedBox(height: 16.h),
              const _InfoGrid(),
              SizedBox(height: 26.h),
              const _SectionTitle(
                title: 'آخر التحديثات',
                subtitle: 'Latest Updates',
              ),
              SizedBox(height: 14.h),
              const _UpdatesList(),
            ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ParentHeader extends StatelessWidget {
  const _ParentHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 58.w,
          height: 58.w,
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Icon(
            Icons.family_restroom_rounded,
            color: Colors.white.withOpacity(0.94),
            size: 26.sp,
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مرحباً ولي الأمر',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0F172A),
                ),
              ),
              Text(
                'Parent Portal',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 13.sp,
                ),
              ),
            ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'أحمد محمد علي',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withOpacity(0.94),
              fontSize: 24.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'الصف الرابع الابتدائي - الشعبة A',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: const Color(0xFF22C55E),
                size: 22.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'حاضر اليوم داخل المدرسة',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.94),
                    fontWeight: FontWeight.w800,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  const _InfoGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 14.h,
      crossAxisSpacing: 14.w,
      childAspectRatio: 1.18,
      children: [
        _InfoCard(
          title: 'المعدل العام',
          value: '89%',
          icon: Icons.trending_up_rounded,
          color: const Color(0xFF2563EB),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GradesScreen()),
            );
          },
        ),
        _InfoCard(
          title: 'نسبة الحضور',
          value: '96%',
          icon: Icons.verified_rounded,
          color: const Color(0xFF22C55E),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AttendanceScreen()),
            );
          },
        ),
        _InfoCard(
          title: 'القسط المتبقي',
          value: '200\$',
          icon: Icons.payments_rounded,
          color: const Color(0xFFF59E0B),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FeesScreen()),
            );
          },
        ),
        _InfoCard(
          title: 'واجبات جديدة',
          value: '3',
          icon: Icons.assignment_rounded,
          color: const Color(0xFF0F172A),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HomeworkScreen()),
            );
          },
        ),
        _InfoCard(
          title: 'تتبع الباص',
          value: '7 د',
          icon: Icons.directions_bus_filled_rounded,
          color: const Color(0xFF7C3AED),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BusTrackingScreen()),
            );
          },
        ),
        _InfoCard(
          title: 'الحائط الإعلاني',
          value: '4',
          icon: Icons.campaign_rounded,
          color: const Color(0xFFDC2626),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AnnouncementsScreen()),
            );
          },
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(26.r),
      child: Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.94),
          borderRadius: BorderRadius.circular(26.r),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28.sp),
            const Spacer(),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 21.sp,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF0F172A),
          ),
        ),
        const Spacer(),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.black38,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}

class _UpdatesList extends StatelessWidget {
  const _UpdatesList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 54.h,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F172A),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.r),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FeesScreen()),
              );
            },
            icon: Icon(Icons.payments_rounded, size: 20.sp),
            label: Text(
              'عرض الأقساط والمدفوعات',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 14.h),
        const _UpdateTile(
          title: 'تم تسجيل حضور أحمد الساعة 7:42 صباحاً',
          subtitle: 'Attendance Notification',
          icon: Icons.check_circle_rounded,
          color: Color(0xFF22C55E),
        ),
        const _UpdateTile(
          title: 'تم إضافة واجب رياضيات جديد',
          subtitle: 'Homework Update',
          icon: Icons.assignment_rounded,
          color: Color(0xFF2563EB),
        ),
        const _UpdateTile(
          title: 'القسط القادم مستحق بعد 7 أيام',
          subtitle: 'Payment Reminder',
          icon: Icons.payments_rounded,
          color: Color(0xFFF59E0B),
        ),
      ],
    );
  }
}

class _UpdateTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _UpdateTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: color.withOpacity(0.10),
            child: Icon(icon, color: color, size: 21.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF0F172A),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 12.sp,
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
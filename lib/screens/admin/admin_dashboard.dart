import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'students_screen.dart';
import 'teachers_screen.dart';
import 'attendance_screen.dart';
import 'admin_fees_screen.dart';
import '../../widgets/school_background.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

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
                SizedBox(height: 24.h),
                const _StatsGrid(),
                SizedBox(height: 26.h),
                const _SectionTitle(
                  title: 'إجراءات سريعة',
                  subtitle: 'Quick Actions',
                ),
                SizedBox(height: 14.h),
                const _QuickActions(),
                SizedBox(height: 26.h),
                const _SectionTitle(
                  title: 'آخر الإشعارات',
                  subtitle: 'Latest Updates',
                ),
                SizedBox(height: 14.h),
                const _NotificationsList(),
                SizedBox(height: 26.h),
                const _FeesSummary(),
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
    return Container(
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: [
          Container(
            width: 58.w,
            height: 58.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(6.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  'assets/images/school_logo.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مرحباً، إدارة المدرسة',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'مدرسة المستقبل الأهلية',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
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

class _StatsGrid extends StatelessWidget {
  const _StatsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 14.h,
      crossAxisSpacing: 14.w,
      childAspectRatio: 0.90,
      children: [
        _StatCard(
          title: 'الطلاب',
          value: '420',
          subtitle: 'Student',
          icon: Icons.groups_rounded,
          color: const Color(0xFF2563EB),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StudentsScreen()),
            );
          },
        ),
        _StatCard(
          title: 'المعلمون',
          value: '32',
          subtitle: 'Teachers',
          icon: Icons.badge_rounded,
          color: const Color(0xFF0F172A),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TeachersScreen()),
            );
          },
        ),
        _StatCard(
          title: 'غيابات اليوم',
          value: '18',
          subtitle: 'Absences',
          icon: Icons.event_busy_rounded,
          color: const Color(0xFFEF4444),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AttendanceScreen()),
            );
          },
        ),
        _StatCard(
          title: 'أقساط مستحقة',
          value: '12',
          subtitle: 'Due Fees',
          icon: Icons.payments_rounded,
          color: const Color(0xFFF59E0B),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AdminFeesScreen()),
            );
          },
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
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
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: color.withOpacity(0.10),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Icon(icon, color: color, size: 24.sp),
            ),
            const Spacer(),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
              ),
            ),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black38,
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
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 21.sp,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0F172A),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: _ActionCard(
            title: 'إضافة طالب',
            icon: Icons.person_add_alt_1_rounded,
          ),
        ),
        SizedBox(width: 12.w),
        const Expanded(
          child: _ActionCard(
            title: 'إرسال إعلان',
            icon: Icons.campaign_rounded,
          ),
        ),
        SizedBox(width: 12.w),
        const Expanded(
          child: _ActionCard(
            title: 'تقرير',
            icon: Icons.analytics_rounded,
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _ActionCard({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112.h,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF).withOpacity(0.94),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF2563EB), size: 28.sp),
          const Spacer(),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF0F172A),
              fontWeight: FontWeight.w900,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationsList extends StatelessWidget {
  const _NotificationsList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _NotificationTile(
          title: 'تم تسجيل 18 حالة غياب اليوم',
          subtitle: 'Attendance update',
          icon: Icons.event_busy_rounded,
          color: Color(0xFFEF4444),
        ),
        _NotificationTile(
          title: 'تم نشر إعلان جديد لأولياء الأمور',
          subtitle: 'Announcement sent',
          icon: Icons.campaign_rounded,
          color: Color(0xFF2563EB),
        ),
        _NotificationTile(
          title: '12 قسط مستحق هذا الأسبوع',
          subtitle: 'Fees reminder',
          icon: Icons.payments_rounded,
          color: Color(0xFFF59E0B),
        ),
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _NotificationTile({
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

class _FeesSummary extends StatelessWidget {
  const _FeesSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ملخص الأقساط',
            style: TextStyle(
              fontSize: 21.sp,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '76% من الأقساط الشهرية تم تسديدها حتى الآن.',
            style: TextStyle(
              color: Colors.black54,
              height: 1.5,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: LinearProgressIndicator(
              value: 0.76,
              minHeight: 10.h,
              backgroundColor: const Color(0xFFE2E8F0),
              color: const Color(0xFF22C55E),
            ),
          ),
        ],
      ),
    );
  }
}
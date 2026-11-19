import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../parent/grades_screen.dart';
import '../parent/attendance_screen.dart';
import '../parent/homework_screen.dart';
import '../shared/announcements_screen.dart';
import '../../widgets/school_background.dart';
class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

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
              const _StudentHeader(),
              SizedBox(height: 22.h),
              const _StudentProfileCard(),
              SizedBox(height: 16.h),
              _StudentStatsGrid(
                onGradesTap: () => _open(context, const GradesScreen()),
                onAttendanceTap: () => _open(context, const AttendanceScreen()),
                onHomeworkTap: () => _open(context, const HomeworkScreen()),
                onAnnouncementsTap: () => _open(context, const AnnouncementsScreen()),
              ),
              SizedBox(height: 26.h),
              const _SectionTitle(title: 'واجباتي', subtitle: 'Homework'),
              SizedBox(height: 14.h),
              const _HomeworkTile(
                subject: 'رياضيات',
                task: 'حل تمارين صفحة 42',
                status: 'اليوم',
                color: Color(0xFF2563EB),
              ),
              const _HomeworkTile(
                subject: 'علوم',
                task: 'قراءة الفصل الثالث',
                status: 'غداً',
                color: Color(0xFF22C55E),
              ),
              const _HomeworkTile(
                subject: 'لغة عربية',
                task: 'تحضير النص القادم',
                status: 'هذا الأسبوع',
                color: Color(0xFFF59E0B),
              ),
              SizedBox(height: 26.h),
              const _SectionTitle(title: 'الإعلانات', subtitle: 'Announcements'),
              SizedBox(height: 14.h),
              const _AnnouncementCard(),
            ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StudentHeader extends StatelessWidget {
  const _StudentHeader();

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
          child: Icon(Icons.person_rounded, color: Colors.white.withOpacity(0.94), size: 28.sp),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مرحباً أحمد',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0F172A),
                ),
              ),
              Text(
                'Student Portal',
                style: TextStyle(color: Colors.black45, fontSize: 13.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StudentProfileCard extends StatelessWidget {
  const _StudentProfileCard();

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
            style: TextStyle(
              color: Colors.white.withOpacity(0.94),
              fontSize: 24.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'الصف الرابع الابتدائي - الشعبة A',
            style: TextStyle(color: Colors.white70, fontSize: 13.sp),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Icon(Icons.calendar_month_rounded, color: const Color(0xFF22C55E), size: 22.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'اليوم لديك 3 حصص وواجبان',
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

class _StudentStatsGrid extends StatelessWidget {
  final VoidCallback onGradesTap;
  final VoidCallback onAttendanceTap;
  final VoidCallback onHomeworkTap;
  final VoidCallback onAnnouncementsTap;

  const _StudentStatsGrid({
    required this.onGradesTap,
    required this.onAttendanceTap,
    required this.onHomeworkTap,
    required this.onAnnouncementsTap,
  });

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
        _StatCard(
          title: 'المعدل العام',
          value: '89%',
          icon: Icons.trending_up_rounded,
          color: const Color(0xFF2563EB),
          onTap: onGradesTap,
        ),
        _StatCard(
          title: 'نسبة الحضور',
          value: '96%',
          icon: Icons.verified_rounded,
          color: const Color(0xFF22C55E),
          onTap: onAttendanceTap,
        ),
        _StatCard(
          title: 'واجبات نشطة',
          value: '3',
          icon: Icons.assignment_rounded,
          color: const Color(0xFFF59E0B),
          onTap: onHomeworkTap,
        ),
        _StatCard(
          title: 'إعلانات',
          value: '5',
          icon: Icons.campaign_rounded,
          color: const Color(0xFF0F172A),
          onTap: onAnnouncementsTap,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(26.r),
      onTap: onTap,
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
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              title,
              style: TextStyle(color: Colors.black54, fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeworkTile extends StatelessWidget {
  final String subject;
  final String task;
  final String status;
  final Color color;

  const _HomeworkTile({
    required this.subject,
    required this.task,
    required this.status,
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
            backgroundColor: color.withOpacity(0.10),
            child: Icon(Icons.assignment_rounded, color: color),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject, style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                SizedBox(height: 3.h),
                Text(task, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          Text(status, style: TextStyle(color: Colors.black38, fontSize: 12.sp)),
        ],
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  const _AnnouncementCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(26.r),
      ),
      child: Row(
        children: [
          Icon(Icons.campaign_rounded, color: const Color(0xFF2563EB), size: 30.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'غداً عطلة رسمية بمناسبة مناسبة وطنية. يرجى متابعة الإعلانات القادمة.',
              style: TextStyle(
                color: const Color(0xFF0F172A),
                fontWeight: FontWeight.w800,
                height: 1.5,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
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
        Text(title, style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.w900, color: const Color(0xFF0F172A))),
        const Spacer(),
        Text(subtitle, style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w700, fontSize: 12.sp)),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/school_background.dart';
class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homework = [
      {
        'subject': 'رياضيات',
        'task': 'حل تمارين صفحة 42',
        'due': 'اليوم - 8:00 م',
        'status': 'جديد',
        'icon': Icons.calculate_rounded,
        'color': const Color(0xFF2563EB),
      },
      {
        'subject': 'علوم',
        'task': 'قراءة الفصل الثالث وتحضير الأسئلة',
        'due': 'غداً',
        'status': 'قيد العمل',
        'icon': Icons.science_rounded,
        'color': const Color(0xFF22C55E),
      },
      {
        'subject': 'لغة عربية',
        'task': 'تحضير النص القادم',
        'due': 'هذا الأسبوع',
        'status': 'مفتوح',
        'icon': Icons.menu_book_rounded,
        'color': const Color(0xFFF59E0B),
      },
    ];

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
              const _MainCard(),
              SizedBox(height: 24.h),
              Text(
                'قائمة الواجبات',
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 14.h),
              ...homework.map((item) {
                return _HomeworkTile(
                  subject: item['subject'] as String,
                  task: item['task'] as String,
                  due: item['due'] as String,
                  status: item['status'] as String,
                  icon: item['icon'] as IconData,
                  color: item['color'] as Color,
                );
              }),
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
            'الواجبات',
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

class _MainCard extends StatelessWidget {
  const _MainCard();

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
          Icon(
            Icons.assignment_rounded,
            color: Colors.white.withOpacity(0.94),
            size: 38.sp,
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '3 واجبات جديدة',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.94),
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'متابعة واجبات الطالب حسب المادة وموعد التسليم.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white70,
                    height: 1.5,
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

class _HomeworkTile extends StatelessWidget {
  final String subject;
  final String task;
  final String due;
  final String status;
  final IconData icon;
  final Color color;

  const _HomeworkTile({
    required this.subject,
    required this.task,
    required this.due,
    required this.status,
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
        borderRadius: BorderRadius.circular(24.r),
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
                  subject,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF0F172A),
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  task,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black54,
                    height: 1.4,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  due,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: color.withOpacity(0.10),
              borderRadius: BorderRadius.circular(999.r),
            ),
            child: Text(
              status,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w900,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
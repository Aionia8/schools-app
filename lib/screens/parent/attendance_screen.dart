import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/school_background.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final records = [
      {
        'day': 'الأحد',
        'date': '2026/05/24',
        'status': 'حاضر',
        'time': '7:42 ص',
        'icon': Icons.check_circle_rounded,
        'color': const Color(0xFF22C55E),
      },
      {
        'day': 'الاثنين',
        'date': '2026/05/25',
        'status': 'حاضر',
        'time': '7:39 ص',
        'icon': Icons.check_circle_rounded,
        'color': const Color(0xFF22C55E),
      },
      {
        'day': 'الثلاثاء',
        'date': '2026/05/26',
        'status': 'متأخر',
        'time': '8:12 ص',
        'icon': Icons.schedule_rounded,
        'color': const Color(0xFFF59E0B),
      },
      {
        'day': 'الأربعاء',
        'date': '2026/05/27',
        'status': 'غائب',
        'time': '-',
        'icon': Icons.cancel_rounded,
        'color': const Color(0xFFEF4444),
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
              _Header(),
              SizedBox(height: 20.h),
              const _MainCard(),
              SizedBox(height: 18.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: const [
                  _MiniCard(
                    title: 'حضور',
                    value: '142',
                    icon: Icons.check_circle_rounded,
                    color: Color(0xFF22C55E),
                  ),
                  _MiniCard(
                    title: 'غياب',
                    value: '4',
                    icon: Icons.cancel_rounded,
                    color: Color(0xFFEF4444),
                  ),
                  _MiniCard(
                    title: 'تأخر',
                    value: '3',
                    icon: Icons.schedule_rounded,
                    color: Color(0xFFF59E0B),
                  ),
                  _MiniCard(
                    title: 'الشهر الحالي',
                    value: '98%',
                    icon: Icons.calendar_month_rounded,
                    color: Color(0xFF2563EB),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Text(
                'سجل آخر الأيام',
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 14.h),
              ...records.map((item) {
                return _AttendanceTile(
                  day: item['day'] as String,
                  date: item['date'] as String,
                  status: item['status'] as String,
                  time: item['time'] as String,
                  icon: item['icon'] as IconData,
                  color: item['color'] as Color,
                );
              }),
              SizedBox(height: 18.h),
              const _NoteCard(),
              ],
            
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
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
            'الحضور والغياب',
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
          CircleAvatar(
            radius: 30.r,
            backgroundColor: const Color(0xFFEAFBF1),
            child: Icon(
              Icons.verified_rounded,
              color: const Color(0xFF22C55E),
              size: 32.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'نسبة الحضور 96%',
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
                  'حضور ممتاز مع ملاحظة حالة تأخر واحدة هذا الأسبوع.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white70,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
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

class _MiniCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MiniCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final itemWidth = (MediaQuery.of(context).size.width - 56.w) / 2;

    return SizedBox(
      width: itemWidth,
      child: Container(
        height: 122.h,
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.94),
          borderRadius: BorderRadius.circular(26.r),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24.sp),
            const Spacer(),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF0F172A),
                fontSize: 25.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
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

class _AttendanceTile extends StatelessWidget {
  final String day;
  final String date;
  final String status;
  final String time;
  final IconData icon;
  final Color color;

  const _AttendanceTile({
    required this.day,
    required this.date,
    required this.status,
    required this.time,
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
                  day,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF0F172A),
                    fontWeight: FontWeight.w900,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  date,
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
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                status,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w900,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                time,
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
        ],
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEAFBF1).withOpacity(0.94),
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: const Color(0xFFBBF7D0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            color: const Color(0xFF22C55E),
            size: 22.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'ملاحظة: نسبة حضور الطالب ممتازة. ينصح فقط بالمتابعة لتقليل حالات التأخر الصباحي.',
              style: TextStyle(
                color: const Color(0xFF166534),
                height: 1.5,
                fontWeight: FontWeight.w700,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
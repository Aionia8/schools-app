import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/school_background.dart';
class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final announcements = [
      {
        'title': 'عطلة رسمية',
        'body': 'غداً عطلة رسمية، وسيتم استئناف الدوام يوم الأحد.',
        'time': 'منذ 10 دقائق',
        'icon': Icons.campaign_rounded,
        'color': const Color(0xFF2563EB),
      },
      {
        'title': 'تذكير بالأقساط',
        'body': 'يرجى تسديد القسط الشهري قبل نهاية هذا الأسبوع.',
        'time': 'اليوم',
        'icon': Icons.payments_rounded,
        'color': const Color(0xFFF59E0B),
      },
      {
        'title': 'نشاط مدرسي',
        'body': 'سيتم تنظيم نشاط علمي لطلاب الصف الرابع يوم الخميس.',
        'time': 'أمس',
        'icon': Icons.science_rounded,
        'color': const Color(0xFF22C55E),
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
              SizedBox(height: 24.h),
              const _MainCard(),
              SizedBox(height: 24.h),
              ...announcements.map((item) {
                return _AnnouncementTile(
                  title: item['title'] as String,
                  body: item['body'] as String,
                  time: item['time'] as String,
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
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_rounded, size: 24.sp),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'الحائط الإعلاني',
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
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'School Announcements',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.campaign_rounded,
            color: Colors.white.withOpacity(0.94),
            size: 34.sp,
          ),
          SizedBox(height: 14.h),
          Text(
            'مركز التبليغات الرسمي',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withOpacity(0.94),
              fontSize: 22.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'جميع إعلانات المدرسة، العطل، النشاطات والتنبيهات تظهر هنا بشكل منظم بدل مجموعات الواتساب.',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white70,
              height: 1.6,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnnouncementTile extends StatelessWidget {
  final String title;
  final String body;
  final String time;
  final IconData icon;
  final Color color;

  const _AnnouncementTile({
    required this.title,
    required this.body,
    required this.time,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  body,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black54,
                    height: 1.5,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  time,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
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
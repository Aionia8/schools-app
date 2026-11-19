import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/school_background.dart';
class GradesScreen extends StatelessWidget {
  const GradesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = [
      {
        'name': 'رياضيات',
        'grade': 95,
        'note': 'ممتاز جداً',
        'icon': Icons.calculate_rounded,
        'color': const Color(0xFF2563EB),
      },
      {
        'name': 'علوم',
        'grade': 88,
        'note': 'جيد جداً',
        'icon': Icons.science_rounded,
        'color': const Color(0xFF22C55E),
      },
      {
        'name': 'لغة عربية',
        'grade': 91,
        'note': 'ممتاز',
        'icon': Icons.menu_book_rounded,
        'color': const Color(0xFFF59E0B),
      },
      {
        'name': 'إنكليزي',
        'grade': 83,
        'note': 'جيد جداً',
        'icon': Icons.language_rounded,
        'color': const Color(0xFF7C3AED),
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
              SizedBox(height: 18.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: const [
                  _MiniCard(
                    title: 'أعلى درجة',
                    value: '95%',
                    icon: Icons.workspace_premium_rounded,
                    color: Color(0xFF22C55E),
                  ),
                  _MiniCard(
                    title: 'أقل درجة',
                    value: '83%',
                    icon: Icons.warning_amber_rounded,
                    color: Color(0xFFF59E0B),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Text(
                'درجات المواد',
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 14.h),
              ...subjects.map((item) {
                return _SubjectGradeCard(
                  name: item['name'] as String,
                  grade: item['grade'] as int,
                  note: item['note'] as String,
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
            'الدرجات',
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
            backgroundColor: const Color(0xFFEFF6FF),
            child: Icon(
              Icons.trending_up_rounded,
              color: const Color(0xFF2563EB),
              size: 32.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'المعدل العام 89%',
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
                  'أداء أحمد هذا الفصل مستقر وجيد جداً.',
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

class _SubjectGradeCard extends StatelessWidget {
  final String name;
  final int grade;
  final String note;
  final IconData icon;
  final Color color;

  const _SubjectGradeCard({
    required this.name,
    required this.grade,
    required this.note,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = grade / 100;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: color.withOpacity(0.10),
                child: Icon(icon, color: color, size: 21.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF0F172A),
                    fontWeight: FontWeight.w900,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '$grade%',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w900,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(999.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 9.h,
              backgroundColor: const Color(0xFFE2E8F0),
              color: color,
            ),
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              note,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
              ),
            ),
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
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: const Color(0xFFDCEBFF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            color: const Color(0xFF2563EB),
            size: 22.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'ملاحظة: الطالب ممتاز في الرياضيات ويحتاج متابعة بسيطة في مادة الإنكليزي لرفع المعدل العام.',
              style: TextStyle(
                color: const Color(0xFF1E3A8A),
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
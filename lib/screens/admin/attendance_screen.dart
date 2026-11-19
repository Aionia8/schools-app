import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/school_background.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String selectedDate = 'اليوم';

  final List<Map<String, String>> absences = const [
    {
      'name': 'حسن كريم جاسم',
      'class': 'الخامس الابتدائي',
      'section': 'B',
      'reason': 'مرض',
      'parentStatus': 'تم التواصل',
      'count': '6',
    },
    {
      'name': 'علي حسين عباس',
      'class': 'السادس الابتدائي',
      'section': 'C',
      'reason': 'بدون سبب',
      'parentStatus': 'لم يتم التواصل',
      'count': '9',
    },
    {
      'name': 'نور أحمد سالم',
      'class': 'الرابع الابتدائي',
      'section': 'A',
      'reason': 'سفر',
      'parentStatus': 'تم التواصل',
      'count': '4',
    },
    {
      'name': 'محمد قاسم علي',
      'class': 'الثالث الابتدائي',
      'section': 'A',
      'reason': 'تأخر صباحي',
      'parentStatus': 'بانتظار الرد',
      'count': '7',
    },
  ];

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
              const _PageHeader(),
              SizedBox(height: 22.h),
              const _SummaryCard(),
              SizedBox(height: 18.h),
              const _StatsRow(),
              SizedBox(height: 20.h),
              _DateFilter(
                selectedDate: selectedDate,
                onChanged: (value) {
                  setState(() {
                    selectedDate = value;
                  });
                },
              ),
              SizedBox(height: 22.h),
              const _SectionTitle(
                title: 'قائمة الغائبين',
                subtitle: 'Absent Students',
              ),
              SizedBox(height: 14.h),
              ...absences.map((student) {
                return _AbsenceTile(
                  name: student['name']!,
                  studentClass: student['class']!,
                  section: student['section']!,
                  reason: student['reason']!,
                  parentStatus: student['parentStatus']!,
                  count: student['count']!,
                );
              }),
              SizedBox(height: 22.h),
              const _SectionTitle(
                title: 'الأكثر غياباً',
                subtitle: 'Most Absent',
              ),
              SizedBox(height: 14.h),
              ...absences.map((student) {
                return _MostAbsentTile(
                  name: student['name']!,
                  studentClass: student['class']!,
                  count: student['count']!,
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

class _PageHeader extends StatelessWidget {
  const _PageHeader();

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'غيابات اليوم',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                'Attendance & Absence Tracking',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
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

class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

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
            Icons.event_busy_rounded,
            color: Colors.white,
            size: 38.sp,
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '18 حالة غياب اليوم',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'متابعة الغياب، أسباب الغياب، والتواصل مع أولياء الأمور.',
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

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: const [
        _MiniStatCard(
          title: 'تم التواصل',
          value: '12',
          color: Color(0xFF22C55E),
          icon: Icons.call_rounded,
        ),
        _MiniStatCard(
          title: 'بانتظار الرد',
          value: '6',
          color: Color(0xFFF59E0B),
          icon: Icons.hourglass_bottom_rounded,
        ),
      ],
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _MiniStatCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
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
                fontSize: 26.sp,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF0F172A),
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

class _DateFilter extends StatelessWidget {
  final String selectedDate;
  final ValueChanged<String> onChanged;

  const _DateFilter({
    required this.selectedDate,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final dates = [
      'اليوم',
      'أمس',
      'هذا الأسبوع',
      'هذا الشهر',
    ];

    return SizedBox(
      height: 44.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final item = dates[index];
          final active = item == selectedDate;

          return GestureDetector(
            onTap: () => onChanged(item),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: active ? const Color(0xFFEF4444) : Colors.white.withOpacity(0.94),
                borderRadius: BorderRadius.circular(999.r),
                border: Border.all(
                  color: active
                      ? const Color(0xFFEF4444)
                      : const Color(0xFFE2E8F0),
                ),
              ),
              child: Text(
                item,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: active ? Colors.white : const Color(0xFF0F172A),
                  fontWeight: FontWeight.w900,
                  fontSize: 13.sp,
                ),
              ),
            ),
          );
        },
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

class _AbsenceTile extends StatelessWidget {
  final String name;
  final String studentClass;
  final String section;
  final String reason;
  final String parentStatus;
  final String count;

  const _AbsenceTile({
    required this.name,
    required this.studentClass,
    required this.section,
    required this.reason,
    required this.parentStatus,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final bool contacted = parentStatus == 'تم التواصل';
    final bool waiting = parentStatus == 'بانتظار الرد';

    final Color statusColor = contacted
        ? const Color(0xFF22C55E)
        : waiting
            ? const Color(0xFFF59E0B)
            : const Color(0xFFEF4444);

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
                radius: 23.r,
                backgroundColor: const Color(0xFFFEE2E2),
                child: Icon(
                  Icons.person_off_rounded,
                  color: const Color(0xFFEF4444),
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color(0xFF0F172A),
                        fontWeight: FontWeight.w900,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '$studentClass - الشعبة $section',
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
              _StatusPill(text: parentStatus, color: statusColor),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: _InfoBox(
                  title: 'سبب الغياب',
                  value: reason,
                  color: const Color(0xFF2563EB),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _InfoBox(
                  title: 'عدد الغيابات',
                  value: count,
                  color: const Color(0xFFEF4444),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MostAbsentTile extends StatelessWidget {
  final String name;
  final String studentClass;
  final String count;

  const _MostAbsentTile({
    required this.name,
    required this.studentClass,
    required this.count,
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
            radius: 21.r,
            backgroundColor: const Color(0xFFFEE2E2),
            child: Icon(
              Icons.warning_amber_rounded,
              color: const Color(0xFFEF4444),
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF0F172A),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  studentClass,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            '$count غياب',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFFEF4444),
              fontWeight: FontWeight.w900,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _InfoBox({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String text;
  final Color color;

  const _StatusPill({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 96.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
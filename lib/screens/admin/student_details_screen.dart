import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/school_background.dart';

class StudentDetailsScreen extends StatelessWidget {
  final Map<String, String> student;

  const StudentDetailsScreen({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    final status = student['status'] ?? 'حاضر';
    final isAbsent = status == 'غائب';
    final isLate = status == 'متأخر';

    final statusColor = isAbsent
        ? const Color(0xFFEF4444)
        : isLate
            ? const Color(0xFFF59E0B)
            : const Color(0xFF22C55E);

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
              SizedBox(height: 20.h),
              _ProfileCard(student: student, status: status, statusColor: statusColor),
              SizedBox(height: 18.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: const [
                  _MiniStatCard(
                    title: 'المعدل',
                    value: '89%',
                    icon: Icons.trending_up_rounded,
                    color: Color(0xFF2563EB),
                  ),
                  _MiniStatCard(
                    title: 'الحضور',
                    value: '96%',
                    icon: Icons.verified_rounded,
                    color: Color(0xFF22C55E),
                  ),
                  _MiniStatCard(
                    title: 'الغيابات',
                    value: '4',
                    icon: Icons.event_busy_rounded,
                    color: Color(0xFFEF4444),
                  ),
                  _MiniStatCard(
                    title: 'المتبقي',
                    value: '200\$',
                    icon: Icons.payments_rounded,
                    color: Color(0xFFF59E0B),
                  ),
                ],
              ),
              SizedBox(height: 26.h),
              const _SectionTitle(title: 'الدرجات', subtitle: 'Grades'),
              SizedBox(height: 12.h),
              const _InfoTile(
                icon: Icons.calculate_rounded,
                title: 'رياضيات',
                subtitle: '92%',
                color: Color(0xFF2563EB),
              ),
              const _InfoTile(
                icon: Icons.science_rounded,
                title: 'علوم',
                subtitle: '88%',
                color: Color(0xFF22C55E),
              ),
              const _InfoTile(
                icon: Icons.menu_book_rounded,
                title: 'لغة عربية',
                subtitle: '85%',
                color: Color(0xFFF59E0B),
              ),
              SizedBox(height: 24.h),
              const _SectionTitle(title: 'الأقساط', subtitle: 'Fees'),
              SizedBox(height: 12.h),
              const _InfoTile(
                icon: Icons.check_circle_rounded,
                title: 'المدفوع',
                subtitle: '750,000 د.ع',
                color: Color(0xFF22C55E),
              ),
              const _InfoTile(
                icon: Icons.pending_actions_rounded,
                title: 'المتبقي',
                subtitle: '450,000 د.ع',
                color: Color(0xFFF59E0B),
              ),
              SizedBox(height: 24.h),
              const _SectionTitle(title: 'ولي الأمر', subtitle: 'Guardian'),
              SizedBox(height: 12.h),
              const _InfoTile(
                icon: Icons.person_rounded,
                title: 'محمد علي',
                subtitle: 'والد الطالب',
                color: Color(0xFF0F172A),
              ),
              const _InfoTile(
                icon: Icons.call_rounded,
                title: '0770 000 0000',
                subtitle: 'رقم التواصل',
                color: Color(0xFF2563EB),
              ),
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
          child: Text(
            'ملف الطالب',
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

class _ProfileCard extends StatelessWidget {
  final Map<String, String> student;
  final String status;
  final Color statusColor;

  const _ProfileCard({
    required this.student,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 44.r,
            backgroundColor: Colors.white.withOpacity(0.12),
            backgroundImage: (student['image'] ?? '').isNotEmpty
                ? NetworkImage(student['image']!)
                : null,
            child: (student['image'] ?? '').isEmpty
                ? Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 42.sp,
                  )
                : null,
          ),
          SizedBox(height: 14.h),
          Text(
            student['name'] ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.94),
              fontSize: 24.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            '${student['class']} - الشعبة ${student['section']}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white70, fontSize: 13.sp),
          ),
          SizedBox(height: 14.h),
          _StatusPill(text: status, color: statusColor),
        ],
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MiniStatCard({
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
                fontSize: 25.sp,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF0F172A),
              ),
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black54, fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
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
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: const Color(0xFF0F172A),
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 13.sp,
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
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
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
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
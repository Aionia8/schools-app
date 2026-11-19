import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/school_background.dart';
class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  final List<Map<String, dynamic>> students = [
    {'name': 'أحمد محمد', 'present': true},
    {'name': 'زينب علي', 'present': true},
    {'name': 'حسن كريم', 'present': false},
    {'name': 'مريم خالد', 'present': true},
  ];

  void _showSalaryDetails() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const _SalaryDetailsSheet(),
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
              const _TeacherHeader(),
              SizedBox(height: 22.h),
              const _ClassCard(),
              SizedBox(height: 16.h),
              _SalaryCard(onTap: _showSalaryDetails),
              SizedBox(height: 26.h),

              const _SectionTitle(
                title: 'تسجيل الحضور',
                subtitle: 'Attendance',
              ),
              SizedBox(height: 14.h),

              ...students.map((student) {
                return _StudentAttendanceTile(
                  name: student['name'],
                  present: student['present'],
                  onChanged: (value) {
                    setState(() {
                      student['present'] = value;
                    });
                  },
                );
              }),

              SizedBox(height: 12.h),

              SizedBox(
                height: 56.h,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.save_rounded, size: 21.sp),
                  label: Text(
                    'حفظ الحضور',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 28.h),

              const _SectionTitle(
                title: 'إجراءات سريعة',
                subtitle: 'Quick Actions',
              ),
              SizedBox(height: 14.h),

              Row(
                children: [
                  const Expanded(
                    child: _ActionCard(
                      title: 'إضافة واجب',
                      icon: Icons.assignment_add,
                      color: Color(0xFF2563EB),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  const Expanded(
                    child: _ActionCard(
                      title: 'إدخال درجات',
                      icon: Icons.grade_rounded,
                      color: Color(0xFFF59E0B),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 26.h),

              const _SectionTitle(
                title: 'واجبات اليوم',
                subtitle: 'Homework',
              ),
              SizedBox(height: 14.h),

              const _HomeworkCard(
                subject: 'رياضيات',
                task: 'حل تمارين صفحة 42',
                time: 'اليوم - 8:00 م',
              ),
              const _HomeworkCard(
                subject: 'علوم',
                task: 'قراءة الفصل الثالث',
                time: 'غداً',
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TeacherHeader extends StatelessWidget {
  const _TeacherHeader();

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
          child: Icon(Icons.edit_note_rounded, color: Colors.white.withOpacity(0.94), size: 28.sp),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مرحباً أستاذة سارة',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0F172A),
                ),
              ),
              Text(
                'Teacher Portal',
                style: TextStyle(color: Colors.black45, fontSize: 13.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ClassCard extends StatelessWidget {
  const _ClassCard();

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
            'الصف الرابع الابتدائي',
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
            'الشعبة A - مادة الرياضيات',
            style: TextStyle(color: Colors.white70, fontSize: 13.sp),
          ),
          SizedBox(height: 18.h),
          Row(
            children: [
              Icon(Icons.groups_rounded, color: const Color(0xFF22C55E), size: 22.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  '32 طالب مسجل في هذا الصف',
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

class _SalaryCard extends StatelessWidget {
  final VoidCallback onTap;

  const _SalaryCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.94),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor: const Color(0xFFEAFBF1),
              child: Icon(
                Icons.payments_rounded,
                color: const Color(0xFF22C55E),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الراتب الشهري',
                    style: TextStyle(
                      color: const Color(0xFF0F172A),
                      fontWeight: FontWeight.w900,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'عرض تفاصيل الراتب والحوافز والاستقطاعات',
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '810,000',
                  style: TextStyle(
                    color: const Color(0xFF22C55E),
                    fontWeight: FontWeight.w900,
                    fontSize: 15.sp,
                  ),
                ),
                Text(
                  'د.ع',
                  style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w700,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
            SizedBox(width: 8.w),
            Icon(Icons.arrow_back_ios_new_rounded, size: 15.sp, color: Colors.black26),
          ],
        ),
      ),
    );
  }
}

class _SalaryDetailsSheet extends StatelessWidget {
  const _SalaryDetailsSheet();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.all(22.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.94),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(999.r),
              ),
            ),
            SizedBox(height: 18.h),
            Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: const Color(0xFFEAFBF1),
                  child: Icon(Icons.payments_rounded, color: const Color(0xFF22C55E), size: 24.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'تفاصيل الراتب الشهري',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.h),
            const _SalaryRow(title: 'الراتب الأساسي', value: '750,000 د.ع', color: Color(0xFF2563EB)),
            const _SalaryRow(title: 'الحوافز', value: '75,000 د.ع', color: Color(0xFF22C55E)),
            const _SalaryRow(title: 'الاستقطاعات', value: '15,000 د.ع', color: Color(0xFFEF4444)),
            const _SalaryRow(title: 'الصافي', value: '810,000 د.ع', color: Color(0xFF0F172A)),
            const _SalaryRow(title: 'آخر دفعة', value: '2026/05/01', color: Color(0xFFF59E0B)),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}

class _SalaryRow extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _SalaryRow({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: const Color(0xFF0F172A),
                fontWeight: FontWeight.w900,
                fontSize: 14.sp,
              ),
            ),
          ),
          Text(
            value,
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

class _StudentAttendanceTile extends StatelessWidget {
  final String name;
  final bool present;
  final ValueChanged<bool> onChanged;

  const _StudentAttendanceTile({
    required this.name,
    required this.present,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final color = present ? const Color(0xFF22C55E) : const Color(0xFFEF4444);

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
            child: Icon(
              present ? Icons.check_rounded : Icons.close_rounded,
              color: color,
              size: 21.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
          Switch(
            value: present,
            activeColor: const Color(0xFF22C55E),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _ActionCard({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30.sp),
          const Spacer(),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16.sp,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeworkCard extends StatelessWidget {
  final String subject;
  final String task;
  final String time;

  const _HomeworkCard({
    required this.subject,
    required this.task,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: const Color(0xFFEFF6FF),
            child: Icon(Icons.assignment_rounded, color: const Color(0xFF2563EB), size: 21.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF0F172A),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  task,
                  style: TextStyle(color: Colors.black54, fontSize: 13.sp),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.black38,
              fontSize: 12.sp,
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
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
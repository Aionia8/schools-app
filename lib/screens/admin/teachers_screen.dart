import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'teacher_details_screen.dart';
import '../../widgets/school_background.dart';

class TeachersScreen extends StatefulWidget {
  const TeachersScreen({super.key});

  @override
  State<TeachersScreen> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  String selectedSubject = 'الكل';

  final List<Map<String, String>> teachers = const [
    {
      'name': 'أ. سارة أحمد',
      'subject': 'رياضيات',
      'classes': 'الرابع والخامس',
      'status': 'نشط',
      'salary': '750,000 د.ع',
      'lastPayment': '2026/05/01',
      'salaryStatus': 'مدفوع',
      'image': 'https://i.pravatar.cc/150?img=47',
    },
    {
      'name': 'أ. علي حسين',
      'subject': 'علوم',
      'classes': 'الثالث والرابع',
      'status': 'نشط',
      'salary': '700,000 د.ع',
      'lastPayment': '2026/05/01',
      'salaryStatus': 'مدفوع',
      'image': 'https://i.pravatar.cc/150?img=33',
    },
    {
      'name': 'أ. مريم خالد',
      'subject': 'لغة عربية',
      'classes': 'السادس',
      'status': 'إجازة',
      'salary': '680,000 د.ع',
      'lastPayment': '2026/04/01',
      'salaryStatus': 'قيد المراجعة',
      'image': 'https://i.pravatar.cc/150?img=44',
    },
    {
      'name': 'أ. حسن كريم',
      'subject': 'إنكليزي',
      'classes': 'الأول والثاني',
      'status': 'نشط',
      'salary': '720,000 د.ع',
      'lastPayment': '2026/04/01',
      'salaryStatus': 'مستحق',
      'image': 'https://i.pravatar.cc/150?img=15',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredTeachers = selectedSubject == 'الكل'
        ? teachers
        : teachers.where((teacher) => teacher['subject'] == selectedSubject).toList();

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
              const _PayrollSummary(),
              SizedBox(height: 20.h),
              _SubjectFilter(
                selectedSubject: selectedSubject,
                onChanged: (value) {
                  setState(() {
                    selectedSubject = value;
                  });
                },
              ),
              SizedBox(height: 18.h),
              Text(
                'قائمة المعلمين (${filteredTeachers.length})',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 14.h),
              ...filteredTeachers.map((teacher) {
                return _TeacherTile(
                  teacher: teacher,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TeacherDetailsScreen(teacher: teacher),
                      ),
                    );
                  },
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
                'المعلمون والرواتب',
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
                'Teachers & Payroll Management',
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
          Icon(Icons.badge_rounded, color: Colors.white, size: 38.sp),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '32 معلم مسجل',
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
                  'إدارة بيانات المعلمين، المواد، الصفوف، وحالة الرواتب الشهرية.',
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

class _PayrollSummary extends StatelessWidget {
  const _PayrollSummary();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: const [
        _PayrollMiniCard(
          title: 'إجمالي الرواتب',
          value: '24.5M',
          suffix: 'د.ع',
          color: Color(0xFF2563EB),
          icon: Icons.account_balance_wallet_rounded,
        ),
        _PayrollMiniCard(
          title: 'رواتب مستحقة',
          value: '3',
          suffix: 'معلمين',
          color: Color(0xFFF59E0B),
          icon: Icons.pending_actions_rounded,
        ),
      ],
    );
  }
}

class _PayrollMiniCard extends StatelessWidget {
  final String title;
  final String value;
  final String suffix;
  final Color color;
  final IconData icon;

  const _PayrollMiniCard({
    required this.title,
    required this.value,
    required this.suffix,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final itemWidth = (MediaQuery.of(context).size.width - 56.w) / 2;

    return SizedBox(
      width: itemWidth,
      child: Container(
        height: 132.h,
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
                fontSize: 23.sp,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF0F172A),
              ),
            ),
            Text(
              suffix,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black38, fontSize: 12.sp),
            ),
            SizedBox(height: 4.h),
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

class _SubjectFilter extends StatelessWidget {
  final String selectedSubject;
  final ValueChanged<String> onChanged;

  const _SubjectFilter({
    required this.selectedSubject,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final subjects = ['الكل', 'رياضيات', 'علوم', 'لغة عربية', 'إنكليزي'];

    return SizedBox(
      height: 44.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: subjects.length,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final item = subjects[index];
          final active = item == selectedSubject;

          return GestureDetector(
            onTap: () => onChanged(item),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: active ? const Color(0xFF2563EB) : Colors.white.withOpacity(0.94),
                borderRadius: BorderRadius.circular(999.r),
                border: Border.all(
                  color: active
                      ? const Color(0xFF2563EB)
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

class _TeacherTile extends StatelessWidget {
  final Map<String, String> teacher;
  final VoidCallback onTap;

  const _TeacherTile({
    required this.teacher,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final name = teacher['name'] ?? '';
    final subject = teacher['subject'] ?? '';
    final classes = teacher['classes'] ?? '';
    final status = teacher['status'] ?? '';
    final salary = teacher['salary'] ?? '';
    final lastPayment = teacher['lastPayment'] ?? '';
    final salaryStatus = teacher['salaryStatus'] ?? '';

    final bool isActive = status == 'نشط';
    final bool isPaid = salaryStatus == 'مدفوع';
    final bool isDue = salaryStatus == 'مستحق';

    final Color statusColor =
        isActive ? const Color(0xFF22C55E) : const Color(0xFFF59E0B);

    final Color salaryColor = isPaid
        ? const Color(0xFF22C55E)
        : isDue
            ? const Color(0xFFF59E0B)
            : const Color(0xFF2563EB);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
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
                  backgroundColor: statusColor.withOpacity(0.10),
                  backgroundImage: (teacher['image'] ?? '').isNotEmpty
                      ? NetworkImage(teacher['image']!)
                      : null,
                  child: (teacher['image'] ?? '').isEmpty
                      ? Icon(
                          Icons.person_rounded,
                          color: statusColor,
                          size: 22.sp,
                        )
                      : null,
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
                        '$subject - $classes',
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
                _StatusPill(text: status, color: statusColor),
              ],
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: _InfoBox(
                    title: 'الراتب',
                    value: salary,
                    color: const Color(0xFF2563EB),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _InfoBox(
                    title: 'آخر دفعة',
                    value: lastPayment,
                    color: const Color(0xFF22C55E),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _InfoBox(
                    title: 'الحالة',
                    value: salaryStatus,
                    color: salaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
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
      constraints: BoxConstraints(maxWidth: 82.w),
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
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
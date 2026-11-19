import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'student_details_screen.dart';
import '../../widgets/school_background.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  String selectedClass = 'الكل';

  final List<Map<String, String>> students = const [
    {
      'name': 'أحمد محمد علي',
      'class': 'الرابع الابتدائي',
      'section': 'A',
      'status': 'حاضر',
      'image': 'https://i.pravatar.cc/150?img=12',
    },
    {
      'name': 'زينب علي حسن',
      'class': 'الرابع الابتدائي',
      'section': 'A',
      'status': 'حاضر',
      'image': 'https://i.pravatar.cc/150?img=47',
    },
    {
      'name': 'حسن كريم جاسم',
      'class': 'الخامس الابتدائي',
      'section': 'B',
      'status': 'غائب',
      'image': 'https://i.pravatar.cc/150?img=33',
    },
    {
      'name': 'مريم خالد سعد',
      'class': 'الثالث الابتدائي',
      'section': 'A',
      'status': 'حاضر',
      'image': 'https://i.pravatar.cc/150?img=44',
    },
    {
      'name': 'علي حسين عباس',
      'class': 'السادس الابتدائي',
      'section': 'C',
      'status': 'متأخر',
      'image': 'https://i.pravatar.cc/150?img=15',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredStudents = selectedClass == 'الكل'
        ? students
        : students.where((student) => student['class'] == selectedClass).toList();

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
              SizedBox(height: 20.h),
              _ClassFilter(
                selectedClass: selectedClass,
                onChanged: (value) {
                  setState(() {
                    selectedClass = value;
                  });
                },
              ),
              SizedBox(height: 18.h),
              Text(
                'قائمة الطلاب (${filteredStudents.length})',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 14.h),
              ...filteredStudents.map((student) {
                return _StudentTile(
                  student: student,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StudentDetailsScreen(student: student),
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
                'الطلاب',
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
                'Students Management',
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
          Icon(Icons.groups_rounded, color: Colors.white, size: 38.sp),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '420 طالب مسجل',
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
                  'إدارة ملفات الطلاب، الصفوف، الشعب والحالة اليومية.',
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

class _ClassFilter extends StatelessWidget {
  final String selectedClass;
  final ValueChanged<String> onChanged;

  const _ClassFilter({
    required this.selectedClass,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final classes = [
      'الكل',
      'الثالث الابتدائي',
      'الرابع الابتدائي',
      'الخامس الابتدائي',
      'السادس الابتدائي',
    ];

    return SizedBox(
      height: 44.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: classes.length,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final item = classes[index];
          final active = item == selectedClass;

          return GestureDetector(
            onTap: () => onChanged(item),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: active
                    ? const Color(0xFF2563EB)
                    : Colors.white.withOpacity(0.94),
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

class _StudentTile extends StatelessWidget {
  final Map<String, String> student;
  final VoidCallback onTap;

  const _StudentTile({
    required this.student,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final status = student['status'] ?? 'حاضر';
    final isAbsent = status == 'غائب';
    final isLate = status == 'متأخر';

    final Color statusColor = isAbsent
        ? const Color(0xFFEF4444)
        : isLate
            ? const Color(0xFFF59E0B)
            : const Color(0xFF22C55E);

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
        child: Row(
          children: [
            CircleAvatar(
              radius: 23.r,
              backgroundColor: statusColor.withOpacity(0.10),
              backgroundImage: (student['image'] ?? '').isNotEmpty
                  ? NetworkImage(student['image']!)
                  : null,
              child: (student['image'] ?? '').isEmpty
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
                    student['name'] ?? '',
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
                    '${student['class']} - الشعبة ${student['section']}',
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
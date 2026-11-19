import 'package:flutter/material.dart';

import '../admin/admin_dashboard.dart';
import '../teacher/teacher_dashboard.dart';
import '../parent/parent_dashboard.dart';
import '../student/student_dashboard.dart';
import '../../widgets/school_background.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _openRole(BuildContext context, String role) {
    Widget screen;

    switch (role) {
      case 'admin':
        screen = const AdminDashboard();
        break;
      case 'teacher':
        screen = const TeacherDashboard();
        break;
      case 'parent':
        screen = const ParentDashboard();
        break;
      default:
        screen = const StudentDashboard();
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmall = width < 380;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 16 : 22,
              vertical: 22,
            ),
            children: [
              const _SchoolCard(),
              const SizedBox(height: 28),
              const _DemoTitle(),
              const SizedBox(height: 14),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: isSmall ? 1.35 : 1.55,
                children: [
                  _RoleCard(
                    title: 'الإدارة',
                    subtitle: 'Admin',
                    icon: Icons.dashboard_rounded,
                    color: const Color(0xFF2563EB),
                    onTap: () => _openRole(context, 'admin'),
                  ),
                  _RoleCard(
                    title: 'المعلم',
                    subtitle: 'Teacher',
                    icon: Icons.edit_note_rounded,
                    color: const Color(0xFF22C55E),
                    onTap: () => _openRole(context, 'teacher'),
                  ),
                  _RoleCard(
                    title: 'ولي الأمر',
                    subtitle: 'Parent',
                    icon: Icons.family_restroom_rounded,
                    color: const Color(0xFFF59E0B),
                    onTap: () => _openRole(context, 'parent'),
                  ),
                  _RoleCard(
                    title: 'الطالب',
                    subtitle: 'Student',
                    icon: Icons.person_rounded,
                    color: const Color(0xFF0F172A),
                    onTap: () => _openRole(context, 'student'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'Powered by Space-H',
                  style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SchoolCard extends StatelessWidget {
  const _SchoolCard();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmall = width < 380;

    return Container(
      padding: EdgeInsets.all(isSmall ? 18 : 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFE6B7),
            Color(0xFFFFC9C9),
            Color(0xFFE0C3FC),
            Color(0xFFB8D8FF),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: isSmall ? 62 : 72,
            height: isSmall ? 62 : 72,
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/school_logo.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مدرسة المستقبل الأهلية',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'School Management Platform',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'بيئة مدرسية ذكية ومتكاملة',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              'MVP',
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontWeight: FontWeight.w900,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoTitle extends StatelessWidget {
  const _DemoTitle();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الدخول التجريبي',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'اختر نوع الحساب للمعاينة',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.lock_open_rounded, color: Color(0xFF2563EB)),
      ],
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmall = width < 380;

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(isSmall ? 12 : 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: isSmall ? 36 : 40,
              height: isSmall ? 36 : 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.10),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: isSmall ? 21 : 23),
            ),
            SizedBox(width: isSmall ? 8 : 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isSmall ? 14 : 16,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isSmall ? 11 : 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_back_rounded,
              size: 16,
              color: Colors.black38,
            ),
          ],
        ),
      ),
    );
  }
}
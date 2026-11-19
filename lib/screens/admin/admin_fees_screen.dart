import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'fee_details_screen.dart';
import '../../widgets/school_background.dart';

class AdminFeesScreen extends StatefulWidget {
  const AdminFeesScreen({super.key});

  @override
  State<AdminFeesScreen> createState() => _AdminFeesScreenState();
}

class _AdminFeesScreenState extends State<AdminFeesScreen> {
  String selectedStatus = 'الكل';

  final List<Map<String, String>> fees = const [
    {
      'student': 'أحمد محمد علي',
      'class': 'الرابع الابتدائي',
      'section': 'A',
      'total': '1,200,000 د.ع',
      'paid': '750,000 د.ع',
      'remaining': '450,000 د.ع',
      'status': 'مستحق',
    },
    {
      'student': 'زينب علي حسن',
      'class': 'الرابع الابتدائي',
      'section': 'A',
      'total': '1,200,000 د.ع',
      'paid': '1,200,000 د.ع',
      'remaining': '0 د.ع',
      'status': 'مدفوع',
    },
    {
      'student': 'حسن كريم جاسم',
      'class': 'الخامس الابتدائي',
      'section': 'B',
      'total': '1,200,000 د.ع',
      'paid': '600,000 د.ع',
      'remaining': '600,000 د.ع',
      'status': 'متأخر',
    },
    {
      'student': 'مريم خالد سعد',
      'class': 'الثالث الابتدائي',
      'section': 'A',
      'total': '1,200,000 د.ع',
      'paid': '900,000 د.ع',
      'remaining': '300,000 د.ع',
      'status': 'مستحق',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredFees = selectedStatus == 'الكل'
        ? fees
        : fees.where((item) => item['status'] == selectedStatus).toList();

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
                const _MoneySummary(),
                SizedBox(height: 20.h),
                _StatusFilter(
                  selectedStatus: selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                ),
                SizedBox(height: 22.h),
                Text(
                  'قائمة الأقساط (${filteredFees.length})',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 14.h),
                ...filteredFees.map((item) {
                  return _FeeTile(
                    fee: item,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FeeDetailsScreen(fee: item),
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
                'الأقساط المستحقة',
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
                'Admin Fees Management',
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
          Icon(Icons.payments_rounded, color: Colors.white, size: 38.sp),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '12 قسط مستحق',
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
                  'متابعة الأقساط، المبالغ المدفوعة، والمتبقية لكل طالب.',
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

class _MoneySummary extends StatelessWidget {
  const _MoneySummary();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: const [
        _MiniMoneyCard(
          title: 'المدفوع',
          value: '18.7M',
          suffix: 'د.ع',
          color: Color(0xFF22C55E),
          icon: Icons.check_circle_rounded,
        ),
        _MiniMoneyCard(
          title: 'المتبقي',
          value: '6.4M',
          suffix: 'د.ع',
          color: Color(0xFFF59E0B),
          icon: Icons.pending_actions_rounded,
        ),
      ],
    );
  }
}

class _MiniMoneyCard extends StatelessWidget {
  final String title;
  final String value;
  final String suffix;
  final Color color;
  final IconData icon;

  const _MiniMoneyCard({
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

class _StatusFilter extends StatelessWidget {
  final String selectedStatus;
  final ValueChanged<String> onChanged;

  const _StatusFilter({
    required this.selectedStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final statuses = ['الكل', 'مستحق', 'مدفوع', 'متأخر'];

    return SizedBox(
      height: 44.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: statuses.length,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final item = statuses[index];
          final active = item == selectedStatus;

          return GestureDetector(
            onTap: () => onChanged(item),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: active ? const Color(0xFFF59E0B) : Colors.white,
                borderRadius: BorderRadius.circular(999.r),
                border: Border.all(
                  color: active
                      ? const Color(0xFFF59E0B)
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

class _FeeTile extends StatelessWidget {
  final Map<String, String> fee;
  final VoidCallback onTap;

  const _FeeTile({
    required this.fee,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final student = fee['student'] ?? '';
    final studentClass = fee['class'] ?? '';
    final section = fee['section'] ?? '';
    final total = fee['total'] ?? '';
    final paid = fee['paid'] ?? '';
    final remaining = fee['remaining'] ?? '';
    final status = fee['status'] ?? '';

    final bool isPaid = status == 'مدفوع';
    final bool isLate = status == 'متأخر';

    final Color statusColor = isPaid
        ? const Color(0xFF22C55E)
        : isLate
            ? const Color(0xFFEF4444)
            : const Color(0xFFF59E0B);

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
                  child: Icon(
                    Icons.person_rounded,
                    color: statusColor,
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student,
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
                _StatusPill(text: status, color: statusColor),
              ],
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: _InfoBox(
                    title: 'الإجمالي',
                    value: total,
                    color: const Color(0xFF2563EB),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _InfoBox(
                    title: 'المدفوع',
                    value: paid,
                    color: const Color(0xFF22C55E),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _InfoBox(
                    title: 'المتبقي',
                    value: remaining,
                    color: statusColor,
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
              fontSize: 11.sp,
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
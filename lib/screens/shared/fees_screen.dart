import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../admin/payment_methods_screen.dart';
import '../../widgets/school_background.dart';
class FeesScreen extends StatelessWidget {
  const FeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final feeData = {
      'student': 'أحمد محمد علي',
      'class': 'الرابع الابتدائي',
      'section': 'A',
      'total': '1,200,000 د.ع',
      'paid': '750,000 د.ع',
      'remaining': '450,000 د.ع',
      'status': 'مستحق',
    };

    final fees = [
      {
        'month': 'أيلول',
        'amount': '150,000 د.ع',
        'status': 'مدفوع',
        'paid': true,
      },
      {
        'month': 'تشرين الأول',
        'amount': '150,000 د.ع',
        'status': 'مدفوع',
        'paid': true,
      },
      {
        'month': 'تشرين الثاني',
        'amount': '150,000 د.ع',
        'status': 'مستحق',
        'paid': false,
      },
      {
        'month': 'كانون الأول',
        'amount': '150,000 د.ع',
        'status': 'قادم',
        'paid': false,
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
              const _MainFeesCard(),
              SizedBox(height: 18.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: const [
                  _MiniCard(
                    title: 'المدفوع',
                    value: '750,000',
                    suffix: 'د.ع',
                    color: Color(0xFF22C55E),
                    icon: Icons.check_circle_rounded,
                  ),
                  _MiniCard(
                    title: 'المتبقي',
                    value: '450,000',
                    suffix: 'د.ع',
                    color: Color(0xFFF59E0B),
                    icon: Icons.pending_actions_rounded,
                  ),
                ],
              ),
              SizedBox(height: 26.h),
              Text(
                'جدول الأقساط',
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 14.h),
              ...fees.map((item) {
                final paid = item['paid'] as bool;

                return _FeeMonthTile(
                  month: item['month'] as String,
                  amount: item['amount'] as String,
                  status: item['status'] as String,
                  paid: paid,
                );
              }),
              SizedBox(height: 10.h),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentMethodsScreen(fee: feeData),
                      ),
                    );
                  },
                  icon: Icon(Icons.credit_card_rounded, size: 21.sp),
                  label: Text(
                    'ادفع الآن',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
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
                'الأقساط والمدفوعات',
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
            'Fees & Payments Overview',
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

class _MainFeesCard extends StatelessWidget {
  const _MainFeesCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الرسوم السنوية',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '1,200,000 د.ع',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withOpacity(0.94),
              fontSize: 30.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 22.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: LinearProgressIndicator(
              value: 0.62,
              minHeight: 10.h,
              backgroundColor: const Color(0xFF334155),
              color: const Color(0xFF22C55E),
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            'تم تسديد 62% من الرسوم الدراسية',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13.sp,
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
  final String suffix;
  final Color color;
  final IconData icon;

  const _MiniCard({
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
        height: 148.h,
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
            SizedBox(height: 2.h),
            Text(
              suffix,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black38,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 4.h),
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

class _FeeMonthTile extends StatelessWidget {
  final String month;
  final String amount;
  final String status;
  final bool paid;

  const _FeeMonthTile({
    required this.month,
    required this.amount,
    required this.status,
    required this.paid,
  });

  @override
  Widget build(BuildContext context) {
    final color = paid ? const Color(0xFF22C55E) : const Color(0xFFF59E0B);

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
            backgroundColor:
                paid ? const Color(0xFFEAFBF1) : const Color(0xFFFFF7ED),
            child: Icon(
              paid ? Icons.check_rounded : Icons.schedule_rounded,
              color: color,
              size: 21.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  month,
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
                  amount,
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
            status,
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
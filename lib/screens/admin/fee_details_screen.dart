import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'payment_methods_screen.dart';
import '../../widgets/school_background.dart';

class FeeDetailsScreen extends StatelessWidget {
  final Map<String, String> fee;

  const FeeDetailsScreen({
    super.key,
    required this.fee,
  });

  @override
  Widget build(BuildContext context) {
    final status = fee['status'] ?? 'مستحق';

    final bool isPaid = status == 'مدفوع';
    final bool isLate = status == 'متأخر';

    final Color statusColor = isPaid
        ? const Color(0xFF22C55E)
        : isLate
            ? const Color(0xFFEF4444)
            : const Color(0xFFF59E0B);

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
              _ProfileCard(
                fee: fee,
                status: status,
                statusColor: statusColor,
              ),
              SizedBox(height: 18.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                  children: [
                  _MoneyCard(
                    title: 'الإجمالي',
                    value: fee['total'] ?? '',
                    icon: Icons.account_balance_wallet_rounded,
                    color: const Color(0xFF2563EB),
                  ),
                  _MoneyCard(
                    title: 'المدفوع',
                    value: fee['paid'] ?? '',
                    icon: Icons.check_circle_rounded,
                    color: const Color(0xFF22C55E),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              _WideMoneyCard(
                title: 'المتبقي',
                value: fee['remaining'] ?? '',
                icon: Icons.pending_actions_rounded,
                color: statusColor,
              ),
              SizedBox(height: 24.h),
              const _SectionTitle(
                title: 'سجل الدفعات',
                subtitle: 'Payment History',
              ),
              SizedBox(height: 12.h),
              const _PaymentHistoryTile(
                title: 'الدفعة الأولى',
                amount: '300,000 د.ع',
                date: '2026/02/01',
                method: 'نقدي',
                color: Color(0xFF22C55E),
              ),
              const _PaymentHistoryTile(
                title: 'الدفعة الثانية',
                amount: '450,000 د.ع',
                date: '2026/04/01',
                method: 'تحويل',
                color: Color(0xFF2563EB),
              ),
              SizedBox(height: 24.h),
              const _SectionTitle(
                title: 'إجراءات',
                subtitle: 'Actions',
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 54.h,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: statusColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.add_card_rounded, size: 21.sp),
                  label: Text(
                    isPaid ? 'عرض إيصال الدفع' : 'تسجيل دفعة جديدة',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 54.h,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF0F172A),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    backgroundColor: Colors.white.withOpacity(0.94),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentMethodsScreen(fee: fee),
                      ),
                    );
                  },
                  icon: Icon(Icons.credit_card_rounded, size: 21.sp),
                  label: Text(
                    'ادفع الآن',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16.sp,
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
            'تفاصيل القسط',
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
  final Map<String, String> fee;
  final String status;
  final Color statusColor;

  const _ProfileCard({
    required this.fee,
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
            child: Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 42.sp,
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            fee['student'] ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            '${fee['class']} - الشعبة ${fee['section']}',
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

class _MoneyCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MoneyCard({
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
                fontSize: 20.sp,
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

class _WideMoneyCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _WideMoneyCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 92.h,
      ),
      child: Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(26.r),
          border: Border.all(
            color: color.withOpacity(0.20),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: color.withOpacity(0.13),
              child: Icon(
                icon,
                color: color,
                size: 21.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF0F172A),
                  fontWeight: FontWeight.w900,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Flexible(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w900,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentHistoryTile extends StatelessWidget {
  final String title;
  final String amount;
  final String date;
  final String method;
  final Color color;

  const _PaymentHistoryTile({
    required this.title,
    required this.amount,
    required this.date,
    required this.method,
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
            child: Icon(Icons.receipt_long_rounded, color: color, size: 21.sp),
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
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF0F172A),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  '$date - $method',
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
          Flexible(
            child: Text(
              amount,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w900,
                fontSize: 13.sp,
              ),
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
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.14),
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
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
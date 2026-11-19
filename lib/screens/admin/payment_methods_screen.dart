import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/school_background.dart';
class PaymentMethodsScreen extends StatelessWidget {
  final Map<String, String> fee;

  const PaymentMethodsScreen({
    super.key,
    required this.fee,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = fee['remaining'] ?? '0 د.ع';
    final student = fee['student'] ?? '';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(22.w),
            children: [
              const _PageHeader(),
              SizedBox(height: 20.h),
              _PaymentHeaderCard(
                student: student,
                remaining: remaining,
              ),
              SizedBox(height: 24.h),
              Text(
                'اختر طريقة الدفع',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 14.h),
              const _PaymentOption(
                title: 'زين كاش',
                subtitle: 'دفع عبر محفظة ZainCash',
                icon: Icons.phone_android_rounded,
                color: Color(0xFF7C3AED),
              ),
              const _PaymentOption(
                title: 'آسيا حوالة',
                subtitle: 'دفع عبر محفظة آسيا حوالة',
                icon: Icons.account_balance_wallet_rounded,
                color: Color(0xFFEF4444),
              ),
              const _PaymentOption(
                title: 'كي كارد',
                subtitle: 'دفع عبر بطاقة Qi Card',
                icon: Icons.credit_card_rounded,
                color: Color(0xFF2563EB),
              ),
              const _PaymentOption(
                title: 'Visa / MasterCard',
                subtitle: 'دفع بالبطاقات العالمية',
                icon: Icons.payment_rounded,
                color: Color(0xFF0F172A),
              ),
              const _PaymentOption(
                title: 'دفع نقدي للإدارة',
                subtitle: 'تسجيل دفع يدوي داخل المدرسة',
                icon: Icons.payments_rounded,
                color: Color(0xFF22C55E),
              ),
              SizedBox(height: 16.h),
              const _InfoNote(),
            ],
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
            'طرق الدفع',
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

class _PaymentHeaderCard extends StatelessWidget {
  final String student;
  final String remaining;

  const _PaymentHeaderCard({
    required this.student,
    required this.remaining,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.credit_card_rounded,
            color: Colors.white,
            size: 38.sp,
          ),
          SizedBox(height: 14.h),
          Text(
            student,
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
            'المبلغ المطلوب: $remaining',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w700,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _PaymentOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24.r),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم اختيار $title كطريقة دفع تجريبية'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 21.r,
                backgroundColor: color.withOpacity(0.10),
                child: Icon(icon, color: color, size: 22.sp),
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
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      subtitle,
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
              Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 15.sp,
                color: Colors.black26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoNote extends StatelessWidget {
  const _InfoNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: const Color(0xFFF59E0B),
            size: 22.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'هذه صفحة دفع تجريبية للعرض فقط. الربط الحقيقي مع بوابات الدفع يتم لاحقاً عند إطلاق النسخة التجارية.',
              style: TextStyle(
                color: const Color(0xFF92400E),
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
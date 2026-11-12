import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import 'models/promo.dart';
import 'models/quick_action.dart';
import 'models/spending_category.dart';
import 'models/transaction.dart';

/// Hard-coded demo content for the redesign.
abstract final class SampleData {
  static const String customerName = 'Aditya Ramadhan';
  static const String customerInitials = 'AR';
  static const String accountNumber = '•••• 8831';
  static const double balance = 12500000;
  static const double monthlySpending = 4250000;
  static const double monthlyBudget = 7000000;
  static const double monthlyIncome = 9750000;

  static const List<QuickAction> quickActions = [
    QuickAction(label: 'Transfer', icon: Icons.north_east_rounded),
    QuickAction(label: 'Top Up', icon: Icons.add_card_rounded),
    QuickAction(
      label: 'QRIS',
      icon: Icons.qr_code_scanner_rounded,
      highlighted: true,
    ),
    QuickAction(label: 'Bayar', icon: Icons.receipt_long_rounded),
    QuickAction(label: 'Tarik Tunai', icon: Icons.local_atm_rounded),
    QuickAction(label: 'Investasi', icon: Icons.show_chart_rounded),
    QuickAction(label: 'Donasi', icon: Icons.volunteer_activism_rounded),
    QuickAction(label: 'Lainnya', icon: Icons.grid_view_rounded, neutral: true),
  ];

  static const List<Promo> promos = [
    Promo(
      tag: 'CASHBACK 30%',
      title: 'Belanja online makin untung',
      subtitle: 'Diskon hingga Rp100.000 di merchant pilihan',
      icon: Icons.shopping_bag_rounded,
      colors: [Color(0xFF0A4A86), Color(0xFF0B80C7)],
    ),
    Promo(
      tag: 'FLASH SALE',
      title: 'Bayar tagihan, dapat cashback',
      subtitle: 'Token listrik & PDAM tanpa biaya admin',
      icon: Icons.bolt_rounded,
      colors: [Color(0xFF0D5F5B), Color(0xFF14A085)],
    ),
    Promo(
      tag: 'BCA PRIORITAS',
      title: 'Wealth insight untukmu',
      subtitle: 'Konsultasi investasi gratis 1-on-1',
      icon: Icons.auto_graph_rounded,
      colors: [Color(0xFF1B2B45), Color(0xFF3D5C7E)],
      accent: AppColors.gold,
    ),
  ];

  static const List<SpendingCategory> spendingCategories = [
    SpendingCategory(
      label: 'Makan & Minum',
      amount: 1850000,
      color: Color(0xFFF59E0B),
    ),
    SpendingCategory(
      label: 'Belanja',
      amount: 1240000,
      color: AppColors.bcaBlue,
    ),
    SpendingCategory(
      label: 'Transport',
      amount: 620000,
      color: Color(0xFF14A085),
    ),
    SpendingCategory(
      label: 'Hiburan',
      amount: 540000,
      color: Color(0xFF7C6BEA),
    ),
  ];

  static const List<BankTransaction> transactions = [
    BankTransaction(
      title: 'Kopi Kenangan',
      subtitle: 'Makan & Minum · Hari ini, 08.45',
      amount: 28000,
      kind: TransactionKind.expense,
      icon: Icons.local_cafe_rounded,
      accent: Color(0xFFD97706),
    ),
    BankTransaction(
      title: 'Transfer dari Rina',
      subtitle: 'Transfer masuk · Hari ini, 07.12',
      amount: 750000,
      kind: TransactionKind.income,
      icon: Icons.south_west_rounded,
      accent: AppColors.success,
    ),
    BankTransaction(
      title: 'Token Listrik PLN',
      subtitle: 'Tagihan · Kemarin, 19.30',
      amount: 202000,
      kind: TransactionKind.expense,
      icon: Icons.bolt_rounded,
      accent: Color(0xFF2563EB),
      pending: true,
    ),
    BankTransaction(
      title: 'Netflix',
      subtitle: 'Hiburan · Kemarin, 12.05',
      amount: 186000,
      kind: TransactionKind.expense,
      icon: Icons.play_circle_outline_rounded,
      accent: Color(0xFFDC2626),
    ),
    BankTransaction(
      title: 'Cashback BCA',
      subtitle: 'Reward · 31 Okt, 16.20',
      amount: 125000,
      kind: TransactionKind.income,
      icon: Icons.redeem_rounded,
      accent: Color(0xFF7C3AED),
    ),
    BankTransaction(
      title: 'Grab',
      subtitle: 'Transport · 31 Okt, 18.20',
      amount: 47000,
      kind: TransactionKind.expense,
      icon: Icons.directions_car_filled_rounded,
      accent: Color(0xFF0D9488),
    ),
  ];
}

import 'package:flutter/material.dart';

import '../../core/utils/formatters.dart';

enum TransactionKind { income, expense }

class BankTransaction {
  const BankTransaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.kind,
    required this.icon,
    required this.accent,
    this.pending = false,
  });

  final String title;
  final String subtitle;
  final double amount;
  final TransactionKind kind;
  final IconData icon;
  final Color accent;
  final bool pending;

  bool get isIncome => kind == TransactionKind.income;

  String get signedAmount => '${isIncome ? '+' : '-'}${formatRupiah(amount)}';
}

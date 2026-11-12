import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/transaction.dart';
import '../../../data/sample_data.dart';
import '../../../shared/widgets/section_header.dart';

class TransactionsSection extends StatelessWidget {
  const TransactionsSection({
    super.key,
    required this.onSeeAll,
    required this.onTransactionTap,
    this.transactions = SampleData.transactions,
    this.title = 'Transaksi Terakhir',
    this.limit = 4,
  });

  final VoidCallback onSeeAll;
  final ValueChanged<BankTransaction> onTransactionTap;
  final List<BankTransaction> transactions;
  final String title;
  final int limit;

  @override
  Widget build(BuildContext context) {
    final visible = transactions.take(limit).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title, actionLabel: 'Semua', onAction: onSeeAll),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: AppColors.cardShadow,
          ),
          child: Column(
            children: [
              for (var index = 0; index < visible.length; index++) ...[
                TransactionTile(
                  transaction: visible[index],
                  onTap: () => onTransactionTap(visible[index]),
                ),
                if (index != visible.length - 1)
                  const Padding(
                    padding: EdgeInsets.only(left: 56, right: 8),
                    child: Divider(),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
    this.onTap,
    this.showType = true,
  });

  final BankTransaction transaction;
  final VoidCallback? onTap;
  final bool showType;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: transaction.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  transaction.icon,
                  size: 20,
                  color: transaction.accent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.1,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            transaction.subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w500,
                              color: AppColors.muted,
                            ),
                          ),
                        ),
                        if (transaction.pending) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 1.5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.warning.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              'Tertunda',
                              style: TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFB45309),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    transaction.signedAmount,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.1,
                      color: transaction.isIncome
                          ? AppColors.success
                          : AppColors.ink,
                    ),
                  ),
                  if (showType) ...[
                    const SizedBox(height: 3),
                    Text(
                      transaction.isIncome ? 'Masuk' : 'Keluar',
                      style: const TextStyle(
                        fontSize: 8.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

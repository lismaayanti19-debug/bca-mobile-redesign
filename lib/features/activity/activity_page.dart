import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/transaction.dart';
import '../../data/sample_data.dart';
import '../../shared/widgets/press_scale.dart';
import '../home/widgets/home_sheets.dart';
import '../home/widgets/transaction_list.dart';

enum _TransactionFilter { all, income, expense }

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  _TransactionFilter _filter = _TransactionFilter.all;

  List<BankTransaction> get _filteredTransactions {
    return switch (_filter) {
      _TransactionFilter.all => SampleData.transactions,
      _TransactionFilter.income =>
        SampleData.transactions
            .where((transaction) => transaction.isIncome)
            .toList(),
      _TransactionFilter.expense =>
        SampleData.transactions
            .where((transaction) => !transaction.isIncome)
            .toList(),
    };
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final transactions = _filteredTransactions;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Aktivitas',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                              color: AppColors.ink,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Semua transaksi kamu di satu tempat',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _CircleButton(
                      icon: Icons.search_rounded,
                      tooltip: 'Cari transaksi',
                      onTap: () => _showMessage('Pencarian transaksi (demo)'),
                    ),
                    const SizedBox(width: 8),
                    _CircleButton(
                      icon: Icons.tune_rounded,
                      tooltip: 'Filter transaksi',
                      onTap: () => _showMessage('Filter lanjutan (demo)'),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFE8F2FC), Color(0xFFF9FBFE)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Ringkasan November',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.ink,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 13,
                            color: AppColors.bcaBlue,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '2026',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.bcaBlue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: _SummaryValue(
                              label: 'Pemasukan',
                              amount: SampleData.monthlyIncome,
                              icon: Icons.south_west_rounded,
                              color: AppColors.success,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 42,
                            color: AppColors.line,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _SummaryValue(
                              label: 'Pengeluaran',
                              amount: SampleData.monthlySpending,
                              icon: Icons.north_east_rounded,
                              color: AppColors.danger,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      _FilterChip(
                        key: const Key('filter-semua'),
                        label: 'Semua',
                        selected: _filter == _TransactionFilter.all,
                        onTap: () =>
                            setState(() => _filter = _TransactionFilter.all),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        key: const Key('filter-masuk'),
                        label: 'Uang masuk',
                        selected: _filter == _TransactionFilter.income,
                        onTap: () =>
                            setState(() => _filter = _TransactionFilter.income),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        key: const Key('filter-keluar'),
                        label: 'Uang keluar',
                        selected: _filter == _TransactionFilter.expense,
                        onTap: () => setState(
                          () => _filter = _TransactionFilter.expense,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Riwayat transaksi',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.softBlue,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        '${transactions.length}',
                        style: const TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.bcaBlue,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => _showMessage('Unduh mutasi rekening (demo)'),
                      behavior: HitTestBehavior.opaque,
                      child: const Row(
                        children: [
                          Icon(
                            Icons.download_rounded,
                            size: 14,
                            color: AppColors.bcaBlue,
                          ),
                          SizedBox(width: 3),
                          Text(
                            'Unduh',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.bcaBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppColors.cardShadow,
                  ),
                  child: transactions.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 36),
                          child: Center(
                            child: Text(
                              'Belum ada transaksi untuk filter ini.',
                              style: TextStyle(
                                fontSize: 10.5,
                                color: AppColors.muted,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            for (
                              var index = 0;
                              index < transactions.length;
                              index++
                            ) ...[
                              TransactionTile(
                                transaction: transactions[index],
                                onTap: () => showTransactionDetail(
                                  context,
                                  transactions[index],
                                ),
                              ),
                              if (index != transactions.length - 1)
                                const Padding(
                                  padding: EdgeInsets.only(left: 56, right: 8),
                                  child: Divider(),
                                ),
                            ],
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryValue extends StatelessWidget {
  const _SummaryValue({
    required this.label,
    required this.amount,
    required this.icon,
    required this.color,
  });

  final String label;
  final double amount;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(icon, size: 12, color: color),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.muted,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            formatRupiah(amount),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
              color: AppColors.ink,
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressScale(
      onTap: onTap,
      scale: 0.95,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? AppColors.bcaBlue : Colors.white,
          borderRadius: BorderRadius.circular(99),
          border: Border.all(
            color: selected ? AppColors.bcaBlue : AppColors.line,
          ),
          boxShadow: selected
              ? const [
                  BoxShadow(
                    color: Color(0x280060AF),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? Colors.white : AppColors.muted,
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: PressScale(
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: AppColors.line),
          ),
          child: Icon(icon, size: 18, color: AppColors.ink),
        ),
      ),
    );
  }
}

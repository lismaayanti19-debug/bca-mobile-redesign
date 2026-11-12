import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/widgets/section_header.dart';
import 'widgets/header_and_balance.dart';
import 'widgets/home_sheets.dart';
import 'widgets/promo_carousel.dart';
import 'widgets/quick_actions_card.dart';
import 'widgets/spending_insight_card.dart';
import 'widgets/transaction_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.onSeeAllTransactions, this.onSeeAllPromos});

  final VoidCallback? onSeeAllTransactions;
  final VoidCallback? onSeeAllPromos;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _balanceVisible = true;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _refresh() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    _showMessage('Data terbaru sudah dimuat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.bcaBlue,
        backgroundColor: Colors.white,
        edgeOffset: 90,
        onRefresh: _refresh,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(
              child: HeaderAndBalance(
                balanceVisible: _balanceVisible,
                onToggleBalance: () {
                  setState(() => _balanceVisible = !_balanceVisible);
                },
                onNotifications: () => showNotificationsSheet(context),
                onHelp: () => _showMessage('Bantuan BCA siap 24/7 (demo)'),
                onAction: _showMessage,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: QuickActionsCard(
                  onAction: (label) => _showMessage('$label · fitur demo'),
                  onAllServices: () => showAllServicesSheet(context),
                  onCustomize: () => _showMessage('Atur layanan cepat (demo)'),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      title: 'Promo & Penawaran',
                      actionLabel: 'Lihat semua',
                      onAction:
                          widget.onSeeAllPromos ??
                          () => _showMessage('Semua promo (demo)'),
                    ),
                    const SizedBox(height: 12),
                    PromoCarousel(
                      onTap: (promo) => showPromoDetail(context, promo),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 26),
                child: Column(
                  children: [
                    SectionHeader(
                      title: 'Insight Pengeluaran',
                      actionLabel: 'Detail',
                      onAction: () =>
                          _showMessage('Rincian pengeluaran (demo)'),
                    ),
                    const SizedBox(height: 10),
                    SpendingInsightCard(
                      onDetail: () =>
                          _showMessage('Rincian pengeluaran (demo)'),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 26),
                child: TransactionsSection(
                  onSeeAll:
                      widget.onSeeAllTransactions ??
                      () => _showMessage('Semua transaksi (demo)'),
                  onTransactionTap: (transaction) =>
                      showTransactionDetail(context, transaction),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 26)),
            const SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'BCA mobile · konsep desain ulang',
                  style: TextStyle(
                    fontSize: 8.5,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                    color: AppColors.muted,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }
}

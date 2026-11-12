import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/promo.dart';
import '../../../data/models/transaction.dart';
import '../../../shared/widgets/press_scale.dart';

const _sheetConstraints = BoxConstraints(maxWidth: 560);

void showAllServicesSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    constraints: _sheetConstraints,
    builder: (sheetContext) {
      return _SheetFrame(
        title: 'Semua Layanan',
        subtitle: 'Pilih layanan yang ingin kamu gunakan',
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _services.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 8,
            childAspectRatio: 0.78,
          ),
          itemBuilder: (context, index) {
            final service = _services[index];
            return PressScale(
              scale: 0.92,
              onTap: () {
                Navigator.of(sheetContext).pop();
                _showSnack(context, '${service.label} · fitur demo');
              },
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: service.color.withValues(alpha: 0.11),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(service.icon, color: service.color, size: 22),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    service.label,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

void showNotificationsSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    constraints: _sheetConstraints,
    builder: (sheetContext) {
      return _SheetFrame(
        title: 'Notifikasi',
        subtitle: '2 pesan belum dibaca',
        child: Column(
          children: [
            for (final notification in _notifications) ...[
              _NotificationTile(notification: notification),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 4),
            TextButton(
              onPressed: () {
                Navigator.of(sheetContext).pop();
                _showSnack(context, 'Semua notifikasi ditandai sudah dibaca');
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.bcaBlue,
                minimumSize: const Size.fromHeight(44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Tandai semua sudah dibaca',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showQrisSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    constraints: _sheetConstraints,
    builder: (sheetContext) {
      return _SheetFrame(
        title: 'QRIS',
        subtitle: 'Bayar cepat di semua merchant QRIS',
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.line),
                boxShadow: AppColors.cardShadow,
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'QRIS',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.4,
                          color: AppColors.ink,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'BCA mobile',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.line),
                    ),
                    child: const SizedBox(
                      width: 190,
                      height: 190,
                      child: CustomPaint(
                        painter: _QrPainter(color: AppColors.navy),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        size: 15,
                        color: AppColors.bcaBlue,
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          'Aditya Ramadhan · Tahapan BCA',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.ink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Tunjukkan kode ini ke kasir. Kode berlaku selama 5 menit dan '
              'hanya dapat digunakan satu kali.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: AppColors.muted,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  _showSnack(context, 'Kode QRIS disimpan ke galeri (demo)');
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.bcaBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.download_rounded, size: 18),
                label: const Text(
                  'Simpan kode QR',
                  style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showTransactionDetail(BuildContext context, BankTransaction transaction) {
  showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    constraints: _sheetConstraints,
    builder: (sheetContext) {
      return _SheetFrame(
        title: 'Detail Transaksi',
        subtitle: transaction.subtitle,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: transaction.accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Icon(
                      transaction.icon,
                      color: transaction.accent,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    transaction.title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    transaction.signedAmount,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.6,
                      color: transaction.isIncome
                          ? AppColors.success
                          : AppColors.ink,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.line),
              ),
              child: Column(
                children: [
                  _DetailRow(
                    label: 'Status',
                    value: transaction.pending ? 'Tertunda' : 'Berhasil',
                    valueColor: transaction.pending
                        ? AppColors.warning
                        : AppColors.success,
                  ),
                  const Divider(),
                  const _DetailRow(label: 'Metode', value: 'BCA mobile'),
                  const Divider(),
                  _DetailRow(
                    label: 'Waktu',
                    value: transaction.subtitle.split(' · ').last,
                  ),
                  const Divider(),
                  const _DetailRow(
                    label: 'ID transaksi',
                    value: 'BCA202611120841',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(sheetContext).pop();
                      _showSnack(context, 'Bukti transaksi sedang disiapkan');
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(46),
                      foregroundColor: AppColors.bcaBlue,
                      side: const BorderSide(color: AppColors.line),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(Icons.download_rounded, size: 17),
                    label: const Text(
                      'Unduh bukti',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.of(sheetContext).pop();
                      _showSnack(context, 'Laporan transaksi dikirim ke BCA');
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(46),
                      backgroundColor: AppColors.bcaBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(Icons.flag_outlined, size: 17),
                    label: const Text(
                      'Laporkan',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

void showPromoDetail(BuildContext context, Promo promo) {
  showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    constraints: _sheetConstraints,
    builder: (sheetContext) {
      return _SheetFrame(
        title: 'Detail Promo',
        subtitle: promo.tag,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                gradient: promo.gradient,
                borderRadius: BorderRadius.circular(22),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Stack(
                  children: [
                    Positioned(
                      top: -50,
                      right: -20,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 14,
                      bottom: 0,
                      child: Icon(
                        promo.icon,
                        size: 86,
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              promo.tag,
                              style: TextStyle(
                                color: promo.accent,
                                fontSize: 8.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 70),
                            child: Text(
                              promo.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                height: 1.25,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(right: 70),
                            child: Text(
                              promo.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xBFFFFFFF),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Syarat & ketentuan',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  SizedBox(height: 10),
                  _PromoBullet(text: 'Berlaku untuk semua nasabah BCA mobile.'),
                  _PromoBullet(
                    text: 'Minimal transaksi Rp100.000 di merchant partner.',
                  ),
                  _PromoBullet(
                    text: 'Cashback maksimal Rp100.000 per nasabah.',
                  ),
                  _PromoBullet(text: 'Periode promo 1–30 November 2026.'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  _showSnack(context, 'Promo berhasil diklaim (demo)');
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.bcaBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Klaim promo',
                  style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _PromoBullet extends StatelessWidget {
  const _PromoBullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.circle, size: 4, color: AppColors.bcaBlue),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 9.5,
                height: 1.45,
                fontWeight: FontWeight.w500,
                color: AppColors.muted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetFrame extends StatelessWidget {
  const _SheetFrame({required this.title, required this.child, this.subtitle});

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.84,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                          color: AppColors.ink,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.background,
                    minimumSize: const Size(34, 34),
                    padding: EdgeInsets.zero,
                  ),
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 17,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification});

  final _Notification notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: notification.unread ? AppColors.softBlue : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line.withValues(alpha: 0.8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: notification.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              notification.icon,
              size: 18,
              color: notification.accent,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                    Text(
                      notification.time,
                      style: const TextStyle(
                        fontSize: 8.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.muted,
                      ),
                    ),
                    if (notification.unread) ...[
                      const SizedBox(width: 5),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.bcaBlue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  notification.message,
                  style: const TextStyle(
                    fontSize: 9.5,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                    color: AppColors.muted,
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.valueColor = AppColors.ink,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.muted,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _QrPainter extends CustomPainter {
  const _QrPainter({required this.color});

  final Color color;

  static const int _modules = 25;

  @override
  void paint(Canvas canvas, Size size) {
    final cell = size.width / _modules;
    final paint = Paint()..color = color;

    bool inFinderZone(int x, int y) {
      return (x < 8 && y < 8) ||
          (x >= _modules - 8 && y < 8) ||
          (x < 8 && y >= _modules - 8);
    }

    for (var y = 0; y < _modules; y++) {
      for (var x = 0; x < _modules; x++) {
        if (inFinderZone(x, y)) continue;
        if (((x * 2) + (y * 3) + (x * y)) % 7 < 3) {
          canvas.drawRect(Rect.fromLTWH(x * cell, y * cell, cell, cell), paint);
        }
      }
    }

    void drawFinder(int x, int y) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x * cell, y * cell, cell * 7, cell * 7),
          Radius.circular(cell * 1.2),
        ),
        paint,
      );
      canvas.drawRect(
        Rect.fromLTWH((x + 1) * cell, (y + 1) * cell, cell * 5, cell * 5),
        Paint()..color = Colors.white,
      );
      canvas.drawRect(
        Rect.fromLTWH((x + 2) * cell, (y + 2) * cell, cell * 3, cell * 3),
        paint,
      );
    }

    drawFinder(0, 0);
    drawFinder(_modules - 7, 0);
    drawFinder(0, _modules - 7);
  }

  @override
  bool shouldRepaint(_QrPainter oldDelegate) => oldDelegate.color != color;
}

void _showSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

class _Service {
  const _Service(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;
}

class _Notification {
  const _Notification({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.accent,
    this.unread = false,
  });

  final String title;
  final String message;
  final String time;
  final IconData icon;
  final Color accent;
  final bool unread;
}

const _services = [
  _Service('Transfer', Icons.north_east_rounded, AppColors.bcaBlue),
  _Service('Top Up', Icons.add_card_rounded, Color(0xFF0D9488)),
  _Service('QRIS', Icons.qr_code_scanner_rounded, Color(0xFF7C3AED)),
  _Service('Bayar', Icons.receipt_long_rounded, Color(0xFFD97706)),
  _Service('Tarik Tunai', Icons.local_atm_rounded, Color(0xFF2563EB)),
  _Service('Investasi', Icons.show_chart_rounded, Color(0xFF0E9F6E)),
  _Service('Donasi', Icons.volunteer_activism_rounded, Color(0xFFDC2626)),
  _Service('Asuransi', Icons.shield_outlined, Color(0xFF0891B2)),
  _Service('Kredit', Icons.credit_card_rounded, Color(0xFF9333EA)),
  _Service('e-Money', Icons.wallet_rounded, Color(0xFFCA8A04)),
  _Service('Setor Tunai', Icons.savings_outlined, Color(0xFF059669)),
  _Service('Bantuan', Icons.headset_mic_rounded, Color(0xFF475569)),
];

const _notifications = [
  _Notification(
    title: 'Transfer berhasil',
    message: 'Transfer Rp750.000 dari Rina sudah masuk ke rekening kamu.',
    time: '07.12',
    icon: Icons.south_west_rounded,
    accent: AppColors.success,
    unread: true,
  ),
  _Notification(
    title: 'Promo untukmu',
    message: 'Cashback 30% di merchant pilihan berlaku sampai 30 November.',
    time: 'Kemarin',
    icon: Icons.local_offer_rounded,
    accent: Color(0xFF7C3AED),
    unread: true,
  ),
  _Notification(
    title: 'Pembayaran terjadwal',
    message: 'Tagihan internet akan dipotong otomatis besok pukul 08.00.',
    time: '2 hari',
    icon: Icons.event_available_rounded,
    accent: AppColors.warning,
  ),
];

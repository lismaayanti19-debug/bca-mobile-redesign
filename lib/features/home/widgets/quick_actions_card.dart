import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/quick_action.dart';
import '../../../data/sample_data.dart';
import '../../../shared/widgets/press_scale.dart';

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({
    super.key,
    required this.onAction,
    required this.onAllServices,
    required this.onCustomize,
  });

  final ValueChanged<String> onAction;
  final VoidCallback onAllServices;
  final VoidCallback onCustomize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Layanan Cepat',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                      color: AppColors.ink,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onCustomize,
                  behavior: HitTestBehavior.opaque,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Icon(
                          Icons.tune_rounded,
                          size: 13,
                          color: AppColors.muted,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Atur',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth / 4;
              return Wrap(
                children: [
                  for (final action in SampleData.quickActions)
                    SizedBox(
                      width: itemWidth,
                      child: _QuickActionItem(
                        action: action,
                        onTap: action.label == 'Lainnya'
                            ? onAllServices
                            : () => onAction(action.label),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  const _QuickActionItem({required this.action, required this.onTap});

  final QuickAction action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color foreground;
    final BoxDecoration decoration;

    if (action.highlighted) {
      foreground = Colors.white;
      decoration = BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0073C8), AppColors.bcaBlue],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x380060AF),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      );
    } else if (action.neutral) {
      foreground = AppColors.muted;
      decoration = BoxDecoration(
        color: const Color(0xFFF3F6FA),
        borderRadius: BorderRadius.circular(15),
      );
    } else {
      foreground = AppColors.bcaBlue;
      decoration = BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.bcaBlue.withValues(alpha: 0.13),
            AppColors.bcaBlue.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      );
    }

    return PressScale(
      onTap: onTap,
      scale: 0.92,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: decoration,
              child: Icon(action.icon, size: 22, color: foreground),
            ),
            const SizedBox(height: 8),
            Text(
              action.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10.2,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

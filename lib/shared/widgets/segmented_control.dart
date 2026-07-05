import 'package:flutter/material.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_durations.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Flat segmented control with a sliding thumb (`.seg`).
class SegmentedControl extends StatelessWidget {
  const SegmentedControl({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.lineLight,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.segmented),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final segmentWidth = constraints.maxWidth / options.length;
          return SizedBox(
            height: 36,
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: AppDurations.segmented,
                  curve: AppDurations.ease,
                  left: segmentWidth * selectedIndex,
                  width: segmentWidth,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(
                        AppRadii.segmentedThumb,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF231C12,
                          ).withValues(alpha: 0.05),
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    for (final (index, option) in options.indexed)
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => onChanged(index),
                          child: Center(
                            child: Text(
                              option,
                              style: AppTextStyles.action.copyWith(
                                color: index == selectedIndex
                                    ? AppColors.deepen(AppColors.accent)
                                    : AppColors.inkTertiary,
                              ),
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
      ),
    );
  }
}

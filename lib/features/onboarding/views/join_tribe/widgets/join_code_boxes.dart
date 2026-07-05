import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/features/onboarding/views/join_tribe/join_tribe_controller.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:provider/provider.dart';

/// Row of six single-character code inputs (`.ob-code-inputs`).
class JoinCodeBoxes extends StatelessWidget {
  const JoinCodeBoxes({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<JoinTribeController>();

    return Row(
      children: [
        for (var i = 0; i < JoinTribeController.codeLength; i++) ...[
          if (i > 0) const SizedBox(width: 9),
          Expanded(
            child: _CodeBox(index: i, value: controller.code[i]),
          ),
        ],
      ],
    );
  }
}

class _CodeBox extends StatelessWidget {
  const _CodeBox({required this.index, required this.value});

  final int index;
  final String value;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<JoinTribeController>();
    final isFilled = value.isNotEmpty;

    return SizedBox(
      height: 56,
      child: TextField(
        onChanged: (text) {
          controller.setCharacter(index, text);
          if (text.isNotEmpty) FocusScope.of(context).nextFocus();
        },
        textAlign: TextAlign.center,
        maxLines: 1,
        style: GoogleFonts.figtree(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: isFilled ? Colors.white : AppColors.surface,
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadii.segmented),
            borderSide: BorderSide(
              color: isFilled ? AppColors.accent : AppColors.line,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadii.segmented),
            borderSide: const BorderSide(color: AppColors.accent),
          ),
        ),
      ),
    );
  }
}

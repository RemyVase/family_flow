import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/theme/app_colors.dart';

/// Round member avatar showing the member's initial in their color.
class MemberAvatar extends StatelessWidget {
  const MemberAvatar({
    super.key,
    required this.member,
    this.size = 36,
    this.filled = false,
  });

  final Member member;
  final double size;

  /// Filled = solid member color + white initial (leaderboard, profile list).
  /// Otherwise soft background + colored initial (detail, create form).
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final soft = AppColors.soften(member.color, 0.2);

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? member.color : soft,
        border: filled
            ? null
            : Border.all(color: AppColors.soften(member.color, 0.35)),
      ),
      child: Text(
        member.initial,
        style: GoogleFonts.figtree(
          fontSize: size * 0.42,
          fontWeight: FontWeight.w700,
          color: filled ? Colors.white : member.color,
          height: 1,
        ),
      ),
    );
  }
}

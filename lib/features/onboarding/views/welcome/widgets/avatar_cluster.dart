import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/theme/app_colors.dart';

/// Overlapping row of four demo avatars on the welcome step (`.ob-cluster`).
class AvatarCluster extends StatelessWidget {
  const AvatarCluster({super.key});

  static const double _avatarSize = 44;

  /// Horizontal distance between two avatars (44px minus the 14px overlap).
  static const double _step = _avatarSize - 14;

  static const List<(String, Color)> _demoAvatars = [
    ('L', AppColors.memberTerracotta),
    ('M', AppColors.memberGreen),
    ('P', AppColors.memberBlue),
    ('T', AppColors.memberPurple),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _avatarSize + _step * (_demoAvatars.length - 1),
      height: _avatarSize,
      child: Stack(
        children: [
          // Reversed so the leftmost avatar sits on top, like the design.
          for (final (index, (initial, color))
              in _demoAvatars.indexed.toList().reversed)
            Positioned(
              left: index * _step,
              child: Container(
                width: _avatarSize,
                height: _avatarSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.background, width: 3),
                ),
                child: Text(
                  initial,
                  style: GoogleFonts.figtree(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

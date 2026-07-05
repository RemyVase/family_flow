import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/theme/app_colors.dart';

/// Overlapping row of four demo avatars on the welcome step (`.ob-cluster`).
class AvatarCluster extends StatelessWidget {
  const AvatarCluster({super.key});

  static const List<(String, Color)> _demoAvatars = [
    ('L', AppColors.memberTerracotta),
    ('M', AppColors.memberGreen),
    ('P', AppColors.memberBlue),
    ('T', AppColors.memberPurple),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final (index, (initial, color)) in _demoAvatars.indexed)
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: index == 0 ? 0 : -14),
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
      ],
    );
  }
}

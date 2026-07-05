import 'package:flutter/material.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/task_card.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';

/// Banner of the detail screen: striped photo placeholder, or a
/// member-tinted banner with a sparkle when the task has no photo.
class TaskDetailBanner extends StatelessWidget {
  const TaskDetailBanner({super.key, required this.task, required this.member});

  final Task task;
  final Member member;

  @override
  Widget build(BuildContext context) {
    if (task.hasPhoto) {
      return Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.line),
          borderRadius: BorderRadius.circular(AppRadii.panel),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.panel),
          child: const CustomPaint(
            painter: StripedPlaceholderPainter(stripeWidth: 11),
          ),
        ),
      );
    }

    return Container(
      height: 120,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.soften(member.color, 0.2),
        borderRadius: BorderRadius.circular(AppRadii.panel),
      ),
      child: AppIcon(AppIconData.sparkle, size: 34, color: member.color),
    );
  }
}

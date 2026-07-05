import 'package:flutter/material.dart';
import 'package:our_tribe/features/profile/views/profile/profile_controller.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/color_swatch_button.dart';
import 'package:our_tribe/shared/widgets/member_avatar.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_durations.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Danger red of destructive actions (remove member, leave tribe).
const Color kDangerRed = Color(0xFFC0442F);

/// One member row (`.pf-swipe`): tap opens the color palette (when
/// allowed), swiping left reveals "Retirer" (chief only, never self) with
/// an inline confirmation.
class ProfileMemberRow extends StatefulWidget {
  const ProfileMemberRow({super.key, required this.member});

  final Member member;

  @override
  State<ProfileMemberRow> createState() => _ProfileMemberRowState();
}

class _ProfileMemberRowState extends State<ProfileMemberRow> {
  static const double _revealWidth = 88;

  double _dragOffset = 0;
  bool _isConfirming = false;

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset = (_dragOffset + details.delta.dx).clamp(-96.0, 0.0);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    setState(() {
      _dragOffset = _dragOffset < -44 ? -_revealWidth : 0;
    });
  }

  void _onRowTap(ProfileController controller) {
    if (_dragOffset < 0) {
      setState(() => _dragOffset = 0);
      return;
    }
    if (controller.canEditColor(widget.member.id)) {
      controller.toggleEditing(widget.member.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<ProfileController>();
    final member = widget.member;
    final canRemove = controller.canRemove(member.id);
    final canColor = controller.canEditColor(member.id);
    final isPaletteOpen = controller.editingMemberId == member.id;

    return Column(
      children: [
        ClipRect(
          child: Stack(
            children: [
              if (canRemove && !_isConfirming)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _isConfirming = true;
                        _dragOffset = 0;
                      }),
                      child: Container(
                        width: _revealWidth,
                        color: kDangerRed,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AppIcon(
                              AppIconData.trash,
                              size: 17,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              l10n.removeAction,
                              style: AppTextStyles.meta.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              AnimatedContainer(
                duration: AppDurations.segmented,
                curve: AppDurations.ease,
                transform: Matrix4.translationValues(_dragOffset, 0, 0),
                color: AppColors.surface,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _onRowTap(controller),
                  onHorizontalDragUpdate: canRemove ? _onDragUpdate : null,
                  onHorizontalDragEnd: canRemove ? _onDragEnd : null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        MemberAvatar(member: member, size: 30, filled: true),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: member.name,
                              style: AppTextStyles.taskName.copyWith(
                                fontSize: 14.5,
                              ),
                              children: [
                                if (member.isChief)
                                  TextSpan(
                                    text: ' · ${l10n.chiefSuffix}',
                                    style: AppTextStyles.meta,
                                  )
                                else if (member.isCurrentUser)
                                  TextSpan(
                                    text: ' · ${l10n.meSuffix}',
                                    style: AppTextStyles.meta,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: member.color,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: member.color.withValues(alpha: 0.12),
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                        ),
                        if (canColor) ...[
                          const SizedBox(width: 10),
                          const AppIcon(
                            AppIconData.pencil,
                            size: 14,
                            color: AppColors.inkTertiary,
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
        if (isPaletteOpen)
          Padding(
            padding: const EdgeInsets.only(
              left: 40,
              top: 4,
              bottom: AppSpacing.md,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 9,
                runSpacing: 9,
                children: [
                  for (final color in AppColors.memberPalette)
                    ColorSwatchButton(
                      color: color,
                      isSelected: member.color == color,
                      onTap: () => controller.setMemberColor(member.id, color),
                    ),
                ],
              ),
            ),
          ),
        if (_isConfirming)
          Padding(
            padding: const EdgeInsets.only(top: 11, bottom: 4),
            child: Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: l10n.removeMemberQuestion(member.name),
                      style: AppTextStyles.action.copyWith(fontSize: 13),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _isConfirming = false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      border: Border.all(color: AppColors.line),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Text(
                      l10n.cancelButton,
                      style: AppTextStyles.action.copyWith(fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                GestureDetector(
                  onTap: () => controller.removeMember(member.id),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: kDangerRed,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Text(
                      l10n.removeAction,
                      style: AppTextStyles.action.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

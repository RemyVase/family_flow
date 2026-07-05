import 'package:flutter/material.dart';
import 'package:our_tribe/shared/widgets/sticky_action_bar.dart';
import 'package:our_tribe/shared/widgets/tribe_background.dart';
import 'package:our_tribe/theme/app_spacing.dart';

/// Common layout of every onboarding step: motif background, scrollable
/// body and an optional sticky footer.
class OnboardingScaffold extends StatelessWidget {
  const OnboardingScaffold({
    super.key,
    required this.body,
    this.footer,
    this.centered = false,
  });

  final Widget body;
  final Widget? footer;

  /// Centers the body vertically (welcome / done steps).
  final bool centered;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: TribeBackground(
        child: Stack(
          children: [
            SafeArea(
              bottom: false,
              child: centered
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenHorizontal,
                      ),
                      child: Center(child: body),
                    )
                  : SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        AppSpacing.screenHorizontal,
                        AppSpacing.lg,
                        AppSpacing.screenHorizontal,
                        footer != null
                            ? AppSpacing.stickyActionClearance
                            : AppSpacing.xxl,
                      ),
                      child: body,
                    ),
            ),
            if (footer != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: StickyActionBar(child: footer!),
              ),
          ],
        ),
      ),
    );
  }
}

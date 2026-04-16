import 'package:flutter/material.dart';
import 'package:motion_kit/fake_var.dart';
import 'package:motion_kit/theme/app_tokens.dart';

AppTokens tokensOf(BuildContext context) =>
    Theme.of(context).extension<AppTokens>() ??
    (Globals.wcagModeEnabled ? AppTokens.wcag : AppTokens.standard);

Color wcagColor(
  BuildContext context, {
  required Color standard,
  required Color wcag,
}) =>
    Globals.wcagModeEnabled ? wcag : standard;

class WcagTapTarget extends StatelessWidget {
  final Widget child;
  final bool compact;

  const WcagTapTarget({
    super.key,
    required this.child,
    this.compact = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!Globals.wcagModeEnabled) return child;
    final tokens = tokensOf(context);
    final minSize = compact ? tokens.compactTapTargetSize : tokens.minTapTargetSize;
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minSize, minHeight: minSize),
      child: child,
    );
  }
}

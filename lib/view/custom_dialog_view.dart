import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
const _kDialogBorderRadius = BorderRadius.all(Radius.circular(12.0));
class CustomMacosAlertDialog extends StatelessWidget {
  /// Builds a macOS-style Alert Dialog
  const CustomMacosAlertDialog({
    super.key,
    required this.child,
    required this.primaryButton,
    this.secondaryButton,
    this.horizontalActions = true,
    this.suppress,
  });

  /// This should be your application's icon.
  ///
  /// The size of this widget should be 56x56.

  /// The title for the dialog.
  ///
  /// Typically a Text widget.

  /// The content to display in the dialog.
  ///
  /// Typically a Text widget.
  final Widget child;

  /// The primary action a user can take.
  ///
  /// Typically a [PushButton].
  final Widget primaryButton;

  /// The secondary action a user can take.
  ///
  /// Typically a [PushButton].
  final Widget? secondaryButton;

  /// Determines whether to lay out [primaryButton] and [secondaryButton]
  /// horizontally or vertically.
  ///
  /// Defaults to `true`.
  final bool? horizontalActions;

  /// A widget to allow users to suppress alerts of this type.
  ///
  /// The logic for this should be user-implemented. Here is a sample of a
  /// widget that can be passed in for this parameter:
  /// ```dart
  /// class DoNotNotifyRow extends StatefulWidget {
  ///   const DoNotNotifyRow({Key? key}) : super(key: key);
  ///
  ///   @override
  ///   _DoNotNotifyRowState createState() => _DoNotNotifyRowState();
  /// }
  ///
  /// class _DoNotNotifyRowState extends State<DoNotNotifyRow> {
  ///   bool suppress = false;
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Row(
  ///       mainAxisAlignment: MainAxisAlignment.center,
  ///       children: [
  ///         MacosCheckbox(
  ///  value: suppress,
  ///  onChanged: (value) {
  ///    setState(() => suppress = value);
  ///  },
  ///         ),
  ///         const SizedBox(width: 8),
  ///         Text('Don\'t ask again'),
  ///       ],
  ///     );
  ///   }
  /// }
  /// ```
  ///
  /// Notable, the above widget is a `StatefulWidget`. Your widget must be
  /// stateful or your checkbox will not update as you expect.
  final Widget? suppress;

  @override
  Widget build(BuildContext context) {
    final brightness = MacosTheme.brightnessOf(context);

    final outerBorderColor = brightness.resolve(
      Colors.black.withOpacity(0.23),
      Colors.black.withOpacity(0.76),
    );

    final innerBorderColor = brightness.resolve(
      Colors.white.withOpacity(0.45),
      Colors.white.withOpacity(0.15),
    );

    return Dialog(
      backgroundColor: brightness.resolve(
        CupertinoColors.systemGrey6.color,
        MacosColors.controlBackgroundColor.darkColor,
      ),
      shape:  RoundedRectangleBorder(
        borderRadius: _kDialogBorderRadius,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: innerBorderColor,
          ),
          borderRadius: _kDialogBorderRadius,
        ),
        foregroundDecoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: outerBorderColor,
          ),
          borderRadius: _kDialogBorderRadius,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 260,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              child,
              const SizedBox(height: 18),
              if (secondaryButton == null) ...[
                Row(
                  children: [
                    Expanded(
                      child: primaryButton,
                    ),
                  ],
                ),
              ] else ...[
                if (horizontalActions!) ...[
                  Row(
                    children: [
                      if (secondaryButton != null) ...[
                        Expanded(
                          child: secondaryButton!,
                        ),
                        const SizedBox(width: 8.0),
                      ],
                      Expanded(
                        child: primaryButton,
                      ),
                    ],
                  ),
                ] else ...[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(child: primaryButton),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      if (secondaryButton != null) ...[
                        Row(
                          children: [
                            Expanded(
                              child: secondaryButton!,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ],
              ],
              if (suppress != null) ...[
                const SizedBox(height: 16),
                DefaultTextStyle(
                  style: MacosTheme.of(context).typography.headline,
                  child: suppress!,
                ),
              ],
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
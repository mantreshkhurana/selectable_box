import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

/// A widget that can be selected and deselected.
class SelectableBox extends StatelessWidget {
  /// Width of [SelectableBox] widget.
  final double width;

  /// Height of [SelectableBox] widget.
  final double height;

  /// Background color of the [SelectableBox] widget.
  final Color color;

  /// Background color of the [SelectableBox] widget when it is selected.
  final Color? selectedColor;

  /// Border color of [SelectableBox] widget.
  final Color borderColor;

  /// Border color of the [SelectableBox] widget when it is selected.
  final Color selectedBorderColor;

  /// Border width of the [SelectableBox] widget.
  final double borderWidth;

  /// Border radius of the [SelectableBox] widget.
  final double borderRadius;

  /// Padding of the box.
  final EdgeInsetsGeometry padding;

  /// Duration of the animation in [SelectableBox] widget.
  final Duration animationDuration;

  /// Opacity of the [SelectableBox] widget when it is not selected.
  final double opacity;

  /// Opacity of the [SelectableBox] widget when it is selected.
  final double? selectedOpacity;

  /// Alignment of the checkbox in the [SelectableBox] widget.
  final Alignment checkboxAlignment;

  /// Padding of the checkbox in the [SelectableBox] widget.
  final EdgeInsetsGeometry checkboxPadding;

  /// Icon to be displayed when the [SelectableBox] widget is selected.
  final Widget selectedIcon;

  /// Icon to be displayed when the [SelectableBox] widget is not selected.
  final Widget unSelectedIcon;

  /// Whether to show the checkbox or not.
  final bool showCheckbox;

  /// Callback when the [SelectableBox] widget is tapped.
  final VoidCallback onTap;

  /// Whether the [SelectableBox] widget is selected or not.
  final bool isSelected;

  /// Child widget of the [SelectableBox] widget.
  final Widget child;

  const SelectableBox({
    Key? key,
    this.width = 320,
    this.height = 200,
    this.color = Colors.white,
    this.selectedColor = Colors.white,
    this.borderColor = Colors.grey,
    this.selectedBorderColor = Colors.blue,
    this.borderWidth = 1,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(8),
    this.animationDuration = const Duration(milliseconds: 200),
    this.opacity = 0.5,
    this.selectedOpacity = 1,
    this.checkboxAlignment = Alignment.topRight,
    this.checkboxPadding = const EdgeInsets.all(0),
    this.selectedIcon = const Icon(
      Icons.check_circle,
      color: Colors.green,
    ),
    this.unSelectedIcon = const Icon(
      Icons.check_circle_outline,
      color: Colors.grey,
    ),
    this.showCheckbox = true,
    required this.onTap,
    required this.isSelected,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Padding(
            padding: padding,
            child: AnimatedOpacity(
              duration: animationDuration,
              opacity: isSelected ? selectedOpacity! : opacity,
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? selectedColor : color,
                  border: Border.all(
                    color: isSelected ? selectedBorderColor : borderColor,
                    width: borderWidth,
                  ),
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: borderRadius,
                    cornerSmoothing: 0.5,
                  ),
                ),
                height: height,
                width: width,
                child: ClipRRect(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: borderRadius,
                    cornerSmoothing: 0.5,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
          showCheckbox
              ? Positioned.fill(
                  child: Padding(
                    padding: checkboxPadding,
                    child: Align(
                      alignment: checkboxAlignment,
                      child: isSelected ? selectedIcon : unSelectedIcon,
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

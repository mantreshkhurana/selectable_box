import 'package:flutter/material.dart';

/// A widget that can be selected and deselected.
class SelectableBox extends StatefulWidget {
  /// Width of [SelectableBox] widget.
  final double width;

  /// Height of [SelectableBox] widget.
  final double height;

  /// Background color of the [SelectableBox] widget.
  final Color color;

  /// Background color of the [SelectableBox] widget when it is selected.
  final Color? isSelectedColor;

  /// Border color of [SelectableBox] widget.
  final Color borderColor;

  /// Border color of the [SelectableBox] widget when it is selected.
  final Color isSelectedBorderColor;

  /// Border width of the [SelectableBox] widget.
  final double borderWidth;

  /// Border radius of the [SelectableBox] widget.
  final BorderRadius borderRadius;

  /// Padding of the box.
  final EdgeInsetsGeometry padding;

  /// Duration of the animation in [SelectableBox] widget.
  final Duration animationDuration;

  /// Opacity of the [SelectableBox] widget when it is not selected.
  final double opacity;

  /// Opacity of the [SelectableBox] widget when it is selected.
  final double? isSelectedOpacity;

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
    this.isSelectedColor = Colors.white,
    this.borderColor = Colors.grey,
    this.isSelectedBorderColor = Colors.blue,
    this.borderWidth = 1,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.padding = const EdgeInsets.all(8),
    this.animationDuration = const Duration(milliseconds: 200),
    this.opacity = 0.5,
    this.isSelectedOpacity = 1,
    required this.onTap,
    required this.isSelected,
    required this.child,
  }) : super(key: key);

  @override
  State<SelectableBox> createState() => _SelectableBoxState();
}

class _SelectableBoxState extends State<SelectableBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: widget.padding,
        child: AnimatedOpacity(
          duration: widget.animationDuration,
          opacity:
              widget.isSelected ? widget.isSelectedOpacity! : widget.opacity,
          child: Container(
            decoration: BoxDecoration(
              color: widget.isSelected ? widget.isSelectedColor : widget.color,
              border: Border.all(
                color: widget.isSelected
                    ? widget.isSelectedBorderColor
                    : widget.borderColor,
                width: widget.borderWidth,
              ),
              borderRadius: widget.borderRadius,
            ),
            height: widget.height,
            width: widget.width,
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

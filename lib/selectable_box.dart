import 'package:flutter/material.dart';

class SelectableBox extends StatefulWidget {
  final double width;
  final double height;
  final Color color;
  final Color? isSelectedColor;
  final Color borderColor;
  final Color isSelectedBorderColor;
  final double borderWidth;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final Duration animationDuration;
  final double opacity;
  final double? isSelectedOpacity;
  final VoidCallback onTap;
  final bool isSelected;
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

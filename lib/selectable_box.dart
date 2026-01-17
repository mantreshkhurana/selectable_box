import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A smooth border radius implementation similar to iOS/Figma squircle.
class SmoothRectangleBorder extends OutlinedBorder {
  final BorderRadiusGeometry borderRadius;
  final double smoothness;

  const SmoothRectangleBorder({
    super.side,
    this.borderRadius = BorderRadius.zero,
    this.smoothness = 0.6,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _buildPath(rect.deflate(side.width), borderRadius.resolve(textDirection));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _buildPath(rect, borderRadius.resolve(textDirection));
  }

  Path _buildPath(Rect rect, BorderRadius radius) {
    final double topLeftRadius = radius.topLeft.x;
    final double topRightRadius = radius.topRight.x;
    final double bottomLeftRadius = radius.bottomLeft.x;
    final double bottomRightRadius = radius.bottomRight.x;

    final path = Path();

    double getOffset(double r) => r * smoothness;

    path.moveTo(rect.left, rect.top + topLeftRadius);
    path.cubicTo(
      rect.left, rect.top + getOffset(topLeftRadius),
      rect.left + getOffset(topLeftRadius), rect.top,
      rect.left + topLeftRadius, rect.top,
    );

    path.lineTo(rect.right - topRightRadius, rect.top);

    path.cubicTo(
      rect.right - getOffset(topRightRadius), rect.top,
      rect.right, rect.top + getOffset(topRightRadius),
      rect.right, rect.top + topRightRadius,
    );

    path.lineTo(rect.right, rect.bottom - bottomRightRadius);

    path.cubicTo(
      rect.right, rect.bottom - getOffset(bottomRightRadius),
      rect.right - getOffset(bottomRightRadius), rect.bottom,
      rect.right - bottomRightRadius, rect.bottom,
    );

    path.lineTo(rect.left + bottomLeftRadius, rect.bottom);

    path.cubicTo(
      rect.left + getOffset(bottomLeftRadius), rect.bottom,
      rect.left, rect.bottom - getOffset(bottomLeftRadius),
      rect.left, rect.bottom - bottomLeftRadius,
    );

    path.close();
    return path;
  }

  @override
  ShapeBorder scale(double t) {
    return SmoothRectangleBorder(
      side: side.scale(t),
      borderRadius: borderRadius * t,
      smoothness: smoothness,
    );
  }

  @override
  OutlinedBorder copyWith({BorderSide? side, BorderRadiusGeometry? borderRadius, double? smoothness}) {
    return SmoothRectangleBorder(
      side: side ?? this.side,
      borderRadius: borderRadius ?? this.borderRadius,
      smoothness: smoothness ?? this.smoothness,
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none) return;
    final paint = side.toPaint();
    final path = getOuterPath(rect, textDirection: textDirection);
    canvas.drawPath(path, paint);
  }
}

/// A custom clipper for smooth border radius.
class SmoothRectClipper extends CustomClipper<Path> {
  final double radius;
  final double smoothness;

  SmoothRectClipper({required this.radius, this.smoothness = 0.6});

  @override
  Path getClip(Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final path = Path();
    double getOffset(double r) => r * smoothness;
    final r = radius;

    path.moveTo(rect.left, rect.top + r);
    path.cubicTo(
      rect.left, rect.top + getOffset(r),
      rect.left + getOffset(r), rect.top,
      rect.left + r, rect.top,
    );

    path.lineTo(rect.right - r, rect.top);

    path.cubicTo(
      rect.right - getOffset(r), rect.top,
      rect.right, rect.top + getOffset(r),
      rect.right, rect.top + r,
    );

    path.lineTo(rect.right, rect.bottom - r);

    path.cubicTo(
      rect.right, rect.bottom - getOffset(r),
      rect.right - getOffset(r), rect.bottom,
      rect.right - r, rect.bottom,
    );

    path.lineTo(rect.left + r, rect.bottom);

    path.cubicTo(
      rect.left + getOffset(r), rect.bottom,
      rect.left, rect.bottom - getOffset(r),
      rect.left, rect.bottom - r,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(SmoothRectClipper oldClipper) {
    return radius != oldClipper.radius || smoothness != oldClipper.smoothness;
  }
}

/// A custom painter for gradient borders with smooth corners.
class _GradientBorderPainter extends CustomPainter {
  final Gradient gradient;
  final double borderWidth;
  final double borderRadius;
  final double smoothness;

  _GradientBorderPainter({
    required this.gradient,
    required this.borderWidth,
    required this.borderRadius,
    this.smoothness = 0.6,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final path = _buildSmoothPath(rect);

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawPath(path, paint);
  }

  Path _buildSmoothPath(Rect rect) {
    final path = Path();
    final r = borderRadius;
    double getOffset(double radius) => radius * smoothness;

    path.moveTo(rect.left, rect.top + r);
    path.cubicTo(
      rect.left, rect.top + getOffset(r),
      rect.left + getOffset(r), rect.top,
      rect.left + r, rect.top,
    );

    path.lineTo(rect.right - r, rect.top);

    path.cubicTo(
      rect.right - getOffset(r), rect.top,
      rect.right, rect.top + getOffset(r),
      rect.right, rect.top + r,
    );

    path.lineTo(rect.right, rect.bottom - r);

    path.cubicTo(
      rect.right, rect.bottom - getOffset(r),
      rect.right - getOffset(r), rect.bottom,
      rect.right - r, rect.bottom,
    );

    path.lineTo(rect.left + r, rect.bottom);

    path.cubicTo(
      rect.left + getOffset(r), rect.bottom,
      rect.left, rect.bottom - getOffset(r),
      rect.left, rect.bottom - r,
    );

    path.close();
    return path;
  }

  @override
  bool shouldRepaint(_GradientBorderPainter oldDelegate) {
    return gradient != oldDelegate.gradient ||
        borderWidth != oldDelegate.borderWidth ||
        borderRadius != oldDelegate.borderRadius ||
        smoothness != oldDelegate.smoothness;
  }
}

/// Controller for managing multi-selection of [SelectableBox] widgets.
class SelectableBoxController extends ChangeNotifier {
  final Set<String> _selectedIds = {};
  final int? maxSelections;

  /// Creates a controller for managing multi-selection.
  ///
  /// [maxSelections] limits the number of items that can be selected.
  /// If null, unlimited selections are allowed.
  SelectableBoxController({this.maxSelections});

  /// Returns the set of currently selected IDs.
  Set<String> get selectedIds => Set.unmodifiable(_selectedIds);

  /// Returns the number of currently selected items.
  int get selectedCount => _selectedIds.length;

  /// Returns true if any items are selected.
  bool get hasSelection => _selectedIds.isNotEmpty;

  /// Returns true if the item with the given [id] is selected.
  bool isSelected(String id) => _selectedIds.contains(id);

  /// Toggles the selection state of the item with the given [id].
  ///
  /// Returns true if the item is now selected, false otherwise.
  bool toggle(String id) {
    if (_selectedIds.contains(id)) {
      _selectedIds.remove(id);
      notifyListeners();
      return false;
    } else {
      if (maxSelections != null && _selectedIds.length >= maxSelections!) {
        return false;
      }
      _selectedIds.add(id);
      notifyListeners();
      return true;
    }
  }

  /// Selects the item with the given [id].
  ///
  /// Returns true if the item was selected, false if max selections reached.
  bool select(String id) {
    if (_selectedIds.contains(id)) return true;
    if (maxSelections != null && _selectedIds.length >= maxSelections!) {
      return false;
    }
    _selectedIds.add(id);
    notifyListeners();
    return true;
  }

  /// Deselects the item with the given [id].
  void deselect(String id) {
    if (_selectedIds.remove(id)) {
      notifyListeners();
    }
  }

  /// Selects all items with the given [ids].
  void selectAll(Iterable<String> ids) {
    for (final id in ids) {
      if (maxSelections != null && _selectedIds.length >= maxSelections!) {
        break;
      }
      _selectedIds.add(id);
    }
    notifyListeners();
  }

  /// Clears all selections.
  void clearSelection() {
    if (_selectedIds.isNotEmpty) {
      _selectedIds.clear();
      notifyListeners();
    }
  }
}

/// Badge position for the [SelectableBox] widget.
enum BadgePosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

/// A widget that can be selected and deselected.
class SelectableBox extends StatefulWidget {
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

  /// Gradient for the border. If provided, overrides [borderColor] and [selectedBorderColor].
  final Gradient? borderGradient;

  /// Gradient for the border when selected. If null, uses [borderGradient].
  final Gradient? selectedBorderGradient;

  /// Border width of the [SelectableBox] widget.
  final double borderWidth;

  /// Border radius of the [SelectableBox] widget.
  final double borderRadius;

  /// Padding of the box.
  final EdgeInsetsGeometry padding;

  /// Duration of the animation in [SelectableBox] widget.
  final Duration animationDuration;

  /// Animation curve for the [SelectableBox] widget.
  final Curve animationCurve;

  /// Opacity of the [SelectableBox] widget when it is not selected.
  final double opacity;

  /// Opacity of the [SelectableBox] widget when it is selected.
  final double? selectedOpacity;

  /// Scale of the [SelectableBox] widget when it is not selected.
  final double scale;

  /// Scale of the [SelectableBox] widget when it is selected (iOS-like effect).
  final double selectedScale;

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
  final VoidCallback? onTap;

  /// Callback when the [SelectableBox] widget is long pressed.
  final VoidCallback? onLongPress;

  /// Whether the [SelectableBox] widget is selected or not.
  final bool isSelected;

  /// Whether the [SelectableBox] widget is enabled or not.
  final bool enabled;

  /// Opacity when the widget is disabled.
  final double disabledOpacity;

  /// Whether to enable haptic feedback on tap.
  final bool enableHapticFeedback;

  /// Type of haptic feedback to use.
  final HapticFeedbackType hapticFeedbackType;

  /// Shadow/elevation when not selected.
  final double elevation;

  /// Shadow/elevation when selected.
  final double selectedElevation;

  /// Shadow color.
  final Color shadowColor;

  /// Badge text to display (e.g., count or label).
  final String? badgeText;

  /// Badge background color.
  final Color badgeColor;

  /// Badge text style.
  final TextStyle? badgeTextStyle;

  /// Badge position.
  final BadgePosition badgePosition;

  /// Badge padding.
  final EdgeInsetsGeometry badgePadding;

  /// Whether to show the badge.
  final bool showBadge;

  /// Custom badge widget. If provided, overrides [badgeText].
  final Widget? customBadge;

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
    this.borderGradient,
    this.selectedBorderGradient,
    this.borderWidth = 1,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(8),
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.opacity = 0.5,
    this.selectedOpacity = 1,
    this.scale = 1.0,
    this.selectedScale = 1.0,
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
    this.onTap,
    this.onLongPress,
    required this.isSelected,
    this.enabled = true,
    this.disabledOpacity = 0.4,
    this.enableHapticFeedback = false,
    this.hapticFeedbackType = HapticFeedbackType.light,
    this.elevation = 0,
    this.selectedElevation = 0,
    this.shadowColor = Colors.black,
    this.badgeText,
    this.badgeColor = Colors.red,
    this.badgeTextStyle,
    this.badgePosition = BadgePosition.topRight,
    this.badgePadding = const EdgeInsets.all(4),
    this.showBadge = false,
    this.customBadge,
    required this.child,
  }) : super(key: key);

  @override
  State<SelectableBox> createState() => _SelectableBoxState();
}

/// Haptic feedback types available for [SelectableBox].
enum HapticFeedbackType {
  light,
  medium,
  heavy,
  selection,
  vibrate,
}

class _SelectableBoxState extends State<SelectableBox> with SingleTickerProviderStateMixin {
  void _triggerHapticFeedback() {
    if (!widget.enableHapticFeedback) return;

    switch (widget.hapticFeedbackType) {
      case HapticFeedbackType.light:
        HapticFeedback.lightImpact();
        break;
      case HapticFeedbackType.medium:
        HapticFeedback.mediumImpact();
        break;
      case HapticFeedbackType.heavy:
        HapticFeedback.heavyImpact();
        break;
      case HapticFeedbackType.selection:
        HapticFeedback.selectionClick();
        break;
      case HapticFeedbackType.vibrate:
        HapticFeedback.vibrate();
        break;
    }
  }

  void _handleTap() {
    if (!widget.enabled) return;
    _triggerHapticFeedback();
    widget.onTap?.call();
  }

  void _handleLongPress() {
    if (!widget.enabled) return;
    _triggerHapticFeedback();
    widget.onLongPress?.call();
  }

  Alignment _getBadgeAlignment() {
    switch (widget.badgePosition) {
      case BadgePosition.topLeft:
        return Alignment.topLeft;
      case BadgePosition.topRight:
        return Alignment.topRight;
      case BadgePosition.bottomLeft:
        return Alignment.bottomLeft;
      case BadgePosition.bottomRight:
        return Alignment.bottomRight;
    }
  }

  Widget _buildBadge() {
    if (widget.customBadge != null) {
      return widget.customBadge!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: widget.badgeColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        widget.badgeText ?? '',
        style: widget.badgeTextStyle ??
            const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentOpacity = widget.enabled
        ? (widget.isSelected ? widget.selectedOpacity! : widget.opacity)
        : widget.disabledOpacity;

    final currentScale = widget.isSelected ? widget.selectedScale : widget.scale;
    final currentElevation = widget.isSelected ? widget.selectedElevation : widget.elevation;

    final useGradientBorder = widget.borderGradient != null ||
        (widget.isSelected && widget.selectedBorderGradient != null);

    final currentGradient = widget.isSelected
        ? (widget.selectedBorderGradient ?? widget.borderGradient)
        : widget.borderGradient;

    return GestureDetector(
      onTap: widget.onTap != null ? _handleTap : null,
      onLongPress: widget.onLongPress != null ? _handleLongPress : null,
      child: AnimatedScale(
        scale: currentScale,
        duration: widget.animationDuration,
        curve: widget.animationCurve,
        child: Stack(
          children: [
            Padding(
              padding: widget.padding,
              child: AnimatedOpacity(
                duration: widget.animationDuration,
                curve: widget.animationCurve,
                opacity: currentOpacity,
                child: AnimatedContainer(
                  duration: widget.animationDuration,
                  curve: widget.animationCurve,
                  decoration: ShapeDecoration(
                    color: widget.isSelected ? widget.selectedColor : widget.color,
                    shape: SmoothRectangleBorder(
                      side: useGradientBorder
                          ? BorderSide.none
                          : BorderSide(
                              color: widget.isSelected
                                  ? widget.selectedBorderColor
                                  : widget.borderColor,
                              width: widget.borderWidth,
                            ),
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      smoothness: 0.6,
                    ),
                    shadows: currentElevation > 0
                        ? [
                            BoxShadow(
                              color: widget.shadowColor.withValues(alpha: 0.3),
                              blurRadius: currentElevation * 2,
                              spreadRadius: currentElevation / 2,
                              offset: Offset(0, currentElevation),
                            ),
                          ]
                        : null,
                  ),
                  height: widget.height,
                  width: widget.width,
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: SmoothRectClipper(
                          radius: widget.borderRadius,
                          smoothness: 0.6,
                        ),
                        child: widget.child,
                      ),
                      if (useGradientBorder && currentGradient != null)
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _GradientBorderPainter(
                              gradient: currentGradient,
                              borderWidth: widget.borderWidth,
                              borderRadius: widget.borderRadius,
                              smoothness: 0.6,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (widget.showCheckbox)
              Positioned.fill(
                child: Padding(
                  padding: widget.checkboxPadding,
                  child: Align(
                    alignment: widget.checkboxAlignment,
                    child: AnimatedSwitcher(
                      duration: widget.animationDuration,
                      child: widget.isSelected
                          ? widget.selectedIcon
                          : widget.unSelectedIcon,
                    ),
                  ),
                ),
              ),
            if (widget.showBadge && (widget.badgeText != null || widget.customBadge != null))
              Positioned.fill(
                child: Padding(
                  padding: widget.badgePadding,
                  child: Align(
                    alignment: _getBadgeAlignment(),
                    child: _buildBadge(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

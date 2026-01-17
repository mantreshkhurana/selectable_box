# Changelog

All notable changes to this project will be documented in this file.

## 2.0.0

- **Breaking:** `SelectableBox` is now a `StatefulWidget`.
- **Breaking:** `onTap` is now optional (nullable).
- Added `SelectableBoxController` for multi-selection support with `maxSelections` limit.
- Added `onLongPress` callback.
- Added `enabled` property with `disabledOpacity` for disabled state.
- Added `animationCurve` property for custom animation curves.
- Added `scale` and `selectedScale` properties for iOS-like scale animation.
- Added `enableHapticFeedback` and `hapticFeedbackType` for haptic feedback.
- Added `borderGradient` and `selectedBorderGradient` for gradient borders.
- Added `elevation`, `selectedElevation`, and `shadowColor` for shadow/elevation.
- Added badge support: `showBadge`, `badgeText`, `badgeColor`, `badgeTextStyle`, `badgePosition`, `badgePadding`, `customBadge`.
- Added `BadgePosition` enum and `HapticFeedbackType` enum.
- Removed `figma_squircle` dependency - smooth border radius now implemented in code.

## 1.0.9

- Removed `figma_squircle` dependency.
- Implemented custom smooth border radius (squircle) in code.
- Reduced package dependencies.

## 1.0.8

- Bug fixes & improvements.

## 1.0.7

- API changes.

## 1.0.6

- Faster performance.

## 1.0.5

- API changes.

## 1.0.4

- Screenshot update.

## 1.0.3

- Checkbox widget.
- Smooth border radius.

## 1.0.2

- Code linting.

## 1.0.1

- Documentation update.

## 1.0.0

- Initial release.

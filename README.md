# Selectable Box

[![GitHub stars](https://img.shields.io/github/stars/mantreshkhurana/selectable_box.svg?style=social)](https://github.com/mantreshkhurana/selectable_box)
[![pub package](https://img.shields.io/pub/v/selectable_box.svg)](https://pub.dartlang.org/packages/selectable_box)

Use `SelectableBox` to create a selectable box in your flutter app, `SelectableBox` comes with a lot of customization options mentioned below.
Convert any widget into a selectable box.

![Screenshot](https://raw.githubusercontent.com/mantreshkhurana/selectable_box/stable/screenshots/screenshot-1.png)

## Installation

Add `selectable_box: ^1.0.7` in your project's pubspec.yaml:

```yaml
dependencies:
  selectable_box: ^1.0.7
```

## Usage

Import `selectable_box` in your dart file:

```dart
import 'package:selectable_box/selectable_box.dart';
```

Then use `SelectableBox` in your widget tree:

```dart
bool isSelected = false;

SelectableBox(
  height: 250,
  width: 400,
  color: Colors.white,
  selectedColor: Colors.white,
  borderColor: Colors.grey,
  selectedBorderColor: Colors.blue,
  borderWidth: 1,
  borderRadius: 20,
  padding: const EdgeInsets.all(8),
  animationDuration: const Duration(milliseconds: 200),
  opacity: 0.5,
  selectedOpacity: 1,
  checkboxAlignment: Alignment.topRight,
  checkboxPadding: const EdgeInsets.all(0),
  selectedIcon: const Icon(
    Icons.check_circle,
    color: Colors.green,
  ),
  unSelectedIcon: const Icon(
    Icons.check_circle_outline,
    color: Colors.grey,
  ),
  showCheckbox: true,
  onTap: () {
    setState(() {
      isSelected = !isSelected;
    });
  },
  isSelected: isSelected,
  child: const Image(
    image: AssetImage('assets/images/1.jpg'),
    fit: BoxFit.cover,
  ),
),
```

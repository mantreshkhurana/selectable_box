# Selectable Box

[![GitHub stars](https://img.shields.io/github/stars/mantreshkhurana/selectable_box.svg?style=social)](https://github.com/mantreshkhurana/selectable_box)
[![pub package](https://img.shields.io/pub/v/selectable_box.svg)](https://pub.dartlang.org/packages/selectable_box)

Use SelectableBox to create a selectable box in your flutter app.

![Screenshot](https://raw.githubusercontent.com/mantreshkhurana/selectable_box/stable/screenshots/screenshot-1.png)

## Installation

Add `selectable_box: ^1.0.1` in your project's pubspec.yaml:

```yaml
dependencies:
  selectable_box: ^1.0.1
```

## Usage

Import `selectable_box` in your dart file:

```dart
import 'package:selectable_box/selectable_box.dart';
```

Then use `SelectableBox` in your widget tree:

```dart
SelectableBox(
    width: 320,
    height: 200,
    color: Colors.white,
    isSelectedColor: Colors.white,
    borderColor: Colors.grey,
    isSelectedBorderColor: Colors.blue,
    borderWidth: 1,
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    padding: const EdgeInsets.all(8),
    animationDuration: const Duration(milliseconds: 200),
    opacity: 0.6,
    isSelectedOpacity: 1,
    onTap: () {},
    isSelected: false,
    child: const Image(
      image: AssetImage('assets/images/2.jpg'),
      fit: BoxFit.cover,
    ),
),
```

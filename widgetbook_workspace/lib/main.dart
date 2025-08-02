import 'package:flutter/material.dart';
import 'package:hydex/core/ui/theme.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// This file does not exist yet,
// it will be generated in the next step
import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      lightTheme: AppTheme.theme(),
      darkTheme: AppTheme.theme(),
      addons: [
        ViewportAddon(IosViewports.phones),
        MaterialThemeAddon(
          themes: [WidgetbookTheme(name: "Light", data: AppTheme.theme())],
        ),
      ],
      directories: directories,
    );
  }
}

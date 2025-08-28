import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../style/color/color.dart';
import '../../style/theme/theme.dart';

class ThemeSettingsWidget extends StatelessWidget {
  const ThemeSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      children: [
        // Toggle light/dark
        SwitchListTile(
          title: const Text('Dark Mode'),
          value: themeProvider.isDarkMode,
          onChanged: (_) => themeProvider.toggleTheme(),
        ),
        const SizedBox(height: 16),
        // Pilihan warna primer
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _colorCircle(AppColor.red, themeProvider, context),
            _colorCircle(AppColor.green, themeProvider, context),
            _colorCircle(AppColor.blue, themeProvider, context),
          ],
        ),
      ],
    );
  }

  Widget _colorCircle(
      MaterialColor color, ThemeProvider provider, BuildContext context) {
    return GestureDetector(
      onTap: () => provider.setPrimaryColor(color),
      child: CircleAvatar(
        backgroundColor: color,
        radius: 20,
        child: provider.primaryColor == color
            ? const Icon(Icons.check, color: Colors.white)
            : null,
      ),
    );
  }
}

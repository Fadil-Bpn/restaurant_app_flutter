import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission/style/theme/theme.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context);

    bool isDesktop = MediaQuery.of(context).size.width > 800;

    Widget content = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              "Pengaturan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),

          const ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifikasi"),
            subtitle: Text("Kelola preferensi notifikasi"),
          ),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text("Tentang Aplikasi"),
            subtitle: Text("Versi 1.0.0"),
          ),
        ],
      ),
    );

    // responsive: beda tampilan desktop vs mobile
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: isDesktop
          ? Container( // desktop: panel samping
              width: MediaQuery.of(context).size.width * 0.4,
              height: double.infinity,
              padding: const EdgeInsets.all(16),
              child: content,
            )
          : Scaffold(
              appBar: AppBar(
                title: const Text("Pengaturan"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: content,
              ),
            ),
    );
  }
}


void openSettings(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Settings",
    barrierColor: Colors.black54, 
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.centerLeft,
        child: const SettingsView(),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      final offsetAnimation = Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(anim);

      return SlideTransition(position: offsetAnimation, child: child);
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
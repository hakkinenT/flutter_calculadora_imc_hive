import 'package:flutter/material.dart';

import '../pages/settings_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.network(
              "https://canalspatz.com.br/wp-content/uploads/2019/11/IMAGEM-DESTAQUE-BLOG-INFOGRAFICO-SPATZ.png",
              width: 100,
              height: 100,
            ),
          ),
          ListTile(
            title: const Text("Configurações"),
            leading: const Icon(Icons.settings),
            onTap: () => _onListTileTapped(context),
          )
        ],
      ),
    );
  }

  void _onListTileTapped(BuildContext context) {
    _closeDrawer(context);
    _goToSettingsPage(context);
  }

  void _goToSettingsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SettingsPage(),
      ),
    );
  }

  void _closeDrawer(BuildContext context) {
    Navigator.pop(context);
  }
}

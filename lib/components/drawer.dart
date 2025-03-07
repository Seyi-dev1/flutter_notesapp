import 'package:flutter/material.dart';
import 'package:flutter_notes_app/components/drawer_tile.dart';
import 'package:flutter_notes_app/pages/settings_page.dart';

class MyDrwer extends StatelessWidget {
  const MyDrwer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //header
          const DrawerHeader(
            child: (Icon(Icons.note)),
          ),

          //notes tile
          DrawerTile(
            title: "Notes",
            leading: const Icon(Icons.home),
            onTap: () => Navigator.pop(context),
          ),

          //settings tile
          DrawerTile(
              title: "Settings",
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              })
        ],
      ),
    );
  }
}

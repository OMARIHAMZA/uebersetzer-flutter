import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:uebersetzer/core/widgets/my_app_bar_widget.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SettingsList(
        lightBackgroundColor: Theme.of(context).canvasColor,
        sections: [
          // Padding Section
          EmptySection(),
          SettingsSection(
            title: 'App Settings',
            tiles: [
              SettingsTile(
                title: 'Data and Storage',
                leading: Icon(Icons.pie_chart_outline_outlined),
                onPressed: (BuildContext context) {},
              ),

              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),

              SettingsTile.switchTile(
                title: 'Dark Mode',
                switchValue: false,
                leading: Icon(Icons.invert_colors_on),
                onToggle: (value) {},
              ),

              SettingsTile(
                title: 'Interface Colors',
                subtitle: 'Default',
                leading: Icon(Icons.color_lens_outlined),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
          EmptySection(),
          EmptySection(),
          SettingsSection(
            title: 'Info & Contact',
            tiles: [
              SettingsTile(
                title: 'About',
                leading: Icon(Icons.contact_support_outlined),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Review',
                leading: Icon(Icons.thumb_up_alt_outlined),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Suggestions / Report Bugs',
                leading: Icon(Icons.chat_bubble_outline),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EmptySection extends SettingsSection {
  EmptySection() : super(title: '', tiles: []);
}

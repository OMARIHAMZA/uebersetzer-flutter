import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:uebersetzer/core/widgets/my_app_bar_widget.dart';
import 'package:uebersetzer/main.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context: context,
      ),
      body: SettingsList(
        lightBackgroundColor: Theme.of(context).canvasColor,
        sections: [
          // Padding Section
          EmptySection(),
          SettingsSection(
            title: getL10nInstance(context).appSettings,
            tiles: [
              SettingsTile(
                title: getL10nInstance(context).dataAndStorage,
                leading: Icon(Icons.pie_chart_outline_outlined),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: getL10nInstance(context).language,
                subtitle: getL10nInstance(context).english,
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: getL10nInstance(context).darkMode,
                switchValue: false,
                leading: Icon(Icons.invert_colors_on),
                onToggle: (value) {},
              ),
              SettingsTile(
                title: getL10nInstance(context).interfaceColors,
                subtitle: getL10nInstance(context).defaultColors,
                leading: Icon(Icons.color_lens_outlined),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
          EmptySection(),
          EmptySection(),
          SettingsSection(
            title: getL10nInstance(context).infoAndContact,
            tiles: [
              SettingsTile(
                title: getL10nInstance(context).about,
                leading: Icon(Icons.contact_support_outlined),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: getL10nInstance(context).review,
                leading: Icon(Icons.thumb_up_alt_outlined),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: getL10nInstance(context).suggestionsAndBugs,
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

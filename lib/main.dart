import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'injection_container.dart' as di;
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as l10n;

l10n.AppLocalizations getL10nInstance(BuildContext context) =>
    l10n.AppLocalizations.of(context);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: l10n.AppLocalizations.localizationsDelegates,
      supportedLocales: l10n.AppLocalizations.supportedLocales,
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => getL10nInstance(context).appName,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

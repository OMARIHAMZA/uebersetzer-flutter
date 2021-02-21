// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Dictionary`
  String get appName {
    return Intl.message(
      'Dictionary',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get favorites {
    return Intl.message(
      'Saved',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Copied to clipboard`
  String get dataCopied {
    return Intl.message(
      'Copied to clipboard',
      name: 'dataCopied',
      desc: '',
      args: [],
    );
  }

  /// `Nothing is here`
  String get noData {
    return Intl.message(
      'Nothing is here',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error has occurred.`
  String get unknownError {
    return Intl.message(
      'Unknown error has occurred.',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Start a search!`
  String get noSearchHistory {
    return Intl.message(
      'Start a search!',
      name: 'noSearchHistory',
      desc: '',
      args: [],
    );
  }

  /// `Local Data`
  String get localData {
    return Intl.message(
      'Local Data',
      name: 'localData',
      desc: '',
      args: [],
    );
  }

  /// `Duden`
  String get duden {
    return Intl.message(
      'Duden',
      name: 'duden',
      desc: '',
      args: [],
    );
  }

  /// `Linguee`
  String get linguee {
    return Intl.message(
      'Linguee',
      name: 'linguee',
      desc: '',
      args: [],
    );
  }

  /// `Verbformen`
  String get verbformen {
    return Intl.message(
      'Verbformen',
      name: 'verbformen',
      desc: '',
      args: [],
    );
  }

  /// `Keyword`
  String get keyword {
    return Intl.message(
      'Keyword',
      name: 'keyword',
      desc: '',
      args: [],
    );
  }

  /// `Saved Words`
  String get savedWords {
    return Intl.message(
      'Saved Words',
      name: 'savedWords',
      desc: '',
      args: [],
    );
  }

  /// `Show all`
  String get showAll {
    return Intl.message(
      'Show all',
      name: 'showAll',
      desc: '',
      args: [],
    );
  }

  /// `Listen`
  String get listen {
    return Intl.message(
      'Listen',
      name: 'listen',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `Meanings`
  String get meanings {
    return Intl.message(
      'Meanings',
      name: 'meanings',
      desc: '',
      args: [],
    );
  }

  /// `Copyright (c) Frank Richter <frank.richter@hrz.tu-chemnitz.de> 1995-2020`
  String get localDataCopyRights {
    return Intl.message(
      'Copyright (c) Frank Richter <frank.richter@hrz.tu-chemnitz.de> 1995-2020',
      name: 'localDataCopyRights',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `App Settings`
  String get appSettings {
    return Intl.message(
      'App Settings',
      name: 'appSettings',
      desc: '',
      args: [],
    );
  }

  /// `Data and Storage`
  String get dataAndStorage {
    return Intl.message(
      'Data and Storage',
      name: 'dataAndStorage',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `German`
  String get german {
    return Intl.message(
      'German',
      name: 'german',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Interface Colors`
  String get interfaceColors {
    return Intl.message(
      'Interface Colors',
      name: 'interfaceColors',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get defaultColors {
    return Intl.message(
      'Default',
      name: 'defaultColors',
      desc: '',
      args: [],
    );
  }

  /// `Info & Contact`
  String get infoAndContact {
    return Intl.message(
      'Info & Contact',
      name: 'infoAndContact',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Suggestions / Report Bugs`
  String get suggestionsAndBugs {
    return Intl.message(
      'Suggestions / Report Bugs',
      name: 'suggestionsAndBugs',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
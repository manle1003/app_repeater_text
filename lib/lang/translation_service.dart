import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/lang/value/en_US.dart';
import 'package:flutter_getx_base/lang/value/ko_KO.dart';
import 'package:flutter_getx_base/lang/value/vi_VN.dart';
import 'package:get/get.dart';

import 'value/cn_CN.dart';
import 'value/de_AT.dart';
import 'value/de_DE.dart';
import 'value/el_EL.dart';
import 'value/es_ES.dart';
import 'value/fr_FR.dart';
import 'value/hr_HR.dart';
import 'value/hu_HU.dart';
import 'value/it_IT.dart';
import 'value/jp_JP.dart';
import 'value/nl_NL.dart';
import 'value/pl_PL.dart';
import 'value/pt_BR.dart';
import 'value/ro_RO.dart';
import 'value/ru_RU.dart';
import 'value/tr_TR.dart';

class TranslationService extends Translations {
  static Locale? get locale => fallbackLocale;
  static final fallbackLocale = const Locale('en', 'US');

  static final langCodes = [
    'en',
    'vi',
    'ko',
    'cn',
    'de_AT',
    'de',
    'el',
    'es',
    'fr',
    'hr',
    'hu',
    'it',
    'jp',
    'nl',
    'pl',
    'ptBR',
    'ro',
    'ru',
    'tr'
  ];

  static final locales = [
    const Locale('en', 'US'),
    const Locale('vi', 'VN'),
    const Locale('ko', 'KO'),
    const Locale('cn', 'CN'),
    const Locale('de', 'DE'),
    const Locale('de', 'AT'),
    const Locale('el', 'GR'),
    const Locale('es', 'ES'),
    const Locale('fr', 'FR'),
    const Locale('hr', 'HR'),
    const Locale('hu', 'HU'),
    const Locale('it', 'IT'),
    const Locale('jp', 'JP'),
    const Locale('nl', 'NL'),
    const Locale('pl', 'PL'),
    const Locale('pt', 'BR'),
    const Locale('ro', 'RO'),
    const Locale('ru', 'RU'),
    const Locale('tr', 'TR'),
  ];

  static final langs = LinkedHashMap.from({
    'en': 'English',
    'vi': 'Tiếng Việt',
    'ko': 'Korean',
    'cn': 'Chinese',
    'de_AT': 'German (Austria)',
    'de': 'German',
    'el': 'Greek',
    'es': 'Spanish',
    'fr': 'French',
    'hr': 'Croatian',
    'hu': 'Hungarian',
    'it': 'Italian',
    'jp': 'Japanese',
    'nl': 'Dutch',
    'pl': 'Polish',
    'ptBR': 'Portuguese (Brazil)',
    'ro': 'Romanian',
    'ru': 'Russian',
    'tr': 'Turkish',
  });

  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
        'ko_KO': ko,
        'cn_CN': cn,
        'de_DE': de,
        'de_AT': de_AT,
        'el_GR': el,
        'es_ES': es,
        'fr_FR': fr,
        'hr_HR': hr,
        'hu_HU': hu,
        'it_IT': it,
        'jp_JP': jp,
        'nl_NL': nl,
        'pl_PL': pl,
        'pt_BR': ptBR,
        'ro_RO': ro,
        'ru_RU': ru,
        'tr_TR': tr,
      };

  static Locale _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ?? Get.deviceLocale?.languageCode;
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return Get.locale!;
  }
}

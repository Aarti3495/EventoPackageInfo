import 'package:get/get.dart';

import 'de.dart';
import 'en.dart';
import 'fr.dart';
import 'hi.dart';
import 'tha.dart';
import 'zh.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'hi_In': hi,
        'fr_FR': fr,
        'de_DE': de,
        'tha_TH': tha,
        'zh_CN': zh
      };
}

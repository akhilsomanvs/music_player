import 'dart:io';

class AppUtils {
  static String getPlatform() {
    return Platform.isAndroid ? "Android" : "iOS";
  }
}

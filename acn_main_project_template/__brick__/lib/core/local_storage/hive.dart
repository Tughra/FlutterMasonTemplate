import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const String homeBox = 'homeBox';
//const String productionCarouselKEY = 'productionCarouselKey';
//const String campaignKEY = 'campaignKEY';


//const String Message_DATA = 'messageData';
class CacheManager {
  static Box<Map>? homeBoxCache;
  static Future init() async {
    var applicationsDocumentDirectory = await getApplicationDocumentsDirectory();
    var hiveBoxPath = '${applicationsDocumentDirectory.path}/dataCatch';
    Hive.init(hiveBoxPath);
    homeBoxCache = await Hive.openBox<Map>(homeBox);
    //cacheBox ??= Hive.box(CACHE_BOX);
  }

/*
  static int getDiff(String key) {
    int t = cacheBox?.get(key) ?? 0;
    print(t);
    var time = DateTime.fromMillisecondsSinceEpoch(t * 1000);
    print(time);
    var diff = currentDateTime.difference(time).inMinutes;
    print(diff);
    return diff ?? 0;
  }
 */

/*
  /// Removes notification from cache
  static Future<void> purgeTranslation() async {
    //await cacheTranslationBox?.delete(translationKEY);
    cacheFilterBox?.deleteFromDisk();
  }
 */
  static Future<void> purgeFromHomeBoxCatch(String key)async{
    await homeBoxCache?.delete(key);
  }

  void closeHive() {
    Hive.close();
  }
}

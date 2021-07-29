import 'package:mealsApp/CacheService/ICacheService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesCache implements ICacheService {
  static SharedPreferences _instance;

  static Future init() async =>
      _instance = await SharedPreferences.getInstance();

  @override
  Future<bool> addToCache(
    String key,
    String dataToCache,
    String collectionName,
  ) async {
    try {
      final dateFetched = DateTime.now();
      final isAdded = await _instance.setString(
        key,
        dataToCache,
      );
      await _instance.setString(collectionName, dateFetched.toIso8601String());
      if (isAdded) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  @override
  Future<String> readFromCache(String cacheKey, String collectionName) {
    try {
      final dataFromCache = _instance.getString(cacheKey);
      return Future.value(dataFromCache);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> removeFromCache(String cacheKey) async {
    try {
      final isRemoved = await _instance.remove(cacheKey);
      if (isRemoved) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      rethrow;
    }
  }

  /// performs a validation on the cached data
  /// if the data has been in cache for less than or equal to  30 days. The method will return [false]
  /// if the data has been in cache for more than 30 days. The method will return [true]

  static bool validateDataNotStale(String collectionName) {
    // today's date
    final dateToday = DateTime.now();
    // fetch the date when the data was added to the cache
    if (_instance.containsKey(collectionName)) {
      final dateAdded = _instance.getString(collectionName);

      // parse the string to a DateTime object
      final dateDataGotCached = DateTime.parse(dateAdded);

      // perform DateTime Arithmetic
      final daysElapsed = dateToday.difference(dateDataGotCached);

      // check if the data is still valid
      if (daysElapsed.inDays > ICacheService.maxNumberOfDays) {
        // data is stale
        return true;
      } else {
        // data is not stale
        return false;
      }
    } else {
      return true;
    }
  }
}

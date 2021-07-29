abstract class ICacheService {
  /// This denotes the maximum number of days data is kept in the cache before it becomes stale and is refreshed
  static int get maxNumberOfDays => 30;

  /// This method add data in [String] format to the cache for persistence.
  Future<bool> addToCache(
      String key, String dataToCache, String collectionName);

  /// This method reads data from the cache which matches the supplied Key.
  Future<String> readFromCache(String cacheKey, String collectionName);

  /// This method removes a data item which matches the supplied key from cache storage
  Future<bool> removeFromCache(String cacheKey);
}

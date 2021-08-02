import 'dart:collection';

class RepositoryCache {
  RepositoryCache._privateConstructor();

  static final RepositoryCache _instance =
      RepositoryCache._privateConstructor();

  factory RepositoryCache() {
    return _instance;
  }

  int _maxObjects = 4096;

  set maxObjects(int value) {
    _maxObjects = value;
    _trimCache();
  }

  final LinkedHashMap<String, Object> _cache = LinkedHashMap();
  int get numObjects => _cache.length;

  // We want to keep track of type, because when we do persistent storage
  // we will be serializing to/from json, we need to know which
  // (de)serializer to use.
  String _getStorageKey(String key, Type type) => '$key:%:$type';

  Object? _pingAndGetObject(String storageKey) {
    final existing = _cache.remove(storageKey);
    if (existing != null) {
      _cache[storageKey] = existing;
    }
    return existing;
  }

  void _trimCache() {
    while (_cache.length > _maxObjects) {
      _cache.remove(_cache.keys.first);
    }
  }

  List<T>? readObjectList<T>(String key) => getObject(key, T) as List<T>?;

  List<Object>? getObjectList(String key, Type type) =>
      getObject(key, type) as List<Object>?;

  T? readObject<T>(String key) => getObject(key, T) as T?;

  Object? getObject(String key, Type type) =>
      _pingAndGetObject(_getStorageKey(key, type));

  Object _storeObject(String storageKey, Object obj) {
    // Remove before adding to add to end of linked map
    _cache.remove(storageKey);
    _cache[storageKey] = obj;
    _trimCache();
    return obj;
  }

  List<T> stowObjectList<T>(String key, List<T> obj) =>
      _storeObject(_getStorageKey(key, T), obj) as List<T>;

  List<Object> putObjectList(String key, List<Object> obj) =>
      _storeObject(_getStorageKey(key, obj.first.runtimeType), obj)
          as List<Object>;

  T stowObject<T>(String key, T obj) => _storeObject(_getStorageKey(key, T), obj as Object) as T;
  Object putObject(String key, Object obj) =>
      _storeObject(_getStorageKey(key, obj.runtimeType), obj);

  T? clearObject<T>(String key) {
    final storageKey = _getStorageKey(key, T);
    return _cache.remove(storageKey) as T;
  }

  void clearCache() => _cache.clear();
}

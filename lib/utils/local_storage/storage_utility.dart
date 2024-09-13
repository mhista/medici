import 'package:hive/hive.dart';

class HiveService {
  // static  HiveService _instance = HiveService._internal();
  // SINGLETON INSTANCE
  static HiveService? _instance;
  Box? _box;

  factory HiveService.instance() {
    _instance ??= HiveService._internal();
    return _instance!;
  }

  HiveService._internal();

  // late final _storage;

  static Future<void> init(String path) async {
    //  Hive.init(bucketName);
    Hive.init(path);
    _instance = HiveService._internal();
    // _instance!._storage = Hive.init();
  }

  static Future<void> openBox(String boxName) async {
    if (_instance == null) {
      throw Exception('HiveService is not initialized');
    }
    _instance!._box = await Hive.openBox(boxName);
  }

  // get a box from the instance
  Box get box => _instance!._box!;

// generic method to save data
  Future<void> put<T>(String key, T value) async {
    if (_instance == null) {
      throw Exception('HiveService is not initialized');
    }
    await _box?.put(key, value);
  }

  // generic method to read data
  T? get<T>(String key, {T? defaultValue}) {
    if (_instance == null) {
      throw Exception('HiveService is not initialized');
    }
    return _box?.get(key, defaultValue: defaultValue) as T?;
  }

  // check if key exists in the box
  bool containsKey(String key) {
    if (_instance == null) {
      throw Exception('HiveService is not initialized');
    }
    return _box?.containsKey(key) ?? false;
  }

  // check if box is empty
  bool isEmpty() {
    if (_instance == null) {
      throw Exception('HiveService is not initialized');
    }
    return _box?.isEmpty ?? false;
  }

// generic method to remove data
  Future<void> removeData(String key) async {
    if (_instance == null) {
      throw Exception('HiveService is not initialized');
    }
    await _box?.delete(key);
  }

// clear all data in storage
  Future<void> clearAll(Iterable<dynamic> keys) async {
    if (_instance == null) {
      throw Exception('HiveService is not initialized');
    }
    await _box?.deleteAll(keys);
  }
}

// //

// // void work() {
// //   HiveService localStorage = HiveService._instance;

// // // SAVE DATA
// //   localStorage.saveData('UserName', 'JohnDoe');

// //   // READ DATA
// //   localStorage.readData('UserName');

// //   // REMOVE DATA
// //   localStorage.removeData('UserName');

// // // CLEAR ALL
// //   localStorage.clearAll();
// // }

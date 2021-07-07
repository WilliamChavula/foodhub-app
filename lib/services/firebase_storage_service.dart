import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

abstract class StorageService {
  Future<ListResult> listFilesInStorageFolders();
  Future<List<Map<String, List<dynamic>>>> getImageURL(String filePath);
  Future<void> uploadFile(String filePath);
}

class FirebaseStorageService implements StorageService {
  FirebaseStorage storage = FirebaseStorage.instance;

  /// Get Storage reference to a folder within FirebaseStorage
  Reference getStorageReference({String reference}) {
    try {
      if (reference != null) {
        return storage.ref().child(reference);
      } else
        return storage.ref();
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw (e.message);
    }
  }

  /// get a list of all files within a specific directory.
  /// Reference can either be a single directory or a path in the case of a nested directory.
  Future<ListResult> listFilesInStorageFolders(
      {@required String reference}) async {
    return await getStorageReference(reference: reference).listAll();
  }

  /// get list of files in a storage ref
  /// iterate through the files and get download url
  /// get a download url for an image.
  Future<List<Map<String, List<dynamic>>>> getImageURL(String reference) async {
    try {
      List<Map<String, List<dynamic>>> downloadUrls = [];
      ListResult result;

      result = await listFilesInStorageFolders(reference: reference);

      // call two seperate methods one to handle directories and another regular files.
      if (result.prefixes.isNotEmpty) {
        for (var prefix in result.prefixes) {
          var path = prefix.fullPath;
          result = await listFilesInStorageFolders(reference: path);
          var name = prefix.fullPath.split("/")[1];
          var data = await downloadUrlHelper(result.items, name);
          // 1. Call a function and pass result.items and optional name key as parameters
          // 2. the function should return a map with download urls.
          // 3. the map object you have string key and lists and values  e.g. {"a": ["b", "c", "d"]}

          downloadUrls.add(data);
        }
        return downloadUrls;
      }

      for (var i = 0; i < result.items.length; ++i) {
        var name = result.items[i].name.split(".")[0];
        var item = result.items[i];
        var data = await downloadUrlHelperFunc(item, name);

        downloadUrls.add(data);
      }
      return downloadUrls;
    } on SocketException {
      throw SocketException('Failed to download');
    }
  }

  Future<Map<String, List<dynamic>>> downloadUrlHelperFunc(
      Reference paths, String mapKeyName) async {
    var tempList = [];
    var _map = <String, List<dynamic>>{};

    var _refUrl = paths.fullPath;
    try {
      String downloadURL = await storage.ref(_refUrl).getDownloadURL();
      tempList.add(downloadURL);

      _map[mapKeyName] = tempList;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw (e.message);
    }

    return _map;
  }

  Future<Map<String, List<dynamic>>> downloadUrlHelper(
      List<Reference> paths, String mapKeyName) async {
    var tempList = [];
    var _map = <String, List<dynamic>>{};

    for (var i = 0; i < paths.length; ++i) {
      var _refUrl = paths[i].fullPath;
      try {
        String downloadURL = await storage.ref(_refUrl).getDownloadURL();
        tempList.add(downloadURL);

        _map[mapKeyName] = tempList;
      } on FirebaseException catch (e) {
        throw Exception(e.message);
      } catch (e) {
        throw (e.message);
      }
    }

    return _map;
  }

  Future<void> uploadFile(String filePath, {String reference}) async {
    File file = File(filePath);
    try {
      await storage.ref().putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e);
    } catch (e) {
      throw (e.message);
    }
  }
}

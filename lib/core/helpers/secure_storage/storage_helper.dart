// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'storage_key_helper.dart';

class Storage {
  final _storage = const FlutterSecureStorage();
  Future<String?> get getUserId async => await read(StorageKey.userId);
  Future<String?> get getEmailUser async => await read(StorageKey.emailUser);
  Future<String?> get getAuthToken async => await read(StorageKey.authToken);
  Future<String?> get getRefreshToken async =>
      await read(StorageKey.refreshToken);
  Future<String?> get getFullName async => await read(StorageKey.fullName);
  Future<String?> get hostTeamId async => await read(StorageKey.hostTeamId);
  Future<String?> get imageUser async => await read(StorageKey.imageUser);
  Future<String?> get university async => await read(StorageKey.university);
  Future<String?> get encryptPassword async =>
      await read(StorageKey.encryptPassword);
  Future<bool> get getLogged async => await readLogged();

  // Future<String?> get getLastLocation async =>
  //     await read(StorageKey.lastLocation);

  Future<void> write(StorageKey key, String value) async {
    _storage.write(
      key: describeEnum(key),
      value: value,
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  Future<String?> read(StorageKey key) async {
    return await _storage.read(
        key: describeEnum(key),
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ));
  }

  Future<bool> readLogged() async {
    // New method to read logged status as bool
    final loggedString = await _storage.read(
        key: describeEnum(StorageKey.logged),
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ));
    return loggedString?.toLowerCase() == 'true'; // Convert string to bool
  }

  Future<void> clear(StorageKey key) async {
    await _storage.delete(
      key: describeEnum(key),
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  Future<void> clearAll() async {
    await _storage.delete(
      key: describeEnum(StorageKey.authToken),
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );

    await _storage.delete(
      key: describeEnum(StorageKey.fullName),
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );

    await _storage.delete(
      key: describeEnum(StorageKey.userId),
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  Future<void> clearAllData() async {
    await _storage.deleteAll();
  }
}

final storage = Storage();

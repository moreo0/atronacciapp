import 'dart:convert';
import 'package:crypto/crypto.dart';

class HashDataSHA256 {
  HashDataSHA256._internal();

  static String hashSHA256(String plainText) {
    var bytesToHash = utf8.encode(plainText);
    var sha256Digest = sha256.convert(bytesToHash);
    return sha256Digest.toString().toUpperCase();
  }
}
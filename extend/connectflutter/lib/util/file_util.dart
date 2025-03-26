// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

/*
 * Copyright (c) 2019 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class FileUtil {
  const FileUtil._(); // インスタンス化を防ぐ
  static Future<File> _localFile(String filename) async {
    final path = await localPath;
    return File('$path/$filename');
  }

  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> getFilename(
    String userId,
    String type,
    String key,
  ) async {
    return userId + '/' + type + '/' + key;
  }

  static Future<Uint8List?> getImage(String userId, String key) async {
    final filename = await getFilename(userId, 'images', key);
    final file = await _localFile(filename);

    if (await file.exists()) return await file.readAsBytes();
    return null;
  }

  static Future<String?> getString(String userId, String key) async {
    final filename = await getFilename(userId, 'strings', key);
    final file = await _localFile(filename);

    if (await file.exists()) return await file.readAsString();
    return null;
  }

  static Future<Map<String, dynamic>?> getObject(
    String userId,
    String key,
  ) async {
    final filename = await getFilename(userId, 'objects', key);
    final file = await _localFile(filename);

    if (await file.exists()) {
      final objectString = await file.readAsString();
      return JsonDecoder().convert(objectString);
    }

    return null;
  }

  static Future<String> saveImage(
    String userId,
    String key,
    Uint8List image,
  ) async {
    final filename = await getFilename(userId, 'images', key);
    final file = await _localFile(filename);

    if (!await file.parent.exists()) await file.parent.create(recursive: true);

    await file.writeAsBytes(image);

    return filename;
  }

  static void saveObject(
    String userId,
    String key,
    Map<String, dynamic> object,
  ) async {
    final filename = await getFilename(userId, 'objects', key);
    final file = await _localFile(filename);

    if (!await file.parent.exists()) await file.parent.create(recursive: true);

    final jsonString = JsonEncoder().convert(object);
    await file.writeAsString(jsonString);
  }

  static void saveString(String userId, String key, String value) async {
    final filename = await getFilename(userId, 'strings', key);
    final file = await _localFile(filename);

    if (!await file.parent.exists()) await file.parent.create(recursive: true);

    await file.writeAsString(value);
  }

  static Future<void> removeImage(String userId, String key) async {
    final filename = await getFilename(userId, 'images', key);
    final file = await _localFile(filename);
    if (await file.exists()) await file.delete();
  }

  static Future<void> removeObject(String userId, String key) async {
    final filename = await getFilename(userId, 'objects', key);
    final file = await _localFile(filename);
    if (await file.exists()) await file.delete();
  }

  static Future<void> removeString(String userId, String key) async {
    final filename = await getFilename(userId, 'strings', key);
    final file = await _localFile(filename);
    if (await file.exists()) await file.delete();
  }
}

import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import '../../auth/auth_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

List<LectureArrayElementStruct> sortLectureArray(
  List<LectureArrayElementStruct> lectureArray,
  bool descending,
) {
  int compare(DateTime? a, DateTime? b) {
    DateTime _a = a ?? DateTime.now();
    DateTime _b = b ?? DateTime.now();
    return descending ? _b.compareTo(_a) : _a.compareTo(_b);
  }

  List<LectureArrayElementStruct> sortedLectureArray = List.from(lectureArray);

  sortedLectureArray.sort((a, b) => compare(a.timestamp, b.timestamp));
  return sortedLectureArray;
}

List<LectureArrayElementStruct> filterLectureArrayByPage(
  List<LectureArrayElementStruct> lectureArray,
  int mediaPage,
) {
  List<LectureArrayElementStruct> filteredLectureArray =
      List.from(lectureArray);

  filteredLectureArray
      .removeWhere((element) => element.contentMediaPage != mediaPage);

  return filteredLectureArray;
}

Future<String> uploadContentMedia(
    String? cid, DocumentReference? courseIndexRef) async {
  //FilePickerResult? result = await FilePicker.platform
  //    .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

  String? downloadURL = await pickAndUploadFile();
  if (downloadURL != null) {
    // Use the download URL as needed
    final courseIndexUpdateData =
        createCourseIndexRecordData(contentMediaURL: downloadURL);
    await courseIndexRef!.update(courseIndexUpdateData);

    print('Uploaded file to $downloadURL');
    return downloadURL;
  } else {
    return '';
  }
}

Future<String?> pickAndUploadFile() async {
  try {
    // Pick a file using the file_picker package
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);

      // Upload the file to Firebase Storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('uploads')
          .child('${DateTime.now().toIso8601String()}${file.path}');
      final taskSnapshot = await ref.putFile(file);

      // Get the download URL for the uploaded file
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print('File uploaded successfully, download URL: $downloadUrl');
      return downloadUrl;
    } else {
      print('No file selected');
      return null;
    }
  } catch (e) {
    print('Failed to upload file: $e');
    return null;
  }
}

// ex) "ko-KR" => "한국어"
String getLanguageName(String languageCode) {
  switch (languageCode) {
    case 'ko-KR':
      return '한국어';
    case 'en-US':
      return 'English';
    default:
      return '';
  }
}

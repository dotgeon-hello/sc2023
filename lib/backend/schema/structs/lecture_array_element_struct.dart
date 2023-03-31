import 'dart:async';

import '../index.dart';
import '../serializers.dart';
import 'package:built_value/built_value.dart';

part 'lecture_array_element_struct.g.dart';

abstract class LectureArrayElementStruct
    implements
        Built<LectureArrayElementStruct, LectureArrayElementStructBuilder> {
  static Serializer<LectureArrayElementStruct> get serializer =>
      _$lectureArrayElementStructSerializer;

  String? get content;

  bool? get isQuestion;

  DateTime? get timestamp;

  int? get contentMediaPage;

  /// Utility class for Firestore updates
  FirestoreUtilData get firestoreUtilData;

  static void _initializeBuilder(LectureArrayElementStructBuilder builder) =>
      builder
        ..content = ''
        ..isQuestion = false
        ..contentMediaPage = 0
        ..firestoreUtilData = FirestoreUtilData();

  LectureArrayElementStruct._();
  factory LectureArrayElementStruct(
          [void Function(LectureArrayElementStructBuilder) updates]) =
      _$LectureArrayElementStruct;
}

LectureArrayElementStruct createLectureArrayElementStruct({
  String? content,
  bool? isQuestion,
  DateTime? timestamp,
  int? contentMediaPage,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LectureArrayElementStruct(
      (l) => l
        ..content = content
        ..isQuestion = isQuestion
        ..timestamp = timestamp
        ..contentMediaPage = contentMediaPage
        ..firestoreUtilData = FirestoreUtilData(
          clearUnsetFields: clearUnsetFields,
          create: create,
          delete: delete,
          fieldValues: fieldValues,
        ),
    );

LectureArrayElementStruct? updateLectureArrayElementStruct(
  LectureArrayElementStruct? lectureArrayElement, {
  bool clearUnsetFields = true,
}) =>
    lectureArrayElement != null
        ? (lectureArrayElement.toBuilder()
              ..firestoreUtilData =
                  FirestoreUtilData(clearUnsetFields: clearUnsetFields))
            .build()
        : null;

void addLectureArrayElementStructData(
  Map<String, dynamic> firestoreData,
  LectureArrayElementStruct? lectureArrayElement,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (lectureArrayElement == null) {
    return;
  }
  if (lectureArrayElement.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  if (!forFieldValue &&
      lectureArrayElement.firestoreUtilData.clearUnsetFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final lectureArrayElementData =
      getLectureArrayElementFirestoreData(lectureArrayElement, forFieldValue);
  final nestedData =
      lectureArrayElementData.map((k, v) => MapEntry('$fieldName.$k', v));

  final create = lectureArrayElement.firestoreUtilData.create;
  firestoreData.addAll(create ? mergeNestedFields(nestedData) : nestedData);

  return;
}

Map<String, dynamic> getLectureArrayElementFirestoreData(
  LectureArrayElementStruct? lectureArrayElement, [
  bool forFieldValue = false,
]) {
  if (lectureArrayElement == null) {
    return {};
  }
  final firestoreData = serializers.toFirestore(
      LectureArrayElementStruct.serializer, lectureArrayElement);

  // Add any Firestore field values
  lectureArrayElement.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLectureArrayElementListFirestoreData(
  List<LectureArrayElementStruct>? lectureArrayElements,
) =>
    lectureArrayElements
        ?.map((l) => getLectureArrayElementFirestoreData(l, true))
        .toList() ??
    [];

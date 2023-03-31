import 'dart:async';

import '../index.dart';
import '../serializers.dart';
import 'package:built_value/built_value.dart';

part 'summary_array_element_struct.g.dart';

abstract class SummaryArrayElementStruct
    implements
        Built<SummaryArrayElementStruct, SummaryArrayElementStructBuilder> {
  static Serializer<SummaryArrayElementStruct> get serializer =>
      _$summaryArrayElementStructSerializer;

  String? get summaryContent;

  DateTime? get timestamp;

  /// Utility class for Firestore updates
  FirestoreUtilData get firestoreUtilData;

  static void _initializeBuilder(SummaryArrayElementStructBuilder builder) =>
      builder
        ..summaryContent = ''
        ..firestoreUtilData = FirestoreUtilData();

  SummaryArrayElementStruct._();
  factory SummaryArrayElementStruct(
          [void Function(SummaryArrayElementStructBuilder) updates]) =
      _$SummaryArrayElementStruct;
}

SummaryArrayElementStruct createSummaryArrayElementStruct({
  String? summaryContent,
  DateTime? timestamp,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SummaryArrayElementStruct(
      (s) => s
        ..summaryContent = summaryContent
        ..timestamp = timestamp
        ..firestoreUtilData = FirestoreUtilData(
          clearUnsetFields: clearUnsetFields,
          create: create,
          delete: delete,
          fieldValues: fieldValues,
        ),
    );

SummaryArrayElementStruct? updateSummaryArrayElementStruct(
  SummaryArrayElementStruct? summaryArrayElement, {
  bool clearUnsetFields = true,
}) =>
    summaryArrayElement != null
        ? (summaryArrayElement.toBuilder()
              ..firestoreUtilData =
                  FirestoreUtilData(clearUnsetFields: clearUnsetFields))
            .build()
        : null;

void addSummaryArrayElementStructData(
  Map<String, dynamic> firestoreData,
  SummaryArrayElementStruct? summaryArrayElement,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (summaryArrayElement == null) {
    return;
  }
  if (summaryArrayElement.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  if (!forFieldValue &&
      summaryArrayElement.firestoreUtilData.clearUnsetFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final summaryArrayElementData =
      getSummaryArrayElementFirestoreData(summaryArrayElement, forFieldValue);
  final nestedData =
      summaryArrayElementData.map((k, v) => MapEntry('$fieldName.$k', v));

  final create = summaryArrayElement.firestoreUtilData.create;
  firestoreData.addAll(create ? mergeNestedFields(nestedData) : nestedData);

  return;
}

Map<String, dynamic> getSummaryArrayElementFirestoreData(
  SummaryArrayElementStruct? summaryArrayElement, [
  bool forFieldValue = false,
]) {
  if (summaryArrayElement == null) {
    return {};
  }
  final firestoreData = serializers.toFirestore(
      SummaryArrayElementStruct.serializer, summaryArrayElement);

  // Add any Firestore field values
  summaryArrayElement.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSummaryArrayElementListFirestoreData(
  List<SummaryArrayElementStruct>? summaryArrayElements,
) =>
    summaryArrayElements
        ?.map((s) => getSummaryArrayElementFirestoreData(s, true))
        .toList() ??
    [];

import 'dart:async';

import '../index.dart';
import '../serializers.dart';
import 'package:built_value/built_value.dart';

part 'quiz_array_element_struct.g.dart';

abstract class QuizArrayElementStruct
    implements Built<QuizArrayElementStruct, QuizArrayElementStructBuilder> {
  static Serializer<QuizArrayElementStruct> get serializer =>
      _$quizArrayElementStructSerializer;

  String? get type;

  QuizTypeShortAnswerStruct get quizShortAnswer;

  QuizTypeChoiceStruct get quizChoice;

  /// Utility class for Firestore updates
  FirestoreUtilData get firestoreUtilData;

  static void _initializeBuilder(QuizArrayElementStructBuilder builder) =>
      builder
        ..type = ''
        ..quizShortAnswer = QuizTypeShortAnswerStructBuilder()
        ..quizChoice = QuizTypeChoiceStructBuilder()
        ..firestoreUtilData = FirestoreUtilData();

  QuizArrayElementStruct._();
  factory QuizArrayElementStruct(
          [void Function(QuizArrayElementStructBuilder) updates]) =
      _$QuizArrayElementStruct;
}

QuizArrayElementStruct createQuizArrayElementStruct({
  String? type,
  QuizTypeShortAnswerStruct? quizShortAnswer,
  QuizTypeChoiceStruct? quizChoice,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    QuizArrayElementStruct(
      (q) => q
        ..type = type
        ..quizShortAnswer =
            quizShortAnswer?.toBuilder() ?? QuizTypeShortAnswerStructBuilder()
        ..quizChoice = quizChoice?.toBuilder() ?? QuizTypeChoiceStructBuilder()
        ..firestoreUtilData = FirestoreUtilData(
          clearUnsetFields: clearUnsetFields,
          create: create,
          delete: delete,
          fieldValues: fieldValues,
        ),
    );

QuizArrayElementStruct? updateQuizArrayElementStruct(
  QuizArrayElementStruct? quizArrayElement, {
  bool clearUnsetFields = true,
}) =>
    quizArrayElement != null
        ? (quizArrayElement.toBuilder()
              ..firestoreUtilData =
                  FirestoreUtilData(clearUnsetFields: clearUnsetFields))
            .build()
        : null;

void addQuizArrayElementStructData(
  Map<String, dynamic> firestoreData,
  QuizArrayElementStruct? quizArrayElement,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (quizArrayElement == null) {
    return;
  }
  if (quizArrayElement.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  if (!forFieldValue && quizArrayElement.firestoreUtilData.clearUnsetFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final quizArrayElementData =
      getQuizArrayElementFirestoreData(quizArrayElement, forFieldValue);
  final nestedData =
      quizArrayElementData.map((k, v) => MapEntry('$fieldName.$k', v));

  final create = quizArrayElement.firestoreUtilData.create;
  firestoreData.addAll(create ? mergeNestedFields(nestedData) : nestedData);

  return;
}

Map<String, dynamic> getQuizArrayElementFirestoreData(
  QuizArrayElementStruct? quizArrayElement, [
  bool forFieldValue = false,
]) {
  if (quizArrayElement == null) {
    return {};
  }
  final firestoreData = serializers.toFirestore(
      QuizArrayElementStruct.serializer, quizArrayElement);

  // Handle nested data for "quizShortAnswer" field.
  addQuizTypeShortAnswerStructData(firestoreData,
      quizArrayElement.quizShortAnswer, 'quizShortAnswer', forFieldValue);

  // Handle nested data for "quizChoice" field.
  addQuizTypeChoiceStructData(
      firestoreData, quizArrayElement.quizChoice, 'quizChoice', forFieldValue);

  // Add any Firestore field values
  quizArrayElement.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getQuizArrayElementListFirestoreData(
  List<QuizArrayElementStruct>? quizArrayElements,
) =>
    quizArrayElements
        ?.map((q) => getQuizArrayElementFirestoreData(q, true))
        .toList() ??
    [];

import 'dart:async';

import '../index.dart';
import '../serializers.dart';
import 'package:built_value/built_value.dart';

part 'quiz_type_choice_struct.g.dart';

abstract class QuizTypeChoiceStruct
    implements Built<QuizTypeChoiceStruct, QuizTypeChoiceStructBuilder> {
  static Serializer<QuizTypeChoiceStruct> get serializer =>
      _$quizTypeChoiceStructSerializer;

  String? get question;

  BuiltList<String>? get choices;

  int? get answer;

  /// Utility class for Firestore updates
  FirestoreUtilData get firestoreUtilData;

  static void _initializeBuilder(QuizTypeChoiceStructBuilder builder) => builder
    ..question = ''
    ..choices = ListBuilder()
    ..answer = 0
    ..firestoreUtilData = FirestoreUtilData();

  QuizTypeChoiceStruct._();
  factory QuizTypeChoiceStruct(
          [void Function(QuizTypeChoiceStructBuilder) updates]) =
      _$QuizTypeChoiceStruct;
}

QuizTypeChoiceStruct createQuizTypeChoiceStruct({
  String? question,
  int? answer,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    QuizTypeChoiceStruct(
      (q) => q
        ..question = question
        ..choices = null
        ..answer = answer
        ..firestoreUtilData = FirestoreUtilData(
          clearUnsetFields: clearUnsetFields,
          create: create,
          delete: delete,
          fieldValues: fieldValues,
        ),
    );

QuizTypeChoiceStruct? updateQuizTypeChoiceStruct(
  QuizTypeChoiceStruct? quizTypeChoice, {
  bool clearUnsetFields = true,
}) =>
    quizTypeChoice != null
        ? (quizTypeChoice.toBuilder()
              ..firestoreUtilData =
                  FirestoreUtilData(clearUnsetFields: clearUnsetFields))
            .build()
        : null;

void addQuizTypeChoiceStructData(
  Map<String, dynamic> firestoreData,
  QuizTypeChoiceStruct? quizTypeChoice,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (quizTypeChoice == null) {
    return;
  }
  if (quizTypeChoice.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  if (!forFieldValue && quizTypeChoice.firestoreUtilData.clearUnsetFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final quizTypeChoiceData =
      getQuizTypeChoiceFirestoreData(quizTypeChoice, forFieldValue);
  final nestedData =
      quizTypeChoiceData.map((k, v) => MapEntry('$fieldName.$k', v));

  final create = quizTypeChoice.firestoreUtilData.create;
  firestoreData.addAll(create ? mergeNestedFields(nestedData) : nestedData);

  return;
}

Map<String, dynamic> getQuizTypeChoiceFirestoreData(
  QuizTypeChoiceStruct? quizTypeChoice, [
  bool forFieldValue = false,
]) {
  if (quizTypeChoice == null) {
    return {};
  }
  final firestoreData =
      serializers.toFirestore(QuizTypeChoiceStruct.serializer, quizTypeChoice);

  // Add any Firestore field values
  quizTypeChoice.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getQuizTypeChoiceListFirestoreData(
  List<QuizTypeChoiceStruct>? quizTypeChoices,
) =>
    quizTypeChoices
        ?.map((q) => getQuizTypeChoiceFirestoreData(q, true))
        .toList() ??
    [];

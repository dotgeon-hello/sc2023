import 'dart:async';

import '../index.dart';
import '../serializers.dart';
import 'package:built_value/built_value.dart';

part 'quiz_type_short_answer_struct.g.dart';

abstract class QuizTypeShortAnswerStruct
    implements
        Built<QuizTypeShortAnswerStruct, QuizTypeShortAnswerStructBuilder> {
  static Serializer<QuizTypeShortAnswerStruct> get serializer =>
      _$quizTypeShortAnswerStructSerializer;

  String? get question;

  String? get answer;

  /// Utility class for Firestore updates
  FirestoreUtilData get firestoreUtilData;

  static void _initializeBuilder(QuizTypeShortAnswerStructBuilder builder) =>
      builder
        ..question = ''
        ..answer = ''
        ..firestoreUtilData = FirestoreUtilData();

  QuizTypeShortAnswerStruct._();
  factory QuizTypeShortAnswerStruct(
          [void Function(QuizTypeShortAnswerStructBuilder) updates]) =
      _$QuizTypeShortAnswerStruct;
}

QuizTypeShortAnswerStruct createQuizTypeShortAnswerStruct({
  String? question,
  String? answer,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    QuizTypeShortAnswerStruct(
      (q) => q
        ..question = question
        ..answer = answer
        ..firestoreUtilData = FirestoreUtilData(
          clearUnsetFields: clearUnsetFields,
          create: create,
          delete: delete,
          fieldValues: fieldValues,
        ),
    );

QuizTypeShortAnswerStruct? updateQuizTypeShortAnswerStruct(
  QuizTypeShortAnswerStruct? quizTypeShortAnswer, {
  bool clearUnsetFields = true,
}) =>
    quizTypeShortAnswer != null
        ? (quizTypeShortAnswer.toBuilder()
              ..firestoreUtilData =
                  FirestoreUtilData(clearUnsetFields: clearUnsetFields))
            .build()
        : null;

void addQuizTypeShortAnswerStructData(
  Map<String, dynamic> firestoreData,
  QuizTypeShortAnswerStruct? quizTypeShortAnswer,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (quizTypeShortAnswer == null) {
    return;
  }
  if (quizTypeShortAnswer.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  if (!forFieldValue &&
      quizTypeShortAnswer.firestoreUtilData.clearUnsetFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final quizTypeShortAnswerData =
      getQuizTypeShortAnswerFirestoreData(quizTypeShortAnswer, forFieldValue);
  final nestedData =
      quizTypeShortAnswerData.map((k, v) => MapEntry('$fieldName.$k', v));

  final create = quizTypeShortAnswer.firestoreUtilData.create;
  firestoreData.addAll(create ? mergeNestedFields(nestedData) : nestedData);

  return;
}

Map<String, dynamic> getQuizTypeShortAnswerFirestoreData(
  QuizTypeShortAnswerStruct? quizTypeShortAnswer, [
  bool forFieldValue = false,
]) {
  if (quizTypeShortAnswer == null) {
    return {};
  }
  final firestoreData = serializers.toFirestore(
      QuizTypeShortAnswerStruct.serializer, quizTypeShortAnswer);

  // Add any Firestore field values
  quizTypeShortAnswer.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getQuizTypeShortAnswerListFirestoreData(
  List<QuizTypeShortAnswerStruct>? quizTypeShortAnswers,
) =>
    quizTypeShortAnswers
        ?.map((q) => getQuizTypeShortAnswerFirestoreData(q, true))
        .toList() ??
    [];

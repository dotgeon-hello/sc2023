import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'course_content_record.g.dart';

abstract class CourseContentRecord
    implements Built<CourseContentRecord, CourseContentRecordBuilder> {
  static Serializer<CourseContentRecord> get serializer =>
      _$courseContentRecordSerializer;

  String? get id;

  BuiltList<LectureArrayElementStruct>? get lectureArray;

  BuiltList<SummaryArrayElementStruct>? get summaryArray;

  BuiltList<QuizArrayElementStruct>? get quizArray;

  String? get contentMediaURL;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(CourseContentRecordBuilder builder) => builder
    ..id = ''
    ..lectureArray = ListBuilder()
    ..summaryArray = ListBuilder()
    ..quizArray = ListBuilder()
    ..contentMediaURL = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('CourseContent');

  static Stream<CourseContentRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<CourseContentRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  CourseContentRecord._();
  factory CourseContentRecord(
          [void Function(CourseContentRecordBuilder) updates]) =
      _$CourseContentRecord;

  static CourseContentRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createCourseContentRecordData({String? id}) {
  final firestoreData = serializers.toFirestore(
    CourseContentRecord.serializer,
    CourseContentRecord(
      (c) => c
        ..id = id
        ..lectureArray = null
        ..summaryArray = null
        ..quizArray = null
        ..contentMediaURL = null,
    ),
  );

  return firestoreData;
}

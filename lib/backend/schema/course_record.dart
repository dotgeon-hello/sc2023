import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'course_record.g.dart';

abstract class CourseRecord
    implements Built<CourseRecord, CourseRecordBuilder> {
  static Serializer<CourseRecord> get serializer => _$courseRecordSerializer;

  DocumentReference? get user;

  String? get cid;

  String? get courseName;

  String? get courseTutor;

  CourseScheduleStruct get courseSchedule;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(CourseRecordBuilder builder) => builder
    ..cid = ''
    ..courseName = ''
    ..courseTutor = ''
    ..courseSchedule = CourseScheduleStructBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Course');

  static Stream<CourseRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<CourseRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  CourseRecord._();
  factory CourseRecord([void Function(CourseRecordBuilder) updates]) =
      _$CourseRecord;

  static CourseRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createCourseRecordData({
  DocumentReference? user,
  String? cid,
  String? courseName,
  String? courseTutor,
  CourseScheduleStruct? courseSchedule,
}) {
  final firestoreData = serializers.toFirestore(
    CourseRecord.serializer,
    CourseRecord(
      (c) => c
        ..user = user
        ..cid = cid
        ..courseName = courseName
        ..courseTutor = courseTutor
        ..courseSchedule = CourseScheduleStructBuilder(),
    ),
  );

  // Handle nested data for "courseSchedule" field.
  addCourseScheduleStructData(firestoreData, courseSchedule, 'courseSchedule');

  return firestoreData;
}

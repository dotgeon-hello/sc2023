import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'course_index_record.g.dart';

abstract class CourseIndexRecord
    implements Built<CourseIndexRecord, CourseIndexRecordBuilder> {
  static Serializer<CourseIndexRecord> get serializer =>
      _$courseIndexRecordSerializer;

  DocumentReference? get user;

  DateTime? get createdAt;

  String? get title;

  String? get cid;

  @BuiltValueField(wireName: 'content_id')
  String? get contentId;

  DateTime? get viewedAt;

  String? get contentMediaURL;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(CourseIndexRecordBuilder builder) => builder
    ..title = ''
    ..cid = ''
    ..contentId = ''
    ..contentMediaURL = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('CourseIndex');

  static Stream<CourseIndexRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<CourseIndexRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  CourseIndexRecord._();
  factory CourseIndexRecord([void Function(CourseIndexRecordBuilder) updates]) =
      _$CourseIndexRecord;

  static CourseIndexRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createCourseIndexRecordData({
  DocumentReference? user,
  DateTime? createdAt,
  String? title,
  String? cid,
  String? contentId,
  DateTime? viewedAt,
  String? contentMediaURL,
}) {
  final firestoreData = serializers.toFirestore(
    CourseIndexRecord.serializer,
    CourseIndexRecord(
      (c) => c
        ..user = user
        ..createdAt = createdAt
        ..title = title
        ..cid = cid
        ..contentId = contentId
        ..viewedAt = viewedAt
        ..contentMediaURL = contentMediaURL,
    ),
  );

  return firestoreData;
}

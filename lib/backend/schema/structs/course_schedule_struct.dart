import 'dart:async';

import '../index.dart';
import '../serializers.dart';
import 'package:built_value/built_value.dart';

part 'course_schedule_struct.g.dart';

abstract class CourseScheduleStruct
    implements Built<CourseScheduleStruct, CourseScheduleStructBuilder> {
  static Serializer<CourseScheduleStruct> get serializer =>
      _$courseScheduleStructSerializer;

  bool? get monday;

  bool? get tuesday;

  bool? get wednesday;

  bool? get thursday;

  bool? get friday;

  bool? get saturday;

  bool? get sunday;

  /// Utility class for Firestore updates
  FirestoreUtilData get firestoreUtilData;

  static void _initializeBuilder(CourseScheduleStructBuilder builder) => builder
    ..monday = false
    ..tuesday = false
    ..wednesday = false
    ..thursday = false
    ..friday = false
    ..saturday = false
    ..sunday = false
    ..firestoreUtilData = FirestoreUtilData();

  CourseScheduleStruct._();
  factory CourseScheduleStruct(
          [void Function(CourseScheduleStructBuilder) updates]) =
      _$CourseScheduleStruct;
}

CourseScheduleStruct createCourseScheduleStruct({
  bool? monday,
  bool? tuesday,
  bool? wednesday,
  bool? thursday,
  bool? friday,
  bool? saturday,
  bool? sunday,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CourseScheduleStruct(
      (c) => c
        ..monday = monday
        ..tuesday = tuesday
        ..wednesday = wednesday
        ..thursday = thursday
        ..friday = friday
        ..saturday = saturday
        ..sunday = sunday
        ..firestoreUtilData = FirestoreUtilData(
          clearUnsetFields: clearUnsetFields,
          create: create,
          delete: delete,
          fieldValues: fieldValues,
        ),
    );

CourseScheduleStruct? updateCourseScheduleStruct(
  CourseScheduleStruct? courseSchedule, {
  bool clearUnsetFields = true,
}) =>
    courseSchedule != null
        ? (courseSchedule.toBuilder()
              ..firestoreUtilData =
                  FirestoreUtilData(clearUnsetFields: clearUnsetFields))
            .build()
        : null;

void addCourseScheduleStructData(
  Map<String, dynamic> firestoreData,
  CourseScheduleStruct? courseSchedule,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (courseSchedule == null) {
    return;
  }
  if (courseSchedule.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  if (!forFieldValue && courseSchedule.firestoreUtilData.clearUnsetFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final courseScheduleData =
      getCourseScheduleFirestoreData(courseSchedule, forFieldValue);
  final nestedData =
      courseScheduleData.map((k, v) => MapEntry('$fieldName.$k', v));

  final create = courseSchedule.firestoreUtilData.create;
  firestoreData.addAll(create ? mergeNestedFields(nestedData) : nestedData);

  return;
}

Map<String, dynamic> getCourseScheduleFirestoreData(
  CourseScheduleStruct? courseSchedule, [
  bool forFieldValue = false,
]) {
  if (courseSchedule == null) {
    return {};
  }
  final firestoreData =
      serializers.toFirestore(CourseScheduleStruct.serializer, courseSchedule);

  // Add any Firestore field values
  courseSchedule.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCourseScheduleListFirestoreData(
  List<CourseScheduleStruct>? courseSchedules,
) =>
    courseSchedules
        ?.map((c) => getCourseScheduleFirestoreData(c, true))
        .toList() ??
    [];

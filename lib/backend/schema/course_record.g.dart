// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CourseRecord> _$courseRecordSerializer =
    new _$CourseRecordSerializer();

class _$CourseRecordSerializer implements StructuredSerializer<CourseRecord> {
  @override
  final Iterable<Type> types = const [CourseRecord, _$CourseRecord];
  @override
  final String wireName = 'CourseRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, CourseRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'courseSchedule',
      serializers.serialize(object.courseSchedule,
          specifiedType: const FullType(CourseScheduleStruct)),
    ];
    Object? value;
    value = object.user;
    if (value != null) {
      result
        ..add('user')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.cid;
    if (value != null) {
      result
        ..add('cid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.courseName;
    if (value != null) {
      result
        ..add('courseName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.courseTutor;
    if (value != null) {
      result
        ..add('courseTutor')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  CourseRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CourseRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'cid':
          result.cid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'courseName':
          result.courseName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'courseTutor':
          result.courseTutor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'courseSchedule':
          result.courseSchedule.replace(serializers.deserialize(value,
                  specifiedType: const FullType(CourseScheduleStruct))!
              as CourseScheduleStruct);
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$CourseRecord extends CourseRecord {
  @override
  final DocumentReference<Object?>? user;
  @override
  final String? cid;
  @override
  final String? courseName;
  @override
  final String? courseTutor;
  @override
  final CourseScheduleStruct courseSchedule;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$CourseRecord([void Function(CourseRecordBuilder)? updates]) =>
      (new CourseRecordBuilder()..update(updates))._build();

  _$CourseRecord._(
      {this.user,
      this.cid,
      this.courseName,
      this.courseTutor,
      required this.courseSchedule,
      this.ffRef})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        courseSchedule, r'CourseRecord', 'courseSchedule');
  }

  @override
  CourseRecord rebuild(void Function(CourseRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CourseRecordBuilder toBuilder() => new CourseRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CourseRecord &&
        user == other.user &&
        cid == other.cid &&
        courseName == other.courseName &&
        courseTutor == other.courseTutor &&
        courseSchedule == other.courseSchedule &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, user.hashCode), cid.hashCode),
                    courseName.hashCode),
                courseTutor.hashCode),
            courseSchedule.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CourseRecord')
          ..add('user', user)
          ..add('cid', cid)
          ..add('courseName', courseName)
          ..add('courseTutor', courseTutor)
          ..add('courseSchedule', courseSchedule)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class CourseRecordBuilder
    implements Builder<CourseRecord, CourseRecordBuilder> {
  _$CourseRecord? _$v;

  DocumentReference<Object?>? _user;
  DocumentReference<Object?>? get user => _$this._user;
  set user(DocumentReference<Object?>? user) => _$this._user = user;

  String? _cid;
  String? get cid => _$this._cid;
  set cid(String? cid) => _$this._cid = cid;

  String? _courseName;
  String? get courseName => _$this._courseName;
  set courseName(String? courseName) => _$this._courseName = courseName;

  String? _courseTutor;
  String? get courseTutor => _$this._courseTutor;
  set courseTutor(String? courseTutor) => _$this._courseTutor = courseTutor;

  CourseScheduleStructBuilder? _courseSchedule;
  CourseScheduleStructBuilder get courseSchedule =>
      _$this._courseSchedule ??= new CourseScheduleStructBuilder();
  set courseSchedule(CourseScheduleStructBuilder? courseSchedule) =>
      _$this._courseSchedule = courseSchedule;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  CourseRecordBuilder() {
    CourseRecord._initializeBuilder(this);
  }

  CourseRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user;
      _cid = $v.cid;
      _courseName = $v.courseName;
      _courseTutor = $v.courseTutor;
      _courseSchedule = $v.courseSchedule.toBuilder();
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CourseRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CourseRecord;
  }

  @override
  void update(void Function(CourseRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CourseRecord build() => _build();

  _$CourseRecord _build() {
    _$CourseRecord _$result;
    try {
      _$result = _$v ??
          new _$CourseRecord._(
              user: user,
              cid: cid,
              courseName: courseName,
              courseTutor: courseTutor,
              courseSchedule: courseSchedule.build(),
              ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'courseSchedule';
        courseSchedule.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CourseRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas

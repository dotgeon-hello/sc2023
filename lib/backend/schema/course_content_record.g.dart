// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_content_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CourseContentRecord> _$courseContentRecordSerializer =
    new _$CourseContentRecordSerializer();

class _$CourseContentRecordSerializer
    implements StructuredSerializer<CourseContentRecord> {
  @override
  final Iterable<Type> types = const [
    CourseContentRecord,
    _$CourseContentRecord
  ];
  @override
  final String wireName = 'CourseContentRecord';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, CourseContentRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lectureArray;
    if (value != null) {
      result
        ..add('lectureArray')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(LectureArrayElementStruct)])));
    }
    value = object.summaryArray;
    if (value != null) {
      result
        ..add('summaryArray')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(SummaryArrayElementStruct)])));
    }
    value = object.quizArray;
    if (value != null) {
      result
        ..add('quizArray')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(QuizArrayElementStruct)])));
    }
    value = object.contentMediaURL;
    if (value != null) {
      result
        ..add('contentMediaURL')
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
  CourseContentRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CourseContentRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'lectureArray':
          result.lectureArray.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(LectureArrayElementStruct)
              ]))! as BuiltList<Object?>);
          break;
        case 'summaryArray':
          result.summaryArray.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(SummaryArrayElementStruct)
              ]))! as BuiltList<Object?>);
          break;
        case 'quizArray':
          result.quizArray.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(QuizArrayElementStruct)
              ]))! as BuiltList<Object?>);
          break;
        case 'contentMediaURL':
          result.contentMediaURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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

class _$CourseContentRecord extends CourseContentRecord {
  @override
  final String? id;
  @override
  final BuiltList<LectureArrayElementStruct>? lectureArray;
  @override
  final BuiltList<SummaryArrayElementStruct>? summaryArray;
  @override
  final BuiltList<QuizArrayElementStruct>? quizArray;
  @override
  final String? contentMediaURL;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$CourseContentRecord(
          [void Function(CourseContentRecordBuilder)? updates]) =>
      (new CourseContentRecordBuilder()..update(updates))._build();

  _$CourseContentRecord._(
      {this.id,
      this.lectureArray,
      this.summaryArray,
      this.quizArray,
      this.contentMediaURL,
      this.ffRef})
      : super._();

  @override
  CourseContentRecord rebuild(
          void Function(CourseContentRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CourseContentRecordBuilder toBuilder() =>
      new CourseContentRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CourseContentRecord &&
        id == other.id &&
        lectureArray == other.lectureArray &&
        summaryArray == other.summaryArray &&
        quizArray == other.quizArray &&
        contentMediaURL == other.contentMediaURL &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, id.hashCode), lectureArray.hashCode),
                    summaryArray.hashCode),
                quizArray.hashCode),
            contentMediaURL.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CourseContentRecord')
          ..add('id', id)
          ..add('lectureArray', lectureArray)
          ..add('summaryArray', summaryArray)
          ..add('quizArray', quizArray)
          ..add('contentMediaURL', contentMediaURL)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class CourseContentRecordBuilder
    implements Builder<CourseContentRecord, CourseContentRecordBuilder> {
  _$CourseContentRecord? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  ListBuilder<LectureArrayElementStruct>? _lectureArray;
  ListBuilder<LectureArrayElementStruct> get lectureArray =>
      _$this._lectureArray ??= new ListBuilder<LectureArrayElementStruct>();
  set lectureArray(ListBuilder<LectureArrayElementStruct>? lectureArray) =>
      _$this._lectureArray = lectureArray;

  ListBuilder<SummaryArrayElementStruct>? _summaryArray;
  ListBuilder<SummaryArrayElementStruct> get summaryArray =>
      _$this._summaryArray ??= new ListBuilder<SummaryArrayElementStruct>();
  set summaryArray(ListBuilder<SummaryArrayElementStruct>? summaryArray) =>
      _$this._summaryArray = summaryArray;

  ListBuilder<QuizArrayElementStruct>? _quizArray;
  ListBuilder<QuizArrayElementStruct> get quizArray =>
      _$this._quizArray ??= new ListBuilder<QuizArrayElementStruct>();
  set quizArray(ListBuilder<QuizArrayElementStruct>? quizArray) =>
      _$this._quizArray = quizArray;

  String? _contentMediaURL;
  String? get contentMediaURL => _$this._contentMediaURL;
  set contentMediaURL(String? contentMediaURL) =>
      _$this._contentMediaURL = contentMediaURL;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  CourseContentRecordBuilder() {
    CourseContentRecord._initializeBuilder(this);
  }

  CourseContentRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _lectureArray = $v.lectureArray?.toBuilder();
      _summaryArray = $v.summaryArray?.toBuilder();
      _quizArray = $v.quizArray?.toBuilder();
      _contentMediaURL = $v.contentMediaURL;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CourseContentRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CourseContentRecord;
  }

  @override
  void update(void Function(CourseContentRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CourseContentRecord build() => _build();

  _$CourseContentRecord _build() {
    _$CourseContentRecord _$result;
    try {
      _$result = _$v ??
          new _$CourseContentRecord._(
              id: id,
              lectureArray: _lectureArray?.build(),
              summaryArray: _summaryArray?.build(),
              quizArray: _quizArray?.build(),
              contentMediaURL: contentMediaURL,
              ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'lectureArray';
        _lectureArray?.build();
        _$failedField = 'summaryArray';
        _summaryArray?.build();
        _$failedField = 'quizArray';
        _quizArray?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CourseContentRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas

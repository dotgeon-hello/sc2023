// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_array_element_struct.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LectureArrayElementStruct> _$lectureArrayElementStructSerializer =
    new _$LectureArrayElementStructSerializer();

class _$LectureArrayElementStructSerializer
    implements StructuredSerializer<LectureArrayElementStruct> {
  @override
  final Iterable<Type> types = const [
    LectureArrayElementStruct,
    _$LectureArrayElementStruct
  ];
  @override
  final String wireName = 'LectureArrayElementStruct';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, LectureArrayElementStruct object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'firestoreUtilData',
      serializers.serialize(object.firestoreUtilData,
          specifiedType: const FullType(FirestoreUtilData)),
    ];
    Object? value;
    value = object.content;
    if (value != null) {
      result
        ..add('content')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isQuestion;
    if (value != null) {
      result
        ..add('isQuestion')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.timestamp;
    if (value != null) {
      result
        ..add('timestamp')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.contentMediaPage;
    if (value != null) {
      result
        ..add('contentMediaPage')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  LectureArrayElementStruct deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LectureArrayElementStructBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isQuestion':
          result.isQuestion = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'contentMediaPage':
          result.contentMediaPage = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'firestoreUtilData':
          result.firestoreUtilData = serializers.deserialize(value,
                  specifiedType: const FullType(FirestoreUtilData))!
              as FirestoreUtilData;
          break;
      }
    }

    return result.build();
  }
}

class _$LectureArrayElementStruct extends LectureArrayElementStruct {
  @override
  final String? content;
  @override
  final bool? isQuestion;
  @override
  final DateTime? timestamp;
  @override
  final int? contentMediaPage;
  @override
  final FirestoreUtilData firestoreUtilData;

  factory _$LectureArrayElementStruct(
          [void Function(LectureArrayElementStructBuilder)? updates]) =>
      (new LectureArrayElementStructBuilder()..update(updates))._build();

  _$LectureArrayElementStruct._(
      {this.content,
      this.isQuestion,
      this.timestamp,
      this.contentMediaPage,
      required this.firestoreUtilData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        firestoreUtilData, r'LectureArrayElementStruct', 'firestoreUtilData');
  }

  @override
  LectureArrayElementStruct rebuild(
          void Function(LectureArrayElementStructBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LectureArrayElementStructBuilder toBuilder() =>
      new LectureArrayElementStructBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LectureArrayElementStruct &&
        content == other.content &&
        isQuestion == other.isQuestion &&
        timestamp == other.timestamp &&
        contentMediaPage == other.contentMediaPage &&
        firestoreUtilData == other.firestoreUtilData;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, content.hashCode), isQuestion.hashCode),
                timestamp.hashCode),
            contentMediaPage.hashCode),
        firestoreUtilData.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LectureArrayElementStruct')
          ..add('content', content)
          ..add('isQuestion', isQuestion)
          ..add('timestamp', timestamp)
          ..add('contentMediaPage', contentMediaPage)
          ..add('firestoreUtilData', firestoreUtilData))
        .toString();
  }
}

class LectureArrayElementStructBuilder
    implements
        Builder<LectureArrayElementStruct, LectureArrayElementStructBuilder> {
  _$LectureArrayElementStruct? _$v;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  bool? _isQuestion;
  bool? get isQuestion => _$this._isQuestion;
  set isQuestion(bool? isQuestion) => _$this._isQuestion = isQuestion;

  DateTime? _timestamp;
  DateTime? get timestamp => _$this._timestamp;
  set timestamp(DateTime? timestamp) => _$this._timestamp = timestamp;

  int? _contentMediaPage;
  int? get contentMediaPage => _$this._contentMediaPage;
  set contentMediaPage(int? contentMediaPage) =>
      _$this._contentMediaPage = contentMediaPage;

  FirestoreUtilData? _firestoreUtilData;
  FirestoreUtilData? get firestoreUtilData => _$this._firestoreUtilData;
  set firestoreUtilData(FirestoreUtilData? firestoreUtilData) =>
      _$this._firestoreUtilData = firestoreUtilData;

  LectureArrayElementStructBuilder() {
    LectureArrayElementStruct._initializeBuilder(this);
  }

  LectureArrayElementStructBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content;
      _isQuestion = $v.isQuestion;
      _timestamp = $v.timestamp;
      _contentMediaPage = $v.contentMediaPage;
      _firestoreUtilData = $v.firestoreUtilData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LectureArrayElementStruct other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LectureArrayElementStruct;
  }

  @override
  void update(void Function(LectureArrayElementStructBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LectureArrayElementStruct build() => _build();

  _$LectureArrayElementStruct _build() {
    final _$result = _$v ??
        new _$LectureArrayElementStruct._(
            content: content,
            isQuestion: isQuestion,
            timestamp: timestamp,
            contentMediaPage: contentMediaPage,
            firestoreUtilData: BuiltValueNullFieldError.checkNotNull(
                firestoreUtilData,
                r'LectureArrayElementStruct',
                'firestoreUtilData'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas

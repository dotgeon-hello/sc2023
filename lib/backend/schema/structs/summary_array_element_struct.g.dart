// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_array_element_struct.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SummaryArrayElementStruct> _$summaryArrayElementStructSerializer =
    new _$SummaryArrayElementStructSerializer();

class _$SummaryArrayElementStructSerializer
    implements StructuredSerializer<SummaryArrayElementStruct> {
  @override
  final Iterable<Type> types = const [
    SummaryArrayElementStruct,
    _$SummaryArrayElementStruct
  ];
  @override
  final String wireName = 'SummaryArrayElementStruct';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, SummaryArrayElementStruct object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'firestoreUtilData',
      serializers.serialize(object.firestoreUtilData,
          specifiedType: const FullType(FirestoreUtilData)),
    ];
    Object? value;
    value = object.summaryContent;
    if (value != null) {
      result
        ..add('summaryContent')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.timestamp;
    if (value != null) {
      result
        ..add('timestamp')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    return result;
  }

  @override
  SummaryArrayElementStruct deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SummaryArrayElementStructBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'summaryContent':
          result.summaryContent = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
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

class _$SummaryArrayElementStruct extends SummaryArrayElementStruct {
  @override
  final String? summaryContent;
  @override
  final DateTime? timestamp;
  @override
  final FirestoreUtilData firestoreUtilData;

  factory _$SummaryArrayElementStruct(
          [void Function(SummaryArrayElementStructBuilder)? updates]) =>
      (new SummaryArrayElementStructBuilder()..update(updates))._build();

  _$SummaryArrayElementStruct._(
      {this.summaryContent, this.timestamp, required this.firestoreUtilData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        firestoreUtilData, r'SummaryArrayElementStruct', 'firestoreUtilData');
  }

  @override
  SummaryArrayElementStruct rebuild(
          void Function(SummaryArrayElementStructBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SummaryArrayElementStructBuilder toBuilder() =>
      new SummaryArrayElementStructBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SummaryArrayElementStruct &&
        summaryContent == other.summaryContent &&
        timestamp == other.timestamp &&
        firestoreUtilData == other.firestoreUtilData;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, summaryContent.hashCode), timestamp.hashCode),
        firestoreUtilData.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SummaryArrayElementStruct')
          ..add('summaryContent', summaryContent)
          ..add('timestamp', timestamp)
          ..add('firestoreUtilData', firestoreUtilData))
        .toString();
  }
}

class SummaryArrayElementStructBuilder
    implements
        Builder<SummaryArrayElementStruct, SummaryArrayElementStructBuilder> {
  _$SummaryArrayElementStruct? _$v;

  String? _summaryContent;
  String? get summaryContent => _$this._summaryContent;
  set summaryContent(String? summaryContent) =>
      _$this._summaryContent = summaryContent;

  DateTime? _timestamp;
  DateTime? get timestamp => _$this._timestamp;
  set timestamp(DateTime? timestamp) => _$this._timestamp = timestamp;

  FirestoreUtilData? _firestoreUtilData;
  FirestoreUtilData? get firestoreUtilData => _$this._firestoreUtilData;
  set firestoreUtilData(FirestoreUtilData? firestoreUtilData) =>
      _$this._firestoreUtilData = firestoreUtilData;

  SummaryArrayElementStructBuilder() {
    SummaryArrayElementStruct._initializeBuilder(this);
  }

  SummaryArrayElementStructBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _summaryContent = $v.summaryContent;
      _timestamp = $v.timestamp;
      _firestoreUtilData = $v.firestoreUtilData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SummaryArrayElementStruct other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SummaryArrayElementStruct;
  }

  @override
  void update(void Function(SummaryArrayElementStructBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SummaryArrayElementStruct build() => _build();

  _$SummaryArrayElementStruct _build() {
    final _$result = _$v ??
        new _$SummaryArrayElementStruct._(
            summaryContent: summaryContent,
            timestamp: timestamp,
            firestoreUtilData: BuiltValueNullFieldError.checkNotNull(
                firestoreUtilData,
                r'SummaryArrayElementStruct',
                'firestoreUtilData'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas

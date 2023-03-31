// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_schedule_struct.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CourseScheduleStruct> _$courseScheduleStructSerializer =
    new _$CourseScheduleStructSerializer();

class _$CourseScheduleStructSerializer
    implements StructuredSerializer<CourseScheduleStruct> {
  @override
  final Iterable<Type> types = const [
    CourseScheduleStruct,
    _$CourseScheduleStruct
  ];
  @override
  final String wireName = 'CourseScheduleStruct';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, CourseScheduleStruct object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'firestoreUtilData',
      serializers.serialize(object.firestoreUtilData,
          specifiedType: const FullType(FirestoreUtilData)),
    ];
    Object? value;
    value = object.monday;
    if (value != null) {
      result
        ..add('monday')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.tuesday;
    if (value != null) {
      result
        ..add('tuesday')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.wednesday;
    if (value != null) {
      result
        ..add('wednesday')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.thursday;
    if (value != null) {
      result
        ..add('thursday')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.friday;
    if (value != null) {
      result
        ..add('friday')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.saturday;
    if (value != null) {
      result
        ..add('saturday')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.sunday;
    if (value != null) {
      result
        ..add('sunday')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  CourseScheduleStruct deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CourseScheduleStructBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'monday':
          result.monday = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'tuesday':
          result.tuesday = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'wednesday':
          result.wednesday = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'thursday':
          result.thursday = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'friday':
          result.friday = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'saturday':
          result.saturday = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'sunday':
          result.sunday = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
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

class _$CourseScheduleStruct extends CourseScheduleStruct {
  @override
  final bool? monday;
  @override
  final bool? tuesday;
  @override
  final bool? wednesday;
  @override
  final bool? thursday;
  @override
  final bool? friday;
  @override
  final bool? saturday;
  @override
  final bool? sunday;
  @override
  final FirestoreUtilData firestoreUtilData;

  factory _$CourseScheduleStruct(
          [void Function(CourseScheduleStructBuilder)? updates]) =>
      (new CourseScheduleStructBuilder()..update(updates))._build();

  _$CourseScheduleStruct._(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday,
      required this.firestoreUtilData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        firestoreUtilData, r'CourseScheduleStruct', 'firestoreUtilData');
  }

  @override
  CourseScheduleStruct rebuild(
          void Function(CourseScheduleStructBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CourseScheduleStructBuilder toBuilder() =>
      new CourseScheduleStructBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CourseScheduleStruct &&
        monday == other.monday &&
        tuesday == other.tuesday &&
        wednesday == other.wednesday &&
        thursday == other.thursday &&
        friday == other.friday &&
        saturday == other.saturday &&
        sunday == other.sunday &&
        firestoreUtilData == other.firestoreUtilData;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, monday.hashCode), tuesday.hashCode),
                            wednesday.hashCode),
                        thursday.hashCode),
                    friday.hashCode),
                saturday.hashCode),
            sunday.hashCode),
        firestoreUtilData.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CourseScheduleStruct')
          ..add('monday', monday)
          ..add('tuesday', tuesday)
          ..add('wednesday', wednesday)
          ..add('thursday', thursday)
          ..add('friday', friday)
          ..add('saturday', saturday)
          ..add('sunday', sunday)
          ..add('firestoreUtilData', firestoreUtilData))
        .toString();
  }
}

class CourseScheduleStructBuilder
    implements Builder<CourseScheduleStruct, CourseScheduleStructBuilder> {
  _$CourseScheduleStruct? _$v;

  bool? _monday;
  bool? get monday => _$this._monday;
  set monday(bool? monday) => _$this._monday = monday;

  bool? _tuesday;
  bool? get tuesday => _$this._tuesday;
  set tuesday(bool? tuesday) => _$this._tuesday = tuesday;

  bool? _wednesday;
  bool? get wednesday => _$this._wednesday;
  set wednesday(bool? wednesday) => _$this._wednesday = wednesday;

  bool? _thursday;
  bool? get thursday => _$this._thursday;
  set thursday(bool? thursday) => _$this._thursday = thursday;

  bool? _friday;
  bool? get friday => _$this._friday;
  set friday(bool? friday) => _$this._friday = friday;

  bool? _saturday;
  bool? get saturday => _$this._saturday;
  set saturday(bool? saturday) => _$this._saturday = saturday;

  bool? _sunday;
  bool? get sunday => _$this._sunday;
  set sunday(bool? sunday) => _$this._sunday = sunday;

  FirestoreUtilData? _firestoreUtilData;
  FirestoreUtilData? get firestoreUtilData => _$this._firestoreUtilData;
  set firestoreUtilData(FirestoreUtilData? firestoreUtilData) =>
      _$this._firestoreUtilData = firestoreUtilData;

  CourseScheduleStructBuilder() {
    CourseScheduleStruct._initializeBuilder(this);
  }

  CourseScheduleStructBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _monday = $v.monday;
      _tuesday = $v.tuesday;
      _wednesday = $v.wednesday;
      _thursday = $v.thursday;
      _friday = $v.friday;
      _saturday = $v.saturday;
      _sunday = $v.sunday;
      _firestoreUtilData = $v.firestoreUtilData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CourseScheduleStruct other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CourseScheduleStruct;
  }

  @override
  void update(void Function(CourseScheduleStructBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CourseScheduleStruct build() => _build();

  _$CourseScheduleStruct _build() {
    final _$result = _$v ??
        new _$CourseScheduleStruct._(
            monday: monday,
            tuesday: tuesday,
            wednesday: wednesday,
            thursday: thursday,
            friday: friday,
            saturday: saturday,
            sunday: sunday,
            firestoreUtilData: BuiltValueNullFieldError.checkNotNull(
                firestoreUtilData,
                r'CourseScheduleStruct',
                'firestoreUtilData'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas

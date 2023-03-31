// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_array_element_struct.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<QuizArrayElementStruct> _$quizArrayElementStructSerializer =
    new _$QuizArrayElementStructSerializer();

class _$QuizArrayElementStructSerializer
    implements StructuredSerializer<QuizArrayElementStruct> {
  @override
  final Iterable<Type> types = const [
    QuizArrayElementStruct,
    _$QuizArrayElementStruct
  ];
  @override
  final String wireName = 'QuizArrayElementStruct';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, QuizArrayElementStruct object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'quizShortAnswer',
      serializers.serialize(object.quizShortAnswer,
          specifiedType: const FullType(QuizTypeShortAnswerStruct)),
      'quizChoice',
      serializers.serialize(object.quizChoice,
          specifiedType: const FullType(QuizTypeChoiceStruct)),
      'firestoreUtilData',
      serializers.serialize(object.firestoreUtilData,
          specifiedType: const FullType(FirestoreUtilData)),
    ];
    Object? value;
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  QuizArrayElementStruct deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new QuizArrayElementStructBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'quizShortAnswer':
          result.quizShortAnswer.replace(serializers.deserialize(value,
                  specifiedType: const FullType(QuizTypeShortAnswerStruct))!
              as QuizTypeShortAnswerStruct);
          break;
        case 'quizChoice':
          result.quizChoice.replace(serializers.deserialize(value,
                  specifiedType: const FullType(QuizTypeChoiceStruct))!
              as QuizTypeChoiceStruct);
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

class _$QuizArrayElementStruct extends QuizArrayElementStruct {
  @override
  final String? type;
  @override
  final QuizTypeShortAnswerStruct quizShortAnswer;
  @override
  final QuizTypeChoiceStruct quizChoice;
  @override
  final FirestoreUtilData firestoreUtilData;

  factory _$QuizArrayElementStruct(
          [void Function(QuizArrayElementStructBuilder)? updates]) =>
      (new QuizArrayElementStructBuilder()..update(updates))._build();

  _$QuizArrayElementStruct._(
      {this.type,
      required this.quizShortAnswer,
      required this.quizChoice,
      required this.firestoreUtilData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        quizShortAnswer, r'QuizArrayElementStruct', 'quizShortAnswer');
    BuiltValueNullFieldError.checkNotNull(
        quizChoice, r'QuizArrayElementStruct', 'quizChoice');
    BuiltValueNullFieldError.checkNotNull(
        firestoreUtilData, r'QuizArrayElementStruct', 'firestoreUtilData');
  }

  @override
  QuizArrayElementStruct rebuild(
          void Function(QuizArrayElementStructBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuizArrayElementStructBuilder toBuilder() =>
      new QuizArrayElementStructBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuizArrayElementStruct &&
        type == other.type &&
        quizShortAnswer == other.quizShortAnswer &&
        quizChoice == other.quizChoice &&
        firestoreUtilData == other.firestoreUtilData;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, type.hashCode), quizShortAnswer.hashCode),
            quizChoice.hashCode),
        firestoreUtilData.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QuizArrayElementStruct')
          ..add('type', type)
          ..add('quizShortAnswer', quizShortAnswer)
          ..add('quizChoice', quizChoice)
          ..add('firestoreUtilData', firestoreUtilData))
        .toString();
  }
}

class QuizArrayElementStructBuilder
    implements Builder<QuizArrayElementStruct, QuizArrayElementStructBuilder> {
  _$QuizArrayElementStruct? _$v;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  QuizTypeShortAnswerStructBuilder? _quizShortAnswer;
  QuizTypeShortAnswerStructBuilder get quizShortAnswer =>
      _$this._quizShortAnswer ??= new QuizTypeShortAnswerStructBuilder();
  set quizShortAnswer(QuizTypeShortAnswerStructBuilder? quizShortAnswer) =>
      _$this._quizShortAnswer = quizShortAnswer;

  QuizTypeChoiceStructBuilder? _quizChoice;
  QuizTypeChoiceStructBuilder get quizChoice =>
      _$this._quizChoice ??= new QuizTypeChoiceStructBuilder();
  set quizChoice(QuizTypeChoiceStructBuilder? quizChoice) =>
      _$this._quizChoice = quizChoice;

  FirestoreUtilData? _firestoreUtilData;
  FirestoreUtilData? get firestoreUtilData => _$this._firestoreUtilData;
  set firestoreUtilData(FirestoreUtilData? firestoreUtilData) =>
      _$this._firestoreUtilData = firestoreUtilData;

  QuizArrayElementStructBuilder() {
    QuizArrayElementStruct._initializeBuilder(this);
  }

  QuizArrayElementStructBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _quizShortAnswer = $v.quizShortAnswer.toBuilder();
      _quizChoice = $v.quizChoice.toBuilder();
      _firestoreUtilData = $v.firestoreUtilData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QuizArrayElementStruct other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$QuizArrayElementStruct;
  }

  @override
  void update(void Function(QuizArrayElementStructBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QuizArrayElementStruct build() => _build();

  _$QuizArrayElementStruct _build() {
    _$QuizArrayElementStruct _$result;
    try {
      _$result = _$v ??
          new _$QuizArrayElementStruct._(
              type: type,
              quizShortAnswer: quizShortAnswer.build(),
              quizChoice: quizChoice.build(),
              firestoreUtilData: BuiltValueNullFieldError.checkNotNull(
                  firestoreUtilData,
                  r'QuizArrayElementStruct',
                  'firestoreUtilData'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'quizShortAnswer';
        quizShortAnswer.build();
        _$failedField = 'quizChoice';
        quizChoice.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'QuizArrayElementStruct', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_type_choice_struct.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<QuizTypeChoiceStruct> _$quizTypeChoiceStructSerializer =
    new _$QuizTypeChoiceStructSerializer();

class _$QuizTypeChoiceStructSerializer
    implements StructuredSerializer<QuizTypeChoiceStruct> {
  @override
  final Iterable<Type> types = const [
    QuizTypeChoiceStruct,
    _$QuizTypeChoiceStruct
  ];
  @override
  final String wireName = 'QuizTypeChoiceStruct';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, QuizTypeChoiceStruct object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'firestoreUtilData',
      serializers.serialize(object.firestoreUtilData,
          specifiedType: const FullType(FirestoreUtilData)),
    ];
    Object? value;
    value = object.question;
    if (value != null) {
      result
        ..add('question')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.choices;
    if (value != null) {
      result
        ..add('choices')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.answer;
    if (value != null) {
      result
        ..add('answer')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  QuizTypeChoiceStruct deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new QuizTypeChoiceStructBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'question':
          result.question = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'choices':
          result.choices.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'answer':
          result.answer = serializers.deserialize(value,
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

class _$QuizTypeChoiceStruct extends QuizTypeChoiceStruct {
  @override
  final String? question;
  @override
  final BuiltList<String>? choices;
  @override
  final int? answer;
  @override
  final FirestoreUtilData firestoreUtilData;

  factory _$QuizTypeChoiceStruct(
          [void Function(QuizTypeChoiceStructBuilder)? updates]) =>
      (new QuizTypeChoiceStructBuilder()..update(updates))._build();

  _$QuizTypeChoiceStruct._(
      {this.question,
      this.choices,
      this.answer,
      required this.firestoreUtilData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        firestoreUtilData, r'QuizTypeChoiceStruct', 'firestoreUtilData');
  }

  @override
  QuizTypeChoiceStruct rebuild(
          void Function(QuizTypeChoiceStructBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuizTypeChoiceStructBuilder toBuilder() =>
      new QuizTypeChoiceStructBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuizTypeChoiceStruct &&
        question == other.question &&
        choices == other.choices &&
        answer == other.answer &&
        firestoreUtilData == other.firestoreUtilData;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, question.hashCode), choices.hashCode), answer.hashCode),
        firestoreUtilData.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QuizTypeChoiceStruct')
          ..add('question', question)
          ..add('choices', choices)
          ..add('answer', answer)
          ..add('firestoreUtilData', firestoreUtilData))
        .toString();
  }
}

class QuizTypeChoiceStructBuilder
    implements Builder<QuizTypeChoiceStruct, QuizTypeChoiceStructBuilder> {
  _$QuizTypeChoiceStruct? _$v;

  String? _question;
  String? get question => _$this._question;
  set question(String? question) => _$this._question = question;

  ListBuilder<String>? _choices;
  ListBuilder<String> get choices =>
      _$this._choices ??= new ListBuilder<String>();
  set choices(ListBuilder<String>? choices) => _$this._choices = choices;

  int? _answer;
  int? get answer => _$this._answer;
  set answer(int? answer) => _$this._answer = answer;

  FirestoreUtilData? _firestoreUtilData;
  FirestoreUtilData? get firestoreUtilData => _$this._firestoreUtilData;
  set firestoreUtilData(FirestoreUtilData? firestoreUtilData) =>
      _$this._firestoreUtilData = firestoreUtilData;

  QuizTypeChoiceStructBuilder() {
    QuizTypeChoiceStruct._initializeBuilder(this);
  }

  QuizTypeChoiceStructBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _question = $v.question;
      _choices = $v.choices?.toBuilder();
      _answer = $v.answer;
      _firestoreUtilData = $v.firestoreUtilData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QuizTypeChoiceStruct other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$QuizTypeChoiceStruct;
  }

  @override
  void update(void Function(QuizTypeChoiceStructBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QuizTypeChoiceStruct build() => _build();

  _$QuizTypeChoiceStruct _build() {
    _$QuizTypeChoiceStruct _$result;
    try {
      _$result = _$v ??
          new _$QuizTypeChoiceStruct._(
              question: question,
              choices: _choices?.build(),
              answer: answer,
              firestoreUtilData: BuiltValueNullFieldError.checkNotNull(
                  firestoreUtilData,
                  r'QuizTypeChoiceStruct',
                  'firestoreUtilData'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'choices';
        _choices?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'QuizTypeChoiceStruct', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas

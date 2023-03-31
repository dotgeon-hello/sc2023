// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_type_short_answer_struct.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<QuizTypeShortAnswerStruct> _$quizTypeShortAnswerStructSerializer =
    new _$QuizTypeShortAnswerStructSerializer();

class _$QuizTypeShortAnswerStructSerializer
    implements StructuredSerializer<QuizTypeShortAnswerStruct> {
  @override
  final Iterable<Type> types = const [
    QuizTypeShortAnswerStruct,
    _$QuizTypeShortAnswerStruct
  ];
  @override
  final String wireName = 'QuizTypeShortAnswerStruct';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, QuizTypeShortAnswerStruct object,
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
    value = object.answer;
    if (value != null) {
      result
        ..add('answer')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  QuizTypeShortAnswerStruct deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new QuizTypeShortAnswerStructBuilder();

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
        case 'answer':
          result.answer = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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

class _$QuizTypeShortAnswerStruct extends QuizTypeShortAnswerStruct {
  @override
  final String? question;
  @override
  final String? answer;
  @override
  final FirestoreUtilData firestoreUtilData;

  factory _$QuizTypeShortAnswerStruct(
          [void Function(QuizTypeShortAnswerStructBuilder)? updates]) =>
      (new QuizTypeShortAnswerStructBuilder()..update(updates))._build();

  _$QuizTypeShortAnswerStruct._(
      {this.question, this.answer, required this.firestoreUtilData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        firestoreUtilData, r'QuizTypeShortAnswerStruct', 'firestoreUtilData');
  }

  @override
  QuizTypeShortAnswerStruct rebuild(
          void Function(QuizTypeShortAnswerStructBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuizTypeShortAnswerStructBuilder toBuilder() =>
      new QuizTypeShortAnswerStructBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuizTypeShortAnswerStruct &&
        question == other.question &&
        answer == other.answer &&
        firestoreUtilData == other.firestoreUtilData;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, question.hashCode), answer.hashCode),
        firestoreUtilData.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QuizTypeShortAnswerStruct')
          ..add('question', question)
          ..add('answer', answer)
          ..add('firestoreUtilData', firestoreUtilData))
        .toString();
  }
}

class QuizTypeShortAnswerStructBuilder
    implements
        Builder<QuizTypeShortAnswerStruct, QuizTypeShortAnswerStructBuilder> {
  _$QuizTypeShortAnswerStruct? _$v;

  String? _question;
  String? get question => _$this._question;
  set question(String? question) => _$this._question = question;

  String? _answer;
  String? get answer => _$this._answer;
  set answer(String? answer) => _$this._answer = answer;

  FirestoreUtilData? _firestoreUtilData;
  FirestoreUtilData? get firestoreUtilData => _$this._firestoreUtilData;
  set firestoreUtilData(FirestoreUtilData? firestoreUtilData) =>
      _$this._firestoreUtilData = firestoreUtilData;

  QuizTypeShortAnswerStructBuilder() {
    QuizTypeShortAnswerStruct._initializeBuilder(this);
  }

  QuizTypeShortAnswerStructBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _question = $v.question;
      _answer = $v.answer;
      _firestoreUtilData = $v.firestoreUtilData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QuizTypeShortAnswerStruct other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$QuizTypeShortAnswerStruct;
  }

  @override
  void update(void Function(QuizTypeShortAnswerStructBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QuizTypeShortAnswerStruct build() => _build();

  _$QuizTypeShortAnswerStruct _build() {
    final _$result = _$v ??
        new _$QuizTypeShortAnswerStruct._(
            question: question,
            answer: answer,
            firestoreUtilData: BuiltValueNullFieldError.checkNotNull(
                firestoreUtilData,
                r'QuizTypeShortAnswerStruct',
                'firestoreUtilData'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas

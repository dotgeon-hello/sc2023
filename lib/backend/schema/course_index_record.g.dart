// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_index_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CourseIndexRecord> _$courseIndexRecordSerializer =
    new _$CourseIndexRecordSerializer();

class _$CourseIndexRecordSerializer
    implements StructuredSerializer<CourseIndexRecord> {
  @override
  final Iterable<Type> types = const [CourseIndexRecord, _$CourseIndexRecord];
  @override
  final String wireName = 'CourseIndexRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, CourseIndexRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.user;
    if (value != null) {
      result
        ..add('user')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.cid;
    if (value != null) {
      result
        ..add('cid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.contentId;
    if (value != null) {
      result
        ..add('content_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.viewedAt;
    if (value != null) {
      result
        ..add('viewedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
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
  CourseIndexRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CourseIndexRecordBuilder();

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
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'cid':
          result.cid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'content_id':
          result.contentId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'viewedAt':
          result.viewedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
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

class _$CourseIndexRecord extends CourseIndexRecord {
  @override
  final DocumentReference<Object?>? user;
  @override
  final DateTime? createdAt;
  @override
  final String? title;
  @override
  final String? cid;
  @override
  final String? contentId;
  @override
  final DateTime? viewedAt;
  @override
  final String? contentMediaURL;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$CourseIndexRecord(
          [void Function(CourseIndexRecordBuilder)? updates]) =>
      (new CourseIndexRecordBuilder()..update(updates))._build();

  _$CourseIndexRecord._(
      {this.user,
      this.createdAt,
      this.title,
      this.cid,
      this.contentId,
      this.viewedAt,
      this.contentMediaURL,
      this.ffRef})
      : super._();

  @override
  CourseIndexRecord rebuild(void Function(CourseIndexRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CourseIndexRecordBuilder toBuilder() =>
      new CourseIndexRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CourseIndexRecord &&
        user == other.user &&
        createdAt == other.createdAt &&
        title == other.title &&
        cid == other.cid &&
        contentId == other.contentId &&
        viewedAt == other.viewedAt &&
        contentMediaURL == other.contentMediaURL &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, user.hashCode), createdAt.hashCode),
                            title.hashCode),
                        cid.hashCode),
                    contentId.hashCode),
                viewedAt.hashCode),
            contentMediaURL.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CourseIndexRecord')
          ..add('user', user)
          ..add('createdAt', createdAt)
          ..add('title', title)
          ..add('cid', cid)
          ..add('contentId', contentId)
          ..add('viewedAt', viewedAt)
          ..add('contentMediaURL', contentMediaURL)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class CourseIndexRecordBuilder
    implements Builder<CourseIndexRecord, CourseIndexRecordBuilder> {
  _$CourseIndexRecord? _$v;

  DocumentReference<Object?>? _user;
  DocumentReference<Object?>? get user => _$this._user;
  set user(DocumentReference<Object?>? user) => _$this._user = user;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _cid;
  String? get cid => _$this._cid;
  set cid(String? cid) => _$this._cid = cid;

  String? _contentId;
  String? get contentId => _$this._contentId;
  set contentId(String? contentId) => _$this._contentId = contentId;

  DateTime? _viewedAt;
  DateTime? get viewedAt => _$this._viewedAt;
  set viewedAt(DateTime? viewedAt) => _$this._viewedAt = viewedAt;

  String? _contentMediaURL;
  String? get contentMediaURL => _$this._contentMediaURL;
  set contentMediaURL(String? contentMediaURL) =>
      _$this._contentMediaURL = contentMediaURL;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  CourseIndexRecordBuilder() {
    CourseIndexRecord._initializeBuilder(this);
  }

  CourseIndexRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user;
      _createdAt = $v.createdAt;
      _title = $v.title;
      _cid = $v.cid;
      _contentId = $v.contentId;
      _viewedAt = $v.viewedAt;
      _contentMediaURL = $v.contentMediaURL;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CourseIndexRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CourseIndexRecord;
  }

  @override
  void update(void Function(CourseIndexRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CourseIndexRecord build() => _build();

  _$CourseIndexRecord _build() {
    final _$result = _$v ??
        new _$CourseIndexRecord._(
            user: user,
            createdAt: createdAt,
            title: title,
            cid: cid,
            contentId: contentId,
            viewedAt: viewedAt,
            contentMediaURL: contentMediaURL,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas

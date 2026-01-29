/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'dart:typed_data' as _i2;

abstract class EvidenceRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  EvidenceRecord._({
    this.id,
    required this.hash,
    this.note,
    required this.createdAt,
    this.thumbnail,
  });

  factory EvidenceRecord({
    int? id,
    required String hash,
    String? note,
    required DateTime createdAt,
    _i2.ByteData? thumbnail,
  }) = _EvidenceRecordImpl;

  factory EvidenceRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return EvidenceRecord(
      id: jsonSerialization['id'] as int?,
      hash: jsonSerialization['hash'] as String,
      note: jsonSerialization['note'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      thumbnail: jsonSerialization['thumbnail'] == null
          ? null
          : _i1.ByteDataJsonExtension.fromJson(jsonSerialization['thumbnail']),
    );
  }

  static final t = EvidenceRecordTable();

  static const db = EvidenceRecordRepository._();

  @override
  int? id;

  String hash;

  String? note;

  DateTime createdAt;

  _i2.ByteData? thumbnail;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [EvidenceRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EvidenceRecord copyWith({
    int? id,
    String? hash,
    String? note,
    DateTime? createdAt,
    _i2.ByteData? thumbnail,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EvidenceRecord',
      if (id != null) 'id': id,
      'hash': hash,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
      if (thumbnail != null) 'thumbnail': thumbnail?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EvidenceRecord',
      if (id != null) 'id': id,
      'hash': hash,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
      if (thumbnail != null) 'thumbnail': thumbnail?.toJson(),
    };
  }

  static EvidenceRecordInclude include() {
    return EvidenceRecordInclude._();
  }

  static EvidenceRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<EvidenceRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EvidenceRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EvidenceRecordTable>? orderByList,
    EvidenceRecordInclude? include,
  }) {
    return EvidenceRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EvidenceRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(EvidenceRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EvidenceRecordImpl extends EvidenceRecord {
  _EvidenceRecordImpl({
    int? id,
    required String hash,
    String? note,
    required DateTime createdAt,
    _i2.ByteData? thumbnail,
  }) : super._(
         id: id,
         hash: hash,
         note: note,
         createdAt: createdAt,
         thumbnail: thumbnail,
       );

  /// Returns a shallow copy of this [EvidenceRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EvidenceRecord copyWith({
    Object? id = _Undefined,
    String? hash,
    Object? note = _Undefined,
    DateTime? createdAt,
    Object? thumbnail = _Undefined,
  }) {
    return EvidenceRecord(
      id: id is int? ? id : this.id,
      hash: hash ?? this.hash,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
      thumbnail: thumbnail is _i2.ByteData?
          ? thumbnail
          : this.thumbnail?.clone(),
    );
  }
}

class EvidenceRecordUpdateTable extends _i1.UpdateTable<EvidenceRecordTable> {
  EvidenceRecordUpdateTable(super.table);

  _i1.ColumnValue<String, String> hash(String value) => _i1.ColumnValue(
    table.hash,
    value,
  );

  _i1.ColumnValue<String, String> note(String? value) => _i1.ColumnValue(
    table.note,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<_i2.ByteData, _i2.ByteData> thumbnail(_i2.ByteData? value) =>
      _i1.ColumnValue(
        table.thumbnail,
        value,
      );
}

class EvidenceRecordTable extends _i1.Table<int?> {
  EvidenceRecordTable({super.tableRelation})
    : super(tableName: 'evidence_records') {
    updateTable = EvidenceRecordUpdateTable(this);
    hash = _i1.ColumnString(
      'hash',
      this,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    thumbnail = _i1.ColumnByteData(
      'thumbnail',
      this,
    );
  }

  late final EvidenceRecordUpdateTable updateTable;

  late final _i1.ColumnString hash;

  late final _i1.ColumnString note;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnByteData thumbnail;

  @override
  List<_i1.Column> get columns => [
    id,
    hash,
    note,
    createdAt,
    thumbnail,
  ];
}

class EvidenceRecordInclude extends _i1.IncludeObject {
  EvidenceRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => EvidenceRecord.t;
}

class EvidenceRecordIncludeList extends _i1.IncludeList {
  EvidenceRecordIncludeList._({
    _i1.WhereExpressionBuilder<EvidenceRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EvidenceRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => EvidenceRecord.t;
}

class EvidenceRecordRepository {
  const EvidenceRecordRepository._();

  /// Returns a list of [EvidenceRecord]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<EvidenceRecord>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EvidenceRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EvidenceRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EvidenceRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<EvidenceRecord>(
      where: where?.call(EvidenceRecord.t),
      orderBy: orderBy?.call(EvidenceRecord.t),
      orderByList: orderByList?.call(EvidenceRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [EvidenceRecord] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<EvidenceRecord?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EvidenceRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<EvidenceRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EvidenceRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<EvidenceRecord>(
      where: where?.call(EvidenceRecord.t),
      orderBy: orderBy?.call(EvidenceRecord.t),
      orderByList: orderByList?.call(EvidenceRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [EvidenceRecord] by its [id] or null if no such row exists.
  Future<EvidenceRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<EvidenceRecord>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [EvidenceRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [EvidenceRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<EvidenceRecord>> insert(
    _i1.Session session,
    List<EvidenceRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<EvidenceRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [EvidenceRecord] and returns the inserted row.
  ///
  /// The returned [EvidenceRecord] will have its `id` field set.
  Future<EvidenceRecord> insertRow(
    _i1.Session session,
    EvidenceRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<EvidenceRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [EvidenceRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<EvidenceRecord>> update(
    _i1.Session session,
    List<EvidenceRecord> rows, {
    _i1.ColumnSelections<EvidenceRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<EvidenceRecord>(
      rows,
      columns: columns?.call(EvidenceRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EvidenceRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EvidenceRecord> updateRow(
    _i1.Session session,
    EvidenceRecord row, {
    _i1.ColumnSelections<EvidenceRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<EvidenceRecord>(
      row,
      columns: columns?.call(EvidenceRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EvidenceRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EvidenceRecord?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<EvidenceRecordUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<EvidenceRecord>(
      id,
      columnValues: columnValues(EvidenceRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EvidenceRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<EvidenceRecord>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<EvidenceRecordUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<EvidenceRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EvidenceRecordTable>? orderBy,
    _i1.OrderByListBuilder<EvidenceRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<EvidenceRecord>(
      columnValues: columnValues(EvidenceRecord.t.updateTable),
      where: where(EvidenceRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EvidenceRecord.t),
      orderByList: orderByList?.call(EvidenceRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [EvidenceRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<EvidenceRecord>> delete(
    _i1.Session session,
    List<EvidenceRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<EvidenceRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [EvidenceRecord].
  Future<EvidenceRecord> deleteRow(
    _i1.Session session,
    EvidenceRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EvidenceRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<EvidenceRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<EvidenceRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<EvidenceRecord>(
      where: where(EvidenceRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EvidenceRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<EvidenceRecord>(
      where: where?.call(EvidenceRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

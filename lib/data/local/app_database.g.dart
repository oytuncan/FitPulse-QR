// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PrRecordsTable extends PrRecords
    with TableInfo<$PrRecordsTable, PrRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _machineIdMeta = const VerificationMeta(
    'machineId',
  );
  @override
  late final GeneratedColumn<String> machineId = GeneratedColumn<String>(
    'machine_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    machineId,
    weightKg,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pr_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('machine_id')) {
      context.handle(
        _machineIdMeta,
        machineId.isAcceptableOrUnknown(data['machine_id']!, _machineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_machineIdMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      machineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}machine_id'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PrRecordsTable createAlias(String alias) {
    return $PrRecordsTable(attachedDatabase, alias);
  }
}

class PrRecord extends DataClass implements Insertable<PrRecord> {
  final int id;
  final String userId;
  final String machineId;
  final double weightKg;
  final DateTime createdAt;
  const PrRecord({
    required this.id,
    required this.userId,
    required this.machineId,
    required this.weightKg,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['machine_id'] = Variable<String>(machineId);
    map['weight_kg'] = Variable<double>(weightKg);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PrRecordsCompanion toCompanion(bool nullToAbsent) {
    return PrRecordsCompanion(
      id: Value(id),
      userId: Value(userId),
      machineId: Value(machineId),
      weightKg: Value(weightKg),
      createdAt: Value(createdAt),
    );
  }

  factory PrRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrRecord(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      machineId: serializer.fromJson<String>(json['machineId']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'machineId': serializer.toJson<String>(machineId),
      'weightKg': serializer.toJson<double>(weightKg),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PrRecord copyWith({
    int? id,
    String? userId,
    String? machineId,
    double? weightKg,
    DateTime? createdAt,
  }) => PrRecord(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    machineId: machineId ?? this.machineId,
    weightKg: weightKg ?? this.weightKg,
    createdAt: createdAt ?? this.createdAt,
  );
  PrRecord copyWithCompanion(PrRecordsCompanion data) {
    return PrRecord(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      machineId: data.machineId.present ? data.machineId.value : this.machineId,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrRecord(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('machineId: $machineId, ')
          ..write('weightKg: $weightKg, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, machineId, weightKg, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrRecord &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.machineId == this.machineId &&
          other.weightKg == this.weightKg &&
          other.createdAt == this.createdAt);
}

class PrRecordsCompanion extends UpdateCompanion<PrRecord> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> machineId;
  final Value<double> weightKg;
  final Value<DateTime> createdAt;
  const PrRecordsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.machineId = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PrRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String machineId,
    required double weightKg,
    this.createdAt = const Value.absent(),
  }) : userId = Value(userId),
       machineId = Value(machineId),
       weightKg = Value(weightKg);
  static Insertable<PrRecord> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? machineId,
    Expression<double>? weightKg,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (machineId != null) 'machine_id': machineId,
      if (weightKg != null) 'weight_kg': weightKg,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PrRecordsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? machineId,
    Value<double>? weightKg,
    Value<DateTime>? createdAt,
  }) {
    return PrRecordsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      machineId: machineId ?? this.machineId,
      weightKg: weightKg ?? this.weightKg,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (machineId.present) {
      map['machine_id'] = Variable<String>(machineId.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrRecordsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('machineId: $machineId, ')
          ..write('weightKg: $weightKg, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PrRecordsTable prRecords = $PrRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [prRecords];
}

typedef $$PrRecordsTableCreateCompanionBuilder = PrRecordsCompanion Function({
  Value<int> id,
  required String userId,
  required String machineId,
  required double weightKg,
  Value<DateTime> createdAt,
});
typedef $$PrRecordsTableUpdateCompanionBuilder = PrRecordsCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<String> machineId,
  Value<double> weightKg,
  Value<DateTime> createdAt,
});

class $$PrRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $PrRecordsTable> {
  $$PrRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get machineId => $composableBuilder(
    column: $table.machineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PrRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $PrRecordsTable> {
  $$PrRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get machineId => $composableBuilder(
    column: $table.machineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PrRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrRecordsTable> {
  $$PrRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get machineId =>
      $composableBuilder(column: $table.machineId, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PrRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrRecordsTable,
          PrRecord,
          $$PrRecordsTableFilterComposer,
          $$PrRecordsTableOrderingComposer,
          $$PrRecordsTableAnnotationComposer,
          $$PrRecordsTableCreateCompanionBuilder,
          $$PrRecordsTableUpdateCompanionBuilder,
          (PrRecord, BaseReferences<_$AppDatabase, $PrRecordsTable, PrRecord>),
          PrRecord,
          PrefetchHooks Function()
        > {
  $$PrRecordsTableTableManager(_$AppDatabase db, $PrRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> machineId = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PrRecordsCompanion(
                id: id,
                userId: userId,
                machineId: machineId,
                weightKg: weightKg,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String machineId,
                required double weightKg,
                Value<DateTime> createdAt = const Value.absent(),
              }) => PrRecordsCompanion.insert(
                id: id,
                userId: userId,
                machineId: machineId,
                weightKg: weightKg,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PrRecordsTable, PrRecord>(table),
                  BaseReferences<_$AppDatabase, $PrRecordsTable, PrRecord>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PrRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrRecordsTable,
      PrRecord,
      $$PrRecordsTableFilterComposer,
      $$PrRecordsTableOrderingComposer,
      $$PrRecordsTableAnnotationComposer,
      $$PrRecordsTableCreateCompanionBuilder,
      $$PrRecordsTableUpdateCompanionBuilder,
      (PrRecord, BaseReferences<_$AppDatabase, $PrRecordsTable, PrRecord>),
      PrRecord,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PrRecordsTableTableManager get prRecords =>
      $$PrRecordsTableTableManager(_db, _db.prRecords);
}

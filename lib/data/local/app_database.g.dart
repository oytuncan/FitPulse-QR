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

class $NutritionProfilesTable extends NutritionProfiles
    with TableInfo<$NutritionProfilesTable, NutritionProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NutritionProfilesTable(this.attachedDatabase, [this._alias]);
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
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    false,
    type: DriftSqlType.double,
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
  static const VerificationMeta _activityLevelMeta = const VerificationMeta(
    'activityLevel',
  );
  @override
  late final GeneratedColumn<String> activityLevel = GeneratedColumn<String>(
    'activity_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<String> goal = GeneratedColumn<String>(
    'goal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesMeta = const VerificationMeta(
    'calories',
  );
  @override
  late final GeneratedColumn<int> calories = GeneratedColumn<int>(
    'calories',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinGMeta = const VerificationMeta(
    'proteinG',
  );
  @override
  late final GeneratedColumn<int> proteinG = GeneratedColumn<int>(
    'protein_g',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsGMeta = const VerificationMeta('carbsG');
  @override
  late final GeneratedColumn<int> carbsG = GeneratedColumn<int>(
    'carbs_g',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatGMeta = const VerificationMeta('fatG');
  @override
  late final GeneratedColumn<int> fatG = GeneratedColumn<int>(
    'fat_g',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    gender,
    age,
    heightCm,
    weightKg,
    activityLevel,
    goal,
    calories,
    proteinG,
    carbsG,
    fatG,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<NutritionProfileRow> instance, {
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
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    } else if (isInserting) {
      context.missing(_heightCmMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('activity_level')) {
      context.handle(
        _activityLevelMeta,
        activityLevel.isAcceptableOrUnknown(
          data['activity_level']!,
          _activityLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activityLevelMeta);
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    } else if (isInserting) {
      context.missing(_goalMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(
        _caloriesMeta,
        calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta),
      );
    } else if (isInserting) {
      context.missing(_caloriesMeta);
    }
    if (data.containsKey('protein_g')) {
      context.handle(
        _proteinGMeta,
        proteinG.isAcceptableOrUnknown(data['protein_g']!, _proteinGMeta),
      );
    } else if (isInserting) {
      context.missing(_proteinGMeta);
    }
    if (data.containsKey('carbs_g')) {
      context.handle(
        _carbsGMeta,
        carbsG.isAcceptableOrUnknown(data['carbs_g']!, _carbsGMeta),
      );
    } else if (isInserting) {
      context.missing(_carbsGMeta);
    }
    if (data.containsKey('fat_g')) {
      context.handle(
        _fatGMeta,
        fatG.isAcceptableOrUnknown(data['fat_g']!, _fatGMeta),
      );
    } else if (isInserting) {
      context.missing(_fatGMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NutritionProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NutritionProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      )!,
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      activityLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_level'],
      )!,
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal'],
      )!,
      calories: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calories'],
      )!,
      proteinG: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}protein_g'],
      )!,
      carbsG: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}carbs_g'],
      )!,
      fatG: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fat_g'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NutritionProfilesTable createAlias(String alias) {
    return $NutritionProfilesTable(attachedDatabase, alias);
  }
}

class NutritionProfileRow extends DataClass
    implements Insertable<NutritionProfileRow> {
  final int id;
  final String userId;
  final String gender;
  final int age;
  final double heightCm;
  final double weightKg;
  final String activityLevel;
  final String goal;
  final int calories;
  final int proteinG;
  final int carbsG;
  final int fatG;
  final DateTime updatedAt;
  const NutritionProfileRow({
    required this.id,
    required this.userId,
    required this.gender,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.activityLevel,
    required this.goal,
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['gender'] = Variable<String>(gender);
    map['age'] = Variable<int>(age);
    map['height_cm'] = Variable<double>(heightCm);
    map['weight_kg'] = Variable<double>(weightKg);
    map['activity_level'] = Variable<String>(activityLevel);
    map['goal'] = Variable<String>(goal);
    map['calories'] = Variable<int>(calories);
    map['protein_g'] = Variable<int>(proteinG);
    map['carbs_g'] = Variable<int>(carbsG);
    map['fat_g'] = Variable<int>(fatG);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NutritionProfilesCompanion toCompanion(bool nullToAbsent) {
    return NutritionProfilesCompanion(
      id: Value(id),
      userId: Value(userId),
      gender: Value(gender),
      age: Value(age),
      heightCm: Value(heightCm),
      weightKg: Value(weightKg),
      activityLevel: Value(activityLevel),
      goal: Value(goal),
      calories: Value(calories),
      proteinG: Value(proteinG),
      carbsG: Value(carbsG),
      fatG: Value(fatG),
      updatedAt: Value(updatedAt),
    );
  }

  factory NutritionProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NutritionProfileRow(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      gender: serializer.fromJson<String>(json['gender']),
      age: serializer.fromJson<int>(json['age']),
      heightCm: serializer.fromJson<double>(json['heightCm']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      activityLevel: serializer.fromJson<String>(json['activityLevel']),
      goal: serializer.fromJson<String>(json['goal']),
      calories: serializer.fromJson<int>(json['calories']),
      proteinG: serializer.fromJson<int>(json['proteinG']),
      carbsG: serializer.fromJson<int>(json['carbsG']),
      fatG: serializer.fromJson<int>(json['fatG']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'gender': serializer.toJson<String>(gender),
      'age': serializer.toJson<int>(age),
      'heightCm': serializer.toJson<double>(heightCm),
      'weightKg': serializer.toJson<double>(weightKg),
      'activityLevel': serializer.toJson<String>(activityLevel),
      'goal': serializer.toJson<String>(goal),
      'calories': serializer.toJson<int>(calories),
      'proteinG': serializer.toJson<int>(proteinG),
      'carbsG': serializer.toJson<int>(carbsG),
      'fatG': serializer.toJson<int>(fatG),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NutritionProfileRow copyWith({
    int? id,
    String? userId,
    String? gender,
    int? age,
    double? heightCm,
    double? weightKg,
    String? activityLevel,
    String? goal,
    int? calories,
    int? proteinG,
    int? carbsG,
    int? fatG,
    DateTime? updatedAt,
  }) => NutritionProfileRow(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    gender: gender ?? this.gender,
    age: age ?? this.age,
    heightCm: heightCm ?? this.heightCm,
    weightKg: weightKg ?? this.weightKg,
    activityLevel: activityLevel ?? this.activityLevel,
    goal: goal ?? this.goal,
    calories: calories ?? this.calories,
    proteinG: proteinG ?? this.proteinG,
    carbsG: carbsG ?? this.carbsG,
    fatG: fatG ?? this.fatG,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NutritionProfileRow copyWithCompanion(NutritionProfilesCompanion data) {
    return NutritionProfileRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      gender: data.gender.present ? data.gender.value : this.gender,
      age: data.age.present ? data.age.value : this.age,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      activityLevel: data.activityLevel.present
          ? data.activityLevel.value
          : this.activityLevel,
      goal: data.goal.present ? data.goal.value : this.goal,
      calories: data.calories.present ? data.calories.value : this.calories,
      proteinG: data.proteinG.present ? data.proteinG.value : this.proteinG,
      carbsG: data.carbsG.present ? data.carbsG.value : this.carbsG,
      fatG: data.fatG.present ? data.fatG.value : this.fatG,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NutritionProfileRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('gender: $gender, ')
          ..write('age: $age, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('activityLevel: $activityLevel, ')
          ..write('goal: $goal, ')
          ..write('calories: $calories, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatG: $fatG, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    gender,
    age,
    heightCm,
    weightKg,
    activityLevel,
    goal,
    calories,
    proteinG,
    carbsG,
    fatG,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NutritionProfileRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.gender == this.gender &&
          other.age == this.age &&
          other.heightCm == this.heightCm &&
          other.weightKg == this.weightKg &&
          other.activityLevel == this.activityLevel &&
          other.goal == this.goal &&
          other.calories == this.calories &&
          other.proteinG == this.proteinG &&
          other.carbsG == this.carbsG &&
          other.fatG == this.fatG &&
          other.updatedAt == this.updatedAt);
}

class NutritionProfilesCompanion extends UpdateCompanion<NutritionProfileRow> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> gender;
  final Value<int> age;
  final Value<double> heightCm;
  final Value<double> weightKg;
  final Value<String> activityLevel;
  final Value<String> goal;
  final Value<int> calories;
  final Value<int> proteinG;
  final Value<int> carbsG;
  final Value<int> fatG;
  final Value<DateTime> updatedAt;
  const NutritionProfilesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.gender = const Value.absent(),
    this.age = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.activityLevel = const Value.absent(),
    this.goal = const Value.absent(),
    this.calories = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.carbsG = const Value.absent(),
    this.fatG = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NutritionProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String gender,
    required int age,
    required double heightCm,
    required double weightKg,
    required String activityLevel,
    required String goal,
    required int calories,
    required int proteinG,
    required int carbsG,
    required int fatG,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       gender = Value(gender),
       age = Value(age),
       heightCm = Value(heightCm),
       weightKg = Value(weightKg),
       activityLevel = Value(activityLevel),
       goal = Value(goal),
       calories = Value(calories),
       proteinG = Value(proteinG),
       carbsG = Value(carbsG),
       fatG = Value(fatG),
       updatedAt = Value(updatedAt);
  static Insertable<NutritionProfileRow> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? gender,
    Expression<int>? age,
    Expression<double>? heightCm,
    Expression<double>? weightKg,
    Expression<String>? activityLevel,
    Expression<String>? goal,
    Expression<int>? calories,
    Expression<int>? proteinG,
    Expression<int>? carbsG,
    Expression<int>? fatG,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (gender != null) 'gender': gender,
      if (age != null) 'age': age,
      if (heightCm != null) 'height_cm': heightCm,
      if (weightKg != null) 'weight_kg': weightKg,
      if (activityLevel != null) 'activity_level': activityLevel,
      if (goal != null) 'goal': goal,
      if (calories != null) 'calories': calories,
      if (proteinG != null) 'protein_g': proteinG,
      if (carbsG != null) 'carbs_g': carbsG,
      if (fatG != null) 'fat_g': fatG,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NutritionProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? gender,
    Value<int>? age,
    Value<double>? heightCm,
    Value<double>? weightKg,
    Value<String>? activityLevel,
    Value<String>? goal,
    Value<int>? calories,
    Value<int>? proteinG,
    Value<int>? carbsG,
    Value<int>? fatG,
    Value<DateTime>? updatedAt,
  }) {
    return NutritionProfilesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      activityLevel: activityLevel ?? this.activityLevel,
      goal: goal ?? this.goal,
      calories: calories ?? this.calories,
      proteinG: proteinG ?? this.proteinG,
      carbsG: carbsG ?? this.carbsG,
      fatG: fatG ?? this.fatG,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (activityLevel.present) {
      map['activity_level'] = Variable<String>(activityLevel.value);
    }
    if (goal.present) {
      map['goal'] = Variable<String>(goal.value);
    }
    if (calories.present) {
      map['calories'] = Variable<int>(calories.value);
    }
    if (proteinG.present) {
      map['protein_g'] = Variable<int>(proteinG.value);
    }
    if (carbsG.present) {
      map['carbs_g'] = Variable<int>(carbsG.value);
    }
    if (fatG.present) {
      map['fat_g'] = Variable<int>(fatG.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NutritionProfilesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('gender: $gender, ')
          ..write('age: $age, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('activityLevel: $activityLevel, ')
          ..write('goal: $goal, ')
          ..write('calories: $calories, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatG: $fatG, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PrRecordsTable prRecords = $PrRecordsTable(this);
  late final $NutritionProfilesTable nutritionProfiles =
      $NutritionProfilesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    prRecords,
    nutritionProfiles,
  ];
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
typedef $$NutritionProfilesTableCreateCompanionBuilder =
    NutritionProfilesCompanion Function({
      Value<int> id,
      required String userId,
      required String gender,
      required int age,
      required double heightCm,
      required double weightKg,
      required String activityLevel,
      required String goal,
      required int calories,
      required int proteinG,
      required int carbsG,
      required int fatG,
      required DateTime updatedAt,
    });
typedef $$NutritionProfilesTableUpdateCompanionBuilder =
    NutritionProfilesCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> gender,
      Value<int> age,
      Value<double> heightCm,
      Value<double> weightKg,
      Value<String> activityLevel,
      Value<String> goal,
      Value<int> calories,
      Value<int> proteinG,
      Value<int> carbsG,
      Value<int> fatG,
      Value<DateTime> updatedAt,
    });

class $$NutritionProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $NutritionProfilesTable> {
  $$NutritionProfilesTableFilterComposer({
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

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get carbsG => $composableBuilder(
    column: $table.carbsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fatG => $composableBuilder(
    column: $table.fatG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NutritionProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $NutritionProfilesTable> {
  $$NutritionProfilesTableOrderingComposer({
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

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get carbsG => $composableBuilder(
    column: $table.carbsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fatG => $composableBuilder(
    column: $table.fatG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NutritionProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NutritionProfilesTable> {
  $$NutritionProfilesTableAnnotationComposer({
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

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<int> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<int> get proteinG =>
      $composableBuilder(column: $table.proteinG, builder: (column) => column);

  GeneratedColumn<int> get carbsG =>
      $composableBuilder(column: $table.carbsG, builder: (column) => column);

  GeneratedColumn<int> get fatG =>
      $composableBuilder(column: $table.fatG, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NutritionProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NutritionProfilesTable,
          NutritionProfileRow,
          $$NutritionProfilesTableFilterComposer,
          $$NutritionProfilesTableOrderingComposer,
          $$NutritionProfilesTableAnnotationComposer,
          $$NutritionProfilesTableCreateCompanionBuilder,
          $$NutritionProfilesTableUpdateCompanionBuilder,
          (
            NutritionProfileRow,
            BaseReferences<
              _$AppDatabase,
              $NutritionProfilesTable,
              NutritionProfileRow
            >,
          ),
          NutritionProfileRow,
          PrefetchHooks Function()
        > {
  $$NutritionProfilesTableTableManager(
    _$AppDatabase db,
    $NutritionProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NutritionProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NutritionProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NutritionProfilesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> gender = const Value.absent(),
                Value<int> age = const Value.absent(),
                Value<double> heightCm = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<String> activityLevel = const Value.absent(),
                Value<String> goal = const Value.absent(),
                Value<int> calories = const Value.absent(),
                Value<int> proteinG = const Value.absent(),
                Value<int> carbsG = const Value.absent(),
                Value<int> fatG = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => NutritionProfilesCompanion(
                id: id,
                userId: userId,
                gender: gender,
                age: age,
                heightCm: heightCm,
                weightKg: weightKg,
                activityLevel: activityLevel,
                goal: goal,
                calories: calories,
                proteinG: proteinG,
                carbsG: carbsG,
                fatG: fatG,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String gender,
                required int age,
                required double heightCm,
                required double weightKg,
                required String activityLevel,
                required String goal,
                required int calories,
                required int proteinG,
                required int carbsG,
                required int fatG,
                required DateTime updatedAt,
              }) => NutritionProfilesCompanion.insert(
                id: id,
                userId: userId,
                gender: gender,
                age: age,
                heightCm: heightCm,
                weightKg: weightKg,
                activityLevel: activityLevel,
                goal: goal,
                calories: calories,
                proteinG: proteinG,
                carbsG: carbsG,
                fatG: fatG,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NutritionProfilesTable, NutritionProfileRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $NutritionProfilesTable,
                    NutritionProfileRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NutritionProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NutritionProfilesTable,
      NutritionProfileRow,
      $$NutritionProfilesTableFilterComposer,
      $$NutritionProfilesTableOrderingComposer,
      $$NutritionProfilesTableAnnotationComposer,
      $$NutritionProfilesTableCreateCompanionBuilder,
      $$NutritionProfilesTableUpdateCompanionBuilder,
      (
        NutritionProfileRow,
        BaseReferences<
          _$AppDatabase,
          $NutritionProfilesTable,
          NutritionProfileRow
        >,
      ),
      NutritionProfileRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PrRecordsTableTableManager get prRecords =>
      $$PrRecordsTableTableManager(_db, _db.prRecords);
  $$NutritionProfilesTableTableManager get nutritionProfiles =>
      $$NutritionProfilesTableTableManager(_db, _db.nutritionProfiles);
}

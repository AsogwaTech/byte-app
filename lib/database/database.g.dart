// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class AppUserData extends DataClass implements Insertable<AppUserData> {
  final int? id;
  final String name;
  final String? email;
  final String? phoneNumber;
  final String? token;
  final String? dateOfBirth;
  final String? imagePath;
  AppUserData(
      {this.id,
      required this.name,
      this.email,
      this.phoneNumber,
      this.token,
      this.dateOfBirth,
      this.imagePath});
  factory AppUserData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return AppUserData(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_name'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email']),
      phoneNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}phone_number']),
      token: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}token']),
      dateOfBirth: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date_of_birth']),
      imagePath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image_path']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    map['user_name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String?>(email);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String?>(phoneNumber);
    }
    if (!nullToAbsent || token != null) {
      map['token'] = Variable<String?>(token);
    }
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<String?>(dateOfBirth);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String?>(imagePath);
    }
    return map;
  }

  AppUserCompanion toCompanion(bool nullToAbsent) {
    return AppUserCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: Value(name),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      token:
          token == null && nullToAbsent ? const Value.absent() : Value(token),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
    );
  }

  factory AppUserData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppUserData(
      id: serializer.fromJson<int?>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      token: serializer.fromJson<String?>(json['token']),
      dateOfBirth: serializer.fromJson<String?>(json['dateOfBirth']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'token': serializer.toJson<String?>(token),
      'dateOfBirth': serializer.toJson<String?>(dateOfBirth),
      'imagePath': serializer.toJson<String?>(imagePath),
    };
  }

  AppUserData copyWith(
          {int? id,
          String? name,
          String? email,
          String? phoneNumber,
          String? token,
          String? dateOfBirth,
          String? imagePath}) =>
      AppUserData(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        token: token ?? this.token,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        imagePath: imagePath ?? this.imagePath,
      );
  @override
  String toString() {
    return (StringBuffer('AppUserData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('token: $token, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, email, phoneNumber, token, dateOfBirth, imagePath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUserData &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.phoneNumber == this.phoneNumber &&
          other.token == this.token &&
          other.dateOfBirth == this.dateOfBirth &&
          other.imagePath == this.imagePath);
}

class AppUserCompanion extends UpdateCompanion<AppUserData> {
  final Value<int?> id;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> phoneNumber;
  final Value<String?> token;
  final Value<String?> dateOfBirth;
  final Value<String?> imagePath;
  const AppUserCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.token = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.imagePath = const Value.absent(),
  });
  AppUserCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.token = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.imagePath = const Value.absent(),
  }) : name = Value(name);
  static Insertable<AppUserData> custom({
    Expression<int?>? id,
    Expression<String>? name,
    Expression<String?>? email,
    Expression<String?>? phoneNumber,
    Expression<String?>? token,
    Expression<String?>? dateOfBirth,
    Expression<String?>? imagePath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'user_name': name,
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (token != null) 'token': token,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (imagePath != null) 'image_path': imagePath,
    });
  }

  AppUserCompanion copyWith(
      {Value<int?>? id,
      Value<String>? name,
      Value<String?>? email,
      Value<String?>? phoneNumber,
      Value<String?>? token,
      Value<String?>? dateOfBirth,
      Value<String?>? imagePath}) {
    return AppUserCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      token: token ?? this.token,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (name.present) {
      map['user_name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String?>(email.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String?>(phoneNumber.value);
    }
    if (token.present) {
      map['token'] = Variable<String?>(token.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<String?>(dateOfBirth.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String?>(imagePath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppUserCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('token: $token, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }
}

class $AppUserTable extends AppUser with TableInfo<$AppUserTable, AppUserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppUserTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'user_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String?> phoneNumber = GeneratedColumn<String?>(
      'phone_number', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String?> token = GeneratedColumn<String?>(
      'token', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<String?> dateOfBirth = GeneratedColumn<String?>(
      'date_of_birth', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _imagePathMeta = const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String?> imagePath = GeneratedColumn<String?>(
      'image_path', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, email, phoneNumber, token, dateOfBirth, imagePath];
  @override
  String get aliasedName => _alias ?? 'app_user';
  @override
  String get actualTableName => 'app_user';
  @override
  VerificationContext validateIntegrity(Insertable<AppUserData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['user_name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    }
    if (data.containsKey('token')) {
      context.handle(
          _tokenMeta, token.isAcceptableOrUnknown(data['token']!, _tokenMeta));
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppUserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return AppUserData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AppUserTable createAlias(String alias) {
    return $AppUserTable(attachedDatabase, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $AppUserTable appUser = $AppUserTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [appUser];
}

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:sqfentity_gen/sqfentity_gen.dart';
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
part 'db.g.dart';

const SqfEntityTable alarm = SqfEntityTable(
    tableName: 'tbl_alarm',
    primaryKeyName: 'ROWID',
    useSoftDeleting: false,
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    fields: [
      SqfEntityField("TIME", DbType.text),
      SqfEntityField("DAY", DbType.text),
      SqfEntityField("STATUS", DbType.bool),
      SqfEntityField("DESC", DbType.text),
    ]);

const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);
@SqfEntityBuilder(dbModel)
const dbModel = SqfEntityModel(
    modelName: 'DbModel',
    databaseName: 'DbModel3.db',
    databaseTables: [alarm],
    sequences: [seqIdentity],
    dbVersion: 1,
    bundledDatabasePath: null);

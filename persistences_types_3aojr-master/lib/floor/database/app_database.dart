import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:persistences_types_3aojr/floor/daos/booking_dao.dart';
import 'package:persistences_types_3aojr/floor/models/book.dart';


part 'app_database.g.dart';

@Database(version: 1, entities: [Book])
abstract class AppDatabase extends FloorDatabase{
  BookingDao get bookingDao;
}
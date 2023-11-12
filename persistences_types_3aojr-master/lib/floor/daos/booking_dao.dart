
import 'package:floor/floor.dart';
import 'package:persistences_types_3aojr/floor/models/book.dart';

@dao
abstract class BookingDao{

  @Query("SELECT  * FROM Book")
  Future<List<Book>> findAll();

  @insert
  Future<void> insertBook(Book book);

  @delete
  Future<void> deleteBook(Book book);
}
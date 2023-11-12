import 'package:flutter/material.dart';
import 'package:persistences_types_3aojr/floor/daos/booking_dao.dart';
import 'package:persistences_types_3aojr/floor/database/app_database.dart';
import 'package:persistences_types_3aojr/floor/models/book.dart';
import 'package:persistences_types_3aojr/floor/screens/add.dart';
import 'package:persistences_types_3aojr/utils/constants.dart';

class BooksListWidget extends StatefulWidget {
  const BooksListWidget({super.key});

  @override
  State<BooksListWidget> createState() => _BooksListWidgetState();
}

class _BooksListWidgetState extends State<BooksListWidget> {
  
  BookingDao? dao;
  List<Book> books = [];
  final title = const Text("Livros");
  final addWidget = BookAddWidget();

  @override
  void initState(){
    super.initState();
    _initializDatabase();
  }

  _initializDatabase() async{
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    dao = database.bookingDao;

    await _getAllBook();
  }

  _getAllBook() async{
    if(dao != null){
      final result = await dao!.findAll();
      setState(() {
        books = result;
      });
    }
  }

  _deleteBook(Book book) async{
    if(dao != null){
      await dao!.deleteBook(book);
      _getAllBook();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => addWidget)).then((value) => _getAllBook()),
              icon: iconAdd)
        ],
      ),
      body: ListView.builder(
          itemBuilder: (context, index) => _buildItem(index),
          itemCount: books.length),
    );
  }

  Widget _buildItem(index) {
    Book book = books[index];
    return Padding(
        padding: padding,
        child: Card(
          child: ListTile(
            leading: Text(book.id != null ? book.id!.toString() : ""),
            title: Text(book.name),
            subtitle: Text(book.author),
            onLongPress: (){
              _deleteBook(book);
            },
          ),
        ));
  }
}

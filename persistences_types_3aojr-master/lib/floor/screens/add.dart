import 'package:flutter/material.dart';
import 'package:persistences_types_3aojr/floor/database/app_database.dart';
import 'package:persistences_types_3aojr/floor/models/book.dart';
import 'package:persistences_types_3aojr/utils/constants.dart';

class BookAddWidget extends StatelessWidget {
  BookAddWidget({super.key});

  final title = const Text("Novo livro");
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nameDecoration = const InputDecoration(
      hintText: "Nome do livro", labelText: "Nome do livro");
  final _authorController = TextEditingController();
  final _authorDecoration = const InputDecoration(
      hintText: "Autor do livro", labelText: "Autor do livro");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
          padding: padding,
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                decoration: _nameDecoration,
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nome do livro inválido";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: _authorDecoration,
                controller: _authorController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Autor do livro inválido";
                  }
                  return null;
                },
              ),
              Padding(
                  padding: paddingButton,
                  child: ElevatedButton(
                    child: buttonLabel,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final database = await $FloorAppDatabase
                            .databaseBuilder('app_database.db')
                            .build();
                        final dao = database.bookingDao;

                        final book = Book(_nameController.text, _authorController.text, null);
                        await dao.insertBook(book);
                        Navigator.pop(context);
                      }
                    },
                  ))
            ]),
          )),
    );
  }
}

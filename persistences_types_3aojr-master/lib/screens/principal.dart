import 'package:flutter/material.dart';
import 'package:persistences_types_3aojr/types/menu.dart';
import 'package:persistences_types_3aojr/utils/constants.dart';

class PrincipalWidget extends StatelessWidget {
  PrincipalWidget({super.key});

  final List<Menu> menus = [
    Menu("Floor", "Lista de livros", "assets/floor.png", "/books"),
    Menu("Firebase", "Lista de carros", "assets/firebase.png", "/cars")
  ];

  final title = const Text("Flutter - Persistência");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
         backgroundColor: Theme.of(context).colorScheme.inversePrimary
         ),
         body: ListView.separated(
          itemBuilder: (context, index){
            final menu = menus[index];
            
            return ListTile(
              leading: Image.asset(menu.icon),
              title: Text(menu.title),
              subtitle: Text(menu.subtitle),
              trailing: nextIcon,
              onTap: (){
                Navigator.pushNamed(context, menu.path);
              },
            );
          }, 
          separatorBuilder: (context, index){
            return divider;
          },
          itemCount: menus.length),
    );
  }
}
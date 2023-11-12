import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistences_types_3aojr/firebase/models/car.dart';
import 'package:persistences_types_3aojr/firebase/screens/add.dart';
import 'package:persistences_types_3aojr/utils/constants.dart';

class CarsListWidget extends StatefulWidget {
  const CarsListWidget({super.key});

  @override
  State<CarsListWidget> createState() => _CarsListWidgetState();
}

class _CarsListWidgetState extends State<CarsListWidget> {
  final List<Car> books = [
    Car("Carro 1", "Autor 1"),
    Car("Carro 2", "Autor 2"),
  ];

  final title = const Text("Carros");
  final addWidget = CarAddWidget();
  final notFound = const Center(child: Text("Nenhum carro encontrado!"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => addWidget)),
              icon: iconAdd)
        ],
      ),
      body: _buildList(context)
    );
  }

  Widget _buildList(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("cars").snapshots(),
       builder: (context, snapshot){
        if(!snapshot.hasData) return const LinearProgressIndicator();
        if(snapshot.data == null){
          return notFound;
        }else{
          return _buildListView(context, snapshot.data!.docs);
        }
       });
  }

  Widget _buildListView(BuildContext context, List<QueryDocumentSnapshot> snapshot){
    return ListView(
      padding: paddingButton,
      children: snapshot.map((data) => _buildItem(context, data)).toList(),
    );
  }

  Widget _buildItem(BuildContext context, QueryDocumentSnapshot data) {
    Car car = Car.fromSnapshot(data);
    return Padding(
        padding: padding,
        child: Card(
          child: ListTile(
            leading: Text(car.id != null ? car.id!.toString() : ""),
            title: Text(car.brand),
            subtitle: Text(car.model),
            onLongPress: () async{
              await data.reference.delete();
            },
          ),
        ));
  }
}

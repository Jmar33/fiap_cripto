import 'package:cloud_firestore/cloud_firestore.dart';

class Car{
  int? id;
  final String brand; 
  final String model;

  DocumentReference? reference;


  Car(this.brand, this.model);

  Map<String, dynamic> toJson() => {
    "brand": brand,
    "model": model,
  };

  Car.fromMap(Map<String, dynamic> map, {this.reference}) : 
    brand = map["brand"],
    model = map["model"];

  Car.fromSnapshot(QueryDocumentSnapshot snapshot) : this.fromMap(
    snapshot.data() as Map<String, dynamic>, reference: snapshot.reference
  );
}
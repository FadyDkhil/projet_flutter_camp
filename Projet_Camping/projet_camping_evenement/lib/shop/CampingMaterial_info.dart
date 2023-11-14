// import 'package:camping_materiel/CampingMaterial.dart';
// import 'package:camping_materiel/CampingMaterial.dart';
import 'package:flutter/material.dart';

class CampingMaterialInfo extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String addDate;
  final String userID;

  const CampingMaterialInfo(
      this.name, this.description, this.price, this.addDate, this.userID);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        child: Column(
          children: [
            Text(name),
            Text(description),
            const SizedBox(
              height: 5,
            ),
            Text('$price DT'),
            const SizedBox(
              height: 5,
            ),
            Text(addDate),
          ],
        ),
      ),
    );
  }
}

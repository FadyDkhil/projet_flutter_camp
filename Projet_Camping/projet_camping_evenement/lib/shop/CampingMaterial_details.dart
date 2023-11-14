import 'package:flutter/material.dart';

class CampingMaterialDetails extends StatefulWidget {
  final String _name;
  final String _description;
  final String _price;
  final String _addDate;
  final String _userID;

  const CampingMaterialDetails(
      this._name, this._description, this._price, this._addDate, this._userID);

  @override
  _CampingMaterialDetailsState createState() => _CampingMaterialDetailsState();
}

class _CampingMaterialDetailsState extends State<CampingMaterialDetails> {
  //late int _currentQuantity;
  @override
  void initState() {
    // _currentQuantity = widget._quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._name),
      ),
      body: Column(
        children: [
          // Container(
          //   width: double.infinity,
          //   margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          //   child: Image.asset(widget._image, width: 460, height: 215),
          // ),

          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
            child: Text(widget._description),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
            child: Text(widget._price),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
            child: Text(widget._addDate),
          ),

          SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Buy", textScaleFactor: 2),
                ],
              ),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.fromLTRB(20, 20, 20, 50),
          //   child: Text("Exemplaire disponible: $_currentQuantity"),
          // ),
        ],
      ),
    );
  }
}

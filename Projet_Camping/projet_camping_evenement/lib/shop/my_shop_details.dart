import 'package:flutter/material.dart';
import 'package:projet_camping_evenement/shop/edit_CampingMaterial.dart';
import 'package:http/http.dart' as http;

class MyShopDetails extends StatefulWidget {
  final String _id;
  final String _name;
  final String _description;
  final String _price;
  final String _addDate;
  final String _userID;

  const MyShopDetails(this._id, this._name, this._description, this._price,
      this._addDate, this._userID);

  @override
  _MyShopDetailsState createState() => _MyShopDetailsState();
}

class _MyShopDetailsState extends State<MyShopDetails> {
  //late int _currentQuantity;
  Future<void> deleteMaterial() async {
    try {
      final response = await http.delete(Uri.http(
          "localhost:3000", "/material/campingMaterial/${widget._id}"));

      if (response.statusCode == 203) {
        // The event was successfully deleted
        Navigator.pop(context); // You can navigate back or do any other action
      } else {
        // Handle error
        print('Failed to delete event: ${response.body}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

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

          Container(
            margin: const EdgeInsets.fromLTRB(175, 15, 0, 15),
            child: SizedBox(
              width: 120,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EditMaterial(
                                id: widget._id,
                              )));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Edit")
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(175, 0, 0, 0),
            child: SizedBox(
              width: 120,
              height: 40,
              child: ElevatedButton(
                onPressed: deleteMaterial,
                // onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Delete")
                  ],
                ),
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

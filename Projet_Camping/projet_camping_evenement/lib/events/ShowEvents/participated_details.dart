import 'package:flutter/material.dart';

class ParticipatedEventsDetails extends StatefulWidget {
  final String _id;
  final String _name;
  final String _location;
  final String _description;
  final String _startDate;
  final String _endDate;
  final String _maxPeople;
  final String _userID;

  const ParticipatedEventsDetails(
      this._id,
      this._name,
      this._location,
      this._description,
      this._startDate,
      this._endDate,
      this._maxPeople,
      this._userID);

  @override
  _ParticipatedEventsDetailsState createState() =>
      _ParticipatedEventsDetailsState();
}

class _ParticipatedEventsDetailsState extends State<ParticipatedEventsDetails> {
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
            margin: const EdgeInsets.fromLTRB(100, 50, 0, 30),
            child: Text("${widget._location} ", textScaleFactor: 2),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(100, 15, 0, 30),
            child: Text(widget._description),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(100, 15, 0, 30),
            child: Text(
                "Start Date: ${widget._startDate} Ends: ${widget._endDate}"),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(100, 0, 20, 50),
            child: Text("Participents: ${widget._maxPeople}"),
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(100, 15, 0, 0),
            child: SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Unparticipate", textScaleFactor: 2),
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

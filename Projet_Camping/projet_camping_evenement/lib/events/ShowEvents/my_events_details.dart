import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet_camping_evenement/events/edit_event.dart';

class MyEventDetails extends StatefulWidget {
  final String _id;
  final String _name;
  final String _location;
  final String _description;
  final String _startDate;
  final String _endDate;
  final String _maxPeople;
  final String _userID;

  const MyEventDetails(this._id, this._name, this._location, this._description,
      this._startDate, this._endDate, this._maxPeople, this._userID);

  @override
  _MyEventDetailsState createState() => _MyEventDetailsState();
}

class _MyEventDetailsState extends State<MyEventDetails> {
  Future<void> deleteEvent() async {
    try {
      final response = await http
          .delete(Uri.http("localhost:3000", "/fady/events/${widget._id}"));

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
            margin: const EdgeInsets.fromLTRB(175, 30, 0, 30),
            child: Text("${widget._location} ", textScaleFactor: 2),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(175, 15, 0, 30),
            child: Text(widget._description),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(175, 15, 0, 30),
            child: Text(
                "Start Date: ${widget._startDate} Ends: ${widget._endDate}"),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(175, 15, 0, 30),
            child: Text("Participents: ${widget._maxPeople}"),
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
                          builder: (BuildContext context) => EditEvent(
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
                onPressed: deleteEvent,
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

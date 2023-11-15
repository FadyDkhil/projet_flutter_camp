import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../../user_provider.dart';

class EventDetails extends StatefulWidget {
  final String _name;
  final String _location;
  final String _description;
  final String _startDate;
  final String _endDate;
  final String _maxPeople;
  final String _userID;

  const EventDetails(this._name, this._location, this._description,
      this._startDate, this._endDate, this._maxPeople, this._userID);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late String userID;
  //late int _currentQuantity;
  @override
  void initState() {
    // _currentQuantity = widget._quantity;
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      userID = Provider.of<UserProvider>(context, listen: false).userId ?? "-1";
    });
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
                onPressed: () {
                  Map<String, dynamic> eventData = {
                    "name": widget._name,
                    "location": widget._location,
                    "description": widget._description,
                    "startDate": widget._startDate,
                    "endDate": widget._endDate,
                    "maxPeople": widget._maxPeople,
                    "userID": userID,
                  };

                  Map<String, String> headers = {
                    "Content-Type": "application/json",
                  };
                  http
                      .post(
                    Uri.http("localhost:3000", "/fady/participated"),
                    headers: headers,
                    body: json.encode(eventData),
                  )
                      .then((http.Response response) {
                    if (response.statusCode == 201) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text("Information"),
                            content: Text("Event Subscribed!"),
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text("Error"),
                            content: Text("An error occurred"),
                          );
                        },
                      );
                    }
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.follow_the_signs_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Participate", textScaleFactor: 2),
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

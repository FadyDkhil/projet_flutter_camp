import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../user_provider.dart';

import 'package:projet_camping_evenement/navigations/nav_bottom.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  String? _name;
  String? _location;
  String? _desc;
  String? _startDate;
  String? _endDate;
  String? _peopleMaxNb;

  late String userID;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Access context in initState by using a post-frame callback
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      userID = Provider.of<UserProvider>(context, listen: false).userId ?? "-1";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Event"),
      ),
      body: Form(
        key: _formKey,
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 2, 20, 20),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Name"),
              onSaved: (String? newValue) {
                _name = newValue;
              },
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Name mustn't be empty";
                } else {
                  return null;
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: TextFormField(
              // keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Location"),
              onSaved: (String? newValue) {
                _location = newValue;
              },
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "You must choose a location";
                } else {
                  return null;
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Description"),
              onSaved: (String? newValue) {
                _desc = newValue;
              },
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Description mustn't be empty";
                } else {
                  return null;
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: TextFormField(
              // keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Start Date"),
              onSaved: (String? newValue) {
                _startDate = newValue;
              },
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Date mustn't be empty";
                } else {
                  return null;
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: TextFormField(
              // keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "End Date"),
              onSaved: (String? newValue) {
                _endDate = newValue;
              },
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Date mustn't be empty";
                } else {
                  return null;
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: TextFormField(
              // keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Maximum Number of people"),
              onSaved: (String? newValue) {
                _peopleMaxNb = newValue;
              },
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Max people mustn't be empty";
                } else {
                  return null;
                }
              },
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              child: const Text("Add Event"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Map<String, dynamic> eventData = {
                    "name": _name,
                    "location": _location,
                    "description": _desc,
                    "startDate": _startDate,
                    "endDate": _endDate,
                    "maxPeople": _peopleMaxNb,
                    "userID": userID,
                  };

                  Map<String, String> headers = {
                    "Content-Type": "application/json",
                  };
                  http
                      .post(Uri.http("localhost:3000", "/fady/events"),
                          headers: headers, body: json.encode(eventData))
                      .then((http.Response response) {
                    if (response.statusCode == 201) {
                      Navigator.pushReplacementNamed(context, "/home");
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text("Information"),
                              content: Text("Event Added Successfully!"),
                            );
                          });
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text("Error"),
                              content: Text("An error occurred"),
                            );
                          });
                    }
                  });
                }
              },
            ),
            const SizedBox(
              width: 20,
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/home");
              },
              child: const Text("Cancel"),
            ),
          ])
        ]),
      ),
    );
  }
}

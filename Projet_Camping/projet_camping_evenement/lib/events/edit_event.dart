import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../user_provider.dart';
import 'package:provider/provider.dart';

class EditEvent extends StatefulWidget {
  final String id;
  const EditEvent({required this.id});

  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  String? _id;
  String? _name;
  String? _location;
  String? _desc;
  String? _startDate;
  String? _endDate;
  String? _peopleMaxNb;
  String? _userID;

  late String userID;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String idEvent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      userID = Provider.of<UserProvider>(context, listen: false).userId ?? "-1";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Event"),
      ),
      body: Form(
        key: _formKey,
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
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
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
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
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
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
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
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
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
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
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
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
              child: const Text("Edit Event"),
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
                    "Content-Type": "application/json"
                    // "Content-Type": "application/json; charset=UTF-8"
                  };

                  http
                      .patch(
                          Uri.http(
                              "localhost:3000", "/fady/events/${widget.id}"),
                          body: json.encode(eventData),
                          headers: headers)
                      .then((http.Response response) {
                    if (response.statusCode == 202) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text("Information"),
                              content: Text("Event Changed Succesfully!"),
                            );
                          });
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text("Information"),
                              content: Text("Event Changed Succesfully!"),
                            );
                          });
                    }
                  });

                  // String msg = "Username: ${_username}";
                }
              },
            ),
            const SizedBox(
              width: 20,
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                //Navigator.pushReplacementNamed(context, "/my_events");
              },
              child: const Text("Cancel"),
            ),
          ])
        ]),
      ),
    );
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import '../user_provider.dart';
import 'package:provider/provider.dart';

class AddCampingMaterial extends StatefulWidget {
  const AddCampingMaterial({Key? key});

  @override
  _AddCampingMaterialState createState() => _AddCampingMaterialState();
}

class _AddCampingMaterialState extends State<AddCampingMaterial> {
  String? _name;
  String? _desc;
  String? _price;
  String? _addDate;
  String? _userID;
  late String userID;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        title: const Text("Add Camping Material"),
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
                  border: OutlineInputBorder(), labelText: "price"),
              onSaved: (String? newValue) {
                _price = newValue;
              },
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "price mustn't be empty";
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
                  border: OutlineInputBorder(), labelText: "add Date"),
              onSaved: (String? newValue) {
                _addDate = newValue;
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
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              child: const Text("Add CampingMaterial"),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Map<String, dynamic> campingmaterialData = {
                    "name": _name,
                    "description": _desc,
                    "price": _price,
                    "addDate": _addDate,
                    "userID": userID
                  };

                  Map<String, String> headers = {
                    "Content-Type": "application/json"
                    // "Content-Type": "application/json; charset=UTF-8"
                  };
                  await http
                      .post(
                          Uri.http(
                              "localhost:3000", "/material/campingMaterial"),
                          headers: headers,
                          body: json.encode(campingmaterialData))
                      .then((http.Response response) {
                    if (response.statusCode == 201) {
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //         const CampingMaterial()));
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text("Information"),
                              content:
                                  Text("camping material Added Succesfully!"),
                            );
                          });
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text("Error"),
                              content: Text("An error occured"),
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
                Navigator.pop(context);
                //Navigator.pushReplacementNamed(context, "/shop");
              },
              child: const Text("Cancel"),
            ),
          ])
        ]),
      ),
    );
  }
}

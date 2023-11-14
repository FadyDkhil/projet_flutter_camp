import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../user_provider.dart';
import 'package:provider/provider.dart';

class EditMaterial extends StatefulWidget {
  final String id;
  const EditMaterial({required this.id});

  @override
  _EditMaterialState createState() => _EditMaterialState();
}

class _EditMaterialState extends State<EditMaterial> {
  String? _id;
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
        title: const Text("Edit Material"),
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
              maxLines: 3,
              // keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Description"),
              onSaved: (String? newValue) {
                _desc = newValue;
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
                  border: OutlineInputBorder(), labelText: "Price"),
              onSaved: (String? newValue) {
                _price = newValue;
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
                  border: OutlineInputBorder(), labelText: "Add Date"),
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
              child: const Text("Edit Material"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  Map<String, dynamic> materialData = {
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

                  http
                      .patch(
                          Uri.http("localhost:3000",
                              "material/campingMaterial/${widget.id}"),
                          body: json.encode(materialData),
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
                }
              },
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepOrange),
                ),
                child: const Text("Cancel"),
                onPressed: () {
                  _formKey.currentState!.reset();
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => const Login()));
                }),
          ])
        ]),
      ),
    );
  }
}

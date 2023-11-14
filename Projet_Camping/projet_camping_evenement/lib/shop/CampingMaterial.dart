import 'package:flutter/material.dart';
import 'package:projet_camping_evenement/shop/CampingMaterial_details.dart';
import 'package:projet_camping_evenement/shop/CampingMaterial_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CampingMaterial extends StatefulWidget {
  const CampingMaterial({Key? key}) : super(key: key);

  @override
  State<CampingMaterial> createState() => _CampingMaterialState();
}

class _CampingMaterialState extends State<CampingMaterial> {
  late Future<void> _fetchedMaterials;
  final List<CampingMaterialClass> _campingMaterials = [];
  final userID = "-1";

  Future<void> fetchMaterials() async {
    try {
      final response = await http
          .get(Uri.http("localhost:3000", "/material/campingMaterial"));

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is Map &&
            jsonResponse.containsKey("campingMaterials")) {
          final List<dynamic> campingMaterialsFromServer =
              jsonResponse["campingMaterials"];

          // Clear existing events before adding new ones.
          _campingMaterials.clear();
          campingMaterialsFromServer.forEach((element) {
            _campingMaterials.add(CampingMaterialClass(
              element["name"] ?? "",
              element["description"] ?? "",
              element["price"] ?? "",
              element["addDate"] ?? "",
              element["userID"] ?? "",
            ));
          });

          // campingMaterialsFromServer.forEach((element) {
          //   _campingMaterials.add(CampingMaterialClass(element["name"],
          //       element["location"], element["price"], element["addDate"]));
          // });
        } else {
          print("Invalid response format: Missing 'events' key or not a Map.");
        }
      } else {
        // Handle error cases here.
        print("Failed to load events. Status code: ${response.statusCode}");
      }
    } catch (error) {
      // Handle network or other errors.
      print("Error fetching events: $error");
    }
  }

  @override
  void initState() {
    _fetchedMaterials = fetchMaterials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Recreate _fetchedEvents when the widget is rebuilt
    _fetchedMaterials = fetchMaterials();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop"),
      ),
      body: FutureBuilder(
        future: _fetchedMaterials,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return GridView.builder(
              itemCount: _campingMaterials.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => CampingMaterialDetails(
                          _campingMaterials[index].name,
                          _campingMaterials[index].description,
                          _campingMaterials[index].price,
                          _campingMaterials[index].addDate,
                          _campingMaterials[index].userID),
                    ),
                  ),
                  child: CampingMaterialInfo(
                      _campingMaterials[index].name,
                      _campingMaterials[index].description,
                      _campingMaterials[index].price,
                      _campingMaterials[index].addDate,
                      _campingMaterials[index].userID),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 100,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/home");
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class CampingMaterialClass {
  String name;
  String description;
  String price;
  String addDate;
  String userID;

  CampingMaterialClass(
      this.name, this.description, this.price, this.addDate, this.userID);
}

// import 'package:flutter/material.dart';
// // import 'package:camping_materiel/CampingMaterial_info.dart';
// // import 'package:camping_materiel/add_CampingMaterial.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:projet_camping_evenement/shop/CampingMaterial_info.dart';

// class CampingMaterial extends StatefulWidget {
//   const CampingMaterial({Key? key}) : super(key: key);

//   @override
//   State<CampingMaterial> createState() => _CampingMaterialState();
// }

// class _CampingMaterialState extends State<CampingMaterial> {
//   final List<CampingMaterialClass> _CampingMaterial = [];
//   late Future<bool> _fetchedCampingMaterial;
//   Future<bool> fetchCampingMaterial() async {
//     http.Response response =
//         await http.get(Uri.http("localhost:3000", "/material/campingMaterial"));
//     if (response.statusCode == 200) {
//       final List<dynamic> campingMaterialFromServer =
//           json.decode(response.body);
//       campingMaterialFromServer.forEach((element) {
//         _CampingMaterial.add(CampingMaterialClass(element["name"],
//             element["description"], element["price"], element["addDate"]));
//       });
//     }
//     return true;
//   }

//   @override
//   void initState() {
//     _fetchedCampingMaterial = fetchCampingMaterial();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Shop"),
//       ),
//       body: GridView.builder(
//         itemCount: _CampingMaterial.length,
//         itemBuilder: (BuildContext context, int index) {
//           return CampingMaterialInfo(
//             _CampingMaterial[index].name,
//             _CampingMaterial[index].description,
//             _CampingMaterial[index].price,
//             _CampingMaterial[index].addDate,
//           );
//         },
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           mainAxisExtent: 100,
//           mainAxisSpacing: 5,
//           crossAxisSpacing: 5,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, "/shop/add");
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //       builder: (context) =>
//           //           AddCampingMaterial()), // Navigate to AddCampingMaterial page
//           //);
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class CampingMaterialClass {
//   String name;
//   String description;
//   String price;
//   String addDate;

//   CampingMaterialClass(this.name, this.description, this.price, this.addDate);
// }
// // _CampingMaterial.add(CampingMaterialClass(
// //   "materiel 1", "description", "100 dt", "11-08-2023", ));
// // _CampingMaterial.add(CampingMaterialClass(
// //     "materiel 2", "description", "120 dt", "11-01-2024"));
// // _CampingMaterial.add(CampingMaterialClass(
// //     "materiel 3", "description", "30 dt", "11-01-2024"));
// // _CampingMaterial.add(CampingMaterialClass(
// //     "materiel 4", "description", "20 dt", "11-01-2024"));
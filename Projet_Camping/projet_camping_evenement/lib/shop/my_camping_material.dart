import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projet_camping_evenement/events/ShowEvents/my_events_details.dart';
import 'package:projet_camping_evenement/events/ShowEvents/my_events_info.dart';
import 'package:projet_camping_evenement/shop/my_shop_details.dart';
import 'package:projet_camping_evenement/shop/my_shop_info.dart';
import '../../user_provider.dart';
import 'package:provider/provider.dart';

class MyShop extends StatefulWidget {
  const MyShop({super.key});

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  final List<CampingMaterialClass> _campingMaterial = [];
  late Future<void> _fetchedCampingMaterial;
  late String userID;

  Future<void> fetchCampingMaterial() async {
    try {
      final response = await http
          .get(Uri.http("localhost:3000", "/material/campingMaterial"));

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is Map &&
            jsonResponse.containsKey("campingMaterials")) {
          final List<dynamic> campingMaterialFromServer =
              jsonResponse["campingMaterials"];

          _campingMaterial.clear();

          campingMaterialFromServer.forEach((element) {
            _campingMaterial.add(CampingMaterialClass(
              element["_id"] ?? "",
              element["name"] ?? "",
              element["description"] ?? "",
              element["price"] ?? "",
              element["addDate"] ?? "",
              element["userID"] ?? "",
            ));
          });

          setState(() {
            print(_campingMaterial.length);
          });
        } else {
          print("Invalid response format: Missing 'events' key or not a Map.");
        }
      } else {
        print("Failed to load events. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching events: $error");
    }
  }

  Future<void> _refresh() async {
    await fetchCampingMaterial();
  }

  @override
  void initState() {
    _fetchedCampingMaterial = fetchCampingMaterial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userID = Provider.of<UserProvider>(context).userId ?? "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Shop"),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder(
          future: _fetchedCampingMaterial,
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
              final List<CampingMaterialClass> filteredShop = _campingMaterial
                  .where((campingMaterial) => campingMaterial.userID == userID)
                  .toList();
              return GridView.builder(
                itemCount: filteredShop.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyShopDetails(
                            filteredShop[index].id,
                            filteredShop[index].name,
                            filteredShop[index].description,
                            filteredShop[index].price,
                            filteredShop[index].addDate,
                            filteredShop[index].userID),
                      ),
                    ),
                    child: MyShopInfo(
                        filteredShop[index].id,
                        filteredShop[index].name,
                        filteredShop[index].description,
                        filteredShop[index].price,
                        filteredShop[index].addDate,
                        filteredShop[index].userID),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 150,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/my_shop");
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class CampingMaterialClass {
  String id;
  String name;
  String description;
  String price;
  String addDate;
  String userID;

  CampingMaterialClass(this.id, this.name, this.description, this.price,
      this.addDate, this.userID);
}

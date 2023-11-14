// // --------- DYNAMIC FUTUR
import 'package:flutter/material.dart';
import 'package:projet_camping_evenement/events/ShowEvents/event_details.dart';
import 'package:projet_camping_evenement/events/ShowEvents/events_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  late Future<void> _fetchedEvents;
  final List<EventsClass> _events = [];

  Future<void> fetchEvents() async {
    try {
      final response =
          await http.get(Uri.http("localhost:3000", "/fady/events"));

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is Map && jsonResponse.containsKey("events")) {
          final List<dynamic> eventsFromServer = jsonResponse["events"];

          // Clear existing events before adding new ones.
          _events.clear();

          eventsFromServer.forEach((element) {
            _events.add(EventsClass(
                element["name"],
                element["location"],
                element["description"],
                element["startDate"],
                element["endDate"],
                element["maxPeople"],
                element["userID"]));
          });
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
    _fetchedEvents = fetchEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Recreate _fetchedEvents when the widget is rebuilt
    _fetchedEvents = fetchEvents();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
      ),
      body: FutureBuilder(
        future: _fetchedEvents,
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
              itemCount: _events.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => EventDetails(
                          _events[index].name,
                          _events[index].location,
                          _events[index].description,
                          _events[index].startDate,
                          _events[index].endDate,
                          _events[index].maxPeople,
                          _events[index].userID),
                    ),
                  ),
                  child: EventsInfo(
                      _events[index].name,
                      _events[index].location,
                      _events[index].description,
                      _events[index].startDate,
                      _events[index].endDate,
                      _events[index].maxPeople,
                      _events[index].userID),
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

class EventsClass {
  String name;
  String location;
  String description;
  String startDate;
  String endDate;
  String maxPeople;
  String userID;

  EventsClass(this.name, this.location, this.description, this.startDate,
      this.endDate, this.maxPeople, this.userID);
}

// // ----------- STATIQUE

// import 'package:flutter/material.dart';
// import 'package:projet_camping_evenement/events/ShowEvents/event_details.dart';
// import 'package:projet_camping_evenement/events/ShowEvents/events_info.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// // ignore: camel_case_types
// class Events extends StatefulWidget {
//   const Events({super.key});

//   @override
//   State<Events> createState() => _EventsState();
// }

// class _EventsState extends State<Events> {
//   final List<EventsClass> _events = [];

//   @override
//   void initState() {
//     _events.add(EventsClass(
//         "Camp 1", "Ain Drahem", "desc", "11-01-2024", "endDate", "8"));
//     _events.add(EventsClass(
//         "Camp 2", "Ain Drahem", "desc", "11-01-2024", "endDate", "8"));
//     _events.add(EventsClass(
//         "Camp 3", "Ain Drahem", "desc", "11-01-2024", "endDate", "8"));
//     _events.add(EventsClass(
//         "Camp 4", "Ain Drahem", "desc", "11-01-2024", "endDate", "8"));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Events"),
//         ),
//         body: GridView.builder(
//           itemCount: _events.length,
//           itemBuilder: (BuildContext context, int index) {
//             return GestureDetector(
//                 onTap: () => {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (BuildContext context) => EventDetails(
//                                 _events[index].name,
//                                 _events[index].location,
//                                 _events[index].description,
//                                 _events[index].startDate,
//                                 _events[index].endDate,
//                                 _events[index].maxPeople)),
//                       )
//                     },
//                 child: EventsInfo(
//                     _events[index].name,
//                     _events[index].location,
//                     _events[index].description,
//                     _events[index].startDate,
//                     _events[index].endDate,
//                     _events[index].maxPeople));
//           },
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               mainAxisExtent: 150,
//               mainAxisSpacing: 5,
//               crossAxisSpacing: 5),
//         ));
//   }
// }

// class EventsClass {
//   String name;
//   String location;
//   String description;
//   String startDate;
//   String endDate;
//   String maxPeople;

//   EventsClass(this.name, this.location, this.description, this.startDate,
//       this.endDate, this.maxPeople);
// }

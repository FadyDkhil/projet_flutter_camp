import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet_camping_evenement/events/ShowEvents/participated_details.dart';
import 'package:projet_camping_evenement/events/ShowEvents/participated_info.dart';
import 'dart:convert';
import '../../user_provider.dart';
import 'package:provider/provider.dart';
import 'package:projet_camping_evenement/events/ShowEvents/my_events_details.dart';
import 'package:projet_camping_evenement/events/ShowEvents/my_events_info.dart';

class ParticipatedEvents extends StatefulWidget {
  const ParticipatedEvents({super.key});

  @override
  State<ParticipatedEvents> createState() => _ParticipatedEventsState();
}

class _ParticipatedEventsState extends State<ParticipatedEvents> {
  final List<MyEventsClass> _events = [];
  late Future<void> _fetchedEvents;

  late String userID; // Declare userID as a late variable

  Future<void> fetchEvents() async {
    try {
      final response =
          await http.get(Uri.http("localhost:3000", "/fady/participated"));

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is Map && jsonResponse.containsKey("events")) {
          final List<dynamic> eventsFromServer = jsonResponse["events"];

          _events.clear();

          eventsFromServer.forEach((element) {
            _events.add(MyEventsClass(
                element["_id"],
                element["name"],
                element["location"],
                element["description"],
                element["startDate"],
                element["endDate"],
                element["maxPeople"],
                element["userID"]));
          });

          setState(() {
            print(_events.length);
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
    await fetchEvents();
  }

  @override
  void initState() {
    _fetchedEvents = fetchEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Access context here in the build method
    userID = Provider.of<UserProvider>(context).userId ?? "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Participated"),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder(
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
              final List<MyEventsClass> filteredEvents =
                  _events.where((event) => event.userID == userID).toList();

              return GridView.builder(
                itemCount: filteredEvents.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ParticipatedEventsDetails(
                                filteredEvents[index].id,
                                filteredEvents[index].name,
                                filteredEvents[index].location,
                                filteredEvents[index].description,
                                filteredEvents[index].startDate,
                                filteredEvents[index].endDate,
                                filteredEvents[index].maxPeople,
                                filteredEvents[index].userID),
                      ),
                    ),
                    child: ParticipatedInfo(
                        filteredEvents[index].id,
                        filteredEvents[index].name,
                        filteredEvents[index].location,
                        filteredEvents[index].description,
                        filteredEvents[index].startDate,
                        filteredEvents[index].endDate,
                        filteredEvents[index].maxPeople,
                        filteredEvents[index].userID),
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
          Navigator.pushReplacementNamed(context, "/my_events");
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class MyEventsClass {
  String id;
  String name;
  String location;
  String description;
  String startDate;
  String endDate;
  String maxPeople;
  String userID;

  MyEventsClass(this.id, this.name, this.location, this.description,
      this.startDate, this.endDate, this.maxPeople, this.userID);
}

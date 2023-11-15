import 'package:flutter/material.dart';
import 'package:projet_camping_evenement/events/edit_event.dart';
import 'package:http/http.dart' as http;

class ParticipatedInfo extends StatefulWidget {
  final String id;
  final String name;
  final String location;
  final String description;
  final String startDate;
  final String endDate;
  final String maxPeople;
  final String userID;

  const ParticipatedInfo(
    this.id,
    this.name,
    this.location,
    this.description,
    this.startDate,
    this.endDate,
    this.maxPeople,
    this.userID,
  );

  @override
  _ParticipatedInfoState createState() => _ParticipatedInfoState();
}

class _ParticipatedInfoState extends State<ParticipatedInfo> {
  Future<void> deleteEvent() async {
    try {
      final response = await http.delete(
          Uri.http("localhost:3000", "/fady/participated/${widget.id}"));

      if (response.statusCode == 203) {
        // The event was successfully deleted
        Navigator.pushReplacementNamed(context, "/home");
        //Navigator.pop(context); // You can navigate back or do any other action
      } else {
        // Handle error
        print('Failed to delete event: ${response.body}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        child: Column(
          children: [
            Text(widget.name),
            Text(widget.location),
            const SizedBox(
              height: 5,
            ),
            Text('${widget.maxPeople}'),
            Text(widget.startDate),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: deleteEvent,
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class EventsInfo extends StatelessWidget {
  final String name;
  final String location;
  final String description;
  final String startDate;
  final String endDate;
  final String maxPeople;
  final String userID;

  const EventsInfo(this.name, this.location, this.description, this.startDate,
      this.endDate, this.maxPeople, this.userID);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        child: Column(
          children: [
            Text(name),
            Text(location),
            const SizedBox(
              height: 5,
            ),
            Text('0/$maxPeople'),
            Text(startDate),
          ],
        ),
      ),
    );
  }
}

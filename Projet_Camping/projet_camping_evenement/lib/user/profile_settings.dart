import 'package:flutter/material.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile Settings"),
        ),
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(170, 0, 0, 0),
                child: SizedBox(
                  height: 100,
                  width: 250,
                  child: Row(children: [
                    OutlinedButton(
                        onPressed: () {},
                        child: const Text("Change Information"))
                  ]),
                )),
          ],
        ));
  }
}

import 'package:flutter/material.dart';

import 'main.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            const Flexible(flex: 4, child: Text("Welcome to ProfileView")),
            Flexible(
              flex: 4,
              child: ElevatedButton(
                child: const Text("PoseActivity"),
                onPressed: () async {
                  await channel.invokeMethod("intentTo", "poseActivity");
                },
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

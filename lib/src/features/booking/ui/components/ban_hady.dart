import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BanHady extends StatelessWidget {
  const BanHady({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: .center,
          children: [
            SizedBox(height: 300),
            Text("Are you Hady? hehe, you are banned."),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _launchUrl();
              },
              child: Text("Beg for forgiveness"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(
    Uri.parse("https://api.whatsapp.com/send?phone=201288013559"),
  )) {
    throw Exception('Could not launch');
  }
}

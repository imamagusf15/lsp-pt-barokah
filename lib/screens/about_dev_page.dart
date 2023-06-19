import 'package:flutter/material.dart';

class AboutDevPage extends StatelessWidget {
  const AboutDevPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Dev"),
      ),
      body: Column(
        children: const [
          ListTile(
            title: Text("Developer"),
            subtitle: Text("Imam Agus Faisal"),
          )
        ],
      ),
    );
  }
}

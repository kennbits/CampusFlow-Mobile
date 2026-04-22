import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('About App')),
      body: ListView(
        padding:
            const EdgeInsets.all(20),
        children: const [
          SizedBox(height: 20),

          CircleAvatar(
            radius: 48,
            backgroundColor:
                Colors.redAccent,
            child: Icon(
              Icons.school,
              color: Colors.white,
              size: 46,
            ),
          ),

          SizedBox(height: 18),

          Center(
            child: Text(
              'CampusFlow',
              style: TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 8),

          Center(
            child: Text(
              'Version 1.0.0',
            ),
          ),

          SizedBox(height: 28),

          Text(
            'CampusFlow is a campus utility management app for submitting and monitoring water, electricity, and waste reports.',
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 30),

          ListTile(
            leading: Icon(Icons.people),
            title: Text('Developed By'),
            subtitle:
                Text('CampusFlow Team'),
          ),

          ListTile(
            leading: Icon(Icons.email),
            title: Text('Contact'),
            subtitle:
                Text('support@campusflow.com'),
          ),
        ],
      ),
    );
  }
}
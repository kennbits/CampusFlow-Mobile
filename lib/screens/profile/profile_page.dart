import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            const CircleAvatar(
              radius: 45,
              backgroundColor:
                  Colors.redAccent,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 50,
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              'ADMIN',
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'CampusFlow User',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 28),

            ListTile(
              leading:
                  const Icon(Icons.lock),
              title: const Text(
                  'Change Password'),
              trailing: const Icon(
                  Icons.chevron_right),
              onTap: () {},
            ),

            ListTile(
              leading:
                  const Icon(Icons.info),
              title:
                  const Text('About App'),
              trailing: const Icon(
                  Icons.chevron_right),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
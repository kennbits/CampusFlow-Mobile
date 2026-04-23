import 'package:flutter/material.dart';
import '../auth/login_screen.dart';
import '../../services/auth_service.dart';
import '../../services/api_service.dart';
import 'change_password_page.dart';
import 'about_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() =>
      _ProfilePageState();
}

class _ProfilePageState
    extends State<ProfilePage> {
  String username = 'USER';
  String email = '';
  String role = 'CampusFlow User';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      final data =
          await ApiService.getProfile();

      if (!mounted) return;

      setState(() {
        username =
            (data['name'] ?? 'USER')
                .toString()
                .toUpperCase();

        email =
            data['email'] ?? '';

        role = data['role'] ??
            'CampusFlow User';

        isLoading = false;
      });
    } catch (e) {
      await loadLocalUser();
    }
  }

  Future<void> loadLocalUser() async {
    final authService = AuthService();
    final savedUser =
        await authService.getUsername();

    if (!mounted) return;

    setState(() {
      username =
          savedUser.isEmpty
              ? 'USER'
              : savedUser.toUpperCase();

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Profile')),
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : ListView(
              padding:
                  const EdgeInsets.all(20),
              children: [
                const SizedBox(height: 10),

                const CircleAvatar(
                  radius: 46,
                  backgroundColor:
                      Colors.redAccent,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 48,
                  ),
                ),

                const SizedBox(height: 14),

                Center(
                  child: Text(
                    username,
                    style:
                        const TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                Center(
                  child: Text(
                    role,
                    style: TextStyle(
                      color: Colors
                          .grey
                          .shade600,
                    ),
                  ),
                ),

                if (email.isNotEmpty) ...[
                  const SizedBox(
                      height: 4),
                  Center(
                    child: Text(
                      email,
                      style: TextStyle(
                        color: Colors
                            .grey
                            .shade600,
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 28),

                Card(
                  child: ListTile(
                    leading:
                        const Icon(
                            Icons.info),
                    title: const Text(
                        'About App'),
                    trailing:
                        const Icon(Icons
                            .chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const AboutPage(),
                        ),
                      );
                    },
                  ),
                ),

                Card(
                  child: ListTile(
                    leading:
                        const Icon(
                            Icons.lock),
                    title: const Text(
                        'Change Password'),
                    trailing:
                        const Icon(Icons
                            .chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const ChangePasswordPage(),
                        ),
                      );
                    },
                  ),
                ),

                Card(
                  child: ListTile(
                    leading:
                        const Icon(
                            Icons.logout),
                    title: const Text(
                        'Logout'),
                    trailing:
                        const Icon(Icons
                            .chevron_right),
                    onTap: () async {
                      await AuthService()
                          .logout();

                      if (!context
                          .mounted) {
                        return;
                      }

                      Navigator
                          .pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const LoginScreen(),
                        ),
                        (route) =>
                            false,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
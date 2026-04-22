import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() =>
      _ChangePasswordPageState();
}

class _ChangePasswordPageState
    extends State<ChangePasswordPage> {
  final _currentController =
      TextEditingController();

  final _newController =
      TextEditingController();

  final _confirmController =
      TextEditingController();

  bool loading = false;

  Future<void> savePassword() async {
    final current =
        _currentController.text.trim();

    final newPass =
        _newController.text.trim();

    final confirm =
        _confirmController.text.trim();

    if (current.isEmpty ||
        newPass.isEmpty ||
        confirm.isEmpty) {
      showMsg('Fill all fields');
      return;
    }

    if (newPass != confirm) {
      showMsg('Passwords do not match');
      return;
    }

    setState(() {
      loading = true;
    });

    await Future.delayed(
      const Duration(seconds: 1),
    );

    setState(() {
      loading = false;
    });

    showMsg('Password updated');

    if (!mounted) return;

    Navigator.pop(context);
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Change Password'),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller:
                  _currentController,
              obscureText: true,
              decoration:
                  const InputDecoration(
                labelText:
                    'Current Password',
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _newController,
              obscureText: true,
              decoration:
                  const InputDecoration(
                labelText:
                    'New Password',
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller:
                  _confirmController,
              obscureText: true,
              decoration:
                  const InputDecoration(
                labelText:
                    'Confirm Password',
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: loading
                    ? null
                    : savePassword,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Save',
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
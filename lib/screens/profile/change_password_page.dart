import 'package:flutter/material.dart';
import '../../services/api_service.dart';

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

  bool show1 = false;
  bool show2 = false;
  bool show3 = false;

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

    try {
      final result =
          await ApiService.changePassword(
        currentPassword: current,
        newPassword: newPass,
        confirmPassword: confirm,
      );

      if (!mounted) return;

      showMsg(
        result['message'] ??
            'Password updated',
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      showMsg('Failed to update');
    } finally {
      if (!mounted) return;

      setState(() {
        loading = false;
      });
    }
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  InputDecoration fieldStyle(
    String label,
    bool visible,
    VoidCallback toggle,
  ) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
      suffixIcon: IconButton(
        onPressed: toggle,
        icon: Icon(
          visible
              ? Icons.visibility
              : Icons.visibility_off,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Change Password'),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),
        child: Container(
          padding:
              const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: dark
                ? Colors.grey.shade900
                : Colors.white,
            borderRadius:
                BorderRadius.circular(
              18,
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 8,
                color: Colors.black12,
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(
                Icons.lock_reset,
                size: 55,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller:
                    _currentController,
                obscureText: !show1,
                decoration:
                    fieldStyle(
                  'Current Password',
                  show1,
                  () {
                    setState(() {
                      show1 = !show1;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller:
                    _newController,
                obscureText: !show2,
                decoration:
                    fieldStyle(
                  'New Password',
                  show2,
                  () {
                    setState(() {
                      show2 = !show2;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller:
                    _confirmController,
                obscureText: !show3,
                decoration:
                    fieldStyle(
                  'Confirm Password',
                  show3,
                  () {
                    setState(() {
                      show3 = !show3;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              SizedBox(
                width:
                    double.infinity,
                height: 52,
                child:
                    ElevatedButton(
                  onPressed:
                      loading
                          ? null
                          : savePassword,
                  style:
                      ElevatedButton
                          .styleFrom(
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),
                  ),
                  child: loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child:
                              CircularProgressIndicator(
                            strokeWidth:
                                2,
                          ),
                        )
                      : const Text(
                          'Update Password',
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
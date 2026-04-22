import 'package:flutter/material.dart';
import '../../submit/submit_page.dart';
import '../auth/login_screen.dart';
import '../../services/auth_service.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> with TickerProviderStateMixin {
  late AnimationController _sidebarController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _sidebarController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _sidebarController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _sidebarController.dispose();
    super.dispose();
  }

  void _toggleSidebar() {
    if (_sidebarController.isCompleted) {
      _sidebarController.reverse();
    } else {
      _sidebarController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _HomeMenuContent(
      sidebarController: _sidebarController,
      slideAnimation: _slideAnimation,
      onProfileTap: _toggleSidebar,
    );
  }
}

class _HomeMenuContent extends StatelessWidget {
  final AnimationController sidebarController;
  final Animation<Offset> slideAnimation;
  final VoidCallback onProfileTap;

  const _HomeMenuContent({
    required this.sidebarController,
    required this.slideAnimation,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour12 = now.hour == 0 ? 12 : (now.hour > 12 ? now.hour - 12 : now.hour);
    final ampm = now.hour >= 12 ? 'P.M.' : 'A.M.';
    final formattedDate =
        '${_monthName(now.month)} ${now.day}, ${now.year} ${hour12}:${_twoDigits(now.minute)} $ampm';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // faded background with bsu.jpg
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/bsu.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.65),
                    BlendMode.modulate,
                  ),
                ),
              ),
              child: const SizedBox.shrink(),
            ),
          ),
          // main content
          SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: onProfileTap,
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.grey.shade300,
                          child: Icon(Icons.person, color: Colors.grey.shade700, size: 30),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.notifications, size: 32, color: Colors.redAccent),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(child: const SizedBox.shrink()),
                      Positioned(
                        left: 24,
                        right: 24,
                        bottom: 36,
                        child: Center(
                          child: SizedBox(
                            height: 110,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SubmitPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                elevation: 12,
                                shadowColor: Colors.black45,
                                padding: const EdgeInsets.symmetric(horizontal: 28),
                              ),
                              child: const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 56,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Scrim/overlay
          AnimatedBuilder(
            animation: sidebarController,
            builder: (context, child) {
              return IgnorePointer(
                ignoring: sidebarController.value < 0.5,
                child: GestureDetector(
                  onTap: () {
                    if (sidebarController.isCompleted) {
                      sidebarController.reverse();
                    }
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.3 * sidebarController.value),
                  ),
                ),
              );
            },
          ),
          // Sidebar
          SlideTransition(
            position: slideAnimation,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // User Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            child: Icon(Icons.person, color: Colors.white, size: 36),
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            'USER',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.white30,
                      thickness: 1.5,
                    ),
                    // Menu Items
                    Expanded(
                      child: Column(
                        children: [
                          _SidebarMenuItem(
                            icon: Icons.person,
                            label: 'Account Settings',
                            onTap: () {
                              sidebarController.reverse();
                            },
                          ),
                          const SizedBox(height: 12),
                          _SidebarMenuItemWithToggle(
                            icon: Icons.palette,
                            label: 'Theme',
                            onTap: () {},
                          ),
                          const SizedBox(height: 12),
                          _SidebarMenuItem(
                            icon: Icons.logout,
                            label: 'Log Out',
                            onTap: () async {
                              sidebarController.reverse();

                              final authService = AuthService();
                              await authService.logout();

                              if (!context.mounted) return;

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _monthName(int m) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[m - 1];
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');
}

class _SidebarMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SidebarMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarMenuItemWithToggle extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SidebarMenuItemWithToggle({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_SidebarMenuItemWithToggle> createState() =>
      _SidebarMenuItemWithToggleState();
}

class _SidebarMenuItemWithToggleState extends State<_SidebarMenuItemWithToggle> {
  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(widget.icon, color: Colors.white, size: 24),
              const SizedBox(width: 16),
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Transform.scale(
            scale: 0.85,
            child: Switch(
              value: _isEnabled,
              onChanged: (value) {
                setState(() {
                  _isEnabled = value;
                });
                widget.onTap();
              },
              activeThumbColor: Colors.white,
              activeTrackColor: Colors.white24,
            ),
          ),
        ],
      ),
    );
  }
}
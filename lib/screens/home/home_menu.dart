import 'package:flutter/material.dart';
import '../../submit/submit_page.dart';
import '../auth/login_screen.dart';
import '../../services/auth_service.dart';
import '../../main.dart';

import '../status/status_page.dart';
import '../history/history_page.dart';
import '../alerts/alerts_page.dart';
import '../profile/profile_page.dart';
import '../../services/api_service.dart';

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

class _HomeMenuContent extends StatefulWidget {
  final AnimationController sidebarController;
  final Animation<Offset> slideAnimation;
  final VoidCallback onProfileTap;

  const _HomeMenuContent({
    super.key,
    required this.sidebarController,
    required this.slideAnimation,
    required this.onProfileTap,
  });

  @override
  State<_HomeMenuContent> createState() => _HomeMenuContentState();
}

class _HomeMenuContentState extends State<_HomeMenuContent> {
  String username = 'USER';

  int statusCount = 0;
  int alertCount = 0;

  @override
  void initState() {
    super.initState();
    loadUser();
    loadDashboardData();
  }

  Future<void> loadUser() async {
    final authService = AuthService();
    final savedUser = await authService.getUsername();

    if (!mounted) return;

    setState(() {
      username =
          savedUser.isEmpty ? 'USER' : savedUser.toUpperCase();
    });
  }

  Future<void> loadDashboardData() async {
    try {
      final statusData = await ApiService.getStatus();
      final alertData = await ApiService.getAlerts();

      if (!mounted) return;

      setState(() {
        statusCount = statusData.length;
        alertCount = alertData.length;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/images/bsu.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      isDark ? Colors.black.withOpacity(0.55) : Colors.white.withOpacity(0.65),
                      BlendMode.modulate,
                    ),
                  ),
                ),
              ),
            ),

            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(14),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: cardColor.withOpacity(0.92),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: widget.onProfileTap,
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.redAccent,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.notifications,
                              color: Colors.redAccent,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AlertsPage(),
                                ),
                              );
                            },
                          ),

                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Center(
                                child: Text(
                                  '$alertCount',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.45,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _DashboardCard(
                        title: 'Status ($statusCount)',
                        icon: Icons.pending_actions,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const StatusPage(),
                            ),
                          );
                        },
                      ),

                      _DashboardCard(
                        title: 'History',
                        icon: Icons.history,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HistoryPage(),
                            ),
                          );
                        },
                      ),

                      _DashboardCard(
                        title: 'Alerts',
                        icon: Icons.notifications_active,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AlertsPage(),
                            ),
                          );
                        },
                      ),

                      _DashboardCard(
                        title: 'Profile',
                        icon: Icons.person,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProfilePage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 90,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SubmitPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),

            AnimatedBuilder(
              animation: widget.sidebarController,
              builder: (context, child) {
                return IgnorePointer(
                  ignoring: widget.sidebarController.value < 0.5,
                  child: GestureDetector(
                    onTap: () {
                      widget.sidebarController.reverse();
                    },
                    child: Container(
                      color: Colors.black.withOpacity(
                        0.35 * widget.sidebarController.value,
                      ),
                    ),
                  ),
                );
              },
            ),

            SlideTransition(
              position: widget.slideAnimation,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.76,
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.white24,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                username,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Divider(
                        color: Colors.white30,
                      ),

                      _SidebarMenuItemWithToggle(
                        icon: Icons.dark_mode,
                        label: 'Dark Mode',
                        onTap: () {},
                      ),

                      _SidebarMenuItem(
                        icon: Icons.logout,
                        label: 'Log Out',
                        onTap: () async {
                          await AuthService().logout();

                          if (!context.mounted) {
                            return;
                          }

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
              ),
            ),
          ],
        ),
      ),
    );
  }
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
                CampusFlowApp.of(context).changeTheme(value);
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

class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor =
        Theme.of(context).cardColor;

    return InkWell(
      borderRadius:
          BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor.withOpacity(0.92),
          borderRadius:
              BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black12,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 34,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
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
import '../../services/offline_queue_service.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu>
    with TickerProviderStateMixin {
  late AnimationController _sidebarController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _sidebarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _sidebarController,
        curve: Curves.easeInOut,
      ),
    );
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
    return _HomeContent(
      controller: _sidebarController,
      animation: _slideAnimation,
      onMenuTap: _toggleSidebar,
    );
  }
}

class _HomeContent extends StatefulWidget {
  final AnimationController controller;
  final Animation<Offset> animation;
  final VoidCallback onMenuTap;

  const _HomeContent({
    required this.controller,
    required this.animation,
    required this.onMenuTap,
  });

  @override
  State<_HomeContent> createState() =>
      _HomeContentState();
}

class _HomeContentState
    extends State<_HomeContent> {
  String username = 'USER';

  int statusCount = 0;
  int alertCount = 0;

  @override
  void initState() {

    super.initState();

    loadUser();

    loadData();

    syncOfflineReadings();
  }

  Future<void> loadUser() async {
    final user =
        await AuthService().getUsername();

    if (!mounted) return;

    setState(() {
      username = user.isEmpty
          ? 'USER'
          : user.toUpperCase();
    });
  }

  Future<void> loadData() async {
    try {
      final status =
          await ApiService.getStatus();

      final alerts =
          await ApiService.getAlerts();

      if (!mounted) return;

      setState(() {
        statusCount = status.length;
        alertCount = alerts.length;
      });
    } catch (_) {}
  }

  Future<void> syncOfflineReadings()
  async {

    await OfflineQueueService()
        .syncPendingReadings();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF5F6FA),
                    Colors.white,
                  ],
                ),
              ),
            ),

            Column(
              children: [
                // Header
                Container(
                  margin: const EdgeInsets.all(18),
                  padding:
                      const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius:
                        BorderRadius.circular(
                            24),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap:
                            widget.onMenuTap,
                        child:
                            const CircleAvatar(
                          radius: 24,
                          backgroundColor:
                              Color(
                            0xFFED1B2F,
                          ),
                          child: Icon(
                            Icons.menu,
                            color:
                                Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(
                          width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            const Text(
                              'Welcome',
                              style:
                                  TextStyle(
                                fontSize:
                                    13,
                                color: Colors
                                    .black54,
                              ),
                            ),
                            Text(
                              username,
                              style:
                                  const TextStyle(
                                fontSize:
                                    18,
                                fontWeight:
                                    FontWeight
                                        .w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Stack(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const AlertsPage(),
                                ),
                              );
                            },
                            icon:
                                const Icon(
                              Icons
                                  .notifications_none,
                              color: Color(
                                0xFFED1B2F,
                              ),
                              size: 30,
                            ),
                          ),

                          Positioned(
                            right: 8,
                            top: 8,
                            child:
                                Container(
                              width: 18,
                              height: 18,
                              decoration:
                                  const BoxDecoration(
                                color: Colors
                                    .red,
                                shape: BoxShape
                                    .circle,
                              ),
                              child: Center(
                                child: Text(
                                  '$alertCount',
                                  style:
                                      const TextStyle(
                                    fontSize:
                                        10,
                                    color: Colors
                                        .white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                // Grid
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 18,
                    ),
                    child:
                        GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing:
                          14,
                      mainAxisSpacing:
                          14,
                      childAspectRatio:
                          1.12,
                      children: [
                        _MenuCard(
                          title:
                              'Status ($statusCount)',
                          icon: Icons
                              .pending_actions,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const StatusPage(),
                              ),
                            );
                          },
                        ),
                        _MenuCard(
                          title:
                              'History',
                          icon:
                              Icons.history,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const HistoryPage(),
                              ),
                            );
                          },
                        ),
                        _MenuCard(
                          title:
                              'Alerts',
                          icon: Icons
                              .notifications_active,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const AlertsPage(),
                              ),
                            );
                          },
                        ),
                        _MenuCard(
                          title:
                              'Profile',
                          icon:
                              Icons.person,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const ProfilePage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Submit button
                Padding(
                  padding:
                      const EdgeInsets
                          .fromLTRB(
                    20,
                    0,
                    20,
                    24,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 58,
                    child:
                        ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const SubmitPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'SUBMIT REPORT',
                        style:
                            TextStyle(
                          fontSize:
                              16,
                          fontWeight:
                              FontWeight
                                  .w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Overlay
            AnimatedBuilder(
              animation:
                  widget.controller,
              builder:
                  (context, child) {
                return IgnorePointer(
                  ignoring: widget
                          .controller
                          .value ==
                      0,
                  child:
                      GestureDetector(
                    onTap: () {
                      widget
                          .controller
                          .reverse();
                    },
                    child: Container(
                      color: Colors
                          .black26
                          .withOpacity(
                        widget
                                .controller
                                .value *
                            0.4,
                      ),
                    ),
                  ),
                );
              },
            ),

            // Sidebar
            SlideTransition(
              position:
                  widget.animation,
              child: Container(
                width:
                    MediaQuery.of(
                              context)
                          .size
                          .width *
                      0.76,
                decoration:
                    const BoxDecoration(
                  color: Color(
                    0xFFED1B2F,
                  ),
                  borderRadius:
                      BorderRadius.only(
                    topRight:
                        Radius.circular(
                            24),
                    bottomRight:
                        Radius.circular(
                            24),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(
                          height: 22),

                      const CircleAvatar(
                        radius: 34,
                        backgroundColor:
                            Colors.white24,
                        child: Icon(
                          Icons.person,
                          color: Colors
                              .white,
                          size: 34,
                        ),
                      ),

                      const SizedBox(
                          height: 12),

                      Text(
                        username,
                        style:
                            const TextStyle(
                          color: Colors
                              .white,
                          fontSize: 20,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),

                      const SizedBox(
                          height: 24),

                      _SideItem(
                        icon: Icons
                            .dark_mode,
                        label:
                            'Dark Mode',
                        trailing:
                            Switch(
                          value: Theme.of(
                                      context)
                                  .brightness ==
                              Brightness
                                  .dark,
                          onChanged:
                              (value) {
                            CampusFlowApp.of(
                                    context)
                                .changeTheme(
                                    value);
                          },
                        ),
                      ),

                      _SideItem(
                        icon:
                            Icons.logout,
                        label:
                            'Logout',
                        onTap:
                            () async {
                          await AuthService()
                              .logout();

                          if (!context
                              .mounted) {
                            return;
                          }

                          Navigator.pushAndRemoveUntil(
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

class _MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius:
          BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(
                  22),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              padding:
                  const EdgeInsets
                      .all(14),
              decoration:
                  const BoxDecoration(
                color: Color(
                  0x11ED1B2F,
                ),
                shape:
                    BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 34,
                color: const Color(
                  0xFFED1B2F,
                ),
              ),
            ),
            const SizedBox(
                height: 12),
            Text(
              title,
              textAlign:
                  TextAlign.center,
              style:
                  const TextStyle(
                fontSize: 15,
                fontWeight:
                    FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SideItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SideItem({
    required this.icon,
    required this.label,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.w600,
        ),
      ),
      trailing: trailing,
    );
  }
}
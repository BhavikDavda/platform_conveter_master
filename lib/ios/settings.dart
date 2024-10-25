import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:platform_converter/provider/home_provider.dart'; // Assuming HomeProvider manages theme state

class iosSettingsPage extends StatefulWidget {
  const iosSettingsPage({super.key});

  @override
  State<iosSettingsPage> createState() => _iosSettingsPageState();
}

class _iosSettingsPageState extends State<iosSettingsPage> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Settings"),
        backgroundColor: CupertinoColors.systemTeal,
      ),
      child: SafeArea(
        child: CupertinoScrollbar(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                "Preferences",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildDarkModeSwitch(),
            
              _buildNotificationSwitch(),
              
              _buildListTile(
                title: "Account Settings",
                subtitle: "Manage your account",
                icon: CupertinoIcons.person,
                onTap: () {
                  Navigator.pushNamed(context, "AccountSettings");
                },
              ),
              
              _buildListTile(
                title: "Privacy Policy",
                icon: CupertinoIcons.lock,
                onTap: () {
                  Navigator.pushNamed(context, "PrivacyPolicy");
                },
              ),
              const Divider(),
              _buildListTile(
                title: "About Us",
                icon: CupertinoIcons.info,
                onTap: () {
                  Navigator.pushNamed(context, "AboutUs");
                },
              ),
            
              _buildListTile(
                title: "Logout",
                icon: CupertinoIcons.square_arrow_right,
                onTap: () {
                  _showLogoutConfirmation(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDarkModeSwitch() {
    return CupertinoListTile(
      title: const Text("Dark Mode"),
      subtitle: const Text("Enable dark theme"),
      trailing: CupertinoSwitch(
        value: isDarkMode,
        onChanged: (bool value) {
          setState(() {
            isDarkMode = value;
          });
          Provider.of<HomeProvider>(context, listen: false);
        },
      ),
      leading: const Icon(CupertinoIcons.moon),
    );
  }

  Widget _buildNotificationSwitch() {
    return CupertinoListTile(
      title: const Text("Enable Notifications"),
      subtitle: const Text("Receive app notifications"),
      trailing: CupertinoSwitch(
        value: notificationsEnabled,
        onChanged: (bool value) {
          setState(() {
            notificationsEnabled = value;
          });
        },
      ),
      leading: const Icon(CupertinoIcons.bell),
    );
  }

  Widget _buildListTile({required String title, String? subtitle, required IconData icon, required VoidCallback onTap}) {
    return CupertinoListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(CupertinoIcons.right_chevron),
      leading: Icon(icon),
      onTap: onTap,
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Logged out successfully")),
                );
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}

class CupertinoListTile extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget trailing;
  final Widget leading;
  final VoidCallback? onTap;

  const CupertinoListTile({
    Key? key,
    required this.title,
    this.subtitle,
    required this.trailing,
    required this.leading,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Row(
        children: [
          leading,
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                if (subtitle != null) subtitle!,
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}

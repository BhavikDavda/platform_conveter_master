import 'package:flutter/material.dart';
import 'package:platform_converter/provider/home_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade400,
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
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
          SwitchListTile(
            title: const Text("Dark Mode"),
            subtitle: const Text("Enable dark theme"),
            value: isDarkMode,
            onChanged: (bool value) {
              setState(() {
                isDarkMode = value;
              });
              Provider.of<HomeProvider>(context, listen: false);
            },
            secondary: const Icon(Icons.dark_mode),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text("Enable Notifications"),
            subtitle: const Text("Receive app notifications"),
            value: notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
            secondary: const Icon(Icons.notifications_active),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Account Settings"),
            subtitle: const Text("Manage your account"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to account settings page
              Navigator.pushNamed(context, "AccountSettings");
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Privacy Policy"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to privacy policy page
              Navigator.pushNamed(context, "PrivacyPolicy");
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About Us"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to about us page
              Navigator.pushNamed(context, "AboutUs");
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Logout"),
            onTap: () {
              // Implement logout functionality
              _showLogoutConfirmation(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Log the user out
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

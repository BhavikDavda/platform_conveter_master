import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/model/contact..dart';
import 'package:platform_converter/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    Contact contact = ModalRoute.of(context)!.settings.arguments as Contact;
    final isAndroid = Provider.of<HomeProvider>(context).isAndroid;

    // Choose Android or iOS UI based on the platform
    return isAndroid ? _buildAndroidUI(context, contact) : _buildCupertinoUI(context, contact);
  }

  // Android UI with Material Design
  Widget _buildAndroidUI(BuildContext context, Contact contact) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Details"),
        backgroundColor:Colors.teal.shade400,
        elevation: 4,
        shadowColor: Colors.pinkAccent.withOpacity(0.4),
      ),
      body: _buildAndroidContent(context, contact),
    );
  }

  Widget _buildAndroidContent(BuildContext context, Contact contact) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildAndroidHeader(contact),
            const SizedBox(height: 24),
            _buildAndroidInfoCard(
              context,
              Icons.call,
              "Phone",
              "+91 ${contact.number ?? " "}",
              onTap: () => launchUrl(Uri.parse("tel://${contact.number}")),
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            _buildAndroidInfoCard(
              context,
              Icons.email,
              "Email",
              contact.email ?? "No email",
              onTap: () => launchUrl(Uri.parse("mailto:${contact.email}")),
              imageUrl: "https://mailmeteor.com/logos/assets/PNG/Gmail_Logo_512px.png",
            ),
            const SizedBox(height: 16),
            _buildAndroidInfoCard(
              context,
              Icons.message,
              "WhatsApp",
              "Message on WhatsApp",
              onTap: () => launchUrl(Uri.parse("https://wa.me/${contact.number}")),
              imageUrl: "https://upload.wikimedia.org/wikipedia/commons/5/5e/WhatsApp_icon.png",
            ),
            const SizedBox(height: 16),
            _buildAndroidInfoCard(
              context,
              Icons.share,
              "Share Contact",
              "Share",
              onTap: () => Share.share(contact.number!),
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAndroidHeader(Contact contact) {
    return Center(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
          color: Colors.teal.shade400,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 8,
            ),
          ],
        ),
        child: Center(
          child: Text(
            contact.name?.isNotEmpty == true ? contact.name![0].toUpperCase() : '?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 80,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAndroidInfoCard(BuildContext context, IconData icon, String label, String info, {required VoidCallback onTap, Color? color, String? imageUrl}) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: imageUrl != null
            ? Image.network(imageUrl, width: 40, height: 40)
            : Icon(icon, color: color ?? Theme.of(context).primaryColor, size: 32),
        title: Text(info, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(label),
        onTap: onTap,
      ),
    );
  }

  // iOS UI with Cupertino Design
  Widget _buildCupertinoUI(BuildContext context, Contact contact) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Contact Details"),
      ),
      child: _buildCupertinoContent(context, contact),
    );
  }

  Widget _buildCupertinoContent(BuildContext context, Contact contact) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCupertinoHeader(contact),
            const SizedBox(height: 24),
            _buildCupertinoInfoCard(
              context,
              CupertinoIcons.person,
              "Name",
              " ${contact.name ?? " "}",
              onTap: () => launchUrl(Uri.parse("tel://${contact}")),
              color: CupertinoColors.activeGreen,
            ),
            _buildCupertinoInfoCard(
              context,
              CupertinoIcons.phone,
              "Phone",
              "+91 ${contact.number ?? " "}",
              onTap: () => launchUrl(Uri.parse("tel://${contact.number}")),
              color: CupertinoColors.activeGreen,
            ),
            const SizedBox(height: 16),
            _buildCupertinoInfoCard(
              context,
              CupertinoIcons.mail,
              "Email",
              contact.email ?? "No email",
              onTap: () => launchUrl(Uri.parse("mailto:${contact.email}")),
            ),
            const SizedBox(height: 16),
            _buildCupertinoInfoCard(
              context,
              CupertinoIcons.chat_bubble_2,
              "WhatsApp",
              "Message on WhatsApp",
              onTap: () => launchUrl(Uri.parse("https://wa.me/${contact.number}")),
            ),
            const SizedBox(height: 16),
            _buildCupertinoInfoCard(
              context,
              CupertinoIcons.share,
              "Share Contact",
              "Share",
              onTap: () => Share.share(contact.number!),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCupertinoHeader(Contact contact) {
    return Center(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
          color: CupertinoColors.systemTeal,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            contact.name?.isNotEmpty == true ? contact.name![0].toUpperCase() : '?',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: CupertinoColors.white,
              fontSize: 80,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCupertinoInfoCard(BuildContext context, IconData icon, String label, String info, {required VoidCallback onTap, Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: CupertinoColors.separator),
        ),
        child: Row(
          children: [
            Icon(icon, color: color ?? CupertinoColors.activeBlue, size: 32),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(info, style: TextStyle(decoration: TextDecoration.none,fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(label, style: TextStyle(decoration: TextDecoration.none,color: CupertinoColors.systemGrey,fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
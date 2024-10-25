
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/model/contact..dart';
import 'package:platform_converter/provider/contect_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';



class MissedCallPage extends StatefulWidget {
  const MissedCallPage({super.key});

  @override
  State<MissedCallPage> createState() => _MissedCallPageState();
}

class _MissedCallPageState extends State<MissedCallPage> {
  List<Contact> MissedCallList = [
    Contact(name: "Rahul Sharma", number: "1234567890", email: "rahul@example.com", address: "123 Main St"),
    Contact(name: "Priya Singh", number: "9876543210", email: "priya@example.com", address: "456 Main St"),
    Contact(name: "Amit Patel", number: "5551234567", email: "amit@example.com", address: "789 Main St"),
    Contact(name: "Suresh Nair", number: "5559876543", email: "suresh@example.com", address: "101 Main St"),
    Contact(name: "Sunita Iyer", number: "5555555555", email: "sunita@example.com", address: "202 Main St"),
    Contact(name: "Rohit Verma", number: "5550000001", email: "rohit@example.com", address: "303 Main St"),
    Contact(name: "Anjali Desai", number: "5550000002", email: "anjali@example.com", address: "404 Main St"),
    Contact(name: "Vikram Reddy", number: "5550000003", email: "vikram@example.com", address: "505 Main St"),
    Contact(name: "Neha Kapoor", number: "5550000004", email: "neha@example.com", address: "606 Main St"),
    Contact(name: "Arjun Rao", number: "5550000005", email: "arjun@example.com", address: "707 Main St"),
    Contact(name: "Pooja Gupta", number: "5550000006", email: "pooja@example.com", address: "808 Main St"),

  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Consumer<ContactProvider>(
          builder: (BuildContext context, ContactProvider value, Widget? child) {
            if (value.MissedCallList.isEmpty) {
              return const Center(
                child: Text(
                  "No Contacts",
                  style: TextStyle(fontSize: 50),
                ),
              );
            }
            return ListView.builder(
              itemCount: value.MissedCallList.length,
              itemBuilder: (context, index) {
                Contact contact = value.MissedCallList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shadowColor: Colors.red,
                    color: Colors.red.shade50,
                    elevation: 2,
                    child: ListTile(
                      onTap: () {
                        launchUrl(Uri.parse("tel://${contact.number}"));
                      },
                      onLongPress: () {
                        _showDeleteConfirmation(context, index);
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(
                          "${contact.name?.isNotEmpty == true ? contact.name![0].toUpperCase() : '?'}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        contact.name ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        contact.number ?? "",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("DetailScreen", arguments: contact);
                        },
                        child: const Icon(Icons.info_outline_rounded),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        )
    );
  }
}

void _showDeleteConfirmation(BuildContext context, int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete Contact"),
        content: const Text("Are you sure you want to delete this contact?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Provider.of<ContactProvider>(context, listen: false).removeContact(index);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Contact deleted")),
              );
            },
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
}

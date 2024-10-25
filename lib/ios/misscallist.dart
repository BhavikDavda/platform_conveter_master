import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/model/contact..dart';
import 'package:platform_converter/provider/contect_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/global.dart';


class IosMissedCallPage extends StatefulWidget {
  const IosMissedCallPage({super.key});

  @override
  State<IosMissedCallPage> createState() => _IosMissedCallPageState();
}

class _IosMissedCallPageState extends State<IosMissedCallPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: value.MissedCallList.length,
                    itemBuilder: (context, index) {
                      Contact contact = value.MissedCallList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.2),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse("tel://${contact.number}"));
                            },
                            onLongPress: () {
                              _showDeleteConfirmation(context, index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Text(
                                      "${contact.name?.isNotEmpty == true ? contact.name![0].toUpperCase() : '?'}",
                                      style: const TextStyle(decoration: TextDecoration.none,color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          contact.name ?? "",
                                          style: const TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Text(
                                          contact.number ?? "",
                                          style: const TextStyle(decoration: TextDecoration.none,color: Colors.grey, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: const Icon(CupertinoIcons.info),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed("DetailScreen", arguments: contact);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
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

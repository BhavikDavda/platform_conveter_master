import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/model/contact..dart';
import 'package:platform_converter/provider/contect_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/home_provider.dart';

class IosContactlist extends StatefulWidget {
  const IosContactlist({super.key});

  @override
  State<IosContactlist> createState() => _IosContactlistState();
}

class _IosContactlistState extends State<IosContactlist> {
  TextEditingController _searchController = TextEditingController();
  List<Contact> _filteredContacts = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterContacts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterContacts() {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredContacts = provider.contactList.where((contact) {
        return contact.name?.toLowerCase().contains(query) ?? false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: Consumer<ContactProvider>(
        builder: (BuildContext context, ContactProvider value, Widget? child) {
          List<Contact> contactsToDisplay = _searchController.text.isEmpty
              ? value.contactList
              : _filteredContacts;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    CupertinoTextField(
                      controller: _searchController,
                      placeholder: 'Search Contacts',
                      prefix: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(CupertinoIcons.search),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: contactsToDisplay.length,
                        itemBuilder: (context, index) {
                          Contact contact = contactsToDisplay[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                launchUrl(Uri.parse("tel://${contact.number}"));
                              },
                              onLongPress: () {
                                _showDeleteConfirmation(context, index);
                              },
                              child: CupertinoButton(
                                onPressed: () {
                                  launchUrl(
                                      Uri.parse("tel://${contact.number}"));
                                },
                                padding: EdgeInsets.zero,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: CupertinoColors.systemGrey
                                            .withOpacity(0.4),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: CupertinoColors
                                            .systemTeal,
                                        child: Text(
                                          "${contact.name?.isNotEmpty == true
                                              ? contact.name![0].toUpperCase()
                                              : '?'}",
                                          style: const TextStyle(
                                              color: CupertinoColors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              contact.name ?? "",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: CupertinoColors.black,
                                              ),
                                            ),
                                            Text(
                                              contact.number ?? "",
                                              style: const TextStyle(
                                                color: CupertinoColors
                                                    .systemGrey,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        child: const Icon(CupertinoIcons.pencil,
                                            color: CupertinoColors.systemGrey),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, "AddContact",
                                              arguments: index);
                                        },
                                      ),
                                      CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        child: const Icon(CupertinoIcons.info,
                                            color: CupertinoColors.systemGrey),
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              "DetailScreen",
                                              arguments: contact);
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
                    ),
                  ],
                ),
                Positioned(
                  bottom: 5.0,
                  right: 5.0,
                  child: CupertinoButton(
                    color: CupertinoColors.systemTeal,
                    borderRadius: BorderRadius.circular(30.0),
                    child: const Icon(
                        CupertinoIcons.add, color: CupertinoColors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, "AddContact");
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text("Delete Contact"),
          message: const Text("Are you sure you want to delete this contact?"),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Provider.of<ContactProvider>(context, listen: false)
                    .removeContact(index);
                Navigator.of(context).pop();
              },
              isDestructiveAction: true,
              child: const Text("Delete"),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
        );
      },
    );
  }
}

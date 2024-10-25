import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Voicemail {
  final String senderName;
  final String number;
  final DateTime timeReceived;
  final String message;

  Voicemail({
    required this.senderName,
    required this.number,
    required this.timeReceived,
    required this.message,
  });
}

class iosiosDummyVoicemailPage extends StatefulWidget {
  const iosiosDummyVoicemailPage({super.key});

  @override
  State<iosiosDummyVoicemailPage> createState() => _iosiosDummyVoicemailPageState();
}

class _iosiosDummyVoicemailPageState extends State<iosiosDummyVoicemailPage> {
  final List<Voicemail> voicemailList = [
    Voicemail(senderName: "Alice Johnson", number: "1234567890", timeReceived: DateTime.now().subtract(const Duration(hours: 1)), message: "Hey, call me back when you can!"),
    Voicemail(senderName: "Bob Smith", number: "0987654321", timeReceived: DateTime.now().subtract(const Duration(hours: 2)), message: "Don't forget our meeting tomorrow."),
    Voicemail(senderName: "Charlie Brown", number: "5678901234", timeReceived: DateTime.now().subtract(const Duration(hours: 3)), message: "Can you send me the files?"),
    Voicemail(senderName: "David Wilson", number: "6789012345", timeReceived: DateTime.now().subtract(const Duration(hours: 4)), message: "Let's catch up this weekend!"),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Voicemails"),
      ),
      child: SafeArea(
        child: voicemailList.isEmpty
            ? const Center(
          child: Text(
            "No Voicemails",
            style: TextStyle(fontSize: 20),
          ),
        )
            : CupertinoScrollbar(
          child: ListView.builder(
            itemCount: voicemailList.length,
            itemBuilder: (context, index) {
              Voicemail voicemail = voicemailList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: GestureDetector(
                    onTap: () {
                      _playVoicemail(voicemail.message);
                    },
                    onLongPress: () {
                      _showDeleteConfirmation(context, index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.pinkAccent,
                            child: Text(
                              voicemail.senderName.isNotEmpty
                                  ? voicemail.senderName[0].toUpperCase()
                                  : '?',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  voicemail.senderName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  voicemail.number,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            _formatTime(voicemail.timeReceived),
                            style: const TextStyle(color: Colors.black),
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
      ),
    );
  }

  void _playVoicemail(String message) {
    // Simulate playing the voicemail
    print("Playing voicemail: $message");
    CupertinoDialogAction(
      onPressed: () {},
      child: Text("Playing voicemail: $message"),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Delete Voicemail"),
          content: const Text("Are you sure you want to delete this voicemail?"),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            CupertinoDialogAction(
              onPressed: () {
                setState(() {
                  voicemailList.removeAt(index); // Remove voicemail
                });
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Voicemail deleted")),
                );
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')} ${time.day}/${time.month}/${time.year}";
  }
}

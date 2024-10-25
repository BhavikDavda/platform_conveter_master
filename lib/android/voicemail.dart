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

class DummyVoicemailPage extends StatefulWidget {
  const DummyVoicemailPage({super.key});

  @override
  State<DummyVoicemailPage> createState() => _DummyVoicemailPageState();
}

class _DummyVoicemailPageState extends State<DummyVoicemailPage> {
  final List<Voicemail> voicemailList = [
    Voicemail(senderName: "Alice Johnson", number: "1234567890", timeReceived: DateTime.now().subtract(const Duration(hours: 1)), message: "Hey, call me back when you can!"),
    Voicemail(senderName: "Bob Smith", number: "0987654321", timeReceived: DateTime.now().subtract(const Duration(hours: 2)), message: "Don't forget our meeting tomorrow."),
    Voicemail(senderName: "Charlie Brown", number: "5678901234", timeReceived: DateTime.now().subtract(const Duration(hours: 3)), message: "Can you send me the files?"),
    Voicemail(senderName: "David Wilson", number: "6789012345", timeReceived: DateTime.now().subtract(const Duration(hours: 4)), message: "Let's catch up this weekend!"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voicemails"),
        centerTitle: true,
        backgroundColor: Colors.teal.shade400,
      ),
      body: SafeArea(
        child: voicemailList.isEmpty
            ? const Center(
          child: Text(
            "No Voicemails",
            style: TextStyle(fontSize: 20),
          ),
        )
            : ListView.builder(
          itemCount: voicemailList.length,
          itemBuilder: (context, index) {
            Voicemail voicemail = voicemailList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shadowColor: Colors.teal.shade400,
                elevation: 2,
                child: ListTile(
                  onTap: () {
                    _playVoicemail(voicemail.message);
                  },
                  onLongPress: () {
                    _showDeleteConfirmation(context, index);
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal.shade400,
                    child: Text(
                      voicemail.senderName.isNotEmpty
                          ? voicemail.senderName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    voicemail.senderName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    voicemail.number,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: Text(
                    _formatTime(voicemail.timeReceived),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _playVoicemail(String message) {
    // Simulate playing the voicemail
    print("Playing voicemail: $message");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Playing voicemail: $message")),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Voicemail"),
          content: const Text("Are you sure you want to delete this voicemail?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
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

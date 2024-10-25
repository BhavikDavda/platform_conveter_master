
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/contact..dart';
import '../../provider/contect_provider.dart';
import '../../provider/home_provider.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  int? editIndex;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    editIndex = ModalRoute.of(context)?.settings.arguments as int?;
    if (editIndex != null) {
      Contact contact = Provider.of<ContactProvider>(context, listen: false).contactList[editIndex!];
      nameController.text = contact.name ?? "";
      numberController.text = contact.number ?? "";
      emailController.text = contact.email ?? "";
      addressController.text = contact.address ?? "";
    }
    if (Provider.of<HomeProvider>(context).isAndroid) {
      return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.teal.shade400,
          title: const Text("Add Contact"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Enter your name',
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'Your Name',
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Enter your phone number',
                    prefixIcon: const Icon(Icons.call),
                    labelText: 'Your Phone Number',
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please enter a phone number' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Enter your email',
                    prefixIcon: const Icon(Icons.email),
                    labelText: 'Your Email',
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Enter your address',
                    prefixIcon: const Icon(Icons.location_on),
                    labelText: 'Your Address',
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Contact con = Contact(
                          name: nameController.text,
                          number: numberController.text,
                          email: emailController.text,
                          address: addressController.text,
                        );

                        if (editIndex == null) {
                          Provider.of<ContactProvider>(context, listen: false).addContact(con);
                        } else {
                          Provider.of<ContactProvider>(context, listen: false).editContact(con, editIndex!);
                        }

                        nameController.clear();
                        numberController.clear();
                        emailController.clear();
                        addressController.clear();
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade400,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      editIndex != null ? "Edit Contact" : "Add Contact",
                      style: const TextStyle(fontSize: 18,color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    else {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(editIndex != null ? "Edit Contact" : "Add Contact"),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CupertinoTextFormFieldRow(
                    controller: nameController,
                    prefix: const Icon(CupertinoIcons.person),
                    placeholder: 'Enter your name',
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextFormFieldRow(
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    prefix: const Icon(CupertinoIcons.phone),
                    placeholder: 'Enter your phone number',
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextFormFieldRow(
                    controller: emailController,
                    prefix: const Icon(CupertinoIcons.mail),
                    placeholder: 'Enter your email',
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextFormFieldRow(
                    controller: addressController,
                    prefix: const Icon(CupertinoIcons.location),
                    placeholder: 'Enter your address',
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  const SizedBox(height: 20),
                  CupertinoButton.filled(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Contact con = Contact(
                          name: nameController.text,
                          number: numberController.text,
                          email: emailController.text,
                          address: addressController.text,
                        );

                        if (editIndex == null) {
                          Provider.of<ContactProvider>(context, listen: false)
                              .addContact(con);
                        } else {
                          Provider.of<ContactProvider>(context, listen: false)
                              .editContact(con, editIndex!);
                        }

                        nameController.clear();
                        numberController.clear();
                        emailController.clear();
                        addressController.clear();
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      editIndex != null ? "Edit Contact" : "Add Contact",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }}
  }

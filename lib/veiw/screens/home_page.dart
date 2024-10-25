import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/android/contactlist.dart';
import 'package:platform_converter/android/misscalllist.dart';
import 'package:platform_converter/android/settings.dart';
import 'package:platform_converter/ios/contactlist.dart';
import 'package:platform_converter/ios/iosvoicemail.dart';
import 'package:platform_converter/ios/misscallist.dart';
import 'package:platform_converter/ios/settings.dart';
import 'package:platform_converter/provider/home_provider.dart';

import 'package:provider/provider.dart';

import '../../android/voicemail.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    if (Provider
        .of<HomeProvider>(context)
        .isAndroid) {
      return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.teal.shade400,
          title: const Text("Contacts", style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold),),
          centerTitle: true,
          actions: [
            Consumer<HomeProvider>(
              builder: (context, homeProvider, child) {
                return Switch(
                  activeColor: Colors.white,
                  value: homeProvider.isAndroid,
                  onChanged: (value) {
                    homeProvider.change(); // Toggle between Android and iOS
                  },
                );
              },
            )
          ],
        ),
        bottomNavigationBar: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: homeProvider.menuIndex,
              onTap: (index) {
                homeProvider.changeMenuIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.contact_page_outlined),
                  label: "Contacts",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.call),
                  label: "Missed Calls",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.voicemail),
                  label: "Voice mail",
                ),

              ],
            );
          },
        ),
        body:
        SafeArea(
          child: Consumer<HomeProvider>(
            builder: (context, homeProvider, child) {
              // Switch between different pages based on selected index
              switch (homeProvider.menuIndex) {
                case 0:
                  return Contactlist(); // Display Home Page
                case 1:
                  return MissedCallPage();
                case 2:
                  return const SettingsPage();
                case 3:
                  return const DummyVoicemailPage();
                default:
                  return Contactlist();
              }
            },
          ),
        ),

      );
    } else {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor:Colors.teal.shade400,
          middle: const Text(
            "IOS Contact",
            style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold),
          ),
          trailing: Consumer<HomeProvider>(
            builder: (context, homeProvider, child) {
              return CupertinoSwitch(
                value: homeProvider.isAndroid,
                onChanged: (value) {
                  homeProvider.change(); // Toggle between Android and iOS
                },
              );
            },
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Consumer<HomeProvider>(
                  builder: (context, homeProvider, child) {

                    switch (homeProvider.menuIndex) {
                      case 0:
                        return const IosContactlist();
                      case 1:
                        return const IosMissedCallPage();
                      case 2: return const iosSettingsPage();
                      case 3:
                        return const iosiosDummyVoicemailPage();
                    // Display Add Contact Page
                      default:
                        return const IosContactlist();
                    }
                  },
                ),
              ),
              CupertinoTabBar(
                currentIndex: Provider
                    .of<HomeProvider>(context)
                    .menuIndex,
                onTap: (index) {
                  Provider.of<HomeProvider>(context, listen: false)
                      .changeMenuIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person_2),
                    label: "Contacts",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.phone),
                    label: "Missed Calls",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.settings),
                    label: "Settings",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.mic),
                    label: "Settings",
                  ),

                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
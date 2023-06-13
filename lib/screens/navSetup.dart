import 'package:epic_project/screens/activeDrives.dart';
import 'package:epic_project/screens/homepages/userHomepage.dart';
import 'package:epic_project/screens/marketplace.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'authentication/AccountPage.dart';

class navSetup extends StatefulWidget {
  const navSetup({super.key});

  @override
  State<navSetup> createState() => _navSetupState();
}

class _navSetupState extends State<navSetup> {
  int current_index = 1;
  final _pages = [
    const activeDrives(),
    const userHomepage(),
    const marketplace(),
  ];
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12 && current_index == 1) {
      return 'Good Morning!';
    }
    if (hour < 17 && current_index == 1) {
      return 'Good Afternoon!';
    }
    if (current_index == 1) {
      return 'Good Evening!';
    }
    if (current_index == 0) {
      return 'Donate Now!';
    }
    if (current_index == 2) {
      return 'Marketplace';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${greeting()}',
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              //on tap, go to account page
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const accountPage(),
                  ),
                );

              },
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://pbs.twimg.com/media/FejTuGpUoAAPexl?format=jpg&name=large'), //add user profile picture after auth. setup
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.transparent,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              selectedIcon: Icon(Icons.favorite),
              label: 'Donate',
            ),
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.local_grocery_store_outlined),
              selectedIcon: Icon(Icons.local_grocery_store),
              label: 'Market',
            ),
          ],
          onDestinationSelected: (int index) {
            setState(() {
              current_index = index;
            });
          },
          selectedIndex: current_index,
        ),
      ),
      body: IndexedStack(
        children: _pages,
        index: current_index,
      ),
    );
  }
}

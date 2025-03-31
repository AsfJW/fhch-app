import 'package:flutter/material.dart';
import 'package:friends_hch/components/folder_card.dart';
import 'package:friends_hch/screens/documents_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  //const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Map<String, dynamic>> sections = [
    {'title': 'Events', 'color': Colors.blue, 'icon': Icons.event},
    {'title': 'Volunteers', 'color': Colors.green, 'icon': Icons.people},
    {'title': 'Documents', 'color': Colors.orange, 'icon': Icons.description},
    {'title': 'Gallery', 'color': Colors.purple, 'icon': Icons.photo_album},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, title: Text('Welcome to the Friends of HCH!')),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            Image.asset('assets/images/logos/logo-150.png'),
            SizedBox(height: 20.0),
            Text(
              'Here be news - from website for quick edit?',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 25.0),
            ...sections.map((section) {
              return FolderCard(
                title: section['title'],
                color: section['color'],
                icon: Icon(section['icon']),
                onTap: section['title'] == 'Documents'
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DocumentsScreen(),
                          ),
                        );
                      }
                    : null,
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

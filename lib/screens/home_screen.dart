import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marquee/marquee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friends_hch/components/folder_card.dart';
import 'package:friends_hch/screens/documents_screen.dart';
import 'package:friends_hch/screens/add_news_screen.dart';
import 'package:friends_hch/screens/upload_document_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  const HomeScreen({super.key});
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
    final user = FirebaseAuth.instance.currentUser;
    Future<bool> isAdmin() async {
      if (user == null) {
        return false;
      }
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        return doc.data()?['isAdmin'] ?? false;
      } catch (e) {
        print("Error checking admin status: $e");
        return false;
      }
    }

    void navigateToUpload() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UploadDocumentScreen(),
        ),
      );
    }
    void navigateToAddNews() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddNewsScreen(),
        ),
      );
    }
    Widget adminAddNewsButton = FutureBuilder<bool>(
      future: isAdmin(),
      builder: (context, snapshot) => snapshot.data == true
          ? FloatingActionButton(
              onPressed: navigateToAddNews,
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
            )
          : SizedBox.shrink(),
    );
    
    
    Widget adminUploadButton = FutureBuilder<bool>(
      future: isAdmin(),
      builder: (context, snapshot) => snapshot.data == true ? FloatingActionButton(onPressed: navigateToUpload, child: Icon(Icons.upload_file)) : SizedBox.shrink(),
    );
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, title: Text('Welcome to the Friends of HCH!')),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('news').get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    final newsList = snapshot.data!.docs
                        .map((doc) => doc['content'] as String)
                        .toList();
                    return Marquee(
                      text: newsList.join('   '),
                      style: TextStyle(fontWeight: FontWeight.bold),
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      blankSpace: 20.0,
                      velocity: 100.0,
                      pauseAfterRound: Duration(seconds: 1),
                    );
                  } else {
                    return Text('No news available.');
                  }
                },
              ),
            ),
            SizedBox(height: 20.0),
          
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [adminUploadButton, SizedBox(width: 16), adminAddNewsButton],
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

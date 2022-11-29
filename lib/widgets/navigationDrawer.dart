import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class navigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                'Welcome '+user.email!,
                style: TextStyle(
                    fontSize: 20, color: Colors.white
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text(' My Booked Sessions '),
              onTap: () {
                Navigator.pushNamed(context, '/bookings');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                final FirebaseAuth _auth = FirebaseAuth.instance;
                Future<void> _signOut() async {
                  await _auth.signOut();
                }
                _signOut();
                Navigator.pushNamed(context, '/');
                // Navigator.push(context, new MaterialPageRoute(
                //         builder: (context) => new Login())
              },
            ),
          ],
        ),
    );
  }
  }
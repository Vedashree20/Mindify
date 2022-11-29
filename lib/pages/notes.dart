import 'package:flutter/material.dart';
import 'package:myfirstapp/helpers/note_card.dart';
import '../Database/Notes.dart';
import '../widgets/appBar.dart';
import '../widgets/navigationDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home:  Noting(),
));

User? user = FirebaseAuth.instance.currentUser!;
final String uid=user!.uid;
final usersRef = FirebaseFirestore.instance.collection('notesCollection').doc(uid).collection('user notes');



class Noting extends StatefulWidget {
  //const Booking ({Key? key}) : super(key: key);

  @override
  _NotingState createState() => _NotingState();
}

class _NotingState extends State<Noting> {

  List<Object> _notingList = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUsersNotesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
        resizeToAvoidBottomInset : false,
        appBar: appBar(context),
        endDrawer: navigationDrawer(),
        backgroundColor: Colors.purple[50],
        body: SingleChildScrollView(
            child:Column(
              children: <Widget>[
                SizedBox(height:30),
              Text(
            'Your notes',
            style: TextStyle(
              color: Colors.purple[700],
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
        ),
        SizedBox(height:30),
            SafeArea(
                child:ListView.builder(
                    shrinkWrap: true,
                    itemCount:_notingList.length,
                    itemBuilder: (context,index)
                    {
                      return NoteCard(_notingList[index] as Notes);
                    }
                )
            )
            ]
        )
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/takenote');
        },
        backgroundColor: Colors.purple[100],
        child: const Icon(Icons.edit),
      ),
    );
  }

  Future getUsersNotesList() async
  {
    User? user = FirebaseAuth.instance.currentUser!;
    final String uid = user.uid;
    var data = await FirebaseFirestore.instance
        .collection('notes')
        .doc(uid)
        .collection('user notes')
        .get();

    setState(() {
      _notingList = List.from(data.docs.map((doc) => Notes.fromSnapshot(doc)));
    });
  }
}


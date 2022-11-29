import 'package:flutter/material.dart';
import '../Database/Notes.dart';
import '../Database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser!;
final String uid=user!.uid;

class NoteCard extends StatelessWidget {
  final Notes _notes;
  NoteCard(this._notes);
  @override
  Widget build(BuildContext context) {
    return Container(
        child:GestureDetector(
          onTap: ()
    {
      Navigator.pushNamed(context, '/updatenote');
    },
      child: Card(
          color:Colors.purple[100],
          margin: EdgeInsets.all(20),
          child: SizedBox(
              width: 50,
              height: 64,
              child:Padding(
                  padding:const EdgeInsets.all(12.0),
                  child:Column(
                    children:[
                      Row(
                        children:[
                          Text(_notes.Title,style:TextStyle(fontWeight: FontWeight.bold,)),
                        ],
                      ),
                      Row(
                        children:[Text(_notes.Content),
                        ],
                      ),
                    ],
                  )
              )

          )
      )
        )
    );
  }
}


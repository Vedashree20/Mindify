import 'package:flutter/material.dart';
import '../widgets/appBar.dart';
import '../widgets/navigationDrawer.dart';
import '../Database/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// void main() => runApp(MaterialApp(
//   debugShowCheckedModeBanner: false,
//   home:  bookingPage(),
// ));

class takeNote extends StatelessWidget
{
  User? user = FirebaseAuth.instance!.currentUser!;
  final titleController = TextEditingController();
  final notesController = TextEditingController();
  //const bookingPage({Key? key}) : super(key: key);
  static const String routeName = '/booking';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: appBar(context),
      endDrawer: navigationDrawer(),
      backgroundColor: Colors.purple[50],
      body: SingleChildScrollView(
        child:Center(
          child:Form(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height:30),
                Text(
                  'Add a note',
                  style: TextStyle(
                    color: Colors.purple[700],
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height:10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:30),
                  child:Form(
                    child: Column(
                      children:[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:25),
                          child:TextFormField(
                            controller: titleController,
                            keyboardType: TextInputType.emailAddress,
                            decoration:InputDecoration(
                              labelText:'Title*',
                              hintText:'Your Title',
                            ),
                          ),
                        ),
                        SizedBox(height:30),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:25),
                          child:TextFormField(
                            controller: notesController,
                            keyboardType: TextInputType.emailAddress,
                            decoration:InputDecoration(
                              labelText:'Type Text',
                              hintText:'Text',
                            ),
                          ),
                        ),
                        SizedBox(height:30),
                        MaterialButton(
                          onPressed:() {
                            {
                              final String title = titleController.text.trim();
                              final String notes = notesController.text
                                  .trim();
                              void add() async
                              {
                                await DatabaseService(uid: user!.uid)
                                    .updateNotesData(
                                    title, notes);
                              };
                              add();
                              Navigator.pushNamed(context, '/notes');
                            }
                          },
                          child:Text('Add'),
                          minWidth: 150.0,
                          color:Colors.purple[100],
                          textColor:Colors.purple[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

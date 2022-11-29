import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});


  final CollectionReference bookingCollection = FirebaseFirestore.instance
      .collection('bookings');

  Future updateUserData(String name, String therapist, String contact, String city,
      String country) async
  {
    return await bookingCollection.doc(uid).collection('user bookings').add(
        {
          'Created':DateTime.now(),
          'Name': name,
          'Therapist': therapist,
          'Contact': contact,
          'City': city,
          'Country': country,
        }
    );
  }
  final CollectionReference notesCollection = FirebaseFirestore.instance
      .collection('notes');
  Future updateNotesData(String Title, String Content) async
  {
    return await notesCollection.doc(uid).collection('user notes').add(
        {
          'Title':Title,
          'Content':Content,
        }
    );
  }

  Future editNotesData(String Title, String Content) async
  {
    return await notesCollection.doc(uid).collection('user notes').doc().update(
        {
          'Title':Title,
          'Content':Content,
        }
    );
  }

  Future deleteNotesData() async
  {
    return await notesCollection.doc(uid).collection('user notes').doc(uid).delete();
  }
}

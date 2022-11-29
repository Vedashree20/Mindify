class Forms {
  String Therapist;
  DateTime Created;


  Map<String, dynamic> toJson() => {'Created': Created, 'Therapist': Therapist};

  Forms.fromSnapshot(snapshot)
      : Created = snapshot.data()['Created'].toDate(),
        Therapist = snapshot.data()['Therapist'];
}

class   Notes {
  String Title;
  String Content;


  Map<String, dynamic> toJson() => {'Title': Title, 'Content': Content};

  Notes.fromSnapshot(snapshot)
      : Title = snapshot.data()['Title'],
        Content = snapshot.data()['Content'];
}

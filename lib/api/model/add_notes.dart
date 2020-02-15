class AddNotes {
  String personId,note;
  AddNotes({personId,note}) {
    this.personId=personId;
    this.note=note;

  }
  factory AddNotes.fromJson(Map<String, dynamic> parsedJson) {
    return AddNotes(
      personId: parsedJson['personId'],
      note: parsedJson['note'],
    );
  }


}

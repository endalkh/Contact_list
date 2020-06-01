class GetNoteList {
  String id,body,createdAt,updatedAt;
  GetNoteList({id,body,createdAt,updatedAt}) {
    this.id=id;
    this.body=body;
    this.createdAt=createdAt;
    this.updatedAt=updatedAt;

  }
  factory GetNoteList.fromJson(Map<String, dynamic> parsedJson) {
    return GetNoteList(
      id: parsedJson['id'],
      body:parsedJson["body"],
      createdAt: parsedJson['created_at'],
      updatedAt: parsedJson['updated_at'],

    );
  }


}
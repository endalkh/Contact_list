class SearchModel {
  String name,birthDate,id;
  SearchModel( {name,birthDate,id}) {
    this.name=name;
    this.id=id;
    this.birthDate=birthDate;

  }
  factory SearchModel.fromJson(Map<String, dynamic> parsedJson) {
    return SearchModel(
      name: parsedJson['name'],
      id:parsedJson["id"],
      birthDate: parsedJson['birthday']==null?"":parsedJson['birthday'],
    );
  }


}
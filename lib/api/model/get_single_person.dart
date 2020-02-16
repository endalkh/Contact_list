class GetSinglePerson {
    String name,birthDate,id,lastContact;
    GetSinglePerson({name,birthDate,id,lastContact}) {
        this.name=name;
        this.id=id;
        this.birthDate=birthDate;
        this.lastContact=lastContact;

    }
    factory GetSinglePerson.fromJson(Map<String, dynamic> parsedJson) {
        return GetSinglePerson(
                name: parsedJson['name'],
                id:parsedJson["id"],
                birthDate: parsedJson['birthday'],
                lastContact: parsedJson['last_contact'],

                );
    }


}
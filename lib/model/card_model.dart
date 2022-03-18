class CardModel{
  late String id;
  late String phoneNumber;
  late String name;
  late String relationship;

  CardModel({required this.phoneNumber,required this.name, required this.relationship ,required this.id });

  CardModel.fromJson(Map<String,dynamic>json){
    phoneNumber=json["phoneNumber"];
    name =json["name"];
    relationship=json["relationship"];
    id = json["id"];
  }

  Map<String ,String>toJson(){
    return {
      "phoneNumber":phoneNumber,
      "name":name,
      "relationship":relationship,
      "id":id
    };
  }
}
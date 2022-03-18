
import 'dart:convert';
import 'package:http/http.dart';
import '../model/card_model.dart';
class HttpService{
  static const String BaseUrl="622b467614ccb950d2350a9b.mockapi.io";

  static Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8',
  };
// api
  static String API_CARDS_LIST="/api/Cards";
  static String API_CREATE_CARD="/api/Cards";
  static String API_DELETE="/api/Cards/";


  /// main function
  static Future<String?>GET(String api,Map<String,String>params)async{
    Uri uri =Uri.https(BaseUrl, api,params);
    var response = await get(uri, headers: headers);
    if(response.statusCode==200){
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> body) async {
    Uri url = Uri.https(BaseUrl, api);
    var response = await post(url, headers: headers,body: jsonEncode(body));
    if (response.statusCode == 201) {
      print("Status code${response.statusCode}");
      return response.body;
    }

    return null;
  }


  static Future<String?> DELETE(String api, Map<String, String> params) async {
    print("keldi");
    Uri url = Uri.https(BaseUrl, api,params);
    var response = await delete(url, headers: headers,);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return response.body;
    }

    return null;
  }

  /// params


  static  Map<String , String >paramEmpty(){
    Map <String, String>map={};
    return map;
  }


  static Map<String,String>PostBody(CardModel list){
    return {
      "cardNumber":list.name,
      "fullName":list.phoneNumber,
      "fullName":list.relationship,
    };
  }

// parse

  static List<CardModel>parseCards(String list){
    print("++++++++++++++++++++++++++++++++++++++++");
    print(list);
    List newList=jsonDecode(list);
    List<CardModel>cards=List<CardModel>.from(newList.map((e) => CardModel.fromJson(e)));
    return cards;
  }
}
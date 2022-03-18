import 'package:flutter/material.dart';
import 'package:retake_exame_modul6/model/card_model.dart';
import 'package:retake_exame_modul6/service/http_service.dart';
import 'package:retake_exame_modul6/service/util_service.dart';

import 'home_page.dart';
class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
 bool isload =false;
  void storeData()async{
    setState(() {
      isload=true;
    });
    if(nameController.text.isEmpty||phoneController.text.isEmpty|| relationshipController.text.isEmpty){
      Utils.fireSnackBar("Fill in all fields", context);
      return ;
    }
    CardModel data=CardModel(id: "",name: nameController.text,phoneNumber: phoneController.text,relationship: relationshipController.text);
   await HttpService.POST(HttpService.API_CREATE_CARD,HttpService.PostBody(data));
   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
   setState(() {
     isload=false;
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Recipients",style: TextStyle(color: Colors.black,fontSize: 25),),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.black,size: 40,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body:SingleChildScrollView(

        child:isload?Center(child: CircularProgressIndicator(),): Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height ,
          child: Column(
            children: [
              SizedBox(height: 20,),
              Stack(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(60),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.grey.withOpacity(0.8),
                            Colors.white.withOpacity(0.4),
                        Colors.white.withOpacity(0.4),
                        Colors.white.withOpacity(0.4),
                            Colors.grey.withOpacity(0.2),

                      ]

                      )
                    ),
                    child: Container(

                      alignment: Alignment.bottomRight,
                      height: 80,
                      width: 80,
                      child: IconButton(padding: EdgeInsets.zero,
                        constraints: BoxConstraints(minHeight: 0,minWidth: 0,),
                        icon: Icon(Icons.add_circle,color: Colors.black,size: 20,),onPressed: (){},
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  label: Text("Name"),
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10),
                  )
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: relationshipController,
                decoration: InputDecoration(
                    label: Text("Relationship"),
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: InputDecoration(
                    label: Text("Phone Number"),

                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
           Spacer(),
              MaterialButton(onPressed: (){
                storeData();
              },
              minWidth: MediaQuery.of(context).size.width,
                height: 50,color: Colors.blue,
                child: Text("Save"),
                shape: StadiumBorder(),
              ),
            //  SizedBox(height: 50,),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

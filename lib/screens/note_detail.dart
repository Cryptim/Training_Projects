

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:notelist/utils/database_helper.dart';
class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;
   NoteDetail(this.appBarTitle, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NoteDetailState(this.appBarTitle);
  } 
}

class _NoteDetailState extends State<NoteDetail> {
  static final _priorities=['High','Low'];
  final String appBarTitle;
   DatabaseHelper helper=DatabaseHelper();
  final Note note;
  _NoteDetailState(this.appBarTitle);
  
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        moveToLastScreen();
      },
      child: Scaffold(appBar: AppBar(
        title: Text(appBarTitle),
        leading: IconButton(onPressed:(){
          moveToLastScreen();
        } , icon:const Icon(Icons.arrow_back))
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
          child: ListView(
            children:  <Widget>[
              ListTile(
                title: DropdownButton(items:_priorities.map((String dropDownStringItem) {
                
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                  );
                }).toList(),
                value:'Low',
                onChanged:(valueSelectedByUser){
                  setState(() {
                    debugPrint('User Selected $valueSelectedByUser');
                  });
                }
                ),
                
              ),
              //Second element
               Padding(
                padding: const EdgeInsets.only(top: 15,bottom:15 ),
                child: TextField(
                  controller: titleController,
                  onChanged: (value){
                    debugPrint('something change in the Title Text Field');
                  },
                  decoration:  InputDecoration(labelText:'Title',
                  border: OutlineInputBorder(borderRadius:BorderRadius.circular(5.0)) ),
                ),
              ),
              //Three element
                 Padding(
                padding: const EdgeInsets.only(top: 15,bottom:15 ),
                child: TextField(
                  controller: descriptionController,
                  onChanged: (value){
                    debugPrint('something change in the description Text Field');
                  },
                  decoration:  InputDecoration(labelText:'Description',
                  border: OutlineInputBorder(borderRadius:BorderRadius.circular(5.0)) ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15,bottom: 15),
                child: Row(
                  children: <Widget>[
                    Expanded(child: ElevatedButton(onPressed:(){
                      setState(() {
                        debugPrint('Save button Clicked');
                      },
                      );
                    }, child:const Text('save'),
                    ),
                    ),
                    Container(width: 5.0,),
                    Expanded(child: ElevatedButton(onPressed:(){
                      setState(() {
                        debugPrint('Delete button Clicked');
                      },
                      );
                    }, 
                    child:const Text('Delete'),
                    ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        ),
    );
  }
void moveToLastScreen(){
  Navigator.pop(context);
}
}
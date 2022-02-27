import 'package:flutter/material.dart';
class NoteList extends StatelessWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoteListState();
  }
}
class NoteListState extends state<NoteList>{
    int count=0;
    @override
    widget build(context build){
        return Scaffold(
            appBar:AppBar(
               title: Text('Notes');
            );
     body:getNoteListView(),
     floatingActionButton:floatingActionButton(
       onpressed:(){
         debug print('FAB Tab');
       }
       tooltip:'Add Note'
       child:Icon(Icons.add);
     )
    );
   
    }
  listView getNoteListView(){
      Textstyle titleStyle=Theme.of(context).textTheme.subhead;
      return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int positions) {
          return Card(
              color:colors.white,
              elevation:2.0,
              child:ListTile(
                  leading:CircleAvatar(backgroundColor:colors.yellow,child:Icon(Icons.keyboard_arrow_right),)
              );
              title
          );
        },
      ),
  }  
}
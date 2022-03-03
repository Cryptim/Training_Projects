import 'package:flutter/material.dart';
import 'package:notelist/screens/note_detail.dart';
import 'package:notelist/model/note.dart';
import 'package:notelist/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
class NoteList extends StatefulWidget {
  
  
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
DatabaseHelper databaseHelper=DatabaseHelper();
List<Note>notelist;
int count=0;
}

class _NoteListState extends State<NoteList> {
  
  @override
  Widget build(BuildContext context) {
    if (noteList==null){
      notelist=List<Note>();
    }
    return Scaffold(
            appBar:AppBar(
               title: const Text('Notes'),
            ),
            body: getNoteListView(),
            floatingActionButton: FloatingActionButton(onPressed: (){
              debugPrint('FAB clicked');
              Navigator.push(context, MaterialPageRoute(builder: (context){
                navigatorToDetail(Note(", ",2),'Add Note');
              }));
            },
            tooltip:'Add Note' ,
            child: const Icon(Icons.add),
            ),
            
            );
    }
    int count=0;
    ListView getNoteListView(){
      // Textstyle titleStyle=Theme.of(context).textTheme.subhead;
      return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int positions) {
          return  Card(
              color:Colors.white,
              elevation:2.0,
              child:ListTile(
                  leading:const CircleAvatar(backgroundColor:getPriorityColor(this.noteList[positions].priority).yellow,child:getPriorityIcon(this.noteList[positions].priority)
                  ),
                  title: Text(this.noteList[positions].title,),
                  subtitle: const Text(this.noteList[positions].date),
                  trailing: GestureDetector(child: const 
                  Icon(Icons.delete,color:Colors.grey,),
                  onTap: () {
                    _delete(context,noteList[position]);
                  },
                  
                  ),

                  onTap: () {
                    debugPrint('ListTile Tapped');
                    navigatorToDetail(this.noteList[positions],'Edit Note');
                  }
              ),
              );
            
        
        },
      );
  }
  //Return priority color
  Color  getPriorityColor(int priority){
    switch(priority){
      case 1:
      return Colors.red;
      break;
      case 2:
      return Colors.yellow;
      break;
      default:
      return Colors.yellow;
    }
  }
  //Return the priority icon
  Icons getPriorityIcon(int priority){
    case 1:
    return Icon(Icons.play_arrow);
    break;
    case 2:
    return Icon(Icons.keyboard_arrow_right);
    break;
    default:
    return Icon(Icons.keyboard_arrow_right);
  }
  //Delete function
  void _delete(BuildContext context,Note note)async{
    int result =await databaseHelper.deleteNote(note.id);
    if (result!=0){
      _showSnackBar(context,'Note Deleted Successfully');
      //Todo update the list view
      updateListView(NoteList);
    }
  }
  void _showSnackBar(BuildContext context,String message){
    final snackBar=SnackBar(context:Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
void navigatorToDetail(Note note ,String title){
  Navigator.push(context,MaterialPageRoute(builder: (context){
                      return  NoteDetail(note,title);
  
},
  ));}

void updateListView(NoteList){
  final Future<Database> dbFuture=databaseHelper.initializeDatabase();
  dbFuture.then(database){
    Future<List<Note>> noteListFuture=databaseHelper.getNoteList();
    noteListFuture.then((noteList){
      setState((){
        this.noteList=noteList;
        this.count=noteList.length;
      });
    });
  };
}


}
  

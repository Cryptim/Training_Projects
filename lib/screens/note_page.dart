import 'package:flutter/material.dart';
import 'package:notelist/model/note.dart';
import 'package:notelist/screens/note_detail.dart';
import 'package:notelist/utils/database_helper.dart';
class NotePage extends StatefulWidget {
  const NotePage({ Key? key }) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late List<Note> notes;
  bool isLoading=false;
  @override
  void @override
  void initState() {
    super.initState();
    refreshNotes();
  }
  @override
  void dispose(){
    NotesDatabase.instance.close();
    super dispose();
  }
  Future refreshNote() async{
    setState((=>isLoading=true);
    this.notes=await NotesDatabase.instance.readAllNotes()
    setState(()=>isLoading=false);
    );
  }
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBar(
        title: Text('Notes',style: TextStyle(fontSize: 24),
        ),
        actions: [Icon(Icons.search,sizedBox(width:12))],

      ),
      body: Center(child: isLoading 
      ? CircularProgressIndicator(
        :notes.isEmpty
        ?Text('No Notes',style:TextStyle(color: Colors.white,))
        :buildNotes(),
      ),
      ),
      floatingActionButton: FloatingActionButton(onPressed:() async{
await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddE);
refreshNote();
);
      } ,backgroundColor: Colors.black,child:Icon(Icons.add),
      
      ),
    );
  }
  Widget buildNotes=>staggeredGridView.countBuilder(
    padding:const EdgeInsets.all(8),
    itemCount:notes.length,
    staggeredTileBuilder:(index)=>StaggeredTile.
    .fit(2) class NotePage {
    crossAxisCount:4,
    mainAxisSpacing:4,
    crossAxisSpacing:4,
    itemBuilder:(context,index){
      final note=notes[index];
      return GestureDetector(
        on onTap: ()async{
await 
Navigator.of(context).push
(MaterialPage(
  child:NoteCardWidget
  (note:note,index:index) ,
  builder:(context)=>
  NoteDetailPage(noteId:note.id!)
));
        },
      );
    }
    }
  );
}
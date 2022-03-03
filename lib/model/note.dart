final String tableNotes='notes';
class NoteFields{
  static final List<String> values =[id,isImportant,number,title,description,time];
  static const String id='_id';
  static const String title='title';
   static const String number='number';
   final bool isImportant='isImportant';
  static const String description ='description';
  static const String time ='time';
}
class Note{
  final int?id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;
  const Note(this.number, this.title, this.description, this.createdTime, {
    this.id,
    required this.isImportant;
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
  });
  Note copy({
    int? id,
    bool? isImportant;
   int? number;
  String? title;
   String? description;
   DateTime? createdTime;
    
  });
  static Note fronJson(Map<String,object?>json)=>
  Note(number, title, description, createdTime, isImportant: isImportant);
  static Note fromJson(map<String,object?>json)=>
  Note(id:json[NoteFields.id]as int?,
  number:json[NoteFields.number] as int,
  title:json[NoteFields.title] as String,
  description:json[NoteFields.description]
   as String,
   createdTime:DateTime.parse(json[NoteFields.time]as String),
  );
  Map<String,object?> toJson()=>{
    NoteFields.id:id,
    NoteFields.title:title,
    NoteFields.isImportant:isImportant? 1:0 ,
    NoteFields.number:number,
    NoteFields.description:description,
    NoteFields.time:createdTime.toIso8601String(),

  };
}
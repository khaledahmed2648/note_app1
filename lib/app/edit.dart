import 'package:flutter/material.dart';
import 'package:note_app/componants/http_helper.dart';
import 'package:note_app/componants/widgets.dart';
import 'package:note_app/constants/LinkAPI.dart';
import 'package:note_app/main.dart';

class EditNote extends StatefulWidget {
  final note;

  const EditNote({Key? key,required this.note}) : super(key: key);
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  var formkey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  editnote()async {
    var response =await HttpHelper.postRequest(url: LinkEdit, data: {
    
      'note_id':widget.note['note_id'].toString() ,
      'content': contentController.text,
      'title': titleController.text
    });
    if (response['status'] == 'success') {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } else {
      print('error while editing');
    }
  }
  
  @override
  void initState() {
    print(widget.note['note_id']);
    // TODO: implement initState
    super.initState();
    titleController.text=widget.note['note_title'];
    contentController.text=widget.note['note_content'];
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                customTextForm(
                    text: 'Note title',
                    myController: titleController,
                    onValidate: (value) {
                      if (value!.length < 5) {
                        return "title must not be less than 5 characters";
                      }
                    }),
                customTextForm(
                    text: 'Note content',
                    myController: contentController,
                    onValidate: (value) {
                      if (value!.length < 5) {
                        return "content must not be less than 5 characters";
                      }
                    }),
                Container(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: ()async {
                  if(formkey.currentState!.validate()){
                     await editnote();
                  }
                  },
                  child: Text('Add'),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  color: Colors.blue,
                  textColor:Colors.white,
                  
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}

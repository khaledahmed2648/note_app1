import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/componants/http_helper.dart';
import 'package:note_app/componants/widgets.dart';
import 'package:note_app/constants/LinkAPI.dart';
import 'package:note_app/main.dart';
import 'dart:io';

class AddNote extends StatefulWidget {
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  var formkey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  XFile? xfile;
  File? file;
  bool isTherePhoto=false;
  addnote() async {
    if (file == null){
      return showDialog(
          context: context,
          builder: (context) =>const AlertDialog(
            content: Text('please add photo'),
          ));
    }
    else{
      var response = await HttpHelper.postRequestWithFile(
        url: LinkAdd,
        data: {
          'id':sharedPref.getString('id'),
          'content': contentController.text,
          'title': titleController.text
        },file: file!);
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);

    }

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
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      xfile = await ImagePicker().pickImage(
                                          source: ImageSource.gallery);
                                      file = File(xfile!.path);
                                      isTherePhoto = true;
                                      Navigator.of(context).pop();
                                      setState(() {

                                      });
                                    },
                                    child: Text('Gallery')),
                                TextButton(
                                    onPressed: () async {
                                      xfile = await ImagePicker().pickImage(
                                          source: ImageSource.camera);
                                      file = File(xfile!.path);
                                      isTherePhoto = true;
                                      setState(() {

                                      });
                                    },
                                    child: Text('camera')),
                              ],
                            ));
                  },
                  child:isTherePhoto?Icon(Icons.done): Text('Add image from'),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  color :isTherePhoto?Colors.green: Colors.blue,
                  textColor: Colors.white,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                       await addnote();
                    }
                  },
                  child: Text('Add'),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  color: Colors.blue,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}

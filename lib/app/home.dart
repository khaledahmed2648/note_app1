import 'package:flutter/material.dart';
import 'package:note_app/app/edit.dart';
import 'package:note_app/componants/http_helper.dart';
import 'package:note_app/componants/widgets.dart';
import 'package:note_app/constants/LinkAPI.dart';
import 'package:note_app/main.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  getNotes() async {
    print(sharedPref.getString('id'));
    var response = await HttpHelper.postRequest(
        url: LinkView, data: {'id': sharedPref.getString('id')});
    return response;
  }

   deletenote({required String noteId,required String noteImage})async {
    var response =await HttpHelper.postRequest(url: LinkDelete, data: {
      'note_id':noteId ,
      'imagename':noteImage
    });
    if (response['status'] == 'success') {
    setState(() {

    });
    } else {
      print('error while deleting');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: FutureBuilder(
          future: getNotes(),
          builder: (BuildContext context, AsyncSnapshot? snapshot) {
            print(snapshot!.data);
            if (snapshot.hasData) {
              if (snapshot.data['status'] == 'fail')
                return Center(
                  child: Text(
                    'you don\'t have any notes',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              else {
                return ListView.builder(
                    itemCount: snapshot.data['data'].length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => buildNoteItem(
                      imageRoot: '${linkImagesRoot}/${ snapshot.data['data'][index]['note_image']}',
                      onDelete: (){
                      showDialog(context: context, builder:(context)=> AlertDialog(
                        content: Text('Do you realy want to delete this note'),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text('cancel')),
                          TextButton(onPressed: ()async{
                           await deletenote(noteId: snapshot.data['data'][index]['note_id'].toString(),noteImage:snapshot.data['data'][index]['note_image'].toString() );
                                                       Navigator.pop(context);

                          }, child: Text('yes')),
                        ],
                      ));
                      },
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditNote(
                                      note: snapshot.data['data'][index])));
                        },
                        title: '${snapshot.data['data'][index]['note_title']}',
                        content: snapshot.data!['data'][index]
                            ['note_content']));
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text(
                  'you don\'t have any notes',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addnote');
        },
      ),
    );
  }
}

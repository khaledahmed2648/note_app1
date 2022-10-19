import 'package:flutter/material.dart';
import 'package:note_app/componants/http_helper.dart';
import 'package:note_app/componants/widgets.dart';
import 'package:note_app/main.dart';

import '../../constants/LinkAPI.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formKey=GlobalKey<FormState>();
var emailController=TextEditingController();
var passController=TextEditingController();
bool isLoading=false;
login()async{
  isLoading=true;
 var responseBody=await HttpHelper.postRequest(url: LinkLogin, data:{
  'email':emailController.text,
  'password':passController.text
}
);
isLoading=false;
if(responseBody!['status']=='success'){
  sharedPref.setString('id', responseBody['data']['user_id'].toString());
  sharedPref.setString('username', responseBody['data']['username']);
  sharedPref.setString('email', responseBody['data']['email']);

    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }
else{
  showDialog(context: context, builder:(context)=> AlertDialog(
   title: Text('alarm'),content: Text('password or email uncorrect or your not found'),
  ));
}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:isLoading?Center(child: CircularProgressIndicator(),): ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: formKey,
                child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Image.asset(
                  'asssets/images/notes.jpg',
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
               customTextForm(text: 'email',myController: emailController,onValidate: (value){
                  if(value!.length<4){
                    return "email must be not less than 4 characters";
                  }
                  
                }),
                customTextForm(text: 'password',myController: passController,onValidate: (value){
                  if(value!.length<4){
                    return "password must be not less than 4 characters";
                  }
                  
                }), MaterialButton(
                  onPressed: ()async {
                    if(formKey.currentState!.validate())
                    {
                    await login();
                    }
                  },
                  child: Text('LOGIN'),
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
                 MaterialButton(
                  onPressed: () {
                 Navigator.of(context).pushNamedAndRemoveUntil('/signup', (route) => false);
                },
                  child: Text('SIGNUP'),
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                  color: Colors.white,
                  textColor: Colors.black,
                ),
              ],
            )),
          )
        ],
      ),
   
    );
  }
}

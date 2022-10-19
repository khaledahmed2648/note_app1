import 'package:flutter/material.dart';
import 'package:note_app/componants/http_helper.dart';
import 'package:note_app/componants/widgets.dart';
import 'package:note_app/constants/LinkAPI.dart';

import '../../main.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var formkey =GlobalKey<FormState>();
var emailController=TextEditingController();
var passController=TextEditingController();
var nameController=TextEditingController();

signup()async{
  var responseBody=await HttpHelper.postRequest(url: LinkSignUp, data:{
  'username':nameController.text,
  'email':emailController.text,
  'password':passController.text
  } );
if(responseBody!['status']=='success'){
   sharedPref.setString('id', responseBody['data']['user_id'].toString());
  sharedPref.setString('username', responseBody['data']['username']);
  sharedPref.setString('email', responseBody['data']['email']);

    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }
  else {
    print('signUp failed');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: formkey,
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
                customTextForm(text: 'username',myController: nameController,onValidate: (value){
                  if(value!.length<4){
                    return "name must be not less than 4 characters";
                  }
                  
                }),
                customTextForm(text: 'email',myController: emailController,onValidate: (value){
                  if(value!.length<4){
                    return "email must be not less than 4 characters";
                  }
                  
                }),
                customTextForm(text: 'password',myController: passController,onValidate: (value){
                  if(value!.length<4){
                    return "password must be not less than 4 characters";
                  }
                  
                }),
                MaterialButton(
                  onPressed: ()async {
                    if(formkey.currentState!.validate()){
                       await signup();
                    }
                 
                  },
                  child: Text('SignUp'),
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
                 MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                  },
                  child: Text('Login'),
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
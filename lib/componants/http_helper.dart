import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class HttpHelper {
  static getRequest({required String url}) async {
    await http.get(Uri.parse(url)).then((value) {
      if (value.statusCode == 200) {
        var responseBody = jsonDecode(value.body);
        return responseBody;
      } else
        print('error: ${value.statusCode}');
    }).catchError((error) {
      print(error.toString());
    });
  }

  static postRequest({required String url, required Map<String, dynamic> data}) async {
    var response;
    await http.post(Uri.parse(url), body: data).then((value) {
      response = value;
    }).catchError((error) {
      print(error.toString());
    });
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      return responseBody;
    } else
      print('error: ${response.statusCode}');
  }

  // static postRequest({required String url,required Map<String,dynamic>data})async{
  //   var response;
  //   await http.post(Uri.parse(url),body: data).then((value){
  //     response=value;
  //   }).catchError((error){
  //     print (error.toString());
  //   });
  //   if(response.statusCode==200){
  //     print(jsonDecode(response.body));
  //     return jsonDecode(response.body);
  //   }
  //   else print('error : ${response.statusCode}');

  // }

  // static postRequestWithFile({required String url, required Map<String,dynamic> data,required File file})async{
  //   var request =http.MultipartRequest('POST',Uri.parse(url));
  //   var fileLentgth=await file.length();
  //   var fileStream=http.ByteStream(file.openRead());
  //   var multiPartFile=http.MultipartFile('file',fileStream,fileLentgth,filename: basename(file.path));
  //   request.files.add(multiPartFile);
  //   data.forEach((key, value) {
  //     request.fields[key]=value;
  //   });
  //  var myrequest=await request.send().then((value){
    
  //  });
  //  http.Response response=await http.Response.fromStream(myrequest);

  // if(response.statusCode==200){
  //   var responseBody=jsonDecode(response.body);
  //   return responseBody;
  // }
  // else return 'error ${response.statusCode}';

  //  }
  // static postRequestWithFile({required String url, required Map<String,dynamic> data, required File file})async{
  //   var request=http.MultipartRequest('POST',Uri.parse(url));
  //   var multipartFile=http.MultipartFile('file',http.ByteStream(file.openRead()),await file.length(),filename: basename(file.path));
  //   request.files.add(multipartFile);
  //   data.forEach((key, value) {
  //     request.fields[key]=value;

  //   });
  //   var myrequest=await request.send();
  //   var response=await http.Response.fromStream(myrequest);
  // }
  //  static postRequestWithFile({required String url,required Map<String,dynamic> data,required File file})async{
  //   var request=http.MultipartRequest('POST',Uri.parse(url));
  //   var multipartFile=http.MultipartFile('file',http.ByteStream(file.openRead()),await file.length(),filename:basename(file.path));
  //   request.files.add(multipartFile);
  //   data.forEach((key, value) {
  //     request.fields[key]=value;
  //   });
  //    var response =http.Response.fromStream(await request.send());
  //  }

  static postRequestWithFile(
      {required String url,
      required Map<String, dynamic> data,
      required File file}) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    var multipartfile = http.MultipartFile(
        'file', http.ByteStream(file.openRead()), await file.length(),
        filename: basename(file.path));
        request.files.add(multipartfile);
        data.forEach((key, value) {
          request.fields[key]=value;
        });
        var response= await http.Response.fromStream(await request.send());

        if(response.statusCode==200){
          return response.body;
        }else{
          return 'error: ${response.statusCode}';
        }

  }
}

import 'package:flutter/material.dart';

import '../constants/LinkAPI.dart';

Widget customTextForm(
        {required String text,
        required TextEditingController myController,
        required String? Function(String?) onValidate}) =>
    Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        controller: myController,
        validator: onValidate,
        decoration: InputDecoration(
            hintText: text,
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black, width: 1),
            )),
      ),
    );

Widget buildNoteItem(
        {required String imageRoot,
        required String title,
        required String content,
        required void Function()? ontap,
        required void Function()? onDelete}) =>
    ListTile(
      onTap: ontap,
      leading: Image.network(
        imageRoot,
        fit: BoxFit.cover,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
      title: Text(title),
      subtitle: Text(content),
    );

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ViewNote extends StatefulWidget {
  final Map data;
  final DocumentReference ref;
  ViewNote(this.data, this.ref);
  @override
  _ViewNoteState createState() => _ViewNoteState();
}
class _ViewNoteState extends State<ViewNote> {
  String title;
  String des;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(
              12.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 24.0,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey[700],
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                    ),
                    //
                    ElevatedButton(
                      onPressed: delete,
                      child: Icon(
                        Icons.delete_forever,
                        size: 24.0,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.red[300],
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.data['title']}",
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${widget.data['description']}",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void delete() async {
    await widget.ref.delete();
    Navigator.pop(context);
  }
}
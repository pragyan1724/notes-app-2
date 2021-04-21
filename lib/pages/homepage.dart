import 'package:mynotes/pages/login.dart';
import 'package:mynotes/controller/google_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/pages/addnote.dart';
import 'package:mynotes/pages/viewnote.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('notes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        centerTitle: true,
        title: Text('notes_app'),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.exit_to_app),
            label: Text('sign out'),
            onPressed: (){
              signOutUser().whenComplete(() => Navigator.push(context,MaterialPageRoute(builder: (_)=>LoginPage())));
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNote(),),).then((value)
          {
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.grey[700],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Map data = snapshot.data.docs[index].data();
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute( builder: (context) => ViewNote(
                          data,
                          snapshot.data.docs[index].reference,
                        ),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data['title']}",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
    );
  }
}

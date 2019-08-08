import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CloudManager extends StatefulWidget {
  AsyncSnapshot<QuerySnapshot> querySnapshot;
  @override
  _CloudManagerState createState() => _CloudManagerState();

  void vote() {
    for (var data in querySnapshot.data.documents) {
      final record = Record.fromSnapshot(data);
      record.reference.updateData({'votes': record.votes + 1});
    }
  }
}

class _CloudManagerState extends State<CloudManager> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('baby').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          print(snapshot);
          widget.querySnapshot = snapshot;

          return Container();
        });
  }
}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;
  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];
  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
  @override
  String toString() => "Record<$name:$votes>";
}

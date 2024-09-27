import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreen extends StatelessWidget {
  final CollectionReference expenseCollection = FirebaseFirestore.instance.collection('expenses');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expense Tracker')),
      body: StreamBuilder(
        stream: expenseCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['amount'].toString()),
                subtitle: Text(doc['date']),
                trailing: Text(doc['type']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

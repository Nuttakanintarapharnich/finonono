import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  String selectedType = 'รายรับ'; // or 'รายจ่าย'

  Future<void> addExpense() async {
    await FirebaseFirestore.instance.collection('expenses').add({
      'amount': double.parse(amountController.text),
      'date': DateTime.now().toString(),
      'type': selectedType,
      'note': noteController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: Column(
        children: [
          TextField(controller: amountController, decoration: InputDecoration(labelText: 'Amount')),
          DropdownButton<String>(
            value: selectedType,
            items: ['รายรับ', 'รายจ่าย'].map((type) {
              return DropdownMenuItem(value: type, child: Text(type));
            }).toList(),
            onChanged: (value) {
              selectedType = value!;
            },
          ),
          TextField(controller: noteController, decoration: InputDecoration(labelText: 'Note')),
          ElevatedButton(
            onPressed: addExpense,
            child: Text('Add Expense'),
          ),
        ],
      ),
    );
  }
}

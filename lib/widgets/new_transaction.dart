import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  // expeting a function
  final Function addTx;
  NewTransaction(this.addTx);
  // Declaring controllers to save momentanely values from input
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    addTx(enteredTitle, enteredAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_val) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_val) => submitData(),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.purple,
              ),
              onPressed: submitData,
              child: Text('Add transaction'),
            )
          ],
        ),
      ),
    );
  }
}

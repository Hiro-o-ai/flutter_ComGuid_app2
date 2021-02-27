import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx);

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
      // CardWidget use only margin not padding
      // margin: EdgeInsets.all(10),
      elevation: 5,
      // ColumnWidget is wraped ContainerWidget because CardWidget and ColumnWidget isn't userful margin and padding
      // We wanna put space between CardWidget and TextFieldWidget
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          // ColumnWidget isn't use margin and padding
          children: <Widget>[
            TextField(
              // InputDecoration is many propaty for example add varidation etc
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData,
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              // In iOS is not allow decimalplaces. if use it, you select TextInputType.numberWithOptions(decimal: true)
              // so if you wanna make android and iOS application, you selected numberWith ...
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData,
              // onChanged: (val) => amountInput = val,
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx);

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
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              // onChanged: (val) => amountInput = val,
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: () {
                addTx(
                    titleController.text, double.parse(amountController.text));
              },
            )
          ],
        ),
      ),
    );
  }
}

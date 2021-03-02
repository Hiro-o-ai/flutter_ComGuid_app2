import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        // accentColorなどを使用することで一部のWidgetがamber、他はpurpleといった具合となる
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        // ThemeDataによってそのままfloatingactionbuttonの色の変更は非推奨なので、自分で変更した
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          // 十字の部分の色
          foregroundColor: Colors.white,
          // ボタンの大部分の色
          backgroundColor: Colors.amber,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // They are keystroke for textField
  // String titleInput;
  // String amountInput;
  // final titleController = TextEditingController();
  // final amountController = TextEditingController();

  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // )
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        // GestureDetectorはshowModalの子widgetがない部分をタッチするとModalが閉じるしようなのでそれを防ぐためらしいが、そんなことが起きない。。。
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
          // こちらの方がMaterialAppのtheme:のfontfamilyよりも優先される
          // style: TextStyle(fontFamily: 'OpenSans'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      // 並んだWigetが端末の縦サイズを超えたらスクロールする
      // しなかった場合のエラー文
      // The specific RenderFlex in question is: RenderFlex#67c92 relayoutBoundary=up1 OVERFLOWING
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('CHART!'),
                elevation: 5,
              ),
            ),
            TransactionList(_userTransaction),
          ],
        ),
      ),
      // floatingActionButtonは画面のwidgetと重なってもエラーとならない。おそらくレイヤーがことなり、Scaffoldのbodyの上にあると思われる
      // widgettree上ではappbarと同じ海藻にある
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print('build() TransactionList');
    return
        // ListViewはColumnとSingleChildScrollViewを合わせたもの
        // ただし、親のContainerがないとリストは表示されないし、エラーとなる
        // なぜならListViewは画面全体に表示させようとするが、画面上では上にwidgetが存在するため、画面サイズよりも大きくなるため
        transactions.isEmpty
            ? LayoutBuilder(
                builder: (ctx, constraints) {
                  return Column(
                    children: <Widget>[
                      Text(
                        'No transactions added yet!',
                        style: Theme.of(context).textTheme.title,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/image/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  );
                },
              )
            : ListView.builder(
                // itemBuilderがないと膨大な量があることを前提に動くので、それを防ぐため
                itemBuilder: (ctx, index) {
                  return TransactionItem(
                      transaction: transactions[index], deleteTx: deleteTx);
                  // return Card(
                  //   child: Row(
                  //     children: <Widget>[
                  //       Container(
                  //         margin:
                  //             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  //         decoration: BoxDecoration(
                  //           border: Border.all(
                  //             color: Theme.of(context).primaryColor,
                  //             width: 2,
                  //           ),
                  //         ),
                  //         padding: EdgeInsets.all(10),
                  //         child: Text(
                  //           // '\$' + tx.amount.toString(),
                  //           '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 20,
                  //             // Them.of(context).primaryColorで親widgetに設定した色を使用する
                  //             // ただし、しようしない場合は黒
                  //             // primaryColorDarkなどでprimaryColorの濃淡が変わる
                  //             color: Theme.of(context).primaryColor,
                  //           ),
                  //         ),
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //           Text(transactions[index].title,
                  //               // textthmeのtitle:を使用
                  //               style: Theme.of(context).textTheme.title
                  //               // TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  //               ),
                  //           Text(
                  //             // intlpacage
                  //             // pattern1
                  //             // DateFormat('yyyy/MM/dd').format(tx.date),
                  //             // pattern2
                  //             DateFormat.yMMMd().format(transactions[index].date),
                  //             style: TextStyle(color: Colors.grey),
                  //           ),
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // );
                },
                itemCount: transactions.length,
              );
  }
}

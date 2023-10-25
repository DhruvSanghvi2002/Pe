import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(
    this.transactions,
    this.deleteTx,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(children: [
              Text(
                'No transaction added yet',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  height: 200,
                  child: Image.asset('image/waiting.png', fit: BoxFit.cover))
            ])
          : ListView(
              children: transactions.map((tx) {
              return Card(
                  child: Row(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 2,
                        color: Theme.of(context).primaryColor,
                      )),
                      child: Text(
                        '\$${tx.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                      )),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FittedBox(
                          child: Text(tx.title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        Text(DateFormat().format(tx.date),
                            style: TextStyle(color: Colors.grey)),
                      ]),
                  Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).primaryColor,
                        // style: IconButton.styleFrom(
                        //     foregroundColor:
                        //         const Color.fromARGB(255, 206, 233, 30)),
                        onPressed: () => deleteTx(tx.id.toString()),
                      )),
                ],
              ));
            }).toList()),
    );
  }
}

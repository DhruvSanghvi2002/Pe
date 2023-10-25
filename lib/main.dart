import 'package:flutter/material.dart';
import "./widgets/transaction_list.dart";
import "./widgets/new_transaction.dart";
import "./models/transaction.dart";
import "./widgets/chart.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSwatch().copyWith(
      //     primary: Colors.yellow,
      //     secondary: Colors.red,
      //   ),
      // ),

      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Color.fromARGB(255, 219, 67, 56),
          ),
          primaryColor: Color.fromARGB(255, 249, 44, 99),
          fontFamily: 'OpenSans',
          textTheme: TextTheme(titleMedium: TextStyle(color: Colors.pink))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? titleInput;
  String? amountInput;
  final List<Transaction> _userTransactions = [
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
    // ),
  ];
  Iterable<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    });
  }

  void _addNewTransactions(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: chosenDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void deleteTransaction(String id) {
    print(_userTransactions);
    print(_userTransactions.length);
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
              child: NewTransaction(_addNewTransactions),
              behavior: HitTestBehavior.opaque);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Personal Expenses"),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add,
                ),
                onPressed: () => _startAddNewTransaction(context))
          ],
        ),
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Chart(_recentTransactions.toList()),
          TransactionList(_userTransactions, deleteTransaction)
        ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context)));
  }
}

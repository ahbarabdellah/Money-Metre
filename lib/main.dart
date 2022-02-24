import 'package:flutter/material.dart';
import 'package:money/widgets/chart.dart';
import 'widgets/newTransaction.dart';
import 'widgets/listTransaction.dart';
import 'models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Money Metre',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.amber,
            fontFamily: 'Quicksand'),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    //Transaction(id: '1', title: 'shoes', amount: 310.99, date: DateTime.now()),
    //Transaction(id: '2', title: 'grocries', amount: 17.69, date: DateTime.now()),
  ];

  List<Transaction> get _recentTranscation {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  addTransaction(String txtitle, double txamount, DateTime txdate) {
    setState(() {
      _userTransactions.add(Transaction(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: txamount,
        date: txdate,
      ));
      Navigator.of(context).pop();
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: NewTransaction(
            _userTransactions,
            addTransaction,
          ),
        );
      },
    );
  }

  void _removetx(idx) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                startAddNewTransaction(context);
              },
              icon: Icon(Icons.add))
        ],
        centerTitle: true,
        title: const Text('Money Metre'),
      ),
      body: Container(
        child: Column(
          children: [
            Chart(_recentTranscation),
            const SizedBox(
              height: 10,
            ),
            ListTransaction(_userTransactions, _removetx),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startAddNewTransaction(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

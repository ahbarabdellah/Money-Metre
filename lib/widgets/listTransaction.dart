import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class ListTransaction extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function remvtx;
  ListTransaction(this.userTransactions, this.remvtx);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: userTransactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  const Text(
                    'No transactions yet !',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    r'assets\images\noTransactions.png',
                  )
                ])
          : ListView.builder(
              itemCount: userTransactions.length,
              itemBuilder: (ctx, index) {
                return Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 100,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8.0),
                  child: Card(
                    elevation: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          width: 100,
                          height: 100,
                          child: CircleAvatar(
                            backgroundColor: Colors.purple,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              alignment: Alignment.center,
                              width: 100,
                              height: 100,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '\$${userTransactions[index].amount}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 60,
                          width: 150,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  userTransactions[index].title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    '${DateFormat.yMMMd().format(userTransactions[index].date)}',
                                    style: const TextStyle(
                                      fontFamily: 'OpenSans',
                                      //'${userTransactions[index].date}'

                                      color: Color.fromARGB(255, 88, 87, 87),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            iconSize: 40,
                            onPressed: () => remvtx(userTransactions[index].id),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

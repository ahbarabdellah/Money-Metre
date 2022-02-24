import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class NewTransaction extends StatefulWidget {
  final List<Transaction> userTransaction;
  final Function addTransaction;
  NewTransaction(this.userTransaction, this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleControler = TextEditingController();
  final TextEditingController amountControler = TextEditingController();
  DateTime? selectedDate;

  void submitData() {
    if (titleControler.text.isEmpty) {
      return;
    }
    if (amountControler.text.isEmpty) {
      return;
    }
    final enteredTitle = titleControler.text;
    final enteredAmount = double.parse(amountControler.text);

    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        selectedDate.toString() == 'null') {
      return;
    }

    widget.addTransaction(enteredTitle, enteredAmount, selectedDate);
  }

  void _pickDate(
    ctx,
  ) {
    showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 356)),
      lastDate: DateTime.now().subtract(const Duration(days: -356)),
    ).then((value) {
      if (value == 'null') {
        return;
      }
      setState(() {
        selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 3,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
                keyboardType: TextInputType.name,
                controller: titleControler,
                onSubmitted: (_) => submitData(),
                decoration: const InputDecoration(labelText: 'Title')),
            TextField(
                keyboardType: TextInputType.number,
                controller: amountControler,
                onSubmitted: (_) => submitData(),
                decoration: const InputDecoration(labelText: 'Price')),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate.toString() == 'null'
                          ? 'No Date Chossen !'
                          : DateFormat.yMEd().format(selectedDate!),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () => _pickDate(context),
                        child: const Text('Chose Date'))
                  ]),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              child: const Text(
                'Add transaction',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                widget.addTransaction(
                  titleControler.text,
                  double.parse(amountControler.text),
                  selectedDate,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(BudgetTrackerApp());

class BudgetTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      initialRoute: '/app',
      routes: {
        '/app': (context) => HomeScreen(),
        '/expense': (context) => ExpenseScreen(),
        '/addExpense': (context) => AddExpenseScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '@username';
  List<String> topics = ['Groceries', 'Transport', 'Entertainment'];
  List<double> amounts = [100.0, 200.0, -50.0]; // Example initial expenses

  double getTotalExpense() {
    return amounts.fold(0, (previousValue, element) => previousValue + element);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Budget Tracker')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Hi, $userName',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Total Expenses This Month',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('₹${getTotalExpense().toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(topics[index]),
                subtitle: Text('₹${amounts[index].toStringAsFixed(2)}'),
                trailing: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      topics.removeAt(index);
                      amounts.removeAt(index);
                    });
                  },
                  child: Text('Delete'),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Add Topic'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'Topic Name'),
                        onChanged: (value) {},
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Amount'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          topics.add('New Topic');
                          amounts.add(0.0);
                        });
                        Navigator.pop(context);
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}

class ExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expenses')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ListTile(
          title: Text('Expense $index'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addExpense'),
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Expense Value'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add expense logic
              },
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}

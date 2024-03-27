import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:function_tree/function_tree.dart';

void main() {
  runApp(const CalculatorApp());
}

class _HistoryState extends State<History> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _calculations = [];

  @override
  void initState() {
    super.initState();
    _firestore
        .collection('calculationHistory')
        .orderBy('timestamp')
        .limit(10)
        .get()
        .then((querySnapshot) {
      setState(() {
        _calculations = querySnapshot.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go back'))
      ]),
      body: ListView.builder(
        itemCount: _calculations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'Calculation ${index + 1}',
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              '${_calculations[index]['calculationData']['currentValue']} + ${_calculations[index]['calculationData']['storedValue']} = ${_calculations[index]['calculationData']['currentValue'] + _calculations[index]['calculationData']['storedValue']}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.black,
        hintColor: Colors.white,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  String _input = '';
  String _output = '0';
  double _resultFontSize = 48.0;
  double _expressionFontSize = 24.0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  double currentValue = 0;
  double storedValue = 0;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _input = '';
        _output = '0';
      } else if (buttonText == '=') {
        _output = _input.interpret().toString();
        final calculationData = {
          'currentValue': _input,
          'storedValue': _output
        };
        _firestore
            .collection('calculationHistory')
            .add({'calculationData': calculationData});
      } else {
        _input += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout)),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const History()),
                );
              },
              child: const Text('View history'))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _input,
                style: TextStyle(fontSize: _expressionFontSize),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(
                    fontSize: _resultFontSize, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          _buildButtonRow(['7', '8', '9', '/']),
          _buildButtonRow(['4', '5', '6', '*']),
          _buildButtonRow(['1', '2', '3', '-']),
          _buildButtonRow(['C', '0', '=', '+']),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((buttonText) {
          return _buildButton(buttonText);
        }).toList(),
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: InkWell(
        onTap: () => _onButtonPressed(buttonText),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          margin: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(fontSize: 24.0),
            ),
          ),
        ),
      ),
    );
  }
}

class History extends StatefulWidget {
  const History({super.key});
  @override
  _HistoryState createState() => _HistoryState();
}

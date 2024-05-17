import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compound Interest Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Config> loadConfig() async {
    final jsonString = await rootBundle.loadString('assets/config.json');
    final jsonResponse = json.decode(jsonString);
    return Config.fromJson(jsonResponse);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Config>(
      future: loadConfig(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Error loading configuration')));
        }
        final config = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: Text('Compound Interest Calculator'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CalculatorForm(config: config!),
          ),
        );
      },
    );
  }
}

class CalculatorForm extends StatefulWidget {
  final Config config;

  CalculatorForm({required this.config});

  @override
  _CalculatorFormState createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<CalculatorForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _principalController = TextEditingController();

  int _selectedRate = 1;
  int _selectedTimes = 1;
  int _selectedYears = 1;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Rate of Interest Dropdown
          DropdownButtonFormField<int>(
            decoration: InputDecoration(labelText: widget.config.rateOfInterest.labelText),
            value: _selectedRate,
            items: widget.config.rateOfInterest.values.map((item) {
              return DropdownMenuItem<int>(
                value: item.value,
                child: Text(item.label),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedRate = value!;
              });
            },
          ),
          // Principal Amount Text Field
          TextFormField(
            controller: _principalController,
            decoration: InputDecoration(
              labelText: widget.config.principalAmount.hintText,
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              final principal = int.tryParse(value!);
              if (principal == null) {
                return 'Please enter a valid number';
              }
              final minAmount = widget.config.principalAmount.minAmount[_selectedRate.toString()];
              if (principal < minAmount! || principal > widget.config.principalAmount.maxAmount) {
                return widget.config.principalAmount.errorMessage;
              }
              return null;
            },
          ),
          // Times to Compound Dropdown
          DropdownButtonFormField<int>(
            decoration: InputDecoration(labelText: widget.config.timesToCompound.labelText),
            value: _selectedTimes,
            items: widget.config.timesToCompound.values[_selectedRate.toString()]?.map((item) {
              return DropdownMenuItem<int>(
                value: item,
                child: Text('$item'),
              );
            })?.toList() ?? widget.config.timesToCompound.values['default']?.map((item) {
              return DropdownMenuItem<int>(
                value: item,
                child: Text('$item'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedTimes = value!;
              });
            },
          ),
          // Number of Years Dropdown
          DropdownButtonFormField<int>(
            decoration: InputDecoration(labelText: widget.config.numberOfYears.labelText),
            value: _selectedYears,
            items: widget.config.numberOfYears.values[_selectedTimes.toString()]?.map((item) {
              return DropdownMenuItem<int>(
                value: item,
                child: Text('$item'),
              );
            })?.toList() ?? widget.config.numberOfYears.values['default']?.map((item) {
              return DropdownMenuItem<int>(
                value: item,
                child: Text('$item'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedYears = value!;
              });
            },
          ),
          SizedBox(height: 20),
          // Submit Button
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final principal = int.parse(_principalController.text);
                final rate = _selectedRate / 100;
                final times = _selectedTimes;
                final years = _selectedYears;
                final amount = principal * (pow((1 + rate / times), (times * years)));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Future Value: $amount')),
                );
              }
            },
            child: Text('Calculate'),
          ),
        ],
      ),
    );
  }
}
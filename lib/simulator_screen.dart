import 'package:flutter/material.dart';

// https://medium.com/flutterpub/sample-form-part-2-flutter-c19e9f37ac41
// https://www.youtube.com/watch?v=4NhLLmrB4I4

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final controllerPanels = new TextEditingController();
  final controllerInclination = new TextEditingController();
  final controllerAzimut = new TextEditingController();
  final calculatorFormKey = GlobalKey<FormState>();

  int _selectedLocation = 0;
  int _selectedWattPeak = 0;

  List<DropdownMenuItem<int>> locationList = [];
  List<DropdownMenuItem<int>> wattPeakList = [];

  void loadLocationList() {
    locationList = [];
    locationList.add(new DropdownMenuItem(
      child: new Text('Flanders'),
      value: 0,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text('Wallonia'),
      value: 1,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text('Brussels'),
      value: 2,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text('Luxembourg'),
      value: 3,
    ));
  }

  void loadWattPeakList() {
    wattPeakList = [];
    wattPeakList.add(new DropdownMenuItem(
      child: new Text('295'),
      value: 0,
    ));
    wattPeakList.add(new DropdownMenuItem(
      child: new Text('320'),
      value: 1,
    ));
    wattPeakList.add(new DropdownMenuItem(
      child: new Text('350'),
      value: 2,
    ));
  }

  String textToShow = "";

  void sum() {
    if (calculatorFormKey.currentState.validate()) {
      int panels = int.parse(controllerPanels.text);
      int inclination = int.parse(controllerInclination.text);
      int azimut = int.parse(controllerAzimut.text);
      int result = panels + inclination + azimut;

      setState(() {
        textToShow = "$panels + $inclination +$azimut +$_selectedLocation +$_selectedWattPeak = $result";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    loadLocationList();
    loadWattPeakList();
    return Scaffold(
      body: Form(
        key: calculatorFormKey,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: controllerPanels,
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(hintText: "Howpany panels can you place?"),
                validator: (value) {
                  if (value.isEmpty) return "Please enter a number";
                },
              ),
              TextFormField(
                controller: controllerInclination,
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(hintText: "What is your inclination?"),
                validator: (value) {
                  if (value.isEmpty)
                    return "Please enter a number between 0 and 90 degrees";
                },
              ),
              TextFormField(
                controller: controllerAzimut,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "What is your azimut?"),
                validator: (value) {
                  if (value.isEmpty)
                    return "Please enter a number between 0 and 360 degrees";
                },
              ),
              Text('Select your location'),
              Container(
                height: 50,
                child: ListView(
                  children: getLocationFormWidget(),
                ),
              ),
              Text('Select your watt peak'),
              Container(
                height: 50,
                child: ListView(
                  children: getWattPeakFormWidget(),
                ),
              ),
              Text(textToShow, style: TextStyle(fontSize: 20.0)),
              RaisedButton(
                onPressed: sum,
                child: Text('Conclusion'),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getLocationFormWidget() {
    List<Widget> formWidget = new List();

    formWidget.add(new DropdownButton(
      
      hint: new Text('Select location'),
      items: locationList,
      value: _selectedLocation,
      onChanged: (value) {
        setState(() {
          _selectedLocation = value;
        });
      },
      isExpanded: false,
    ));

    return formWidget;
  }

  List<Widget> getWattPeakFormWidget() {
    List<Widget> formWidget = new List();

    formWidget.add(new DropdownButton(
      
      hint: new Text('Select watt peak'),
      items: wattPeakList,
      value: _selectedWattPeak,
      onChanged: (value) {
        setState(() {
          _selectedWattPeak = value;
        });
      },
      isExpanded: false,
    ));

    return formWidget;
  }
}

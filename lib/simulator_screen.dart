import 'package:flutter/material.dart';

// https://medium.com/flutterpub/sample-form-part-2-flutter-c19e9f37ac41
// https://www.youtube.com/watch?v=4NhLLmrB4I4

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final calculatorFormKey = GlobalKey<FormState>();
  final controllerPanels = new TextEditingController();

  int _selectedInclination = 35;
  int _selectedAzimut = 0;
  int _selectedLocation = 0;
  int _selectedWattPeak = 0;

  int factor = 100;

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
      child: new Text('Viessmann VITOVOLT 280Wp blue'),
      value: 0,
    ));
    wattPeakList.add(new DropdownMenuItem(
      child: new Text('Viessmann VITOVOLT 300Wp black'),
      value: 1,
    ));
    wattPeakList.add(new DropdownMenuItem(
      child: new Text('Viessmann VITOVOLT 305Wp blue'),
      value: 2,
    ));
    wattPeakList.add(new DropdownMenuItem(
      child: new Text('SunPower HighPower P19 320Wp black'),
      value: 3,
    ));
    wattPeakList.add(new DropdownMenuItem(
      child: new Text('SunPower HighPower MAX2 360Wp black'),
      value: 4,
    ));
    wattPeakList.add(new DropdownMenuItem(
      child: new Text('SunPower HighPower MAX3 375Wp black'),
      value: 5,
    ));
    wattPeakList.add(new DropdownMenuItem(
      child: new Text('SunPower HighPower MAX3 390Wp black'),
      value: 6,
    ));
  }

  String textToShowMaxPower = "";
  String textToShowEstimatedPower = "";

  

  @override
  Widget build(BuildContext context) {
    loadLocationList();
    loadWattPeakList();
    return Scaffold(
      body: Form(
        key: calculatorFormKey,
        child: SafeArea(
          child: Column(
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
              Text('Select your inclination'),
              Slider(
                value: _selectedInclination.toDouble(),
                min: 0.0,
                max: 90.0,
                divisions: 18,
                activeColor: Colors.red,
                inactiveColor: Colors.black,
                label: 'Set a value',
                onChanged: (double newValue) {
                  setState(() {
                    _selectedInclination = newValue.round();
                  });
                },
              ),
              Text(
                'Value: ${(_selectedInclination).round()}',
              ),
              Text('Select your azimut'),
              Slider(
                value: _selectedAzimut.toDouble(),
                min: -90.0,
                max: 90.0,
                divisions: 36,
                activeColor: Colors.red,
                inactiveColor: Colors.black,
                label: 'Set a value',
                onChanged: (double newValue) {
                  setState(() {
                    _selectedAzimut = newValue.round();
                  });
                },
              ),
              Text(
                'Value: ${(_selectedAzimut).round()}',
              ),
              Text('Efficiency: ${factor}'),
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
              Text(textToShowMaxPower, style: TextStyle(fontSize: 12.0)),
              Text(textToShowEstimatedPower, style: TextStyle(fontSize: 12.0)),
              RaisedButton(
                onPressed: solarSimulation,
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

  void solarSimulation() {
    if (calculatorFormKey.currentState.validate()) {
      int panels = int.parse(controllerPanels.text);
      int location;
      int wattPeak;

      if (_selectedLocation == 0) {
        location = 93;
      } else if (_selectedLocation == 1) {
        location = 95;
      } else if (_selectedLocation == 2) {
        location = 93;
      } else if (_selectedLocation == 3) {
        location = 95;
      }

      if (_selectedWattPeak == 0) {
        wattPeak = 280;
      } else if (_selectedWattPeak == 1) {
        wattPeak = 300;
      } else if (_selectedWattPeak == 2){
        wattPeak = 305;
      } else if (_selectedWattPeak == 3){
        wattPeak = 320;
      } else if (_selectedWattPeak == 4){
        wattPeak = 360;
      } else if (_selectedWattPeak == 5){
        wattPeak = 375;
      } else if (_selectedWattPeak == 6){
        wattPeak = 390;
      }

      if (_selectedInclination == 0) {
        factor = 87;  
    } else if (_selectedInclination == 5 && _selectedAzimut <= -85) {
        factor = 88;
        
    } else if (_selectedInclination == 5 && (_selectedAzimut >= -80 && _selectedAzimut <= -70)) {
        factor = 89;
        
    } else if (_selectedInclination == 5 && (_selectedAzimut >= -65 && _selectedAzimut <= -55)) {
        factor = 90;
        
    } else if (_selectedInclination == 5 && (_selectedAzimut >= -50 && _selectedAzimut <= -10)) {
        factor = 91;
        
    } else if (_selectedInclination == 5 && (_selectedAzimut >= -5 && _selectedAzimut <= 5)) {
        factor = 92;
        
    } else if (_selectedInclination == 5 && (_selectedAzimut >= 10 && _selectedAzimut <= 45)) {
        factor = 91;
        
    } else if (_selectedInclination == 5 && (_selectedAzimut >= 50 && _selectedAzimut <= 60)) {
        factor = 90;
        
    } else if (_selectedInclination == 5 && (_selectedAzimut >= 65 && _selectedAzimut <= 75)) {
        factor = 91;
        
    } else if (_selectedInclination == 5 && _selectedAzimut == 80) {
        factor = 90;
        
    } else if (_selectedInclination == 5 && (_selectedAzimut >= 85 && _selectedAzimut <= 90)) {
        factor = 89;
        
    }

    //helling 10
    else if (_selectedInclination == 10 && _selectedAzimut == -90) {
        factor = 89;
        
    } else if (_selectedInclination == 10 && _selectedAzimut == -85) {
        factor = 90;
        
    } else if (_selectedInclination == 10 && (_selectedAzimut >= -80 && _selectedAzimut <= -70)) {
        factor = 91;
        
    } else if (_selectedInclination == 10 && (_selectedAzimut >= -65 && _selectedAzimut <= -60)) {
        factor = 92;
        
    } else if (_selectedInclination == 10 && _selectedAzimut == -55) {
        factor = 93;
        
    } else if (_selectedInclination == 10 && (_selectedAzimut >= -50 && _selectedAzimut <= -40)) {
        factor = 94;
        
    } else if (_selectedInclination == 10 && (_selectedAzimut >= -35 && _selectedAzimut <= -10)) {
        factor = 95;
        
    } else if (_selectedInclination == 10 && (_selectedAzimut >= -5 && _selectedAzimut <= 5)) {
        factor = 96;
        
    } else if (_selectedInclination == 10 && (_selectedAzimut >= 10 && _selectedAzimut <= 35)) {
        factor = 95;
        
    } else if (_selectedInclination == 10 && (_selectedAzimut >= 40 && _selectedAzimut <= 50)) {
        factor = 94;
        
    } else if (_selectedInclination == 10 && (_selectedAzimut >= 55 && _selectedAzimut <= 65)) {
        factor = 93;
        
    } else if (_selectedInclination == 10 && _selectedAzimut == 70) {
        factor = 92;
        
    } else if (_selectedInclination == 10 && (_selectedAzimut >= 75 && _selectedAzimut <= 80)) {
        factor = 91;
        
    } else if (_selectedInclination == 10 && (_selectedAzimut >= 85 && _selectedAzimut <= 90)) {
        factor = 90;
        
    }

    //helling 15
    else if (_selectedInclination == 15 && _selectedAzimut == -90) {
        factor = 89;
        
    } else if (_selectedInclination == 15 && _selectedAzimut == -85) {
        factor = 90;
        
    } else if (_selectedInclination == 15 && (_selectedAzimut >= -80 && _selectedAzimut <= -70)) {
        factor = 91;
        
    } else if (_selectedInclination == 15 && (_selectedAzimut >= -65 && _selectedAzimut <= -60)) {
        factor = 93;
        
    } else if (_selectedInclination == 15 && _selectedAzimut == -55) {
        factor = 94;
        
    } else if (_selectedInclination == 15 && (_selectedAzimut >= -50 && _selectedAzimut <= -40)) {
        factor = 95;
        
    } else if (_selectedInclination == 15 && (_selectedAzimut >= -35 && _selectedAzimut <= -25)) {
        factor = 96;
        
    } else if (_selectedInclination == 15 && (_selectedAzimut >= -20 && _selectedAzimut <= 20)) {
        factor = 97;
        
    } else if (_selectedInclination == 15 && (_selectedAzimut >= 25 && _selectedAzimut <= 35)) {
        factor = 96;
        
    } else if (_selectedInclination == 15 && (_selectedAzimut >= 40 && _selectedAzimut <= 50)) {
        factor = 95;
        
    } else if (_selectedInclination == 15 && (_selectedAzimut >= 55 && _selectedAzimut <= 60)) {
        factor = 94;
        
    } else if (_selectedInclination == 15 && _selectedAzimut == 65) {
        factor = 93;
        
    } else if (_selectedInclination == 15 && _selectedAzimut == 70) {
        factor = 92;
        
    } else if (_selectedInclination == 15 && (_selectedAzimut >= 75 && _selectedAzimut <= 80)) {
        factor = 91;
        
    } else if (_selectedInclination == 15 && _selectedAzimut == 85) {
        factor = 90;
        
    } else if (_selectedInclination == 15 && _selectedAzimut == 90) {
        factor = 89;
        
    }

    //helling 20
    else if (_selectedInclination == 20 && _selectedAzimut == -90) {
        factor = 87;
        
    } else if (_selectedInclination == 20 && _selectedAzimut == -85) {
        factor = 88;
        
    } else if (_selectedInclination == 20 && _selectedAzimut == -80) {
        factor = 89;
        
    } else if (_selectedInclination == 20 && _selectedAzimut == -75) {
        factor = 90;
        
    } else if (_selectedInclination == 20 && _selectedAzimut == -70) {
        factor = 91;
        
    } else if (_selectedInclination == 20 && _selectedAzimut == -65) {
        factor = 92;
        
    } else if (_selectedInclination == 20 && _selectedAzimut == -60) {
        factor = 93;
        
    } else if (_selectedInclination == 20 && _selectedAzimut == -55) {
        factor = 94;
        
    } else if (_selectedInclination == 20 && _selectedAzimut == -50) {
        factor = 95;
        
    } else if (_selectedInclination == 20 && (_selectedAzimut >= -45 && _selectedAzimut <= -40)) {
        factor = 96;
        
    } else if (_selectedInclination == 20 && (_selectedAzimut >= -35 && _selectedAzimut <= -25)) {
        factor = 97;
        
    } else if (_selectedInclination == 20 && (_selectedAzimut >= -20 && _selectedAzimut <= 20)) {
        factor = 98;
        
    } else if (_selectedInclination == 20 && (_selectedAzimut >= 25 && _selectedAzimut <= 35)) {
        factor = 97;
        
    } else if (_selectedInclination == 20 && (_selectedAzimut >= 40 && _selectedAzimut <= 50)) {
        factor = 96;
        
    } else if (_selectedInclination == 20 && _selectedAzimut == 55) {
        factor = 95;
        
    } else if (_selectedInclination == 20 && _selectedAzimut == 60) {
        factor = 94;
        
    } else if (_selectedInclination == 20 && _selectedAzimut == 65) {
        factor = 93;
        
    } else if (_selectedInclination == 20 && _selectedAzimut == 70) {
        factor = 92;
        
    } else if (_selectedInclination == 20 && _selectedAzimut == 75) {
        factor = 91;
        
    } else if (_selectedInclination == 20 && _selectedAzimut == 80) {
        factor = 90;
        
    } else if (_selectedInclination == 20 && _selectedAzimut == 85) {
        factor = 89;
        
    } else if (_selectedInclination == 20 && _selectedAzimut == 90) {
        factor = 88;
        
    }

    //helling 25
    else if (_selectedInclination == 25 && _selectedAzimut == -90) {
        factor = 87;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == -85) {
        factor = 88;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == -80) {
        factor = 89;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == -75) {
        factor = 90;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == -70) {
        factor = 91;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == -65) {
        factor = 92;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == -60) {
        factor = 93;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == -55) {
        factor = 94;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == -50) {
        factor = 95;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == -45) {
        factor = 96;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == -40) {
        factor = 97;
        
    } else if (_selectedInclination == 25 && (_selectedAzimut >= -35 && _selectedAzimut <= -30)) {
        factor = 98;
        
    } else if (_selectedInclination == 25 && (_selectedAzimut >= -25 && _selectedAzimut <= 20)) {
        factor = 99;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == 25) {
        factor = 98;
        
    } else if (_selectedInclination == 25 && (_selectedAzimut >= 30 && _selectedAzimut <= 40)) {
        factor = 97;
        
    } else if (_selectedInclination == 25 && (_selectedAzimut >= 45 && _selectedAzimut <= 50)) {
        factor = 96;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == 55) {
        factor = 95;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == 60) {
        factor = 94;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == 65) {
        factor = 93;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == 70) {
        factor = 92;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == 75) {
        factor = 91;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == 80) {
        factor = 89;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == 85) {
        factor = 88;
        
    } else if (_selectedInclination == 25 && _selectedAzimut == 90) {
        factor = 87;
        
    }

    //helling 30
    else if (_selectedInclination == 30 && _selectedAzimut == -90) {
        factor = 86;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == -85) {
        factor = 87;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == -80) {
        factor = 88;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == -75) {
        factor = 89;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == -70) {
        factor = 90;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == -65) {
        factor = 92;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == -60) {
        factor = 93;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == -55) {
        factor = 94;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == -50) {
        factor = 95;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == -45) {
        factor = 96;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == -40) {
        factor = 97;
        
    } else if (_selectedInclination == 30 && (_selectedAzimut >= -35 && _selectedAzimut <= -25)) {
        factor = 98;
        
    } else if (_selectedInclination == 30 && (_selectedAzimut >= -20 && _selectedAzimut <= -10)) {
        factor = 99;
        
    } else if (_selectedInclination == 30 && (_selectedAzimut >= -5 && _selectedAzimut <= 20)) {
        factor = 100;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == 25) {
        factor = 99;
        
    } else if (_selectedInclination == 30 && (_selectedAzimut >= 30 && _selectedAzimut <= 35)) {
        factor = 98;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == 40) {
        factor = 97;
        
    } else if (_selectedInclination == 30 && (_selectedAzimut >= 45 && _selectedAzimut <= 50)) {
        factor = 96;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == 55) {
        factor = 95;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == 60) {
        factor = 94;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == 65) {
        factor = 93;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == 70) {
        factor = 91;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == 75) {
        factor = 90;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == 80) {
        factor = 89;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == 85) {
        factor = 87;
        
    } else if (_selectedInclination == 30 && _selectedAzimut == 90) {
        factor = 86;
        
    }

    //helling 35
    else if (_selectedInclination == 35 && _selectedAzimut == -90) {
        factor = 84;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == -85) {
        factor = 85;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == -80) {
        factor = 87;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == -75) {
        factor = 88;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == -70) {
        factor = 89;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == -65) {
        factor = 91;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == -60) {
        factor = 92;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == -55) {
        factor = 93;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == -50) {
        factor = 95;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == -45) {
        factor = 96;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == -40) {
        factor = 97;
        
    } else if (_selectedInclination == 35 && (_selectedAzimut >= -35 && _selectedAzimut <= -25)) {
        factor = 98;
        
    } else if (_selectedInclination == 35 && (_selectedAzimut >= -20 && _selectedAzimut <= -10)) {
        factor = 99;
        
    } else if (_selectedInclination == 35 && (_selectedAzimut >= -5 && _selectedAzimut <= 20)) {
        factor = 100;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == 25) {
        factor = 99;
        
    } else if (_selectedInclination == 35 && (_selectedAzimut >= 30 && _selectedAzimut <= 35)) {
        factor = 98;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == 40) {
        factor = 97;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == 45) {
        factor = 96;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == 50) {
        factor = 95;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == 55) {
        factor = 94;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == 60) {
        factor = 93;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == 65) {
        factor = 92;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == 70) {
        factor = 90;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == 75) {
        factor = 89;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == 80) {
        factor = 88;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == 85) {
        factor = 86;
        
    } else if (_selectedInclination == 35 && _selectedAzimut == 90) {
        factor = 85;
        
    }

    //helling 40
    else if (_selectedInclination == 40 && _selectedAzimut == -90) {
        factor = 82;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == -85) {
        factor = 83;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == -80) {
        factor = 85;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == -75) {
        factor = 86;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == -70) {
        factor = 87;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == -65) {
        factor = 89;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == -60) {
        factor = 90;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == -55) {
        factor = 92;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == -50) {
        factor = 94;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == -45) {
        factor = 95;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == -40) {
        factor = 96;
        
    } else if (_selectedInclination == 40 && (_selectedAzimut >= -35 && _selectedAzimut <= -30)) {
        factor = 97;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == -25) {
        factor = 98;
        
    } else if (_selectedInclination == 40 && (_selectedAzimut >= -20 && _selectedAzimut <= -10)) {
        factor = 99;
        
    } else if (_selectedInclination == 40 && (_selectedAzimut >= -5 && _selectedAzimut <= 5)) {
        factor = 100;
        
    } else if (_selectedInclination == 40 && (_selectedAzimut >= 10 && _selectedAzimut <= 20)) {
        factor = 99;
        
    } else if (_selectedInclination == 40 && (_selectedAzimut >= 25 && _selectedAzimut <= 35)) {
        factor = 98;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == 40) {
        factor = 97;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == 45) {
        factor = 96;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == 50) {
        factor = 95;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == 55) {
        factor = 93;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == 60) {
        factor = 92;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == 65) {
        factor = 91;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == 70) {
        factor = 89;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == 75) {
        factor = 88;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == 80) {
        factor = 87;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == 85) {
        factor = 85;
        
    } else if (_selectedInclination == 40 && _selectedAzimut == 90) {
        factor = 84;
        
    }

    //helling 45
    else if (_selectedInclination == 45 && _selectedAzimut == -90) {
        factor = 80;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == -85) {
        factor = 82;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == -80) {
        factor = 84;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == -75) {
        factor = 85;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == -70) {
        factor = 86;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == -65) {
        factor = 87;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == -60) {
        factor = 89;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == -55) {
        factor = 91;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == -50) {
        factor = 93;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == -45) {
        factor = 94;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == -40) {
        factor = 95;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == -35) {
        factor = 96;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == -30) {
        factor = 96;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == -25) {
        factor = 97;
        
    } else if (_selectedInclination == 45 && (_selectedAzimut >= -20 && _selectedAzimut <= -10)) {
        factor = 98;
        
    } else if (_selectedInclination == 45 && (_selectedAzimut >= -5 && _selectedAzimut <= 5)) {
        factor = 99;
        
    } else if (_selectedInclination == 45 && (_selectedAzimut >= 10 && _selectedAzimut <= 20)) {
        factor = 98;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == 25) {
        factor = 97;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == 30) {
        factor = 97;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == 35) {
        factor = 96;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == 40) {
        factor = 95;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == 45) {
        factor = 95;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == 50) {
        factor = 93;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == 55) {
        factor = 92;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == 60) {
        factor = 91;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == 65) {
        factor = 89;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == 70) {
        factor = 88;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == 75) {
        factor = 87;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == 80) {
        factor = 85;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == 85) {
        factor = 84;
        
    } else if (_selectedInclination == 45 && _selectedAzimut == 90) {
        factor = 82;
        
    }

    //helling 50
    else if (_selectedInclination == 50 && _selectedAzimut == -90) {
        factor = 78;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == -85) {
        factor = 80;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == -80) {
        factor = 82;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == -75) {
        factor = 84;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == -70) {
        factor = 85;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == -65) {
        factor = 87;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == -60) {
        factor = 88;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == -55) {
        factor = 89;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == -50) {
        factor = 91;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == -45) {
        factor = 92;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == -40) {
        factor = 93;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == -35) {
        factor = 94;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == -30) {
        factor = 95;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == -25) {
        factor = 95;
        
    } else if (_selectedInclination == 50 && (_selectedAzimut >= -20 && _selectedAzimut <= -10)) {
        factor = 96;
        
    } else if (_selectedInclination == 50 && (_selectedAzimut >= -5 && _selectedAzimut <= 20)) {
        factor = 97;
        
    } else if (_selectedInclination == 50 && (_selectedAzimut >= 25 && _selectedAzimut <= 30)) {
        factor = 96;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == 35) {
        factor = 95;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == 40) {
        factor = 94;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == 45) {
        factor = 93;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == 50) {
        factor = 92;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == 55) {
        factor = 90;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == 60) {
        factor = 89;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == 65) {
        factor = 88;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == 70) {
        factor = 86;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == 75) {
        factor = 85;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == 80) {
        factor = 84;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == 85) {
        factor = 82;
        
    } else if (_selectedInclination == 50 && _selectedAzimut == 90) {
        factor = 80;
        
    }

    //helling 55
    else if (_selectedInclination == 55 && _selectedAzimut == -90) {
        factor = 76;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == -85) {
        factor = 78;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == -80) {
        factor = 80;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == -75) {
        factor = 82;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == -70) {
        factor = 83;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == -65) {
        factor = 85;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == -60) {
        factor = 86;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == -55) {
        factor = 87;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == -50) {
        factor = 89;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == -45) {
        factor = 90;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == -40) {
        factor = 91;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == -35) {
        factor = 92;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == -30) {
        factor = 93;
        
    } else if (_selectedInclination == 55 && (_selectedAzimut >= -25 && _selectedAzimut <= -15)) {
        factor = 94;
        
    } else if (_selectedInclination == 55 && (_selectedAzimut >= -10 && _selectedAzimut <= 15)) {
        factor = 95;
        
    } else if (_selectedInclination == 55 && (_selectedAzimut >= 20 && _selectedAzimut <= 25)) {
        factor = 94;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == 30) {
        factor = 93;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == 35) {
        factor = 92;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == 40) {
        factor = 91;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == 45) {
        factor = 90;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == 50) {
        factor = 89;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == 55) {
        factor = 88;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == 60) {
        factor = 86;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == 65) {
        factor = 85;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == 70) {
        factor = 83;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == 75) {
        factor = 82;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == 80) {
        factor = 80;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == 85) {
        factor = 78;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == 90) {
        factor = 78;
        
    }

    //helling 60
    else if (_selectedInclination == 60 && _selectedAzimut == -90) {
        factor = 74;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == -85) {
        factor = 76;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == -80) {
        factor = 78;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == -75) {
        factor = 79;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == -70) {
        factor = 81;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == -65) {
        factor = 83;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == -60) {
        factor = 84;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == -55) {
        factor = 85;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == -50) {
        factor = 86;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == -45) {
        factor = 87;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == -40) {
        factor = 88;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == -35) {
        factor = 89;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == -30) {
        factor = 90;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == -35) {
        factor = 90;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == -20) {
        factor = 91;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == -15) {
        factor = 91;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == -10) {
        factor = 92;
        
    } else if (_selectedInclination == 60 && (_selectedAzimut >= -5 && _selectedAzimut <= 20)) {
        factor = 93;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == 25) {
        factor = 92;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == 30) {
        factor = 92;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == 35) {
        factor = 91;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == 40) {
        factor = 90;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == 45) {
        factor = 89;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == 50) {
        factor = 88;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == 55) {
        factor = 87;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == 60) {
        factor = 86;
        
    } else if (_selectedInclination == 55 && _selectedAzimut == 65) {
        factor = 85;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == 70) {
        factor = 83;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == 75) {
        factor = 81;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == 80) {
        factor = 80;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == 85) {
        factor = 78;
        
    } else if (_selectedInclination == 60 && _selectedAzimut == 90) {
        factor = 76;
        
    }

    //helling 65
    else if (_selectedInclination == 65 && _selectedAzimut == -90) {
        factor = 72;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == -85) {
        factor = 74;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == -80) {
        factor = 76;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == -75) {
        factor = 77;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == -70) {
        factor = 78;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == -65) {
        factor = 80;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == -60) {
        factor = 81;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == -55) {
        factor = 82;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == -50) {
        factor = 84;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == -45) {
        factor = 85;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == -40) {
        factor = 86;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == -35) {
        factor = 87;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == -30) {
        factor = 88;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == -25) {
        factor = 88;
        
    } else if (_selectedInclination == 65 && (_selectedAzimut >= -20 && _selectedAzimut <= -10)) {
        factor = 89;
        
    } else if (_selectedInclination == 65 && (_selectedAzimut >= -5 && _selectedAzimut <= 20)) {
        factor = 90;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == 25) {
        factor = 89;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == 30) {
        factor = 89;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == 35) {
        factor = 88;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == 40) {
        factor = 87;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == 45) {
        factor = 87;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == 50) {
        factor = 85;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == 55) {
        factor = 84;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == 60) {
        factor = 83;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == 65) {
        factor = 82;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == 70) {
        factor = 80;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == 75) {
        factor = 79;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == 80) {
        factor = 77;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == 85) {
        factor = 75;
        
    } else if (_selectedInclination == 65 && _selectedAzimut == 90) {
        factor = 73;
        
    }

    //helling 70
    else if (_selectedInclination == 70 && _selectedAzimut == -90) {
        factor = 69;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == -85) {
        factor = 71;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == -80) {
        factor = 73;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == -75) {
        factor = 74;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == -70) {
        factor = 75;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == -65) {
        factor = 77;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == -60) {
        factor = 78;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == -55) {
        factor = 79;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == -50) {
        factor = 81;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == -45) {
        factor = 82;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == -40) {
        factor = 83;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == -35) {
        factor = 84;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == -30) {
        factor = 85;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == -25) {
        factor = 85;
        
    } else if (_selectedInclination == 70 && (_selectedAzimut >= -20 && _selectedAzimut <= -10)) {
        factor = 86;
        
    } else if (_selectedInclination == 70 && (_selectedAzimut >= -5 && _selectedAzimut <= 20)) {
        factor = 87;
        
    } else if (_selectedInclination == 70 && (_selectedAzimut >= 25 && _selectedAzimut <= 35)) {
        factor = 86;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == 40) {
        factor = 85;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == 45) {
        factor = 84;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == 50) {
        factor = 83;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == 55) {
        factor = 81;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == 60) {
        factor = 80;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == 65) {
        factor = 79;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == 70) {
        factor = 77;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == 75) {
        factor = 76;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == 80) {
        factor = 74;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == 85) {
        factor = 72;
        
    } else if (_selectedInclination == 70 && _selectedAzimut == 90) {
        factor = 70;
        
    }

    //helling 75
    else if (_selectedInclination == 75 && _selectedAzimut == -90) {
        factor = 66;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == -85) {
        factor = 68;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == -80) {
        factor = 70;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == -75) {
        factor = 71;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == -70) {
        factor = 72;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == -65) {
        factor = 74;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == -60) {
        factor = 75;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == -55) {
        factor = 76;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == -50) {
        factor = 78;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == -45) {
        factor = 79;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == -40) {
        factor = 80;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == -35) {
        factor = 81;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == -30) {
        factor = 81;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == -25) {
        factor = 82;
        
    } else if (_selectedInclination == 75 && (_selectedAzimut >= -20 && _selectedAzimut <= -10)) {
        factor = 83;
        
    } else if (_selectedInclination == 75 && (_selectedAzimut >= -5 && _selectedAzimut <= 20)) {
        factor = 84;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == 25) {
        factor = 83;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == 30) {
        factor = 83;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == 35) {
        factor = 82;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == 40) {
        factor = 81;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == 45) {
        factor = 81;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == 50) {
        factor = 79;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == 55) {
        factor = 78;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == 60) {
        factor = 77;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == 65) {
        factor = 76;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == 70) {
        factor = 74;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == 75) {
        factor = 73;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == 80) {
        factor = 71;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == 85) {
        factor = 69;
        
    } else if (_selectedInclination == 75 && _selectedAzimut == 90) {
        factor = 68;
        
    }

    //helling 80
    else if (_selectedInclination == 80 && _selectedAzimut == -90) {
        factor = 63;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == -85) {
        factor = 65;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == -80) {
        factor = 67;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == -75) {
        factor = 68;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == -70) {
        factor = 69;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == -65) {
        factor = 71;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == -60) {
        factor = 72;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == -55) {
        factor = 73;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == -50) {
        factor = 74;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == -45) {
        factor = 75;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == -40) {
        factor = 76;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == -35) {
        factor = 77;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == -30) {
        factor = 77;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == -25) {
        factor = 78;
        
    } else if (_selectedInclination == 80 && (_selectedAzimut >= -20 && _selectedAzimut <= -10)) {
        factor = 79;
        
    } else if (_selectedInclination == 80 && (_selectedAzimut >= -5 && _selectedAzimut <= 20)) {
        factor = 80;
        
    } else if (_selectedInclination == 80 && (_selectedAzimut >= 25 && _selectedAzimut <= 35)) {
        factor = 79;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == 40) {
        factor = 78;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == 45) {
        factor = 77;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == 50) {
        factor = 76;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == 55) {
        factor = 75;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == 60) {
        factor = 74;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == 65) {
        factor = 73;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == 70) {
        factor = 71;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == 75) {
        factor = 69;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == 80) {
        factor = 68;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == 85) {
        factor = 66;
        
    } else if (_selectedInclination == 80 && _selectedAzimut == 90) {
        factor = 65;
        
    }

    //helling 85
    else if (_selectedInclination == 85 && _selectedAzimut == -90) {
        factor = 60;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == -85) {
        factor = 61;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == -80) {
        factor = 63;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == -75) {
        factor = 64;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == -70) {
        factor = 65;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == -65) {
        factor = 67;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == -60) {
        factor = 68;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == -55) {
        factor = 69;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == -50) {
        factor = 70;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == -45) {
        factor = 71;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == -40) {
        factor = 72;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == -35) {
        factor = 73;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == -30) {
        factor = 73;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == -25) {
        factor = 74;
        
    } else if (_selectedInclination == 85 && (_selectedAzimut >= -20 && _selectedAzimut <= -10)) {
        factor = 75;
        
    } else if (_selectedInclination == 85 && (_selectedAzimut >= -5 && _selectedAzimut <= 20)) {
        factor = 76;
        
    } else if (_selectedInclination == 85 && (_selectedAzimut >= 25 && _selectedAzimut <= 35)) {
        factor = 75;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == 40) {
        factor = 74;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == 45) {
        factor = 73;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == 50) {
        factor = 72;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == 55) {
        factor = 71;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == 60) {
        factor = 70;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == 65) {
        factor = 68;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == 70) {
        factor = 67;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == 75) {
        factor = 766;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == 80) {
        factor = 64;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == 85) {
        factor = 63;
        
    } else if (_selectedInclination == 85 && _selectedAzimut == 90) {
        factor = 62;
        
    }

    //helling 90
    else if (_selectedInclination == 90 && _selectedAzimut == -90) {
        factor = 56;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == -85) {
        factor = 57;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == -80) {
        factor = 59;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == -75) {
        factor = 60;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == -70) {
        factor = 61;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == -65) {
        factor = 63;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == -60) {
        factor = 64;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == -55) {
        factor = 65;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == -50) {
        factor = 66;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == -45) {
        factor = 67;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == -40) {
        factor = 68;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == -35) {
        factor = 69;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == -30) {
        factor = 69;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == -25) {
        factor = 70;
        
    } else if (_selectedInclination == 90 && (_selectedAzimut >= -20 && _selectedAzimut <= 35)) {
        factor = 71;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == 40) {
        factor = 70;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == 45) {
        factor = 69;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == 50) {
        factor = 68;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == 55) {
        factor = 66;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == 60) {
        factor = 65;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == 65) {
        factor = 64;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == 70) {
        factor = 63;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == 75) {
        factor = 62;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == 80) {
        factor = 61;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == 85) {
        factor = 59;
        
    } else if (_selectedInclination == 90 && _selectedAzimut == 90) {
        factor = 58;
        
    } else {
    }

      int maxPower = panels * wattPeak;
      int estimatedPower = (maxPower * (factor/100) * (location/100)).round();

      setState(() {
        //textToShow = "$panels + $inclination +$azimut +$_selectedLocation +$_selectedWattPeak = $result";
        textToShowMaxPower = "Maximum power: $panels * $wattPeak = $maxPower";
        textToShowEstimatedPower = "Estimated power: ($maxPower * ($factor/100) *($location/100)) = $estimatedPower";
      });
    }
  }
}

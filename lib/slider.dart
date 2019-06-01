import 'package:flutter/material.dart';

//

class SliderScreen extends StatefulWidget {
    @override
    _SliderScreenState createState() {
      return _SliderScreenState();
    }
  }
  
  class _SliderScreenState extends State {
    int _value = 0;
  
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Slider Tutorial',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Slider Tutorial'),
          ),
          body: Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Slider(
                        value: _value.toDouble(),
                        min: -90.0,
                        max: 90.0,
                        divisions: 36,
                        activeColor: Colors.red,
                        inactiveColor: Colors.black,
                        label: 'Set a value',
                        onChanged: (double newValue) {
                          setState(() {
                            _value = newValue.round();
                          });
                        },
                    ),
                    Text(
                      
                    'Value: ${(_value).round()}',
                  ),
                ]
              )
            ),
          )
        ),
      );
    }
  }
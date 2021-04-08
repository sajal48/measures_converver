import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<String> _measures =['meters','kilometers','gram','kilogram','feet','miles','pounds','ounces'];
  double _numberForm;
  String _result;
  String _startmeasure;
  String _totmeasure;
  final Map<String,int> _measureMap ={
    'meters': 0,
    'kilometers': 1,
    'gram':2,
    'kilogram':3,
    'feet':4,
    'miles':5,
    'pounds':6,
    'ounces':7};
  final dynamic _formulas = { '0':[1,0.001,0,0,3.28084,0.000621371,0,0], '1':[1000,1,0,0,3280.84,0.621371,0,0], '2':[0,0,1,0.0001,0,0,0.00220462,0.035274], '3':[0,0,1000,1,0,0,2.20462,35.274], '4':[0.3048,0.0003048,0,0,1,0.000189394,0,0], '5':[1609.34, 1.60934,0,0,5280,1,0,0], '6':[0,0,453.592,0.453592,0,0,1,16], '7':[0,0,28.3495,0.0283495,3.28084,0,0.0625, 1], };
  final TextStyle inputstyle = TextStyle(
    fontSize: 20,
    color:Colors.blue[900]
  );
  final TextStyle labelStyle = TextStyle(
      fontSize: 24,
      color:Colors.grey[700]
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Measures Converter"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Spacer(),
            Text("Value",style: labelStyle,),
            Spacer(),
            TextField(
            style: inputstyle,
            decoration: InputDecoration(
              hintText: "Please insert measures to be converted"
            ),
            onChanged: (text){
              var v= double.tryParse(text);
              if(v!=null)
              {
                setState(() {
                  _numberForm=v;
                });
              }
            },
          ),
            Spacer(),
            Text(
              'From',style: labelStyle,),
            DropdownButton(
                value: _startmeasure,
                isExpanded: true,
                items: _measures.map((String v){
                  return DropdownMenuItem<String>(
                    value: v,
                    child: Text(v),
                  );
                }).toList(),
              onChanged: (value){
                  setState(() {
                    _startmeasure=value;
                  });
              },
            ),
            Spacer(),
            Text(
              "To",style: labelStyle,),
            DropdownButton(
              value: _totmeasure,
              isExpanded: true,
              items: _measures.map((String v){
                return DropdownMenuItem<String>(
                  value: v,
                  child: Text(v),
                );
              }).toList(),
              onChanged: (value){
                setState(() {
                  _totmeasure=value;
                });
              },
            ),
            Spacer(flex: 2,),
            ElevatedButton(
              child: Text("Convert",style: inputstyle,),
              onPressed: (){
                if(_startmeasure.isEmpty||_totmeasure.isEmpty){
                  return;
                }
                else{
                  converter(_numberForm, _startmeasure, _totmeasure);
                }
              },
            ),
            Spacer(flex: 2,),
            Text(
                (_result == null)?"": _result,
            style: labelStyle,),
            Spacer(flex: 8,),
          ],
        ),
      ),
    );
  }

  void converter(double value,String from,String to){
    int nfrom = _measureMap[from];
    int nto = _measureMap[to];
    var multiplier =_formulas[nfrom.toString()][nto];
    print(multiplier);

    var result = value*multiplier;
    if(result ==0){
      _result ="This can not be done";
    }
    else{
      _result ='${_numberForm.toString()} $_startmeasure are $result $_totmeasure';

    }
    setState(() {
      _result =_result;
    });

  }
}


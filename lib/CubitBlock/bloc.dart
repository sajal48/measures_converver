
import 'package:flutter_bloc/flutter_bloc.dart';


class Calculator extends Cubit<String>{
  double value;
  String from;
  String to;
  var result;
  String result_msg;
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

  Calculator() : super('initial');
  void setvalue(double v) => value = v;
  void setfrom(String s)=> from=s;
  void setto(String s)=> to=s;
  void calculate(){
    int nfrom = _measureMap[from];
    int nto = _measureMap[to];
    var multiplier = _formulas[nfrom.toString()][nto];
    result = value *multiplier;
    emit('$value $from are $result $to');
  }



}

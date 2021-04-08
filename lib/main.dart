import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:measures_converver/CubitBlock/bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (_) => Calculator(),
  child: MaterialApp(
      home: HomePage(),
    ),
);
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<String> _measures =['meters','kilometers','gram','kilogram','feet','miles','pounds','ounces'];
  String _startmeasure;
  String _totmeasure;

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
                context.read<Calculator>().setvalue(v);
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
                    _startmeasure = value;
                  });
                context.read<Calculator>().setfrom(value);
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
                  _totmeasure = value;
                });
                context.read<Calculator>().setto(value);
              },
            ),
            Spacer(flex: 2,),
            ElevatedButton(
              child: Text("Convert",style: inputstyle,),
              onPressed: (){
                context.read<Calculator>().calculate();
              },
            ),
            Spacer(flex: 2,),
            BlocBuilder<Calculator, String>(
             builder: (context, state) {
              return Text(
                (state== null)?"": state,
            style: labelStyle,);
  },
),
            Spacer(flex: 8,),
          ],
        ),
      ),
    );
  }

}


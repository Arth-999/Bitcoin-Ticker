import 'package:bitcoin_ticker/reuseableCard.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'global.dart' as global;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'INR';
  String rt1 = '&&';
  String rt2 = '&&';
  String rt3 = '&&';
  bool waiting=false;
  CoinData cc = CoinData();

  DropdownButton<String> androidpicker() {
    List<DropdownMenuItem<String>> l = [];

    for (String i in currenciesList) {
      l.add(
        DropdownMenuItem(
          child: Text(i),
          value: i,
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: l,
      onChanged: (value) {
        setState(() {
          waiting=true;
          selectedCurrency = value;
          func1();
          func2();
          func3();
        });
      },
    );
  }

  CupertinoPicker iospicker() {
    List<Text> l = [];
    for (String cur in currenciesList) {
      l.add(Text(cur));
    }
    return CupertinoPicker(
        backgroundColor: Colors.deepPurple,
        itemExtent: 30,
        onSelectedItemChanged: (index) {
          print(index);
          setState(() {
            selectedCurrency = currenciesList[index];
            func1();
            func2();
            func3();
          });
        },
        children: l);
  }

  void func1() async {
    try {
      var dd = await cc.getcoindata(0, selectedCurrency,context);
      double var1 = dd['rate'];
      waiting=false;
      setState(() {
        rt1 = var1.toStringAsFixed(0);
      });
    } catch (e) {
      global.flag=1;
      Alert(context:context, title: "Error", desc: "INTERNET IS NOT WORKING").show();
      print(e);
    }
  }

  void func2() async {
    if (global.flag == 1) {}
    else {
      try {
        var dd = await cc.getcoindata(1, selectedCurrency, context);
        double var1 = dd['rate'];
        waiting = false;
        setState(() {
          rt2 = var1.toStringAsFixed(0);
        });
      } catch (e) {}
    }
  }

  void func3() async {
    if (global.flag == 1) {}
    else {
      try {
        var dd = await cc.getcoindata(2, selectedCurrency, context);
        double var1 = dd['rate'];
        waiting = false;
        setState(() {
          rt3 = var1.toStringAsFixed(0);
          waiting = false;
        });
      } catch (e) {}
    }
  }

  @override
  void initState() {
    super.initState();
    func1();
    func2();
    func3();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Tracker'),
      ),
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/c.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReuseableCard(0,waiting ?'\$\$':rt1, selectedCurrency),
              ReuseableCard(1,waiting ?'\$\$':rt2, selectedCurrency),
              ReuseableCard(2,waiting ?'\$\$':rt3, selectedCurrency),
            ],
          ),
          Container(
            height: 100.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Color(0xFF512DA8),
            child: Platform.isIOS ? iospicker() : androidpicker(),
          ),
        ],
      ),
    )
    );
  }
}

import 'package:flutter/material.dart';
import 'coin_data.dart';

class ReuseableCard extends StatelessWidget{

  final int index;
  final String str;
  final String selectedcurr;
  ReuseableCard(this.index,this.str,this.selectedcurr);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Color(0xFF512DA8),
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 ${cryptoList[index]} = $str $selectedcurr',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
  }

}
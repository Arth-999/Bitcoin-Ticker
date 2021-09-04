import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'global.dart' as globals;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  Future<dynamic> getcoindata(int i,String curr,BuildContext context) async{
    Uri url=Uri.parse('https://rest.coinapi.io/v1/exchangerate/${cryptoList[i]}/$curr?apikey=6AC8E43C-B908-4D39-AC31-E0097DFFAEED');
    Response res=await get(url);
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
    else {
      print('Request failed with status: ${res.statusCode}.');
      globals.flag=1;
      Alert(context:context, title: "Error in connection with API", desc: "${res.statusCode}").show();
    }
  }
}

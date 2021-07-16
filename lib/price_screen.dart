import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  CoinData coinData = CoinData();
  var data = List(3);
  var bits = List(3);
  var rate = List(3);

  @override
  void initState() {
    super.initState();
    getData(selectedCurrency);
  }

  Future getData(String currency) async {
    for (int i = 0; i <= 2; i++) {
      data[i] = await coinData.getBitcoinData(cryptoList[i], currency);
      print(data[i]);
      setState(() {
        bits[i] = data[i]['rate'];
        rate[i] = bits[i].toInt();
      });
      print(rate[i]);
    }
  }

  DropdownButton getItems() {
    List<DropdownMenuItem> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton(
        value: selectedCurrency,
        items: dropDownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            getData(selectedCurrency);
          });
        });
  }

  CupertinoPicker getPickerItems() {
    List<Widget> pickerItems = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        print(index);
        setState(() {
          selectedCurrency = currenciesList[index];
          getData(selectedCurrency);
        });
      },
      children: pickerItems,
    );
  }

  Widget getChildrens(String crypto, int j) {
    var x = rate[j];
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $x $selectedCurrency',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getChildrens(cryptoList[0], 0),
          getChildrens(cryptoList[1], 1),
          getChildrens(cryptoList[2], 2),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getPickerItems() : getItems(),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:io' show Platform;

import 'package:bitcointicker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  PriceScreenState createState() => PriceScreenState();
}

class PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  int selectedIndex = 0;
  Future<dynamic>? _data_btc;
  Future<dynamic>? _data_eth;
  Future<dynamic>? _data_ltc;
  CoinData coinData = CoinData();
  double? currencyValueBTC;
  double? currencyValueETH;
  double? currencyValueLTC;

  DropdownButton<String> androidDropDownButton() {
    List<DropdownMenuItem<String>> listItems = currenciesList
        .map<DropdownMenuItem<String>>((String value) =>
            DropdownMenuItem<String>(value: value, child: Text(value)))
        .toList();
    return DropdownButton<String>(
      value: selectedCurrency,
      items: listItems,
      onChanged: (String? value) {
        setState(() {
          selectedCurrency = value!;

          _data_btc = updatUi('BTC');
          _data_eth = updatUi('ETH');
          _data_ltc = updatUi('LTC');
        });
      },
    );
  }

  CupertinoPicker iosCupertinoPicker() {
    List<Widget> listItems = List<Widget>.generate(
      currenciesList.length,
      (index) => Text(
        currenciesList[index],
      ),
    );

    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
      },
      children: listItems,
    );
  }

  getPicker() {
    if (Platform.isIOS) {
      return iosCupertinoPicker();
    } else if (Platform.isAndroid) {
      return androidDropDownButton();
    }
  }

  @override
  void initState() {
    _data_btc = updatUi('BTC');
    _data_eth = updatUi('ETH');
    _data_ltc = updatUi('LTC');

    super.initState();
  }

  updatUi(fromAsset) async {
    return await coinData.getCoinData(fromAsset, selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          returnFutureBuilderWidgetBTC(),
          returnFutureBuilderWidgetETH(),
          returnFutureBuilderWidgetLTC(),
          Container(
            height: 100.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }

  FutureBuilder<dynamic> returnFutureBuilderWidgetBTC() {
    return FutureBuilder(
      future: _data_btc,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            currencyValueBTC = snapshot.data;
          } else if (snapshot.hasError) {
            return const Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'No data, try later!',
                style: TextStyle(color: Color(0xFF000000), fontSize: 18),
              ),
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
        return Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 BTC = ${currencyValueBTC!.toStringAsFixed(0)} $selectedCurrency',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  FutureBuilder<dynamic> returnFutureBuilderWidgetLTC() {
    return FutureBuilder(
      future: _data_ltc,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            currencyValueLTC = snapshot.data;
          } else if (snapshot.hasError) {
            return const Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'No data, try later!',
                style: TextStyle(color: Color(0xFF000000), fontSize: 18),
              ),
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
        return Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 LTC = ${currencyValueLTC!.toStringAsFixed(0)} $selectedCurrency',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  FutureBuilder<dynamic> returnFutureBuilderWidgetETH() {
    return FutureBuilder(
      future: _data_eth,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            currencyValueETH = snapshot.data;
          } else if (snapshot.hasError) {
            return const Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'No data, try later!',
                style: TextStyle(color: Color(0xFF000000), fontSize: 18),
              ),
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
        return Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 ETH = ${currencyValueETH!.toStringAsFixed(0)} $selectedCurrency',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

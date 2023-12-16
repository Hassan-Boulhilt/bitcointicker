import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

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
  getCoinData(String btc, String currency) async {
    Map<String, dynamic>? jsonResponse;
    String queryPath = 'rest.coinapi.io';
    String query_ =
        '/v1/exchangerate/$btc/$currency/apikey-2F08C8DC-C2D1-477D-88F7-2D7C5139ABFB';

    Uri url = Uri.https(queryPath, query_);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    }
    return jsonResponse!['rate'];
  }
}

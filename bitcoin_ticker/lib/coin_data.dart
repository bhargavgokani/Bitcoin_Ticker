import 'dart:convert';
import 'package:http/http.dart' as http;

const apikey = '159FD786-034A-4BC4-87A7-44820F657E0A';
const coinURL = "https://rest.coinapi.io/v1/exchangerate";
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
  Future getcoinData(String selectedCurrency) async {
    Map cryptoprice = {};
    for (String crypto in cryptoList) {
      String url = '$coinURL/$crypto/$selectedCurrency?apikey=$apikey';
      var uri = Uri.parse(url);
      http.Response response = await http.get(uri) as http.Response;
      if (response.statusCode == 200) {
        var decodeData = jsonDecode(response.body);
        var lastPrice = decodeData['rate'];
        cryptoprice[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw " Problem with get request";
      }
    }
    return cryptoprice;
  }
}

import 'networking.dart';

const apiKey = 'BF7632D5-3C64-4724-9E50-AC44DE781596';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

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
  Future getBitcoinData(String crypto, String currency) async {
    CoinHelper coinHelper =
        CoinHelper('$coinAPIURL/$crypto/$currency?apikey=$apiKey');
    var bitcoinData = await coinHelper.getData();
    return bitcoinData;
  }
}
